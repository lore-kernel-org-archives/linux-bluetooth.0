Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH] Remove unused DISC_* macros
Date: Fri,  6 May 2011 15:22:14 -0300
Message-Id: <1304706134-1262-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.h |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/src/adapter.h b/src/adapter.h
index 9406b9b..0a5c392 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -42,13 +42,6 @@
 #define STATE_RESOLVNAME	2
 #define STATE_SUSPENDED		3
 
-/* Supported host/controller discover type */
-#define DISC_LE			0x01
-#define DISC_STDINQ		0x02
-#define DISC_INTERLEAVE		0x04
-#define DISC_PINQ		0x08
-#define DISC_RESOLVNAME		0x10
-
 #define MAX_NAME_LENGTH		248
 
 /* Invalid SSP passkey value used to indicate negative replies */
-- 
1.7.1

