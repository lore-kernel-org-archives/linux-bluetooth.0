Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B3BC00140
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Aug 2022 07:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240237AbiHEHM3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Aug 2022 03:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240233AbiHEHM2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Aug 2022 03:12:28 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1A513D13
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 00:12:23 -0700 (PDT)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2757CLI8078107;
        Fri, 5 Aug 2022 16:12:21 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Fri, 05 Aug 2022 16:12:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2757CKom078102
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 5 Aug 2022 16:12:20 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <244af2fe-5340-9e63-a354-d5ab7d155dc4@I-love.SAKURA.ne.jp>
Date:   Fri, 5 Aug 2022 16:12:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: [PATCH (urgent)] Bluetooth: don't try to cancel uninitialized works
 at mgmt_index_removed()
Content-Language: en-US
References: <00000000000008dcfa05e5672b3a@google.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Brian Gix <brian.gix@intel.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <00000000000008dcfa05e5672b3a@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot is reporting attempt to cancel uninitialized work at
mgmt_index_removed() [1], for calling cancel_delayed_work_sync() without
INIT_DELAYED_WORK() is not permitted.

INIT_DELAYED_WORK() is called from mgmt_init_hdev() via chan->hdev_init()
 from hci_mgmt_cmd(), but cancel_delayed_work_sync() is unconditionally
called from mgmt_index_removed().

Call cancel_delayed_work_sync() only if HCI_MGMT flag was set, for
mgmt_init_hdev() sets HCI_MGMT flag when calling INIT_DELAYED_WORK().

Link: https://syzkaller.appspot.com/bug?extid=b8ddd338a8838e581b1c [1]
Reported-by: syzbot <syzbot+b8ddd338a8838e581b1c@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 0ef08313cefdd60d ("Bluetooth: Convert delayed discov_off to hci_sync")
---
I can't test this patch due to lack of reproducer. But please review and
send to linux.git as soon as possible, for currently syzbot can't test
changes for 6.0-rc1 due to this problem (please see "Instances:" table at
https://syzkaller.appspot.com/upstream ).

syzbot was unable to test linux-next.git since 20220628 due to a different bug.
As an unfortunate result, this bug (being there since 20220725) which would have
been already found and fixed in linux-next.git arrived at linux.git...

 net/bluetooth/mgmt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f0bb2fc883d7..6e31023b84f5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8935,6 +8935,8 @@ void mgmt_index_removed(struct hci_dev *hdev)
 			 HCI_MGMT_EXT_INDEX_EVENTS);
 
 	/* Cancel any remaining timed work */
+	if (!hci_dev_test_flag(hdev, HCI_MGMT))
+		return;
 	cancel_delayed_work_sync(&hdev->discov_off);
 	cancel_delayed_work_sync(&hdev->service_cache);
 	cancel_delayed_work_sync(&hdev->rpa_expired);
-- 
2.34.1

