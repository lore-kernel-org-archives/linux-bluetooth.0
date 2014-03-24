Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] Bluetooth: Fix SMP confirmation callback handling
Date: Mon, 24 Mar 2014 14:39:05 +0200
Message-Id: <1395664748-13494-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1395664748-13494-1-git-send-email-johan.hedberg@gmail.com>
References: <1395664748-13494-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In the case that a local pairing confirmation (JUST_CFM) has been
selected as the method we need to use the user confirm request mgmt
event for it with the confirm_hint set to 1 (to indicate confirmation
without any specific passkey value). Without this (if passkey_notify was
used) the pairing would never proceed. This patch adds the necessary
call to mgmt_user_confirm_request in this scenario.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b8c31467a7ac..97e95c849fff 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -422,6 +422,10 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	if (method == REQ_PASSKEY)
 		ret = mgmt_user_passkey_request(hcon->hdev, &hcon->dst,
 						hcon->type, hcon->dst_type);
+	else if (method == JUST_CFM)
+		ret = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
+						hcon->type, hcon->dst_type,
+						passkey, 1);
 	else
 		ret = mgmt_user_passkey_notify(hcon->hdev, &hcon->dst,
 						hcon->type, hcon->dst_type,
-- 
1.8.5.3

