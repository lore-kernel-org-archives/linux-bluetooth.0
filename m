Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3192C32772
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Aug 2022 06:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiHVGzO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 02:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiHVGzN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 02:55:13 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEF81A38B
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Aug 2022 23:55:11 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aeccb.dynamic.kabel-deutschland.de [95.90.236.203])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5903F61EA192C;
        Mon, 22 Aug 2022 08:55:10 +0200 (CEST)
Message-ID: <bf9b240e-5b69-a6ba-325f-df6fe4124a68@molgen.mpg.de>
Date:   Mon, 22 Aug 2022 08:55:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [Bluez PATCH] adapter: Reset pending settings when receiving MGMT
 error
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
References: <20220822125221.Bluez.1.I541cbea9d6295f531c796bf3bda96b22db76bc19@changeid>
 <f9fd47a4-e5fc-5640-de71-dee1d52da2a8@molgen.mpg.de>
 <CAJQfnxHsRrJpQQB06bxhjc1TetK-8H20Cos366A6qH5AY9j9vw@mail.gmail.com>
 <a1f16653-e32e-4dda-a1cb-858c27ba025e@molgen.mpg.de>
 <CAJQfnxHF3CX6fohXZFGOLzj197djZsQrYrTOY6-nxShTrY-D1Q@mail.gmail.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAJQfnxHF3CX6fohXZFGOLzj197djZsQrYrTOY6-nxShTrY-D1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Archie,


Am 22.08.22 um 08:49 schrieb Archie Pusaka:

> On Mon, 22 Aug 2022 at 14:40, Paul Menzel <pmenzel@molgen.mpg.de> wrote:

>> Am 22.08.22 um 08:33 schrieb Archie Pusaka:
>>
>>> On Mon, 22 Aug 2022 at 14:15, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>>
>>>> Am 22.08.22 um 06:53 schrieb Archie Pusaka:
>>>>> From: Archie Pusaka <apusaka@chromium.org>
>>>>
>>>> I think the tag in the email subject needs to be [PATCH BlueZ] to be
>>>> detected by the build bot.
>>>
>>> Is the bot the one who just commented about the test result? If so
>>> probably it can detect this format as well.
>>
>> Yes, I noticed after hitting *Send*.
>>
>>>>> We set the pending settings flag when sending MGMT_SETTING_*
>>>>> commands to the MGMT layer and clear them when receiving success
>>>>> reply, but we don't clear them when receiving error reply. This
>>>>> might cause a setting to be stuck in pending state.
>>>>
>>>> Were you able to reproduce a problem on real hardware?
>>>
>>> I only received some reports, but unfortunately I cannot repro on real
>>> hardware. The symptom is BlueZ can't be turned off, snoop logs shows
>>> that MGMT_OP_SET_POWERED fails to be sent, and we are stuck with it
>>> since the next commands to toggle power are ignored.
>>>>
>>>>> Therefore, also clear the pending flag when receiving error.
>>>>> Furthermore, this patch also postpone setting the pending flag
>>>>
>>>> postpone*s*
>>>
>>> Thanks, will fix.
>>>>
>>>>> until we queue the MGMT command in order to avoid setting it too
>>>>> soon but we return early.
>>>>
>>>> Maybe add a comment, that how you tested this?
>>>
>>> The reporter claims the problem is no longer observable after this
>>> patch. I didn't do any other intelligent way of testing,
>>> unfortunately. Do I also need to document that?
>>
>> Is the bug report public.
> 
> No, the bug report is filed by Vendor testing unreleased devices, so
> unfortunately it is not public.

Understood. For others to reproduce later on, I think, it’s always good 
to have some hints, on what to do. Especially with Bluetooth where two 
devices are involved. Maybe share as much information as you can. (But, 
it’s also my personal opinion. It’s not required.)
>> It’s not a requirement. I just thought, that the Chromium project has a
>> big QA setup, and runs on millions of devices, it’d be good to know, for
>> example, if the patch was battle proven for several months in production
>> or if it’s verified by one person.
> 
> Chromium usually holds the "upstream first" spirit, this patch is no
> exception. So, currently it is not battle proven.
> Whether accepted or not, we would still merge it to the Chromium tree
> though. If required, by that time I can circle back to this patch and
> report any future findings.

Ah, then I made the wrong assumptions from the address 
chromeos-bluetooth-upstreaming@chromium.org. Sorry about that, and thank 
you for clearing that up. I am going to remember that.


Kind regards,

Paul
