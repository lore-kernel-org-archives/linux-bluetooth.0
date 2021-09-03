Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D89C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 04:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E41861059
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 04:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhICEl0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Sep 2021 00:41:26 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56708 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbhICElZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Sep 2021 00:41:25 -0400
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1834eBIB061707;
        Fri, 3 Sep 2021 13:40:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Fri, 03 Sep 2021 13:40:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1834eBWj061704
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 3 Sep 2021 13:40:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] Bluetooth: avoid page fault from sco_send_frame()
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     LinMa <linma@zju.edu.cn>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <15f5a46.b79d9.17ba6802ccd.Coremail.linma@zju.edu.cn>
 <c998d16d-f45a-8be4-2898-9e94509cb2ea@i-love.sakura.ne.jp>
 <60f604f8-2a89-fd3f-996f-9d9e4a229427@i-love.sakura.ne.jp>
 <CABBYNZK-JvPcB_T39_NUE-O6ztE6crNEfmFxszEtAu3OkrKF2A@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <a7bed103-dbb1-6783-aba7-f18a4d495c13@i-love.sakura.ne.jp>
Date:   Fri, 3 Sep 2021 13:40:12 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZK-JvPcB_T39_NUE-O6ztE6crNEfmFxszEtAu3OkrKF2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2021/09/03 12:48, Luiz Augusto von Dentz wrote:
> There is a set already handing this sort of problem:
> 
> https://patchwork.kernel.org/project/bluetooth/patch/20210901002621.414016-3-luiz.dentz@gmail.com/

OK, I didn't know that. (I'm not subscribed to bluethooth ML.)

But can we please keep the fix minimal? Multiple distributors are
waiting for the fix (which can be backported) for more than one month.

  https://security-tracker.debian.org/tracker/CVE-2021-3640
  https://access.redhat.com/security/cve/cve-2021-3640

And it looks to me that your
"[3/4] Bluetooth: SCO: Replace use of memcpy_from_msg with bt_skb_sendmsg"
contains a new use-after-free or memory corruption bug...   :-(

