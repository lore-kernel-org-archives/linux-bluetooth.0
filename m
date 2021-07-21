Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6A3C6377B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jul 2021 23:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EBDD6121F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jul 2021 23:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhGUXBq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jul 2021 19:01:46 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:65447 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhGUXBq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jul 2021 19:01:46 -0400
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 16LNg7Gm072890;
        Thu, 22 Jul 2021 08:42:07 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Thu, 22 Jul 2021 08:42:07 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 16LNg7wL072882
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Jul 2021 08:42:07 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] Bluetooth: reorganize ioctls from hci_sock_bound_ioctl()
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        LinMa <linma@zju.edu.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210720104905.6870-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <CABBYNZLt=fJTtdj9qvC22GkF_uYFe59D2bS3u61K14=Gq43Qbw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <bb9ceb4d-9e5c-1487-233b-426bc58e9a91@i-love.sakura.ne.jp>
Date:   Thu, 22 Jul 2021 08:42:05 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZLt=fJTtdj9qvC22GkF_uYFe59D2bS3u61K14=Gq43Qbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2021/07/22 3:17, Luiz Augusto von Dentz wrote:
> I think it would have been cleaner if we have dedicated functions for
> each command like I did in my patch:
> 
> https://patchwork.kernel.org/project/bluetooth/patch/20210717000731.3836303-1-luiz.dentz@gmail.com/

But your patch was proven to be unsafe. There is a use-after-unregister
race window which would require at least 1000 lines of modification and
a lot of careful review if we try to manage without my patch.
Such all-in-one-step change is too much for "sleep in atomic context"
regression fix which is preventing syzbot from testing Bluetooth module
and is preventing Linux distributors from fixing CVE-2021-3573.

As far as I can see, it is lock_sock() (not bh_lock_sock_nested() in your
patch) that is needed for protecting

	sk->sk_err = EPIPE;
	sk->sk_state = BT_OPEN;
	sk->sk_state_change(sk);

in hci_sock_dev_event(HCI_DEV_UNREG) from concurrent modification

	lock_sock(sk);

	if (sk->sk_state == BT_BOUND) {
		err = -EALREADY;
		goto done;
	}

	(...snipped...)

-		hci_pi(sk)->hdev = hdev;
+		if (hdev) {
+			hci_pi(sk)->dev = hdev->id;
+			hci_dev_put(hdev);
+		}

	(...snipped...)
	/* Race window is here. */
	(...snipped...)

	sk->sk_state = BT_BOUND;
done:
	release_sock(sk);

in hci_sock_bind().

> 
> That way it is simpler to protect the likes of
> copy_from_user/copy_to_user, etc, even if we have to some checks
> duplicated on each function we can have a helper function to checks
> the flags, etc.

My patch calls copy_from_user()/copy_to_user() without lock_sock()
which works nicely with "[PATCH v3] Bluetooth: call lock_sock() outside
of spinlock section". I'd like to backport "[PATCH v2] Bluetooth:
reorganize ioctls from hci_sock_bound_ioctl()" together.

