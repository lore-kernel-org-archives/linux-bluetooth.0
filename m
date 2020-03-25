Return-Path: <SRS0=+pQP=5K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD54C18E5B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 08:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CED520714
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 08:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgCYIhH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:37:07 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38102 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgCYIhG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Mar 2020 04:37:06 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id EB68BCECCA;
        Wed, 25 Mar 2020 09:46:36 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v2] bluetooth: Enforce classic key size verification.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALWDO_WF4n_Ta-fYoxTv4OF_guZy=d8urEyrosUPgWdHXo8Pag@mail.gmail.com>
Date:   Wed, 25 Mar 2020 09:37:04 +0100
Cc:     Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel.holtmann@intel.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <C35897C0-9924-4598-859B-0ADD1EF2FB94@holtmann.org>
References: <20200320133748.154926-1-alainm@chromium.org>
 <CALWDO_WSHiNw+uwcZzufJ7rjHr=zpMs6f3ry=rdLMGLz2gJZ=w@mail.gmail.com>
 <1ACCF17B-90EB-4DE1-BD8C-A927ABEC3913@holtmann.org>
 <CALWDO_V=6NXLTZ=XTc+uAe3YUVkUfe88c4beWWoqWK7+vK4+8g@mail.gmail.com>
 <992DB845-DB7F-41B9-93E0-538B08BDF910@holtmann.org>
 <CALWDO_WF4n_Ta-fYoxTv4OF_guZy=d8urEyrosUPgWdHXo8Pag@mail.gmail.com>
To:     Alain Michaud <alainmichaud@google.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

>>>>>> This change introduces a new configuration to strictly enforce key size
>>>>>> checks.  This ensures that systems are in a secured configuration by
>>>>>> default while allowing for a compatible posture via a Kconfig option to
>>>>>> support controllers who may not support the read encryption key size
>>>>>> command.
>>>>>> 
>>>>>> Signed-off-by: Alain Michaud <alainm@chromium.org>
>>>>>> ---
>>>>>> 
>>>>>> net/bluetooth/Kconfig     | 20 ++++++++++++++++++++
>>>>>> net/bluetooth/hci_core.c  | 10 ++++++++++
>>>>>> net/bluetooth/hci_event.c |  4 ++++
>>>>>> 3 files changed, 34 insertions(+)
>>>>>> 
>>>>>> diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
>>>>>> index 165148c7c4ce..8e177d4f3f02 100644
>>>>>> --- a/net/bluetooth/Kconfig
>>>>>> +++ b/net/bluetooth/Kconfig
>>>>>> @@ -128,4 +128,24 @@ config BT_DEBUGFS
>>>>>>        Provide extensive information about internal Bluetooth states
>>>>>>        in debugfs.
>>>>>> 
>>>>>> +config BT_EXPERT
>>>>>> +       bool "Expert Bluetooth options"
>>>>>> +       depends on BT
>>>>>> +       default n
>>>>>> +       help
>>>>>> +         Provides a set of expert options and configurations that should
>>>>>> +         only be used deliberately by BT experts.  This is considered a
>>>>>> +         global switch to ensure these advanced features or options that
>>>>>> +         depends on BT_EXPERT are only used in expert mode.
>>>>>> +
>>>>>> +config BT_ENFORCE_CLASSIC_KEY_SIZES
>>>>>> +       bool "Enforces security requirements for Bluetooth classic"
>>>>>> +       depends on BT && BT_EXPERT
>>>>>> +       default y
>>>>>> +       help
>>>>>> +         Enforces Bluetooth classic security requirements by disallowing
>>>>>> +         use of insecure Bluetooth controllers, i.e. that doesn't support
>>>>>> +         Read Encryption Key Size command to prevent BT classic connection
>>>>>> +         with very short encryption key.
>>>>>> +
>>>>>> source "drivers/bluetooth/Kconfig"
>>>>>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>>>>>> index 4e6d61a95b20..142130d4b66b 100644
>>>>>> --- a/net/bluetooth/hci_core.c
>>>>>> +++ b/net/bluetooth/hci_core.c
>>>>>> @@ -1540,6 +1540,16 @@ static int hci_dev_do_open(struct hci_dev *hdev)
>>>>>> 
>>>>>>      clear_bit(HCI_INIT, &hdev->flags);
>>>>>> 
>>>>>> +#ifdef BT_ENFORCE_CLASSIC_KEY_SIZES
>>>>>> +       /* Don't allow usage of Bluetooth if the chip doesn't support */
>>>>>> +       /* Read Encryption Key Size command */
>>>>>> +       if (!ret && !(hdev->commands[20] & 0x10)) {
>>>>>> +               bt_dev_err(hdev,
>>>>>> +                          "Disabling BT, Read Encryption Key Size !supported");
>>>>>> +               ret = -EIO;
>>>>>> +       }
>>>>>> +#endif
>>>>> Just FYI, I haven't changed this bit yet.  I'll wait for your guidance
>>>>> on where best to put this to leave the controller in the right state.
>>>> 
>>>> while I was writing a patch to show how to use unconfigured state for controllers that don’t support the Read Encryption Key Size command, I was wonder why put this into the kernel in the first place.
>>>> 
>>>> I was thinking that essentially userspace can just make the decision to use a controller, or use it in LE only mode or not use a controller at all. So all we need is to collect the security information of the controller and kernel and expose them to bluetoothd.
>>>> 
>>>> +Read Security Features Command
>>>> +==============================
>>>> +
>>>> +       Command Code:           0x0048
>>>> +       Controller Index:       <controller id>
>>>> +       Command Parameters:
>>>> +       Return Parameters:      Security_Features (4 Octets)
>>>> +
>>>> +       This command is used to retrieve the supported security features
>>>> +       by the controller or the kernel.
>>>> +
>>>> +       The Security_Features parameter is a bitmask with currently the
>>>> +       following available bits:
>>>> +
>>>> +               0       Encryption Key Size enforcement (BR/EDR)
>>>> +               1       Encryption Key Size enforcement (LE)
>>>> +
>>>> +       This command generates a Command Complete event on success or
>>>> +       a Command Status event on failure.
>>>> +
>>>> +       Possible errors:        Invalid Parameters
>>>> +                               Invalid Index
>>>> +
>>>> +
>>>> 
>>>> I was also considering that we additionally add the ECDH Public Key validation here as supported bits. And in the future even more security related information that we want to enforce. However the enforcement to power on or not use a controller is left to bluetoothd and its main.conf configuration. Thoughts?
>>> I like the idea.  However, I feel we will still need to guard against
>>> the Read Encryption Key Size failing.  Perhaps we can just do this
>>> unconditionally (where it is reported as supported but fails, we
>>> simply set the encryption key size to 0 and move on).
>> 
>> I was thinking the same thing. Lets just set the encryption size to zero and report the error. Care to send a patch for it or should I send one?
> I'll do it shortly.
> 
> Would you want to send patch you suggested (eg: Read Security Features
> Command) or should I?

I was going to send one, but I was wondering if we go beyond a simple 4 octets bit list.

The encryption key size enforcement for BR/EDR is simple and depends on a supported command. And for LE we always do it. The public key validation is a bit funky since for some hardware we would need a negative feature since up to a certain time we assumed it was done the right way.

Additionally we added commands to return the max encryption key size (and some hardware has vendor commands to do so). Do we for example care if the max encryption key size supported is 56-bits or 128-bits.

I would like to spent a few brain cycles to think this through. The patch for returning “static” values is written within a few minutes once we figured out what bluetoothd needs from the kernel.

Regards

Marcel

