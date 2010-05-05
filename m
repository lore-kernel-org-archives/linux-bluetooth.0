Return-Path: <cyrus@holtmann.org>
Message-ID: <4BE14458.1020908@greffrath.com>
Date: Wed, 05 May 2010 12:11:36 +0200
From: Fabian Greffrath <fabian@greffrath.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Detect invalid (i.e. non-UTF-8) device names and fix them during
 initialization phase
Content-Type: multipart/mixed;
 boundary="------------000300040701050206070203"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------000300040701050206070203
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Bluez developers,

recently I have experienced a problem with one of my USB bluetooth 
dongles: Whenever I plugged it into an USB port, the kernel detected 
the device (i.e. reasonable output in dmesg) and the correct kernel 
module (i.e. btusb) was loaded, but bluez frontends like 
gnome-bluetooth could still not activate the device. The bug that I 
reported against this software can be found at: 
<https://bugzilla.gnome.org/show_bug.cgi?id=617050>.

It turned out that my USB dongle was the culprit, since it had an 
invalid default device name that contained non-UTF-8 characters, as 
reported by 'hciconfig -a'. When I changed the device name to 
something reasonable via e.g. 'hciconfig hci0 name foobar', I had to 
*restart* the bluetoothd daemon afterwards in order to get everything 
working as expected. However, when I unplugged the USB dongle and 
plugged it back in, the device name was reset to the defective default 
again and I had to repeat this procedure.

Since I found it unreasonable to be forced to manually change the 
device name and restart the daemon each and every time I plugged my 
USB dongle in, I wanted a solution that detected a faulty device name 
string during the device initialization phase and instantly fixed it 
by writing a converted string back to the device. The attached patch 
does exact this and makes my USB dongle work out-of-the-box, despite 
its defective default device name.

Please review the patch for integration into Bluez.

Cheers,
Fabian

PS: There is still one open question that I would like to address: 
Since I am going to print both the faulty and the fixed device name 
strings to stderr via debug(), should I make sure the strings do not 
contain any ASCII control characters prior to that? At least this is 
what is done in tools/hciconfig.c:442.


--------------000300040701050206070203
Content-Type: text/x-diff;
 name="fix_invalid_non-utf-8_device_name.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fix_invalid_non-utf-8_device_name.patch"

--- bluez-4.64.orig/plugins/hciops.c
+++ bluez-4.64/plugins/hciops.c
@@ -119,6 +119,7 @@ static void init_device(int index)
 	struct hci_dev_info di;
 	pid_t pid;
 	int dd, err;
+	char name[249];
 
 	/* Do initialization in the separate process */
 	pid = fork();
@@ -143,6 +144,30 @@ static void init_device(int index)
 		exit(1);
 	}
 
+	if (hci_read_local_name(dd, sizeof(name), name, 1000) < 0) {
+		error("Can't read local name on hci%d: %s (%d)\n",
+						index, strerror(errno), errno);
+		exit(1);
+	}
+
+	name[248] = '\0';
+
+	if (!g_utf8_validate(name, -1, NULL)) {
+		char *utf8_name;
+
+		utf8_name = g_convert(name, -1, "UTF-8", "ISO-8859-1", NULL, NULL, NULL);
+		if (utf8_name) {
+			debug("Fix invalid non-UTF-8 device name \"%s\" on hci%d to \"%s\"",
+							name, index, utf8_name);
+			if (hci_write_local_name(dd, utf8_name, 2000) < 0) {
+				error("Can't change local name on hci%d: %s (%d)\n",
+								index, strerror(errno), errno);
+				exit(1);
+			}
+			g_free(utf8_name);
+		}
+	}
+
 	memset(&dr, 0, sizeof(dr));
 	dr.dev_id = index;
 

--------------000300040701050206070203--
