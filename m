Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552C0C6FA8F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Aug 2023 14:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbjH2OeZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Aug 2023 10:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbjH2OeU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Aug 2023 10:34:20 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB2ECC
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Aug 2023 07:34:17 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qaznL-0001Uf-1U; Tue, 29 Aug 2023 16:34:15 +0200
Message-ID: <637f0d6e-f30d-3741-fc3a-63713ac0f9ee@leemhuis.info>
Date:   Tue, 29 Aug 2023 16:34:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] Bluetooth: Rework le_scan_restart for hci_sync
Content-Language: en-US, de-DE
To:     Stefan Agner <stefan@agner.ch>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Brian Gix <brian.gix@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
References: <20220727135834.294184-1-brian.gix@intel.com>
 <20220727135834.294184-3-brian.gix@intel.com>
 <578e6d7afd676129decafba846a933f5@agner.ch>
 <CABBYNZJGKfwTQM8WAdUGXueTPnFyus1a65UO5mg2g4PXVuCnpA@mail.gmail.com>
 <CABBYNZLgG+zTsk-6ceqzLXXyVRnN6p-m8sFq9Ss7mveD0f9BsQ@mail.gmail.com>
 <CABUQxGxBdAFncJ6YVb7a9gnU-_YZDGFDmpHJTtm5K1tDGEGRDQ@mail.gmail.com>
 <0de3f0d0d5eb6d83cfc8d90cbb2b1ba1@agner.ch>
 <fcdf856db8fd8e77558b4d82b843c51e@agner.ch>
 <24bf25f7-314f-ca73-59e9-df757732f6a9@leemhuis.info>
 <ac58995a00cb6ad6bb4ce4c74b006a2f@agner.ch>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ac58995a00cb6ad6bb4ce4c74b006a2f@agner.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1693319657;0fa21664;
X-HE-SMSGID: 1qaznL-0001Uf-1U
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 29.08.23 15:27, Stefan Agner wrote:
> 
> No, this hasn't been addressed so far.

Thx and aggh. It's vacation time, so sometimes things take longer, but
that doesn't explain why nothing seems to have happened for 9 weeks now
(at least that how it looks from here, but maybe I missed something).

Luiz, what's up here? What do you need to get down to this?

CCing the other Bluetooth maintainers just to be sure. FWIW, the thread
starts here:
https://lore.kernel.org/linux-bluetooth/578e6d7afd676129decafba846a933f5@agner.ch/#t

Jan saw similar problems:
https://lore.kernel.org/linux-bluetooth/CAPa5EdBSzkuMRoHDJ5w9ESckvNvs68nAfvixyetKcQ5+YD50wA@mail.gmail.com/

> I am also not sure how we can
> help solving that particular issue.

Let's see if this prodding helps to get things rolling. If not, I'll
have to get higher level maintainers involved.

> Besides this, we have other Bluetooth issues which seem to be Kernel
> regressions (where downgrading to Linux 5.15 also helps), folks see
> "hci0: unexpected event for opcode" on Intel but also other systems. We
> haven't bisected that issue yet. But it seems that the Bluetooth stack
> is really somewhat unstable in recent releases.

Might be wise to create a separate thread for those and asking the
bluetooth maintainers if they might have an idea (please CC the
regressions lists as well), maybe we are lucky; if not someone has to
bisect this to get closer to a solution.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

> On 2023-08-29 13:22, Linux regression tracking (Thorsten Leemhuis)
> wrote:
>> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
>> for once, to make this easily accessible to everyone.
>>
>> Stefan, was this regression ever addressed? Doesn't look like it from
>> here, but maybe I'm missing something.
>>
>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>> --
>> Everything you wanna know about Linux kernel regression tracking:
>> https://linux-regtracking.leemhuis.info/about/#tldr
>> If I did something stupid, please tell me, as explained on that page.
>>
>> #regzbot poke
>>
>> On 30.06.23 12:59, Stefan Agner wrote:
>>> Hi Brian,
>>>
>>> Gentle ping on the issue below.
>>>
>>> On 2023-06-20 16:41, Stefan Agner wrote:
>>>> On 2023-06-16 03:22, Brian Gix wrote:
>>>>
>>>>> On Thu, Jun 15, 2023 at 11:28 AM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>>>>
>>>>>> +Brian Gix
>>>>>>
>>>>>> On Thu, Jun 15, 2023 at 10:27 AM Luiz Augusto von Dentz
>>>>>> <luiz.dentz@gmail.com> wrote:
>>>>>>>
>>>>>>> Hi Stefan,
>>>>>>>
>>>>>>> On Thu, Jun 15, 2023 at 5:06 AM Stefan Agner <stefan@agner.ch> wrote:
>>>>>>>>
>>>>>>>> Hi Brian, hi all,
>>>>>>>>
>>>>>>>> We experienced quite some Bluetooth issues after moving from Linux 5.15
>>>>>>>> to 6.1 on Home Assistant OS, especially on Intel NUC type systems (which
>>>>>>>> is a popular choice in our community, so it might just be that). When
>>>>>>>> continuously scanning/listening for BLE packets, the packet flow
>>>>>>>> suddenly ends. Depending on which and how many devices (possibly also
>>>>>>>> other factors) within minutes or hours.
>>>>>>>>
>>>>>>>> Jan (in cc) was able to bisect the issue, and was able to pinpoint the
>>>>>>>> problem to this change.
>>>>>>>>
>>>>>>>> Meanwhile I was able to confirm, that reverting this single commit on
>>>>>>>> the latest 6.1.34 seems to resolve the issue.
>>>>>>>>
>>>>>>>> I've reviewed the change and surrounding code, and one thing I've
>>>>>>>> noticed is that the if statement to set cp.filter_dup in
>>>>>>>> hci_le_set_ext_scan_enable_sync and hci_le_set_scan_enable_sync are
>>>>>>>> different. Not sure if that needs to be the way it is, but my outside
>>>>>>>> gut feeling says hci_le_set_ext_scan_enable_sync should use "if (val &&
>>>>>>>> hci_dev_test_flag(hdev, HCI_MESH))" as well.
>>>>>>>>
>>>>>>>> However, that did not fix the problem (but maybe it is wrong
>>>>>>>> nonetheless?).
>>>>>>>>
>>>>>>>> Anyone has an idea what could be the problem here?
>>>>>>>
>>>>>>> Are there any logs of the problem? Does any HCI command fails or
>>>>>>> anything so that we can track down what could be wrong?
>>>>
>>>> No HCI command fails, there is also no issue reported in the kernel log.
>>>> BlueZ just stops receiving BLE packets, at least from certain devices.
>>>>
>>>>>>
>>>>>> @Brian Gix perhaps you have a better idea what is going wrong here?
>>>>>
>>>>> It seems unlikely that this is Mesh related. Mesh does need for filtering to
>>>>> be FALSE, and Mesh does not use extended scanning in any case.
>>>>>
>>>>> But this was part of the final rewrite to retire the hci_req mechanism in
>>>>> favor of the hci_sync mechanism. So my best guess off the top of my head is
>>>>> that there was an unintended race condition that worked better than the
>>>>> synchronous single-threading mechanism?  Filtering (or not) should not
>>>>
>>>> After review the code I concluded the same. What is a bit surprising to
>>>> me is that it is so well reproducible. I guess it is nicer to have a
>>>> reproducible one than a hard to reproduce one :)
>>>>
>>>>> prevent advertising packets from permanently wedging.  Does anyone have an
>>>>> HCI flow log with and without the offending patch?  Ideally they should be
>>>>> identical...  If they are not then I obviously did something wrong. As this
>>>>> was not specifically Mesh related, I may have missed some non-mesh corner
>>>>> cases.
>>>>
>>>>
>>>> I've taken two btmon captures, I created them using:
>>>> btmon -i hci0 -w /config/hcidump-hci-req-working.log
>>>>
>>>> You can find them at:
>>>> https://os-builds.home-assistant.io/hcidump-hci-req-working.log
>>>> https://os-builds.home-assistant.io/hcidump-hci-sync-non-working.log
>>>
>>> Could you gain any insights from these logs?
>>>
>>> --
>>> Stefan
>>>
>>>
>>>>
>>>> This is while running our user space software (Home Assistant with
>>>> Bluetooth integration). Besides some BLE devices (e.g. Xioami Mi
>>>> Temperature & Humidity sensor) I have a ESP32 running which sends SPAM
>>>> advertisements every 100ms (this accelerates the issue). In the
>>>> non-working case you'll see that the system doesn't receive any SPAM
>>>> advertisements after around 27 seconds. The working log shows that it
>>>> continuously receives the same packets (capture 120s).
>>>>
>>>> Hope this helps.
>>>>
>>>> --
>>>> Stefan
>>>>
>>>>
>>>
>>>
> 
> 
