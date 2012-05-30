Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v2 01/15] sdp: Remove unused BASE_UUID definition
Date: Wed, 30 May 2012 14:59:54 +0200
Message-Id: <1338382808-29725-2-git-send-email-wagi@monom.org>
In-Reply-To: <1338382808-29725-1-git-send-email-wagi@monom.org>
References: <1338382808-29725-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 lib/sdp.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index de5277f..7cb930f 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -60,8 +60,6 @@
 #define SDPDBG(fmt...)
 #endif
 
-#define BASE_UUID "00000000-0000-1000-8000-00805F9B34FB"
-
 static uint128_t bluetooth_base_uuid = {
 	.data = {	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
 			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB }
-- 
1.7.10.130.g36e6c

