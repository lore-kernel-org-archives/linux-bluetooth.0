Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 23 Feb 2010 12:06:14 +0200
Message-ID: <2d5a2c101002230206r5a945ec0hd8b638f171440a33@mail.gmail.com>
Subject: [PATCH 1/2] Fix service driver selection when WHO header is informed
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=0016e6d7e8722d103f048041b397
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--0016e6d7e8722d103f048041b397
Content-Type: text/plain; charset=ISO-8859-1

Drivers which support WHO header should be checked first since they have
priority e.g. pcsuite over ftp.
---
 src/service.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/service.c b/src/service.c
index 196a5c1..c6ce101 100644
--- a/src/service.c
+++ b/src/service.c
@@ -49,8 +49,8 @@ struct obex_service_driver
*obex_service_driver_find(GSList *list,
 		struct obex_service_driver *driver = l->data;

 		if (driver->who && who &&
-				driver->who_size == who_size &&
-				memcmp(driver->who, who, who_size) != 0)
+				(driver->who_size != who_size ||
+				memcmp(driver->who, who, who_size) != 0))
 			continue;

 		if (driver->target == NULL && target == NULL)
@@ -97,7 +97,11 @@ int obex_service_driver_register(struct
obex_service_driver *driver)

 	debug("driver %p service %s registered", driver, driver->name);

-	drivers = g_slist_append(drivers, driver);
+	/* Drivers that support who has priority */
+	if (driver->who)
+		drivers = g_slist_prepend(drivers, driver);
+	else
+		drivers = g_slist_append(drivers, driver);

 	return 0;
 }
-- 
1.6.3.3

-- 
Luiz Augusto von Dentz
Computer Engineer

--0016e6d7e8722d103f048041b397
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Fix-service-driver-selection-when-WHO-header-is-info.patch"
Content-Disposition: attachment;
	filename="0001-Fix-service-driver-selection-when-WHO-header-is-info.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g60j6o8l0

RnJvbSBjY2U2MzM5M2M0MGU1NWRkYmRiYzgyNDFiZGRhZWNkYjVkNzMwNmVmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gVm9uIERlbnR6IDxsdWl6LmRlbnR6LXZv
bkBub2tpYS5jb20+CkRhdGU6IE1vbiwgMjIgRmViIDIwMTAgMTc6MjY6MjYgKzAyMDAKU3ViamVj
dDogW1BBVENIIDEvMl0gRml4IHNlcnZpY2UgZHJpdmVyIHNlbGVjdGlvbiB3aGVuIFdITyBoZWFk
ZXIgaXMgaW5mb3JtZWQKCkRyaXZlcnMgd2hpY2ggc3VwcG9ydCBXSE8gaGVhZGVyIHNob3VsZCBi
ZSBjaGVja2VkIGZpcnN0IHNpbmNlIHRoZXkgaGF2ZQpwcmlvcml0eSBlLmcuIHBjc3VpdGUgb3Zl
ciBmdHAuCi0tLQogc3JjL3NlcnZpY2UuYyB8ICAgMTAgKysrKysrKy0tLQogMSBmaWxlcyBjaGFu
Z2VkLCA3IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL3Nl
cnZpY2UuYyBiL3NyYy9zZXJ2aWNlLmMKaW5kZXggMTk2YTVjMS4uYzZjZTEwMSAxMDA2NDQKLS0t
IGEvc3JjL3NlcnZpY2UuYworKysgYi9zcmMvc2VydmljZS5jCkBAIC00OSw4ICs0OSw4IEBAIHN0
cnVjdCBvYmV4X3NlcnZpY2VfZHJpdmVyICpvYmV4X3NlcnZpY2VfZHJpdmVyX2ZpbmQoR1NMaXN0
ICpsaXN0LAogCQlzdHJ1Y3Qgb2JleF9zZXJ2aWNlX2RyaXZlciAqZHJpdmVyID0gbC0+ZGF0YTsK
IAogCQlpZiAoZHJpdmVyLT53aG8gJiYgd2hvICYmCi0JCQkJZHJpdmVyLT53aG9fc2l6ZSA9PSB3
aG9fc2l6ZSAmJgotCQkJCW1lbWNtcChkcml2ZXItPndobywgd2hvLCB3aG9fc2l6ZSkgIT0gMCkK
KwkJCQkoZHJpdmVyLT53aG9fc2l6ZSAhPSB3aG9fc2l6ZSB8fAorCQkJCW1lbWNtcChkcml2ZXIt
Pndobywgd2hvLCB3aG9fc2l6ZSkgIT0gMCkpCiAJCQljb250aW51ZTsKIAogCQlpZiAoZHJpdmVy
LT50YXJnZXQgPT0gTlVMTCAmJiB0YXJnZXQgPT0gTlVMTCkKQEAgLTk3LDcgKzk3LDExIEBAIGlu
dCBvYmV4X3NlcnZpY2VfZHJpdmVyX3JlZ2lzdGVyKHN0cnVjdCBvYmV4X3NlcnZpY2VfZHJpdmVy
ICpkcml2ZXIpCiAKIAlkZWJ1ZygiZHJpdmVyICVwIHNlcnZpY2UgJXMgcmVnaXN0ZXJlZCIsIGRy
aXZlciwgZHJpdmVyLT5uYW1lKTsKIAotCWRyaXZlcnMgPSBnX3NsaXN0X2FwcGVuZChkcml2ZXJz
LCBkcml2ZXIpOworCS8qIERyaXZlcnMgdGhhdCBzdXBwb3J0IHdobyBoYXMgcHJpb3JpdHkgKi8K
KwlpZiAoZHJpdmVyLT53aG8pCisJCWRyaXZlcnMgPSBnX3NsaXN0X3ByZXBlbmQoZHJpdmVycywg
ZHJpdmVyKTsKKwllbHNlCisJCWRyaXZlcnMgPSBnX3NsaXN0X2FwcGVuZChkcml2ZXJzLCBkcml2
ZXIpOwogCiAJcmV0dXJuIDA7CiB9Ci0tIAoxLjYuMy4zCgo=
--0016e6d7e8722d103f048041b397--
