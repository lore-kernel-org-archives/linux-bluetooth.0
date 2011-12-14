Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] Bluetooth: Use correct struct for user_confirm_neg_reply
Date: Wed, 14 Dec 2011 23:52:04 +0200
Message-Id: <1323899524-13653-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1323899524-13653-1-git-send-email-johan.hedberg@gmail.com>
References: <1323899524-13653-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch fixes user_confirm_neg_reply to use the appropriate struct
for accessing the call parameters.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4d531b9..054229f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1690,7 +1690,7 @@ static int user_confirm_reply(struct sock *sk, u16 index, void *data, u16 len)
 static int user_confirm_neg_reply(struct sock *sk, u16 index, void *data,
 									u16 len)
 {
-	struct mgmt_cp_user_confirm_reply *cp = (void *) data;
+	struct mgmt_cp_user_confirm_neg_reply *cp = (void *) data;
 
 	BT_DBG("");
 
-- 
1.7.7.3

