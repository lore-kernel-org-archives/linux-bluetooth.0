Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCHv2 2/6] emulator: Remove duplicated assignment
Date: Mon, 31 Aug 2015 12:18:04 +0200
Message-Id: <1441016288-23010-2-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1441016288-23010-1-git-send-email-mariusz.skamra@tieto.com>
References: <1441016288-23010-1-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <20150829032025.GA8367@t440s>
References: <20150829032025.GA8367@t440s>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Connection handle has been already assigned few lines earlier.
---
 emulator/btdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index f3ef1ca..77a83ef 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1130,8 +1130,6 @@ static void le_conn_complete(struct btdev *btdev,
 		cc->supv_timeout = lecc->supv_timeout;
 
 		send_event(remote, BT_HCI_EVT_LE_META_EVENT, buf, sizeof(buf));
-
-		cc->handle = cpu_to_le16(42);
 	}
 
 	cc->status = status;
-- 
2.4.3

