Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D10C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 May 2022 12:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241098AbiEPMkg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 May 2022 08:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbiEPMkf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 May 2022 08:40:35 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6231387A2
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 May 2022 05:40:32 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nqa1W-0008Q2-Sf; Mon, 16 May 2022 14:40:30 +0200
Message-ID: <d330ff46-3413-b977-8d32-8ee6867e45d8@leemhuis.info>
Date:   Mon, 16 May 2022 14:40:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] Bluetooth: hci_sync: Fix hci_update_accept_list_sync
 #forregzbot
Content-Language: en-US
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Joey Corleone <joey.corleone@mail.ru>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev
References: <20220224151147.119619-1-luiz.dentz@gmail.com>
 <46FADD2F-2B35-4CC7-BC01-CACB81FC6FAE@holtmann.org>
 <44f9b7f2-ac5f-55e9-e72b-cebe1d9bda80@mail.ru>
 <7583787f-0bc5-c2fc-3f78-3ed566eae152@leemhuis.info>
In-Reply-To: <7583787f-0bc5-c2fc-3f78-3ed566eae152@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1652704832;a53f1ca1;
X-HE-SMSGID: 1nqa1W-0008Q2-Sf
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

TWIMC: this mail is primarily send for documentation purposes and for
regzbot, my Linux kernel regression tracking bot. These mails usually
contain '#forregzbot' in the subject, to make them easy to spot and filter.

On 10.05.22 17:29, Thorsten Leemhuis wrote:
> On 10.05.22 12:36, Joey Corleone wrote:
>> On 24.02.22 21:08, Marcel Holtmann wrote:
> 
>>>> hci_update_accept_list_sync is returning the filter based on the error
>>>> but that gets overwritten by hci_le_set_addr_resolution_enable_sync
>>>> return instead of using the actual result of the likes of
>>>> hci_le_add_accept_list_sync which was intended.
>>>>
>>>> Fixes: ad383c2c65a5b ("Bluetooth: hci_sync: Enable advertising when
>>>> LL privacy is enabled")
>>>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>> ---
>>>> v2: Use u8 filter_policy instead of int ret as variable to store the
>>>> result.
>>>>
>>>> net/bluetooth/hci_sync.c | 5 ++++-
>>>> 1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> patch has been applied to bluetooth-stable tree.
>>>
>>> Regards
>>>
>>> Marcel
>>
>> Just to put you in the loop in case you have not noticed it yet: there
>> seems to be some kind of regression introduced by this patch. See
>> comment #5 of ticket 215768 where Damien Thébault bisected the kernel [1].
> 
> #regzbot ^introduced 80740ebb7e1ad
> #regzbot title net: bluetooth: can't suspend while bluetooth is enabled.
> #regzbot ignore-activity
> #regzbot from: plum <plumerlis@gmail.com>
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215768

#regzbot fixed-by: a9a347655d224fa284187

That fix landed in bluetooth-next. I wonder if that fix would better
have been merged in this cycle, as that will mean many users are exposed
to this for at least three more weeks, but whatever.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
