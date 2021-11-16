Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAC7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 08:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAA506101B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 08:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhKPIV2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Nov 2021 03:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhKPIV2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Nov 2021 03:21:28 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D78FC061570;
        Tue, 16 Nov 2021 00:18:30 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mmtfe-0006Cp-Tz; Tue, 16 Nov 2021 09:18:26 +0100
Message-ID: <70a875d0-7162-d149-dbc1-c2f5e1a8e701@leemhuis.info>
Date:   Tue, 16 Nov 2021 09:18:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-BS
To:     Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@intel.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Orlando Chamberlain <redecorating@protonmail.com>,
        Daniel Winkler <danielwinkler@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Aditya Garg <gargaditya08@live.com>,
        Greg KH <gregkh@linuxfoundation.org>
References: <4970a940-211b-25d6-edab-21a815313954@protonmail.com>
 <20210930063106.19881-1-redecorating@protonmail.com>
 <20210930141256.19943-1-redecorating@protonmail.com>
 <FA02CDD7-CFEC-4481-9940-BA95D81FD3F3@holtmann.org>
 <275acce4-9eab-9cba-7145-5a75a69ca530@protonmail.com>
 <20211001083412.3078-1-redecorating@protonmail.com>
 <CABBYNZLjSfcG_KqTEbL6NOSvHhA5-b1t_S=3FQP4=GwW21kuzg@mail.gmail.com>
 <972034A8-4B22-4FEE-9B37-C0A7C7ADD60C@live.com> <YYZr14zwHnd52rQ7@kroah.com>
 <829A2DF8-818E-4AF1-84F9-49B5822F9146@live.com> <YYePw07y2DzEPSBR@kroah.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
In-Reply-To: <YYePw07y2DzEPSBR@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1637050711;63614f9b;
X-HE-SMSGID: 1mmtfe-0006Cp-Tz
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking. To make this
easy and quick to read for everyone I for once rely on top-posting:

Bluetooth maintainers, what's the status here? The proposed patch is
fixing a regression. It's not a recent one (it afaics was introduced in
v5.11-rc1). Nevertheless it would be good to get this finally resolved.
But this thread seems inactive for more than a week now. Or was progress
made, but is only visible somewhere else?

Ciao, Thorsten (carrying his Linux kernel regression tracker hat)

P.S.: As a Linux kernel regression tracker I'm getting a lot of reports
on my table. I can only look briefly into most of them. Therefore I
unfortunately will get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
about it in a public reply. That's in everyone's interest, as what I
wrote above might be misleading to everyone reading this, which is
something I'd like to avoid.

BTW, I have no personal interest in this issue, which is tracked using
regzbot, my Linux kernel regression tracking bot
(https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
this mail to hopefully get things rolling again and hence don't need to
be CC on all further activities wrt to this regression. Also feel free
to ignore the following lines, they are meant for regzbot:

#regzbot poke

On 07.11.21 09:35, Greg KH wrote:
> On Sat, Nov 06, 2021 at 05:27:27PM +0000, Aditya Garg wrote:
>>> On 06-Nov-2021, at 5:19 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>>> On Sat, Nov 06, 2021 at 09:41:28AM +0000, Aditya Garg wrote:
>>>>> On 06-Nov-2021, at 3:17 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>>>> On Fri, Oct 1, 2021 at 1:56 AM Orlando Chamberlain
>>>>> <redecorating@protonmail.com> wrote:
>>>>>>
>>>>>> The LE Read Transmit Power command is Advertised on some Broadcom
>>>>>> controlers, but not supported. Using this command breaks Bluetooth
>>>>>> on the MacBookPro16,1 and iMac20,1. Added a quirk disabling LE Read
>>>>>> Transmit Power for these devices, based off their common chip id 150.
>>>>>>
>>>>>> Link: https://lore.kernel.org/r/4970a940-211b-25d6-edab-21a815313954@protonmail.com
>>>>>> Signed-off-by: Orlando Chamberlain <redecorating@protonmail.com>
>>>>>> ---
>>>>>> v1->v2: Clarified quirk description
>>>>>>
>>>>>> drivers/bluetooth/btbcm.c   |  4 ++++
>>>>>> include/net/bluetooth/hci.h | 11 +++++++++++
>>>>>> net/bluetooth/hci_core.c    |  3 ++-
>>>>>> 3 files changed, 17 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
>>>>>> index e4182acee488..4ecc50d93107 100644
>>>>>> --- a/drivers/bluetooth/btbcm.c
>>>>>> +++ b/drivers/bluetooth/btbcm.c
>>>>>> @@ -353,6 +353,10 @@ static int btbcm_read_info(struct hci_dev *hdev)
>>>>>>               return PTR_ERR(skb);
>>>>>>
>>>>>>       bt_dev_info(hdev, "BCM: chip id %u", skb->data[1]);
>>>>>> +
>>>>>> +       if (skb->data[1] == 150)
>>>>>> +               set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
>>>>>> +
>>>>>>       kfree_skb(skb);
>>>>>>
>>>>>>       /* Read Controller Features */
>>>>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>>>>>> index b80415011dcd..6da9bd6b7259 100644
>>>>>> --- a/include/net/bluetooth/hci.h
>>>>>> +++ b/include/net/bluetooth/hci.h
>>>>>> @@ -246,6 +246,17 @@ enum {
>>>>>>        * HCI after resume.
>>>>>>        */
>>>>>>       HCI_QUIRK_NO_SUSPEND_NOTIFIER,
>>>>>> +
>>>>>> +       /* When this quirk is set, LE Read Transmit Power is disabled.
>>>>>> +        * This is mainly due to the fact that the HCI LE Read Transmit
>>>>>> +        * Power command is advertised, but not supported; these
>>>>>> +        * controllers often reply with unknown command and need a hard
>>>>>> +        * reset.
>>>>>> +        *
>>>>>> +        * This quirk can be set before hci_register_dev is called or
>>>>>> +        * during the hdev->setup vendor callback.
>>>>>> +        */
>>>>>> +       HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER,
>>>>>> };
>>>>>>
>>>>>> /* HCI device flags */
>>>>>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>>>>>> index 8a47a3017d61..9a23fe7c8d67 100644
>>>>>> --- a/net/bluetooth/hci_core.c
>>>>>> +++ b/net/bluetooth/hci_core.c
>>>>>> @@ -742,7 +742,8 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
>>>>>>                       hci_req_add(req, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
>>>>>>               }
>>>>>>
>>>>>> -               if (hdev->commands[38] & 0x80) {
>>>>>> +               if (hdev->commands[38] & 0x80 &&
>>>>>> +                       !test_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks)) {
>>>>>>                       /* Read LE Min/Max Tx Power*/
>>>>>>                       hci_req_add(req, HCI_OP_LE_READ_TRANSMIT_POWER,
>>>>>>                                   0, NULL);
>>>>>> --
>>>>>> 2.33.0
>>>>>
>>>>> Nowadays it is possible to treat errors such like this on a per
>>>>> command basis (assuming it is not essential for the init sequence):
>>>>>
>>>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>>>>> index 979da5179ff4..f244f42cc609 100644
>>>>> --- a/include/net/bluetooth/hci.h
>>>>> +++ b/include/net/bluetooth/hci.h
>>>>> @@ -551,6 +551,7 @@ enum {
>>>>> #define HCI_LK_AUTH_COMBINATION_P256   0x08
>>>>>
>>>>> /* ---- HCI Error Codes ---- */
>>>>> +#define HCI_ERROR_UNKNOWN_CMD          0x01
>>>>> #define HCI_ERROR_UNKNOWN_CONN_ID      0x02
>>>>> #define HCI_ERROR_AUTH_FAILURE         0x05
>>>>> #define HCI_ERROR_PIN_OR_KEY_MISSING   0x06
>>>>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>>>> This diff cannot be applied to stable 5.15. Could you provide a patch capable of being applied to stable.
>>>
>>> That is not needed until a patch is in Linus's tree.  Why do you need it
>>> earlier?
>>>
>> Well not an emergency, but the issue of Bluetooth not working on some Apple Macs has been there for a long time. BTW, will this patch be there in Linus’s tree in the coming days?
> 
> That is up to the bluetooth maintainers, they have to accept it first.
> 
> thanks,
> 
> greg k-h
> 
> 
