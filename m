Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] hciemu: Make code consistent
Date: Mon, 16 Dec 2013 10:57:40 +0200
Message-Id: <1387184262-21439-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1387184262-21439-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1387184262-21439-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

It is enough to check for zero in __sync_sub_and_fetch(). This  makes
code consistent like shown below:

./src/shared/mgmt.c:    if (__sync_sub_and_fetch(&mgmt->ref_count, 1))
./src/shared/pcap.c:    if (__sync_sub_and_fetch(&pcap->ref_count, 1))
./src/shared/btsnoop.c: if (__sync_sub_and_fetch(&btsnoop->ref_count, 1))
./src/shared/hciemu.c:  if (__sync_sub_and_fetch(&hciemu->ref_count, 1))
---
 src/shared/hciemu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/hciemu.c b/src/shared/hciemu.c
index 0ea191f..c2b4748 100644
--- a/src/shared/hciemu.c
+++ b/src/shared/hciemu.c
@@ -341,7 +341,7 @@ void hciemu_unref(struct hciemu *hciemu)
 	if (!hciemu)
 		return;
 
-	if (__sync_sub_and_fetch(&hciemu->ref_count, 1) > 0)
+	if (__sync_sub_and_fetch(&hciemu->ref_count, 1))
 		return;
 
 	g_list_foreach(hciemu->post_command_hooks, destroy_command_hook, NULL);
-- 
1.8.3.2

