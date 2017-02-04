Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Nicolas Werner <nicolas.werner@gmx.net>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC][PATCH BlueZ] sixaxis: Differing device name between usb and bluetooth connection
Date: Sat, 04 Feb 2017 19:16:28 +0100
Message-ID: <2299304.XBxEXHNB4J@gentooasus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

BlueZ sets the device name of Dual Shock 3 controller to "PLAYSTATION(R)3 
Controller". When you connect the same controller via USB it is set to "Sony 
PLAYSTATION(R)3 Controller".

It seems that at least some games fail to recognize the controller as a Dual 
Shock 3/sixaxis controller and don't load the default mapping for PlayStation 
controllers, if the name doesn't contain the Sony part. Also I don't see a 
reason to use a different name, when connecting via Bluetooth.

I noticed this with "The Binding of Isaac: Rebirth" and it seems, that Steam 
also recognizes the controller better after the patch, although I'm not 
confident, if I can parse the controller configuration dialog correctly.
I don't know, if this breaks anything, because it depends on the current name.

The attached patch changes the device name set when pairing to match the 
device name, when connected via USB.

Nicolas Werner

--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -56,7 +56,7 @@
        uint16_t version;
 } devices[] = {
        {
-               .name = "PLAYSTATION(R)3 Controller",
+               .name = "Sony PLAYSTATION(R)3 Controller",
                .source = 0x0002,
                .vid = 0x054c,
                .pid = 0x0268,

