Return-Path: <cyrus@holtmann.org>
Message-ID: <4BE14819.4080903@greffrath.com>
Date: Wed, 05 May 2010 12:27:37 +0200
From: Fabian Greffrath <fabian@greffrath.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Detect invalid (i.e. non-UTF-8) device names and fix them during
 initialization phase
References: <4BE14458.1020908@greffrath.com>
In-Reply-To: <4BE14458.1020908@greffrath.com>
Content-Type: multipart/mixed;
 boundary="------------020204030209010708080903"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------020204030209010708080903
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Bluez list,

I am sorry, I know this is the worst way to start getting in touch 
with a software project, but I accidently attached the wrong patch to 
my previous email. It's configure_device() that must be patched. 
Please find a corrected patch attached (it has been written against 
bluez 4.63 but applies perfectly against 4.64).

Cheers,
Fabian

--------------020204030209010708080903
Content-Type: text/x-diff;
 name="fix_invalid_non-utf-8_device_name.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fix_invalid_non-utf-8_device_name.patch"

--- bluez-4.63.orig/plugins/hciops.c
+++ bluez-4.63/plugins/hciops.c
@@ -81,6 +81,7 @@ static void configure_device(int index)
 	struct hci_dev_info di;
 	uint16_t policy;
 	int dd, err;
+	char name[249];
 
 	if (hci_devinfo(index, &di) < 0)
 		return;
@@ -96,6 +97,30 @@ static void configure_device(int index)
 		return;
 	}
 
+	if (hci_read_local_name(dd, sizeof(name), name, 1000) < 0) {
+		error("Can't read local name on hci%d: %s (%d)\n",
+						index, strerror(errno), errno);
+		return;
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
+				return;
+			}
+			g_free(utf8_name);
+		}
+	}
+
 	/* Set page timeout */
 	if ((main_opts.flags & (1 << HCID_SET_PAGETO))) {
 		write_page_timeout_cp cp;

--------------020204030209010708080903--
