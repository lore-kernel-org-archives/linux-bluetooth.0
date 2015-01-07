Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v6 1/3] Bluetooth: Add marker to hci_req_ctrl
Date: Wed,  7 Jan 2015 05:10:52 -0800
Message-Id: <1420636254-25626-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add marker field to hci_req_ctrl struct. It can be used to
mark packets, so that they can be distinguished later and alter
processing. Example: packet that disable LE scan can be marked. It
would mean, that it's part of scan restart, and would be processed
differently.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/bluetooth.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 58695ff..7ae372d 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -277,6 +277,7 @@ typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status);
 
 struct hci_req_ctrl {
 	bool			start;
+	bool			marker;
 	u8			event;
 	hci_req_complete_t	complete;
 };
-- 
2.2.0.rc0.207.ga3a616c

