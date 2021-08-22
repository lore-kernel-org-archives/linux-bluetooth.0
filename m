Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01184C4338F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Aug 2021 15:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3C9060C3E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Aug 2021 15:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbhHVPnp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 22 Aug 2021 11:43:45 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61081 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhHVPnp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 22 Aug 2021 11:43:45 -0400
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17MFgudw066736;
        Mon, 23 Aug 2021 00:42:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Mon, 23 Aug 2021 00:42:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17MFgtKb066733
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 23 Aug 2021 00:42:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] Bluetooth: reorganize functions from hci_sock_sendmsg()
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        LinMa <linma@zju.edu.cn>
References: <20210722074208.8040-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <CABBYNZKmF7vODFxkDyRwFsTd933mNNB3vwVOCcxsgof_St=ORw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <246902bb-aafa-43bf-bf7c-ff26bfed5be1@i-love.sakura.ne.jp>
Date:   Mon, 23 Aug 2021 00:42:50 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZKmF7vODFxkDyRwFsTd933mNNB3vwVOCcxsgof_St=ORw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2021/07/24 6:44, Luiz Augusto von Dentz wrote:
> Hi Tetsuo,
> 
> On Thu, Jul 22, 2021 at 12:42 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> Since userfaultfd mechanism allows sleeping with kernel lock held,
>> avoiding page fault with kernel lock held where possible will make
>> the module more robust. This patch just brings memcpy_from_msg() calls
>> to out of sock lock.
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 

Can this patch go to v5.15 ?
