Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F961CDB474
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Oct 2023 06:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbjJQGEv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Oct 2023 02:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQGEv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Oct 2023 02:04:51 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41321B6;
        Mon, 16 Oct 2023 23:04:49 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qsdC9-0002Cw-RU; Tue, 17 Oct 2023 08:04:45 +0200
Message-ID: <9a3e9c6a-e8fd-4fc6-8959-c90fda78ae4c@leemhuis.info>
Date:   Tue, 17 Oct 2023 08:04:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btrtl: Ignore error return for
 hci_devcd_register()
Content-Language: en-US, de-DE
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     patchwork-bot+bluetooth@kernel.org,
        Max Chou <max.chou@realtek.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex_lu@realsil.com.cn,
        hildawu@realtek.com, kirill@shutemov.name, bagasdotme@gmail.com
References: <20231006024707.413349-1-max.chou@realtek.com>
 <169664042379.23949.8315443049400174883.git-patchwork-notify@kernel.org>
 <0ee79296-a404-4d0d-b8ed-42578a77692c@leemhuis.info>
 <CABBYNZ+DcF=q3tH9ZYTEhsrPgygU+hsYwYNEZf-3VwuiyzHXog@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CABBYNZ+DcF=q3tH9ZYTEhsrPgygU+hsYwYNEZf-3VwuiyzHXog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1697522689;1ed6dce6;
X-HE-SMSGID: 1qsdC9-0002Cw-RU
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 16.10.23 19:20, Luiz Augusto von Dentz wrote:
> 
> On Mon, Oct 16, 2023 at 1:07 AM Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> On 07.10.23 03:00, patchwork-bot+bluetooth@kernel.org wrote:
>>>
>>> This patch was applied to bluetooth/bluetooth-next.git (master)
>>> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>>
>> Hi Luiz. Many thx for picking this up. From the branch name is sounds
>> like you plan to submit this change in the next merge window (If I
>> misread the signs feel free to ignore this mail!). Wouldn't it be better
>> to merge this in this cycle, as the commit afaics fixes a regression
>> that was only introduced this cycle?
> 
> It is part of the for-net pull-request:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/tag/?h=for-net-2023-10-13

Ahh, great -- and sorry, the branch name in the "was applied to
bluetooth/bluetooth-next.git" got me on the wrong track.

Ciao, Thorsten
