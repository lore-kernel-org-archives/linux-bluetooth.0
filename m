Return-Path: <cyrus@holtmann.org>
Message-ID: <4E3400F7.4000504@poczta.fm>
Date: Sat, 30 Jul 2011 15:02:47 +0200
From: Lukasz Stelmach <stlman@poczta.fm>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] configuring device class
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi.

I am investigating ways to set the device class (computer/laptop
etc) of a bluetooth device. There is a key in main.conf named
Class to set the class but aparently it is overridden by the
class field of /var/lib/bluetooth/<bdaddr>/config. Once the class
is stored there changes in main.conf don't affect the actual class
the device presents. IMHO it is quite obutse and it took me an hour
or more with a debugger to find out how to change it so I'd like to
propose the following patch. Are there any reasons that the config
file in /var should override the value from /etc?

diff --git a/src/adapter.c b/src/adapter.c
index 4c88a0e..7faa881 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2261,6 +2261,7 @@ void btd_adapter_start(struct btd_adapter *adapter)
 {
 	char address[18];
 	uint8_t cls[3];
+	uint32_t class;
 	gboolean powered;

 	ba2str(&adapter->bdaddr, address);
@@ -2279,10 +2280,11 @@ void btd_adapter_start(struct btd_adapter *adapter)

 	adapter_ops->set_name(adapter->dev_id, adapter->name);

-	if (read_local_class(&adapter->bdaddr, cls) < 0) {
-		uint32_t class = htobl(main_opts.class);
+	class = htobl(main_opts.class);
+	if (class != 0)
 		memcpy(cls, &class, 3);
-	}
+	else
+		read_local_class(&adapter->bdaddr, cls);

 	btd_adapter_set_class(adapter, cls[1], cls[0]);

-- 
Było mi bardzo miło.               Czwarta pospolita klęska, [...]
>Łukasz<                 Już nie katolicka lecz złodziejska.  (c)PP

----------------------------------------------------------------
Znajdz samochod idealny dla siebie!
Szukaj >> http://linkint.pl/f29e2
