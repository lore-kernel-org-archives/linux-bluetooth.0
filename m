Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 16/16] Remove 'periodic' param from hciops_start_inquiry()
Date: Fri, 29 Apr 2011 21:27:32 -0300
Message-Id: <1304123252-14464-17-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
References: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The 'periodic' parameter from hciops_start_inquiry() is useless.
This patch removes it.
---
 plugins/hciops.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index db3ca84..2c49e35 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -3073,13 +3073,13 @@ static int hciops_set_dev_class(int index, uint8_t major, uint8_t minor)
 	return err;
 }
 
-static int hciops_start_inquiry(int index, uint8_t length, gboolean periodic)
+static int hciops_start_inquiry(int index, uint8_t length)
 {
 	struct dev_info *dev = &devs[index];
 	uint8_t lap[3] = { 0x33, 0x8b, 0x9e };
 	inquiry_cp inq_cp;
 
-	DBG("hci%d length %u periodic %d", index, length, periodic);
+	DBG("hci%d length %u", index, length);
 
 	memset(&inq_cp, 0, sizeof(inq_cp));
 	memcpy(&inq_cp.lap, lap, 3);
@@ -3235,9 +3235,9 @@ static int hciops_start_discovery(int index)
 
 	switch (adapter_type) {
 	case BR_EDR_LE:
-		return hciops_start_inquiry(index, LENGTH_BR_LE_INQ, FALSE);
+		return hciops_start_inquiry(index, LENGTH_BR_LE_INQ);
 	case BR_EDR:
-		return hciops_start_inquiry(index, LENGTH_BR_INQ, FALSE);
+		return hciops_start_inquiry(index, LENGTH_BR_INQ);
 	case LE_ONLY:
 		return hciops_start_scanning(index, TIMEOUT_LE_SCAN);
 	default:
-- 
1.7.1

