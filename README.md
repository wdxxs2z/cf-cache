# cf-docker-cache-script
These are cf's docker cache and receptor script
</br>
If you can't use the bosh to deployment diego-docker-cache-release,you can use it.

## 1.Download the cf-cache with root user
```
mkdir -p /var/vcap
git clone https://github.com/wdxxs2z/cf-cache /var/vcap/
```

## 2.Create install.sh
```
cd /var/vcap
./generate -boshUrl https://admin:admin@bosh.example:25555 -outputDir /var/vcap/
./install.sh
```

## 3.Start your monit
```
/var/vcap/bosh/bin/monit -c /var/vcap/bosh/etc/monitrc
```

## 4.Maybe you need modify the garden config and restart garden
```
-insecureDockerRegistry=docker-registry.service.cf.internal:8080
```
