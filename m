Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: mgmt: Fix Set SSP check for supported feature
Date: Tue, 21 Feb 2012 00:24:36 +0200
Message-Id: <1329776676-22800-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329776676-22800-1-git-send-email-johan.hedberg@gmail.com>
References: <1329776676-22800-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If the local controller doesn't support SSP we should always return an
error for the Set SSP command.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4281331..508354a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1065,6 +1065,12 @@ static int set_ssp(struct sock *sk, u16 index, void *data, u16 len)
 		goto failed;
 	}
 
+	if (!(hdev->features[6] & LMP_SIMPLE_PAIR)) {
+		err = cmd_status(sk, index, MGMT_OP_SET_SSP,
+						MGMT_STATUS_NOT_SUPPORTED);
+		goto failed;
+	}
+
 	if (mgmt_pending_find(MGMT_OP_SET_SSP, hdev)) {
 		err = cmd_status(sk, index, MGMT_OP_SET_SSP, MGMT_STATUS_BUSY);
 		goto failed;
-- 
1.7.9

