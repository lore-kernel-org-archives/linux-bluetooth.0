Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 6/6] Bluetooth: Fix indentation
Date: Wed,  1 Feb 2012 19:34:52 -0300
Message-Id: <1328135692-24255-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1328135692-24255-1-git-send-email-andre.guedes@openbossa.org>
References: <1328135692-24255-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes a #define indentation in mgmt.c.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
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
1.7.9

