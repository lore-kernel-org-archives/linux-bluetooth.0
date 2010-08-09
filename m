Return-Path: <cyrus@holtmann.org>
From: David Scherba <dscherba@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, marcel@holtmann.org,
	rshaffer@codeaurora.org, David Scherba <dscherba@codeaurora.org>
Subject: [PATCH 1/2] Remove non-functional hci_devinfo calls in init_device()
Date: Mon,  9 Aug 2010 17:07:38 -0400
Message-Id: <1281388059-15945-2-git-send-email-dscherba@codeaurora.org>
In-Reply-To: <1281388059-15945-1-git-send-email-dscherba@codeaurora.org>
References: <1281388059-15945-1-git-send-email-dscherba@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/hciops.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 5775cf1..b38c056 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -175,12 +175,6 @@ static void init_device(int index)
 		goto fail;
 	}
 
-	if (hci_devinfo(index, &di) < 0)
-		goto fail;
-
-	if (hci_test_bit(HCI_RAW, &di.flags))
-		goto done;
-
 done:
 	hci_close_dev(dd);
 	exit(0);
-- 
1.7.0
-- 
David Scherba
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

