Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org
Subject: [PATCH v3 6/6] Bluetooth: Fix indentation
Date: Wed, 25 Jan 2012 19:52:29 -0300
Message-Id: <1327531949-29463-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1327531949-29463-1-git-send-email-andre.guedes@openbossa.org>
References: <1327531949-29463-1-git-send-email-andre.guedes@openbossa.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0a1fa4c..e7033c1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -44,7 +44,7 @@
 #define LE_SCAN_INT			0x12
 #define LE_SCAN_TIMEOUT_LE_ONLY		10240	/* TGAP(gen_disc_scan_min) */
 
-#define INQUIRY_LEN_BREDR 0x08 /* TGAP(100) */
+#define INQUIRY_LEN_BREDR		0x08	/* TGAP(100) */
 
 #define SERVICE_CACHE_TIMEOUT (5 * 1000)
 
-- 
1.7.8.4
