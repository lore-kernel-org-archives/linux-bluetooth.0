Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Re: Work-around for broken MS device
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1236278908.3602.1896.camel@cookie.hadess.net>
References: <1236278908.3602.1896.camel@cookie.hadess.net>
Content-Type: multipart/mixed; boundary="=-ZdGoVYKaKgeFs+7tnG9P"
Date: Wed, 18 Mar 2009 17:27:59 +0000
Message-Id: <1237397279.15346.1157.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-ZdGoVYKaKgeFs+7tnG9P
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit

On Thu, 2009-03-05 at 18:48 +0000, Bastien Nocera wrote:
> Heya,
> 
> As seen in https://bugzilla.redhat.com/show_bug.cgi?id=450081
> The Microsoft Wireless Notebook Presenter Mouse 8000 has its name in
> ISO-8859-1 instead of UTF-8, as required by the BT spec.
> 
> I've implemented a small work-around. This isn't very invasive, IMO, as
> we already do UTF-8 checks.
> 
> In my tests, this makes the mouse show up as:
> Microsoft® Wireless Notebook Presenter Mouse 8000

Attached is patch in the proper format.

Cheers

--=-ZdGoVYKaKgeFs+7tnG9P
Content-Disposition: attachment; filename="0001-Try-harder-to-get-a-UTF-8-name-for-devices.patch"
Content-Type: text/x-patch; name="0001-Try-harder-to-get-a-UTF-8-name-for-devices.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit

>From eccafa2920607e9d702677dfce1098d63d13f1be Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Wed, 18 Mar 2009 17:24:36 +0000
Subject: [PATCH] Try harder to get a UTF-8 name for devices
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

The Microsoft Wireless Notebook Presenter Mouse 8000 has its name in
ISO-8859-1 instead of UTF-8, as required by the BT spec.

So we try to convert the name to UTF-8 from ISO-8859-1 instead of
just truncating the name. The mouse now shows up as:
MicrosoftÂ® Wireless Notebook Presenter Mouse 8000
---
 src/security.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

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
 
-- 
1.6.0.6


--=-ZdGoVYKaKgeFs+7tnG9P--

