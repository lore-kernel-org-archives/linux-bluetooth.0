Return-Path: <cyrus@holtmann.org>
From: Shailendra Verma <shailendra.capricorn@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Shailendra Verma <shailendra.capricorn@gmail.com>
Subject: [PATCH] bluetooth:hci_bcsp - Change 1 to true for bool type variables assignments.
Date: Tue, 26 May 2015 00:00:57 +0530
Message-Id: <1432578657-4351-1-git-send-email-shailendra.capricorn@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The variables txcrc and hciextn are bool type.So assigning true 
instead of 1.

Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
---
 drivers/bluetooth/hci_bcsp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index dc8e3d4..fc0056a 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -47,8 +47,8 @@
 
 #include "hci_uart.h"
 
-static bool txcrc = 1;
-static bool hciextn = 1;
+static bool txcrc = true;
+static bool hciextn = true;
 
 #define BCSP_TXWINSIZE	4
 
-- 
1.7.9.5
