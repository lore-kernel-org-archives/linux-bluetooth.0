Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 5/5] emulator: Enable Slave-initiated Features Exchange feature
Date: Thu, 27 Aug 2015 17:54:53 +0200
Message-Id: <1440690893-30384-5-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1440690893-30384-1-git-send-email-mariusz.skamra@tieto.com>
References: <1440690893-30384-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 emulator/btdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 1de0956..c00d71a 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -567,6 +567,7 @@ static void set_le_features(struct btdev *btdev)
 
 	btdev->le_features[0] |= 0x01;	/* LE Encryption */
 	btdev->le_features[0] |= 0x02;	/* Connection Parameters Request */
+	btdev->le_features[0] |= 0x08;	/* Slave-initiated Features Exchange */
 }
 
 static void set_amp_features(struct btdev *btdev)
-- 
2.4.3

