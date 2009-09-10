Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] bluez-gnome: Fix crash on pairing request of known rfcomm
 device
From: Stanislav Brabec <sbrabec@suse.cz>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="ISO-8859-2"
Date: Thu, 10 Sep 2009 17:10:15 +0200
Message-Id: <1252595415.3430.17.camel@hammer.suse.cz>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Attached patch fixes crash after access attempt to the device configured
in rfcomm.conf, but not yet paired.

How to reproduce:

1. Configure an unknown RFCOMM device that requires authentication in
   rfcomm.conf (e. g. mobile phone).
2. run pppd on /dev/rfcomm1

Behavior:
- Pairing request on mobile phone
- Crash of bluetooth-applet on desktop

The patch fixes only the crash, not the error completely (at least in
version 1.8). Behavior after the fix:
- Pairing request on mobile phone, then ask for PIN
- No reaction on desktop

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>

Index: bluez-gnome-1.8/common/bluetooth-client.c
===================================================================
--- bluez-gnome-1.8.orig/common/bluetooth-client.c
+++ bluez-gnome-1.8/common/bluetooth-client.c
@@ -330,7 +330,7 @@ static void add_device(DBusGProxy *adapt
 		name = value ? g_value_get_string(value) : NULL;
 
 		value = g_hash_table_lookup(hash, "Class");
-		type = class_to_type(g_value_get_uint(value));
+		type = value ? class_to_type(g_value_get_uint(value)) : BLUETOOTH_TYPE_ANY;
 
 		value = g_hash_table_lookup(hash, "Icon");
 		icon = value ? g_value_get_string(value) : "bluetooth";

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12           tel: +420 284 028 966, +49 911 740538747
190 00 Praha 9                                  fax: +420 284 028 951
Czech Republic                                    http://www.suse.cz/

