Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 8/9] unit/crypto: Update unit test vectors after changes in singing process
Date: Wed, 28 May 2014 16:44:42 +0200
Message-Id: <1401288283-13480-15-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1401288283-13480-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1401288283-13480-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-crypto.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/unit/test-crypto.c b/unit/test-crypto.c
index 9bc072b..c5a6954 100644
--- a/unit/test-crypto.c
+++ b/unit/test-crypto.c
@@ -62,7 +62,7 @@ static const uint8_t msg_2[] = {
 };
 
 static const uint8_t t_msg_2[] = {
-	0x00, 0x00, 0x00, 0x00, 0x79, 0xc1, 0x60, 0x5b, 0x71, 0x32, 0x68, 0x59
+	0x00, 0x00, 0x00, 0x00, 0x27, 0x39, 0x74, 0xf4, 0x39, 0x2a, 0x23, 0x2a
 };
 
 static const struct test_data test_data_2 = {
@@ -79,7 +79,7 @@ static const uint8_t msg_3[] = {
 };
 
 static const uint8_t t_msg_3[12] = {
-	0x00, 0x00, 0x00, 0x00, 0x3e, 0xc3, 0x46, 0x95, 0x2c, 0xdf, 0x88, 0x32
+	0x00, 0x00, 0x00, 0x00, 0xb7, 0xca, 0x94, 0xab, 0x87, 0xc7, 0x82, 0x18
 };
 
 static const struct test_data test_data_3 = {
@@ -98,7 +98,7 @@ static const uint8_t msg_4[] = {
 };
 
 static const uint8_t t_msg_4[12] = {
-	0x00, 0x00, 0x00, 0x00, 0x43, 0x0c, 0xaa, 0x71, 0x19, 0x73, 0xbb, 0x59
+	0x00, 0x00, 0x00, 0x00, 0x44, 0xe1, 0xe6, 0xce, 0x1d, 0xf5, 0x13, 0x68
 };
 
 static const struct test_data test_data_4 = {
-- 
1.8.4

