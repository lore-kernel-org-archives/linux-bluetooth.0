Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E20C636CA
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Jul 2021 06:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A34B261176
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Jul 2021 06:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhGRGZG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Jul 2021 02:25:06 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59747 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhGRGZG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Jul 2021 02:25:06 -0400
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 16I6M5AS079098;
        Sun, 18 Jul 2021 15:22:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Sun, 18 Jul 2021 15:22:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 16I6M5Jh079094
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 18 Jul 2021 15:22:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC] Bluetooth: hci_sock: Fix calling lock_sock when handling
 HCI_DEV_UNREG
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        LinMa <linma@zju.edu.cn>
References: <20210717000731.3836303-1-luiz.dentz@gmail.com>
 <7a0405c7-63ba-3e5c-7b22-503d7b326a11@i-love.sakura.ne.jp>
 <CABBYNZLdYXHxD47xO+TX6U=MK1RtvuAAHLYvS1vTsuk4nFQfrg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <166a8c6d-9928-4edf-8082-111e555f5808@i-love.sakura.ne.jp>
Date:   Sun, 18 Jul 2021 15:22:03 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZLdYXHxD47xO+TX6U=MK1RtvuAAHLYvS1vTsuk4nFQfrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2021/07/18 14:16, Luiz Augusto von Dentz wrote:
> Anyway after all these discussion Im even
> more convinced that the real problem lies in hci_dev_get/hold, after
> all references are usually used to prevent the objects to be freed but
> in this case it doesn't and no locking will gonna fix that.

If hci_dev_hold() calls atomic_long_add_unless(&file->f_count, 1, 0) under RCU,
vhci_release(file) would not be called until all sockets using that hdev drops
the reference, and hci_sock_dev_event(hdev, HCI_DEV_UNREG) no longer needs to
traverse sockets on hci_sk_list.head list. This requires adding "struct file *" to
"struct hci_dev". My patch keeps changes be confined to only hci_sock_dev_event().
