Return-Path: <cyrus@holtmann.org>
From: Alok Barsode <alokbarsode@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 4/8] Using device_event to register and setup already known devices.
Date: Mon, 27 Apr 2009 19:45:41 +0530
Message-Id: <1240841745-11006-4-git-send-email-alok.barsode@gmail.com>
In-Reply-To: <1240841745-11006-1-git-send-email-alok.barsode@gmail.com>
References: <1240841745-11006-1-git-send-email-alok.barsode@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 src/main.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/src/main.c b/src/main.c
index d12edc5..93dbf71 100644
--- a/src/main.c
+++ b/src/main.c
@@ -531,14 +531,11 @@ static void init_all_devices(int ctl)
 	for (i = 0; i < dl->dev_num; i++, dr++) {
 		gboolean devup;
 
-		info("HCI dev %d registered", dr->dev_id);
-		device_devreg_setup(dr->dev_id);
+		device_event(HCI_DEV_REG, dr->dev_id);
 
 		devup = hci_test_bit(HCI_UP, &dr->dev_opt);
-		if (devup) {
-			info("HCI dev %d already up", dr->dev_id);
-			device_devup_setup(dr->dev_id);
-		}
+		if (devup)
+			device_event(HCI_DEV_UP, dr->dev_id);
 	}
 
 	g_free(dl);
-- 
1.5.6.3
