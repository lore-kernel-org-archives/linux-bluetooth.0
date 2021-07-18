Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63746C636C9
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Jul 2021 02:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BF836109E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Jul 2021 02:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhGRCZL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Jul 2021 22:25:11 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50479 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhGRCZL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Jul 2021 22:25:11 -0400
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 16I2MAcJ001983;
        Sun, 18 Jul 2021 11:22:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Sun, 18 Jul 2021 11:22:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 16I2MADx001978
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 18 Jul 2021 11:22:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
In-Reply-To: <20210717000731.3836303-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, LinMa <linma@zju.edu.cn>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: RE: [RFC] Bluetooth: hci_sock: Fix calling lock_sock when handling
 HCI_DEV_UNREG
Message-ID: <7a0405c7-63ba-3e5c-7b22-503d7b326a11@i-love.sakura.ne.jp>
Date:   Sun, 18 Jul 2021 11:22:09 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Luiz Augusto von Dentz wrote:
> This removes the reference of hci_dev to hci_pinfo since the reference
> cannot prevent hdev to be freed hci_pinfo only keeps the index so in
> case the device is unregistered and freed hci_dev_get will return NULL
> thus prevent UAF.

I'm not convinced that this change is safe.

vhci_release() (which will call hci_unregister_dev(hdev)) is called when
refcount to /dev/vchi dropped to 0. That is, vhci_release() might be called
while e.g. hci_sock_bound_ioctl() is in progress.

Since hci_unregister_dev(hdev) calls list_del(&hdev->list) with hci_dev_list_lock
held for write, hci_dev_get(hci_pi(sk)->dev) which scans hci_dev_list with
hci_dev_list_lock held for read will start returning NULL. But I think that
this change introduces two race windows.

Since hci_unregister_dev(hdev) then calls hci_sock_dev_event(hdev, HCI_DEV_UNREG)
and finally calls ida_simple_remove(&hci_index_ida, id), subsequent
hci_register_dev(struct hci_dev *hdev) call can re-assign the id which
hci_pi(sk)->dev is tracking, by calling ida_simple_get() and finally calling
list_add(&hdev->list, &hci_dev_list) with hci_dev_list_lock held for write.

Therefore, I think that first race window is that

+	/* Commands may use copy_from_user which is unsafe while holding hdev as
+	 * it could be unregistered in the meantime.
+	 */
+	hci_dev_put(hdev);
+	hdev = NULL;

causes hci_sock_bound_ioctl() to check flags on an intended hdev and
e.g. hci_sock_reject_list_add() to operate on an unintended hdev.

Also, even if hci_sock_bound_ioctl() and hci_sock_reject_list_add() reached
the same hdev, I think that there still is second race window that

  hci_unregister_dev() {                       hci_sock_reject_list_add() {
                                                 hdev = hci_dev_get(hci_pi(sk)->dev);
    write_lock(&hci_dev_list_lock);
    list_del(&hdev->list);
    write_unlock(&hci_dev_list_lock);
    
    hci_sock_dev_event(hdev, HCI_DEV_UNREG);
    
    hci_dev_lock(hdev);
    hci_bdaddr_list_clear(&hdev->reject_list);
    hci_dev_unlock(hdev);
                                                 hci_dev_lock(hdev);
                                                 err = hci_bdaddr_list_add(&hdev->reject_list, &bdaddr, BDADDR_BREDR); // <= Adding after clear all; at least memory leak.
                                                 hci_dev_unlock(hdev);
                                                 hci_dev_put(hdev);
  }

. That is, an attempt to replace pointer reference with index number is racy.

After all, hci_sock_dev_event(hdev, HCI_DEV_UNREG) is responsible for
waiting for already started e.g. hci_sock_reject_list_add().
