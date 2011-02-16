Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 16 Feb 2011 14:07:47 +0100
Message-ID: <AANLkTinBBdyyUR5-f=HMBNZ-38KnGdnU_M38kzcLuoBg@mail.gmail.com>
Subject: PATCH [1/2] batostr(): Switch byte order before converting
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=001636284618a21d54049c65f72f
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--001636284618a21d54049c65f72f
Content-Type: text/plain; charset=ISO-8859-1

The library function batostr() computes incorrect results because it
does not swap byte-ordering before converting the address. This patch
fixes this behaviour. It tries to make batostr() look like ba2str() to
be consistent.

Patch is also attached as x-patch file. Patch is done against most
recent git version.


diff --git a/lib/bluetooth.c b/lib/bluetooth.c
index 4af2ef6..dd7ca06 100644
--- a/lib/bluetooth.c
+++ b/lib/bluetooth.c
@@ -50,13 +50,14 @@ void baswap(bdaddr_t *dst, const bdaddr_t *src)

 char *batostr(const bdaddr_t *ba)
 {
+	uint8_t b[6];
 	char *str = bt_malloc(18);
 	if (!str)
 		return NULL;

+	baswap((bdaddr_t *) b, ba);
 	sprintf(str, "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
-		ba->b[0], ba->b[1], ba->b[2],
-		ba->b[3], ba->b[4], ba->b[5]);
+		b[0], b[1], b[2], b[3], b[4], b[5]);

 	return str;
 }

--001636284618a21d54049c65f72f
Content-Type: text/x-patch; charset=US-ASCII; name="bluez1.diff"
Content-Disposition: attachment; filename="bluez1.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gk89ccs40

ZGlmZiAtLWdpdCBhL2xpYi9ibHVldG9vdGguYyBiL2xpYi9ibHVldG9vdGguYwppbmRleCA0YWYy
ZWY2Li5kZDdjYTA2IDEwMDY0NAotLS0gYS9saWIvYmx1ZXRvb3RoLmMKKysrIGIvbGliL2JsdWV0
b290aC5jCkBAIC01MCwxMyArNTAsMTQgQEAgdm9pZCBiYXN3YXAoYmRhZGRyX3QgKmRzdCwgY29u
c3QgYmRhZGRyX3QgKnNyYykKIAogY2hhciAqYmF0b3N0cihjb25zdCBiZGFkZHJfdCAqYmEpCiB7
CisJdWludDhfdCBiWzZdOwogCWNoYXIgKnN0ciA9IGJ0X21hbGxvYygxOCk7CiAJaWYgKCFzdHIp
CiAJCXJldHVybiBOVUxMOwogCisJYmFzd2FwKChiZGFkZHJfdCAqKSBiLCBiYSk7CiAJc3ByaW50
ZihzdHIsICIlMi4yWDolMi4yWDolMi4yWDolMi4yWDolMi4yWDolMi4yWCIsCi0JCWJhLT5iWzBd
LCBiYS0+YlsxXSwgYmEtPmJbMl0sCi0JCWJhLT5iWzNdLCBiYS0+Yls0XSwgYmEtPmJbNV0pOwor
CQliWzBdLCBiWzFdLCBiWzJdLCBiWzNdLCBiWzRdLCBiWzVdKTsKIAogCXJldHVybiBzdHI7CiB9
Cg==
--001636284618a21d54049c65f72f--
