Return-Path: <cyrus@holtmann.org>
From: David Scherba <dscherba@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, marcel@holtmann.org,
	rshaffer@codeaurora.org, David Scherba <dscherba@codeaurora.org>
Subject: [PATCH 1/2] Remove non-functional hci_devinfo calls in init_device()
Date: Tue, 10 Aug 2010 11:15:03 -0400
Message-Id: <1281453304-30408-2-git-send-email-dscherba@codeaurora.org>
In-Reply-To: <1281453304-30408-1-git-send-email-dscherba@codeaurora.org>
References: <1281453304-30408-1-git-send-email-dscherba@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/hciops.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 5775cf1..3e3e172 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -122,7 +122,6 @@ static void device_devup_setup(int index)
 static void init_device(int index)
 {
 	struct hci_dev_req dr;
-	struct hci_dev_info di;
 	pid_t pid;
 	int dd, err;
 
@@ -175,13 +174,6 @@ static void init_device(int index)
 		goto fail;
 	}
 
-	if (hci_devinfo(index, &di) < 0)
-		goto fail;
-
-	if (hci_test_bit(HCI_RAW, &di.flags))
-		goto done;
-
-done:
 	hci_close_dev(dd);
 	exit(0);
 
-- 
1.7.0.2
-- 
David Scherba
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
