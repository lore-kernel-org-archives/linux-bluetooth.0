Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtman.org, suraj@atheros.com,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH] Bluetooth: Fix permission of hci_ath.c
Date: Sat, 24 Jul 2010 01:06:05 -0300
Message-Id: <1279944365-15821-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

.c file shall not have the 'x' permission.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 0 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 drivers/bluetooth/hci_ath.c

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
old mode 100755
new mode 100644
-- 
1.7.1.1

