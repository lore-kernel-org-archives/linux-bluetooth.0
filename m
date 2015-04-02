Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 2 Apr 2015 09:15:14 +0530
Message-ID: <CAKafyqr3qcejbQWYQcMDCiOnjTnUC9Di8J0aKzBosm7Ft32vOw@mail.gmail.com>
Subject: [PATCH] andorid/handsfree.c setting sizeof struct properly for sco_handlers[]
From: Prabhu Chawandi <foss.chaws@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

diff --git a/android/handsfree.c b/android/handsfree.c
index 7cdc8b4..e6c4b1b 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -2891,7 +2891,7 @@ failed:

 static const struct ipc_handler sco_handlers[] = {
        /* SCO_OP_GET_FD */
-       { bt_sco_get_fd, false, 0 }
+       { bt_sco_get_fd, false, sizeof(struct sco_cmd_get_fd) }
 };

 static void bt_sco_unregister(void)
