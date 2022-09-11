Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D72ECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Sun, 11 Sep 2022 16:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiIKQW1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 11 Sep 2022 12:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiIKQWU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 11 Sep 2022 12:22:20 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DD11573C
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Sep 2022 09:22:04 -0700 (PDT)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 28BGLoL3041722;
        Mon, 12 Sep 2022 01:21:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Mon, 12 Sep 2022 01:21:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 28BGLj2T041708
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 12 Sep 2022 01:21:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f6de02d1-dcda-0383-739d-27484b4d5c63@I-love.SAKURA.ne.jp>
Date:   Mon, 12 Sep 2022 01:21:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: [PATCH] Bluetooth: avoid hci_dev_test_and_set_flag() in
 mgmt_init_hdev()
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     syzbot <syzbot+844c7bf1b1aa4119c5de@syzkaller.appspotmail.com>,
        linux-bluetooth@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000532e0e05e826413c@google.com>
 <d2d763e3-0dc8-03df-45ba-8d5c4a25acda@I-love.SAKURA.ne.jp>
In-Reply-To: <d2d763e3-0dc8-03df-45ba-8d5c4a25acda@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot is again reporting attempt to cancel uninitialized work
at mgmt_index_removed() [1], for setting of HCI_MGMT flag from
mgmt_init_hdev() from hci_mgmt_cmd() from hci_sock_sendmsg() can
race with testing of HCI_MGMT flag from mgmt_index_removed() from
hci_sock_bind() due to lack of serialization via hci_dev_lock().

Since mgmt_init_hdev() is called with mgmt_chan_list_lock held, we can
safely split hci_dev_test_and_set_flag() into hci_dev_test_flag() and
hci_dev_set_flag(). Thus, in order to close this race, set HCI_MGMT flag
after INIT_DELAYED_WORK() completed.

This is a local fix based on mgmt_chan_list_lock. Lack of serialization
via hci_dev_lock() might be causing different race conditions somewhere
else. But a global fix based on hci_dev_lock() should deserve a future
patch.

Link: https://syzkaller.appspot.com/bug?extid=844c7bf1b1aa4119c5de
Reported-by: syzbot+844c7bf1b1aa4119c5de@syzkaller.appspotmail.com
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 3f2893d3c142986a ("Bluetooth: don't try to cancel uninitialized works at mgmt_index_removed()")
---
 net/bluetooth/mgmt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 72e6595a71cc..3d1cd0666968 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1050,7 +1050,7 @@ static void discov_off(struct work_struct *work)
 
 static void mgmt_init_hdev(struct sock *sk, struct hci_dev *hdev)
 {
-	if (hci_dev_test_and_set_flag(hdev, HCI_MGMT))
+	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		return;
 
 	BT_INFO("MGMT ver %d.%d", MGMT_VERSION, MGMT_REVISION);
@@ -1065,6 +1065,8 @@ static void mgmt_init_hdev(struct sock *sk, struct hci_dev *hdev)
 	 * it
 	 */
 	hci_dev_clear_flag(hdev, HCI_BONDABLE);
+
+	hci_dev_set_flag(hdev, HCI_MGMT);
 }
 
 static int read_controller_info(struct sock *sk, struct hci_dev *hdev,
-- 
2.18.4

