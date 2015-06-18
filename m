Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 17/20] Bluetooth: mgmt: multi-adv for trigger_le_scan()
Date: Thu, 18 Jun 2015 03:16:50 +0200
Message-Id: <1434590213-26599-18-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434590213-26599-1-git-send-email-fgrandel@gmail.com>
References: <1434590213-26599-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
References: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch ensures that instance advertising is correctly canceled
before starting a le scan.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 net/bluetooth/mgmt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 57e27b7..f44c6e3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4215,6 +4215,7 @@ static bool trigger_le_scan(struct hci_request *req, u16 interval, u8 *status)
 			return false;
 		}
 
+		cancel_adv_timeout(hdev);
 		disable_advertising(req);
 	}
 
-- 
1.9.1

