Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 06/22] lib: Fix using old-style initializers
Date: Fri, 10 Feb 2012 18:39:51 -0300
Message-Id: <1328910007-25604-7-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/hci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/hci.c b/lib/hci.c
index b122313..269c021 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -860,7 +860,7 @@ done:
 
 static int __other_bdaddr(int dd, int dev_id, long arg)
 {
-	struct hci_dev_info di = { dev_id: dev_id };
+	struct hci_dev_info di = { .dev_id = dev_id };
 
 	if (ioctl(dd, HCIGETDEVINFO, (void *) &di))
 		return 0;
@@ -873,7 +873,7 @@ static int __other_bdaddr(int dd, int dev_id, long arg)
 
 static int __same_bdaddr(int dd, int dev_id, long arg)
 {
-	struct hci_dev_info di = { dev_id: dev_id };
+	struct hci_dev_info di = { .dev_id = dev_id };
 
 	if (ioctl(dd, HCIGETDEVINFO, (void *) &di))
 		return 0;
-- 
1.7.8.1

