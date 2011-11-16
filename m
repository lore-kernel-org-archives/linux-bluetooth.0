Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <padovan@profusion.mobi>
Cc: Brian Gix <bgix@codeaurora.org>
Subject: [PATCH-v4 1/9] Bluetooth: Add MGMT event for Passkey Entry
Date: Wed, 16 Nov 2011 13:53:12 -0800
Message-Id: <1321480400-17397-2-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1321480400-17397-1-git-send-email-bgix@codeaurora.org>
References: <1321480400-17397-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Brian Gix <bgix@codeaurora.org>
---
 include/net/bluetooth/mgmt.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 139610e..3b68806 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -358,3 +358,8 @@ struct mgmt_ev_device_blocked {
 struct mgmt_ev_device_unblocked {
 	bdaddr_t bdaddr;
 } __packed;
+
+#define MGMT_EV_USER_PASSKEY_REQUEST	0x0017
+struct mgmt_ev_user_passkey_request {
+	bdaddr_t bdaddr;
+} __packed;
-- 
1.7.7.2

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 
