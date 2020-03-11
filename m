Return-Path: <SRS0=o7la=44=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C051C10F27
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 15:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BA0206C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 15:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbgCKPG5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Mar 2020 11:06:57 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:41095 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729965AbgCKPG5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Mar 2020 11:06:57 -0400
Received: from [172.20.10.2] (x59cc8a78.dyn.telefonica.de [89.204.138.120])
        by mail.holtmann.org (Postfix) with ESMTPSA id AAA5ACECDF;
        Wed, 11 Mar 2020 16:16:23 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v1] bluetooth: Enforce classic key size verification.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALWDO_Xpj8vD=9_KK=P=XWhVV7N5wb80duFw=tsP=0k58ct55A@mail.gmail.com>
Date:   Wed, 11 Mar 2020 16:06:53 +0100
Cc:     Alain Michaud <alainm@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <BA6ED066-6024-4184-A097-557308840445@holtmann.org>
References: <20200310151100.134881-1-alainm@chromium.org>
 <4C7539C9-2AEB-4B1A-93CD-23B468C49B2F@holtmann.org>
 <CALWDO_Xpj8vD=9_KK=P=XWhVV7N5wb80duFw=tsP=0k58ct55A@mail.gmail.com>
To:     Alain Michaud <alainmichaud@google.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

>>> This change introduces a new configuration to strictly enforce key size
>>> checks.  This ensures that systems are in a secured configuration by
>>> default while allowing for a compatible posture via a Kconfig option to
>>> support controllers who may not support the read encryption key size
>>> command.
>>> 
>>> Signed-off-by: Alain Michaud <alainm@chromium.org>
>>> ---
>>> 
>>> net/bluetooth/Kconfig     | 10 ++++++++++
>>> net/bluetooth/hci_core.c  | 10 ++++++++++
>>> net/bluetooth/hci_event.c |  5 +++++
>>> 3 files changed, 25 insertions(+)
>>> 
>>> diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
>>> index 165148c7c4ce..6a155b7b6fb2 100644
>>> --- a/net/bluetooth/Kconfig
>>> +++ b/net/bluetooth/Kconfig
>>> @@ -128,4 +128,14 @@ config BT_DEBUGFS
>>>        Provide extensive information about internal Bluetooth states
>>>        in debugfs.
>>> 
>>> +config BT_ENFORCE_CLASSIC_KEY_SIZES
>>> +     bool "Enforces security requirements for Bluetooth classic"
>>> +     depends on BT
>>> +     default y
>>> +     help
>>> +       Enforces Bluetooth classic security requirements by disallowing use of
>>> +       insecure Bluetooth chips, i.e. that doesn't support Read Encryption
>>> +       Key Size command to prevent BT classic connection with very short
>>> +       encryption key.
>>> +
>> 
>> I would drop the CLASSIC part here since it doesn’t really matter that we can enforce this in the host for LE. In general we require the hardware to give us all basics. So I would just do
>> 
>>        config BT_ENFORCE_ENC_KEY_SIZE
>> 
>> I addition, I think that I want to put this behind BT_EXPERT option and actually have this default to n. Distributions or products should be conscious about enabling this. Otherwise I am fine doing this.
> ACK.
> 
>> 
>>> source "drivers/bluetooth/Kconfig"
>>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>>> index 4e6d61a95b20..142130d4b66b 100644
>>> --- a/net/bluetooth/hci_core.c
>>> +++ b/net/bluetooth/hci_core.c
>>> @@ -1540,6 +1540,16 @@ static int hci_dev_do_open(struct hci_dev *hdev)
>>> 
>>>      clear_bit(HCI_INIT, &hdev->flags);
>>> 
>>> +#ifdef BT_ENFORCE_CLASSIC_KEY_SIZES
>>> +     /* Don't allow usage of Bluetooth if the chip doesn't support */
>>> +     /* Read Encryption Key Size command */
>>> +     if (!ret && !(hdev->commands[20] & 0x10)) {
>>> +             bt_dev_err(hdev,
>>> +                        "Disabling BT, Read Encryption Key Size !supported");
>>> +             ret = -EIO;
>>> +     }
>>> +#endif
>>> +
>> 
>> I do not need to check if this is best place. So actually I would like to keep the controller in unconfigured state if a command is missing. It would stay in unconfigured state forever since there is no way to undo it.
> I may need some more guidance on how to leave it in an unconfigured
> state the right way.

I will look into this, but it will take me a bit since I need to my brain back into the right mind to grok the init procedure.

>> --- a/doc/mgmt-api.txt
>> +++ b/doc/mgmt-api.txt
>> @@ -2172,6 +2172,7 @@ Read Controller Configuration Information Command
>> 
>>                0       External configuration
>>                1       Bluetooth public address configuration
>> +               2       Encryption Key Size enforcement
>> 
>>        It is valid to call this command on controllers that do not
>>        require any configuration. It is possible that a fully configured
>> 
>> So if the Read Encryption Key Size command is supported, I would like to set the Supported_Options bit. And the Missing_Options bit would be set depending on this new Kconfig option.
>> 
>> The real advantage with doing it like this is that when a controller is unconfigured, it is easy to detect and can be skipped for systems that have multiple controllers attached.
>> 
>> One fun part of course is that you could disable BR/EDR and enable LE and this option could become allowed again. I would have to check if we can do that with existing mgmt commands and it would flip the Missing_Options bit.
> Ack.

If this way of exposing this, then I might have to give this a spin and test it with the emulator.

>>>      if (!ret) {
>>>              hci_dev_hold(hdev);
>>>              hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>>> index a40ed31f6eb8..6605da7ec72e 100644
>>> --- a/net/bluetooth/hci_event.c
>>> +++ b/net/bluetooth/hci_event.c
>>> @@ -2902,7 +2902,12 @@ static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
>>>      if (rp->status) {
>>>              bt_dev_err(hdev, "failed to read key size for handle %u",
>>>                         handle);
>>> +#ifdef BT_ENFORCE_CLASSIC_KEY_SIZES
>>> +             hci_disconnect(conn, HCI_ERROR_REMOTE_USER_TERM);
>>> +             hci_conn_drop(conn);
>>> +#else
>>>              conn->enc_key_size = HCI_LINK_KEY_SIZE;
>>> +#endif
>> 
>>>      } else {
>>>              conn->enc_key_size = rp->key_size;
>>>      }
>> 
>> This change is not needed at all if you can not bring up a controller that missing the command.
> This change is different as it deals with the command failing for any
> reasons.  In that case it would be wrong to assume the key size is 16.

Good point actually. However just forcing disconnect is not going to work then. Wouldn’t it be enough to set the conn->enc_key_size to 0. The existing code should take care of gracefully rejecting the L2CAP connection. It should be the same as when the Read Encryption Key Size command returns a value lower than the required key size.

Regards

Marcel

