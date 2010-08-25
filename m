Return-Path: <cyrus@holtmann.org>
Message-ID: <4C75292E.9080304@csr.com>
Date: Wed, 25 Aug 2010 15:31:10 +0100
From: David Vrabel <david.vrabel@csr.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: bluetoothd does not check remote names for valid utf8 data
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

bluetoothd does not check in some (all?) places that the remote name
reported by a device is valid utf8 data.  e.g., extract_eir_name() in
src/dbus-hci.c.

The reception of an extended inquiry response containing a name with
invalid utf8 data can cause the dbus interface to disappear.  This is
therefore a denial-of-service vulnerability (at the very least).

The following patch fixes the above problem but there are probably other
places where the check needs to be done.

--- bluez-4.51.orig/src/dbus-hci.c
+++ bluez-4.51/src/dbus-hci.c
@@ -450,6 +450,8 @@
 	switch (*type) {
 	case 0x08:
 	case 0x09:
+		if (!g_utf8_validate(data + 2, data[0] - 1, NULL))
+			return strdup("");
 		return strndup((char *) (data + 2), data[0] - 1);
 	}


David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
