Return-Path: <SRS0=JIrD=3S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DB3C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jan 2020 19:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF1F20716
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jan 2020 19:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgA2TDT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:03:19 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:50629 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgA2TDT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jan 2020 14:03:19 -0500
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3B727CECC9;
        Wed, 29 Jan 2020 20:12:38 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [BlueZ PATCH v3 1/5] mgmt: Add docs for Set Wake Capable
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CANFp7mW5BV9oo2jya86+e8p+XWotMgrMyqJ63+0gjPforcYMuQ@mail.gmail.com>
Date:   Wed, 29 Jan 2020 20:03:17 +0100
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alain Michaud <alainm@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Johan Hedberg <johan.hedberg@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <287E8DBD-B40C-454B-A3C8-9380DCF15D67@holtmann.org>
References: <20200128020505.239349-1-abhishekpandit@chromium.org>
 <20200127180433.BlueZ.v3.1.I999b93b65e613324dbbd16a1cf493be72fa06ad1@changeid>
 <137EB79B-88E6-43E0-894F-A0C8D5F9B710@holtmann.org>
 <CANFp7mUF=1ehF_Kwnf5kdCiypoOL8ph8PPEMbwm53NR-==D-hA@mail.gmail.com>
 <00B97550-7BB3-4F86-8463-A4053C84978A@holtmann.org>
 <CANFp7mW5BV9oo2jya86+e8p+XWotMgrMyqJ63+0gjPforcYMuQ@mail.gmail.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

>>>>> Add docs for new management operation to mark a device as wake capable.
>>>>> 
>>>>> ---
>>>>> 
>>>>> Changes in v3: None
>>>>> Changes in v2:
>>>>> * Separated docs/mgmt-api.txt into its own patch
>>>>> 
>>>>> doc/mgmt-api.txt | 19 +++++++++++++++++++
>>>>> 1 file changed, 19 insertions(+)
>>>>> 
>>>>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>>>>> index 1e59acc54..8a73a9bb9 100644
>>>>> --- a/doc/mgmt-api.txt
>>>>> +++ b/doc/mgmt-api.txt
>>>>> @@ -3047,6 +3047,25 @@ Load Blocked Keys Command
>>>>>     Possible errors:        Invalid Parameters
>>>>>                             Invalid Index
>>>>> 
>>>>> +Set Wake Capable Command
>>>>> +===========================
>>>>> +
>>>>> +     Command Code:           0x0047
>>>>> +     Controller Index:       <controller id>
>>>>> +     Command Parameters:     Address (6 Octets)
>>>>> +                             Address_Type (1 Octet)
>>>>> +                             Wake Capable (1 Octet)
>>>>> +     Return Parameters:      Address (6 Octets)
>>>>> +                             Address_Type (1 Octet)
>>>>> +                             Wake Capable (1 Octet)
>>>>> +
>>>>> +     This command sets whether a bluetooth device is capable of waking the
>>>>> +     system from suspend. This property is used to set the event filter and
>>>>> +     LE whitelist when the system enters suspend.
>>>>> +
>>>>> +     Possible errors:        Failed
>>>>> +                             Invalid Parameters
>>>>> +                             Invalid Index
>>>>> 
>>>> 
>>>> my current thinking goes into this API addition:
>>>> 
>>>> --- a/doc/mgmt-api.txt
>>>> +++ b/doc/mgmt-api.txt
>>>> @@ -2003,6 +2003,7 @@ Add Device Command
>>>>               0       Background scan for device
>>>>               1       Allow incoming connection
>>>>               2       Auto-connect remote device
>>>> +               3       Allow incoming connection to wake up the system
>>>> 
>>>>       With the Action 0, when the device is found, a new Device Found
>>>>       event will be sent indicating this device is available. This
>>>> @@ -2018,6 +2019,9 @@ Add Device Command
>>>>       and if successful a Device Connected event will be sent. This
>>>>       action is only valid for LE Public and LE Random address types.
>>>> 
>>>> +       With the Action 3, the device is allowed to connect the same way
>>>> +       as with Action 1, but allows to wake up the system from suspend.
>>>> +
>>>>       When a device is blocked using Block Device command, then it is
>>>>       valid to add the device here, but all actions will be ignored
>>>>       until the device is unblocked.
>>>> 
>>>> Since we are really talking about incoming connections, then the Add Device command is the one that handles this. Giving a device the option to wake us up that is not set up for incoming connections makes no sense. We can discuss if certain LE advertising packets should wake us up, but that is a total different API in my book.
>>> 
>>> I originally tried implementing this with the Add Device api as you
>>> suggested in the RFC email back in November (when we first talked
>>> about this). I had trouble figuring out when/where in bluez to
>>> actually send the Add Device command.
>>> 
>>> Whether a device supports wake-up is a profile level setting (i.e. HID
>>> only so far). As far as I can tell, Add Device is called before the
>>> profile connection is established. Bluez has two apis that call
>>> MGMT_OP_ADD_DEVICE:
>>> * adapter_auto_connect_add (this seems to be LE)
>>> * adapter_whitelist_add (this seems to be BR/EDR)
>>> 
>>> Both seem to be called BEFORE the registered profiles have a chance to
>>> accept the connection.
>> 
>> this is something for Luiz or Johan to comment on. Maybe our code is not as good as I was thinking in this regard. Or maybe this is actually legacy code that I am trying to rid of by requiring a mgmt API revision that has Add Device support.
>> 
>> In general once we bonded with a device, we should be able to assign certain properties to it that are kept persistently.
>> 
> 
> It looks like add_device would work if I opted to use it as an
> "update_device_params" type of function (I think I can use it in the
> same location I currently use adapter_set_wake_capable; I would just
> check that the device has already been added first).
> 
> You would still need to make a separate call from the original
> add_device so your original criticism of requiring another mgmt call
> for every param being set is still there. I could refactor the action
> parameter to accept flags (i.e. 0x3 = Set connection parameters) and
> then add a uint16_t flags parameter (i.e. 1 << 0: Allow wakeup from
> incoming connection).
> 
> What do you think?

I like to give Johan and Luiz some time to look at userspace code and see where this fits best.

My proposal would be to ignore the API question for a bit. Keep the mgmt command you have for testing for now. Switching over to a different command is done within an hour once we have the internals solid.

As I commented in my review, I would store the BR/EDR ones in the wakeable list and the LE ones as a flag or parameter in the conn params list. My real concern is the complexity your patch set adds. We really need to streamline this and make things simpler. The whitelist update worries me a lot. That code path is already rather complicated and we should not add to it.

For me it looks like you designed this based on the API that mgmt exposes (aka your first patch in the patch set). That leads you on a path that I feel is too complicated. So I would do this complete opposite and figure out the tasks and what information of wakeable or not you need at what point and where are they best places for BR/EDR and LE in hci_dev.

As an example, the whole complexity of disconnecting all devices and disabling page scan and scanning etc. is something that we can get merged quickly. If I assume an empty list of wakeable devices, then I would still disconnect all devices, disable page scan and scanning and also suspend all advertising and discovery.

I fully realize that this is a lot of work, but we need to get this support done right. I already foresee that you might want to have a keep advertising while suspend flag to advertise some sort of non-connectable beacon (like a find me hint). And at that point I don’t want to have to rethink the whole code path again.

Also please don’t be shy and tell if we did things totally stupid. We can change existing code as long as mgmt API stays backwards compatible. I am a big fan of fixing things to make code simpler and make maintenance easier.

Regards

Marcel

