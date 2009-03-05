Return-Path: <cyrus@holtmann.org>
Subject: Work-around for broken MS device
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-URRMxPQRKZacmaTn7jOs"
Date: Thu, 05 Mar 2009 18:48:28 +0000
Message-Id: <1236278908.3602.1896.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-URRMxPQRKZacmaTn7jOs
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit

Heya,

As seen in https://bugzilla.redhat.com/show_bug.cgi?id=450081
The Microsoft Wireless Notebook Presenter Mouse 8000 has its name in
ISO-8859-1 instead of UTF-8, as required by the BT spec.

I've implemented a small work-around. This isn't very invasive, IMO, as
we already do UTF-8 checks.

In my tests, this makes the mouse show up as:
Microsoft® Wireless Notebook Presenter Mouse 8000

Cheers

--=-URRMxPQRKZacmaTn7jOs
Content-Disposition: attachment; filename="bluez-try-utf8-harder.patch"
Content-Type: text/x-patch; name="bluez-try-utf8-harder.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

diff --git a/src/security.c b/src/security.c
index a61d75f..75908ba 100644
--- a/src/security.c
+++ b/src/security.c
@@ -600,8 +600,16 @@ static inline void remote_name_information(int dev, bdaddr_t *sba, void *ptr)
 		memcpy(name, evt->name, 248);
 		/* It's ok to cast end between const and non-const since
 		 * we know it points to inside of name which is non-const */
-		if (!g_utf8_validate(name, -1, (const char **) &end))
-			*end = '\0';
+		if (!g_utf8_validate(name, -1, (const char **) &end)) {
+			char *utf8_name;
+
+			utf8_name = g_convert(name, -1, "UTF-8", "ISO-8859-1", NULL, NULL, NULL);
+			if (utf8_name) {
+				memcpy(name, utf8_name, 248);
+				g_free(utf8_name);
+			} else
+				*end = '\0';
+		}
 		write_device_name(sba, &dba, name);
 	}
 

--=-URRMxPQRKZacmaTn7jOs--

