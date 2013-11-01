Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/6] android/ipc: Update HAL IPC header
Date: Fri,  1 Nov 2013 13:30:14 +0200
Message-Id: <1383305418-13619-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383305418-13619-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383305418-13619-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add ACL states to the header.
---
 android/hal-msg.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 8a344d8..1d256f2 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -405,6 +405,9 @@ struct hal_ev_bond_state_changed {
 	uint8_t state;
 } __attribute__((packed));
 
+#define HAL_ACL_STATE_CONNECTED		0x00
+#define HAL_ACL_STATE_DISCONNECTED	0x01
+
 #define HAL_EV_ACL_STATE_CHANGED	0x89
 struct hal_ev_acl_state_changed {
 	uint8_t status;
-- 
1.7.10.4

