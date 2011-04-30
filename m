Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 10/16] Add extfeatures to struct dev_info
Date: Fri, 29 Apr 2011 21:27:26 -0300
Message-Id: <1304123252-14464-11-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
References: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The extfeatures field will be used by hciops layer to know if the
adapter is LE capable.
---
 plugins/hciops.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 61ae404..965e9de 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -102,6 +102,7 @@ static struct dev_info {
 	char name[249];
 	uint8_t eir[HCI_MAX_EIR_LENGTH];
 	uint8_t features[8];
+	uint8_t extfeatures[8];
 	uint8_t ssp_mode;
 
 	int8_t tx_power;
@@ -1648,6 +1649,7 @@ static void read_local_ext_features_complete(int index,
 				const read_local_ext_features_rp *rp)
 {
 	struct btd_adapter *adapter;
+	struct dev_info *dev = &devs[index];
 
 	DBG("hci%d status %u", index, rp->status);
 
@@ -1664,6 +1666,7 @@ static void read_local_ext_features_complete(int index,
 	if (rp->page_num != 1)
 		return;
 
+	memcpy(dev->extfeatures, rp->features, sizeof(dev->extfeatures));
 	btd_adapter_update_local_ext_features(adapter, rp->features);
 }
 
-- 
1.7.1

