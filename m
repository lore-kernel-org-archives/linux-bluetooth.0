Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72B8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Sep 2021 02:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A20B461051
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Sep 2021 02:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbhIDCEN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Sep 2021 22:04:13 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60299 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhIDCEM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Sep 2021 22:04:12 -0400
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 184230PB021504;
        Sat, 4 Sep 2021 11:03:01 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Sat, 04 Sep 2021 11:03:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 184230T2021501
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 4 Sep 2021 11:03:00 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] Bluetooth: avoid page fault from sco_send_frame()
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
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
 <a7bed103-dbb1-6783-aba7-f18a4d495c13@i-love.sakura.ne.jp>
Message-ID: <883dc4b7-d1a1-3d31-a5a8-8fa1791084b6@i-love.sakura.ne.jp>
Date:   Sat, 4 Sep 2021 11:02:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <a7bed103-dbb1-6783-aba7-f18a4d495c13@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Commit 99c23da0eed4fd20 ("Bluetooth: sco: Fix lock_sock() blockage by memcpy_from_msg()") in linux-next.git should be sent to linux.git now as a mitigation for CVE-2021-3640.

But I think "[PATCH v3 3/4] Bluetooth: SCO: Replace use of memcpy_from_msg with bt_skb_sendmsg" still contains bug.
