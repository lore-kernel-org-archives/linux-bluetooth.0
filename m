Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCHv2 5/6] emulator: Enable Slave-initiated Features Exchange feature
Date: Mon, 31 Aug 2015 12:18:07 +0200
Message-Id: <1441016288-23010-5-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1441016288-23010-1-git-send-email-mariusz.skamra@tieto.com>
References: <1441016288-23010-1-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <20150829032025.GA8367@t440s>
References: <20150829032025.GA8367@t440s>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 emulator/btdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index a3c73d9..7ff750d 100644
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

