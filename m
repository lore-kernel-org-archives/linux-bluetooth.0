Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 23 Feb 2010 12:07:24 +0200
Message-ID: <2d5a2c101002230207h3e3f5da8p1917c273fb27943a@mail.gmail.com>
Subject: [PATCH 2/2] Fix pcsuite WHO header
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=0016e6d99f6f5f7119048041b788
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--0016e6d99f6f5f7119048041b788
Content-Type: text/plain; charset=ISO-8859-1

---
 plugins/ftp.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/plugins/ftp.c b/plugins/ftp.c
index e0a3b97..c3a4193 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -93,6 +93,7 @@
 </record>"

 #define PCSUITE_CHANNEL        24
+#define PCSUITE_WHO_SIZE 8
 #define PCSUITE_RECORD "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>
                                 \
 <record>
         \
   <attribute id=\"0x0001\">
         \
@@ -140,9 +141,8 @@ static const guint8 FTP_TARGET[TARGET_SIZE] = {
 			0xF9, 0xEC, 0x7B, 0xC4,  0x95, 0x3C, 0x11, 0xD2,
 			0x98, 0x4E, 0x52, 0x54,  0x00, 0xDC, 0x9E, 0x09  };

-static const guint8 PCSUITE_TARGET[TARGET_SIZE] = {
-			0x00, 0x00, 0x50, 0x05, 0x00, 0x00, 0x10, 0x00,
-			0x80, 0x00, 0x00, 0x02, 0xEE, 0x00, 0x00, 0x01 };
+static const guint8 PCSUITE_WHO[PCSUITE_WHO_SIZE] = {
+			'P','C',' ','S','u','i','t','e' };

 static gint get_by_type(struct obex_session *os, gchar *type, size_t *size)
 {
@@ -464,8 +464,8 @@ struct obex_service_driver pcsuite = {
 	.record = PCSUITE_RECORD,
 	.target = FTP_TARGET,
 	.target_size = TARGET_SIZE,
-	.who = PCSUITE_TARGET,
-	.who_size = TARGET_SIZE,
+	.who = PCSUITE_WHO,
+	.who_size = PCSUITE_WHO_SIZE,
 	.connect = ftp_connect,
 	.get = ftp_get,
 	.put = ftp_put,
-- 
1.6.3.3


-- 
Luiz Augusto von Dentz
Computer Engineer

--0016e6d99f6f5f7119048041b788
Content-Type: text/x-patch; charset=US-ASCII; name="0002-Fix-pcsuite-WHO-header.patch"
Content-Disposition: attachment;
	filename="0002-Fix-pcsuite-WHO-header.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g60j8hx90

RnJvbSA0MDMzNGQwNjNmYjM0ZWY2MDg1ODk3YWQ2OThkODNkNWEwODAzNTUxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gVm9uIERlbnR6IDxsdWl6LmRlbnR6LXZv
bkBub2tpYS5jb20+CkRhdGU6IE1vbiwgMjIgRmViIDIwMTAgMTc6MzY6NTEgKzAyMDAKU3ViamVj
dDogW1BBVENIIDIvMl0gRml4IHBjc3VpdGUgV0hPIGhlYWRlcgoKLS0tCiBwbHVnaW5zL2Z0cC5j
IHwgICAxMCArKysrKy0tLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9wbHVnaW5zL2Z0cC5jIGIvcGx1Z2lucy9mdHAuYwpp
bmRleCBlMGEzYjk3Li5jM2E0MTkzIDEwMDY0NAotLS0gYS9wbHVnaW5zL2Z0cC5jCisrKyBiL3Bs
dWdpbnMvZnRwLmMKQEAgLTkzLDYgKzkzLDcgQEAKIDwvcmVjb3JkPiIKIAogI2RlZmluZSBQQ1NV
SVRFX0NIQU5ORUwgICAgICAgIDI0CisjZGVmaW5lIFBDU1VJVEVfV0hPX1NJWkUgOAogI2RlZmlu
ZSBQQ1NVSVRFX1JFQ09SRCAiPD94bWwgdmVyc2lvbj1cIjEuMFwiIGVuY29kaW5nPVwiVVRGLThc
IiA/PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKIDxyZWNvcmQ+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcCiAgIDxhdHRyaWJ1dGUgaWQ9XCIweDAwMDFcIj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXApAQCAtMTQwLDkgKzE0MSw4IEBAIHN0
YXRpYyBjb25zdCBndWludDggRlRQX1RBUkdFVFtUQVJHRVRfU0laRV0gPSB7CiAJCQkweEY5LCAw
eEVDLCAweDdCLCAweEM0LCAgMHg5NSwgMHgzQywgMHgxMSwgMHhEMiwKIAkJCTB4OTgsIDB4NEUs
IDB4NTIsIDB4NTQsICAweDAwLCAweERDLCAweDlFLCAweDA5ICB9OwogCi1zdGF0aWMgY29uc3Qg
Z3VpbnQ4IFBDU1VJVEVfVEFSR0VUW1RBUkdFVF9TSVpFXSA9IHsKLQkJCTB4MDAsIDB4MDAsIDB4
NTAsIDB4MDUsIDB4MDAsIDB4MDAsIDB4MTAsIDB4MDAsCi0JCQkweDgwLCAweDAwLCAweDAwLCAw
eDAyLCAweEVFLCAweDAwLCAweDAwLCAweDAxIH07CitzdGF0aWMgY29uc3QgZ3VpbnQ4IFBDU1VJ
VEVfV0hPW1BDU1VJVEVfV0hPX1NJWkVdID0geworCQkJJ1AnLCdDJywnICcsJ1MnLCd1JywnaScs
J3QnLCdlJyB9OwogCiBzdGF0aWMgZ2ludCBnZXRfYnlfdHlwZShzdHJ1Y3Qgb2JleF9zZXNzaW9u
ICpvcywgZ2NoYXIgKnR5cGUsIHNpemVfdCAqc2l6ZSkKIHsKQEAgLTQ2NCw4ICs0NjQsOCBAQCBz
dHJ1Y3Qgb2JleF9zZXJ2aWNlX2RyaXZlciBwY3N1aXRlID0gewogCS5yZWNvcmQgPSBQQ1NVSVRF
X1JFQ09SRCwKIAkudGFyZ2V0ID0gRlRQX1RBUkdFVCwKIAkudGFyZ2V0X3NpemUgPSBUQVJHRVRf
U0laRSwKLQkud2hvID0gUENTVUlURV9UQVJHRVQsCi0JLndob19zaXplID0gVEFSR0VUX1NJWkUs
CisJLndobyA9IFBDU1VJVEVfV0hPLAorCS53aG9fc2l6ZSA9IFBDU1VJVEVfV0hPX1NJWkUsCiAJ
LmNvbm5lY3QgPSBmdHBfY29ubmVjdCwKIAkuZ2V0ID0gZnRwX2dldCwKIAkucHV0ID0gZnRwX3B1
dCwKLS0gCjEuNi4zLjMKCg==
--0016e6d99f6f5f7119048041b788--
