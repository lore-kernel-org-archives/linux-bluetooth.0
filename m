Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] client: Make show command print DiscoverableTimeout
Date: Wed, 25 Jul 2018 13:20:33 +0300
Message-Id: <20180725102035.19439-2-luiz.dentz@gmail.com>
In-Reply-To: <20180725102035.19439-1-luiz.dentz@gmail.com>
References: <20180725102035.19439-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Controller XX:XX:XX:XX:XX:XX (public)
	Name: Vudentz's T460s
	Alias: Intel-1
	Class: 0x004c010c
	Powered: yes
	Discoverable: no
	DiscoverableTimeout: 0x00000000
	Pairable: yes
	UUID: Headset AG                (00001112-0000-1000-8000-00805f9b34fb)
	UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
	UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
	UUID: SIM Access                (0000112d-0000-1000-8000-00805f9b34fb)
	UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
	UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
	UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
	UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
	UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
	UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
	Modalias: usb:v1D6Bp0246d0532
	Discovering: no
---
 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index 59820c6d9..6f472d050 100644
--- a/client/main.c
+++ b/client/main.c
@@ -877,6 +877,7 @@ static void cmd_show(int argc, char *argv[])
 	print_property(proxy, "Class");
 	print_property(proxy, "Powered");
 	print_property(proxy, "Discoverable");
+	print_property(proxy, "DiscoverableTimeout");
 	print_property(proxy, "Pairable");
 	print_uuids(proxy);
 	print_property(proxy, "Modalias");
-- 
2.17.1

