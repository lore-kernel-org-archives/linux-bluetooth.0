Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 02/17] android: trivial: Add comment making code consistent
Date: Mon, 18 Nov 2013 15:20:39 +0200
Message-Id: <1384780854-20970-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384780854-20970-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384780854-20970-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-msg.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 44fd5c8..9e3a81f 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -232,6 +232,8 @@ struct hal_cmd_sock_connect {
 	uint8_t  flags;
 } __attribute__((packed));
 
+/* Bluetooth Hidhost HAL api */
+
 #define HAL_OP_HIDHOST_CONNECT		0x01
 struct hal_cmd_hidhost_connect {
 	uint8_t bdaddr[6];
-- 
1.7.10.4

