Return-Path: <SRS0=JIrD=3S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CE5C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jan 2020 18:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41695206D4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jan 2020 18:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgA2SGm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:06:42 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:56231 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgA2SGl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jan 2020 13:06:41 -0500
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 97E38CECC8;
        Wed, 29 Jan 2020 19:16:00 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [BlueZ PATCH v3 1/5] mgmt: Add docs for Set Wake Capable
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CANFp7mUF=1ehF_Kwnf5kdCiypoOL8ph8PPEMbwm53NR-==D-hA@mail.gmail.com>
Date:   Wed, 29 Jan 2020 19:06:39 +0100
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alain Michaud <alainm@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Transfer-Encoding: 8BIT
Message-Id: <00B97550-7BB3-4F86-8463-A4053C84978A@holtmann.org>
References: <20200128020505.239349-1-abhishekpandit@chromium.org>
 <20200127180433.BlueZ.v3.1.I999b93b65e613324dbbd16a1cf493be72fa06ad1@changeid>
 <137EB79B-88E6-43E0-894F-A0C8D5F9B710@holtmann.org>
 <CANFp7mUF=1ehF_Kwnf5kdCiypoOL8ph8PPEMbwm53NR-==D-hA@mail.gmail.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

>>> Add docs for new management operation to mark a device as wake capable.
>>> 
>>> ---
>>> 
>>> Changes in v3: None
>>> Changes in v2:
>>> * Separated docs/mgmt-api.txt into its own patch
>>> 
>>> doc/mgmt-api.txt | 19 +++++++++++++++++++
>>> 1 file changed, 19 insertions(+)
>>> 
>>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>>> index 1e59acc54..8a73a9bb9 100644
>>> --- a/doc/mgmt-api.txt
>>> +++ b/doc/mgmt-api.txt
>>> @@ -3047,6 +3047,25 @@ Load Blocked Keys Command
>>>      Possible errors:        Invalid Parameters
>>>                              Invalid Index
>>> 
>>> +Set Wake Capable Command
>>> +===========================
>>> +
>>> +     Command Code:           0x0047
>>> +     Controller Index:       <controller id>
>>> +     Command Parameters:     Address (6 Octets)
>>> +                             Address_Type (1 Octet)
>>> +                             Wake Capable (1 Octet)
>>> +     Return Parameters:      Address (6 Octets)
>>> +                             Address_Type (1 Octet)
>>> +                             Wake Capable (1 Octet)
>>> +
>>> +     This command sets whether a bluetooth device is capable of waking the
>>> +     system from suspend. This property is used to set the event filter and
>>> +     LE whitelist when the system enters suspend.
>>> +
>>> +     Possible errors:        Failed
>>> +                             Invalid Parameters
>>> +                             Invalid Index
>>> 
>> 
>> my current thinking goes into this API addition:
>> 
>> --- a/doc/mgmt-api.txt
>> +++ b/doc/mgmt-api.txt
>> @@ -2003,6 +2003,7 @@ Add Device Command
>>                0       Background scan for device
>>                1       Allow incoming connection
>>                2       Auto-connect remote device
>> +               3       Allow incoming connection to wake up the system
>> 
>>        With the Action 0, when the device is found, a new Device Found
>>        event will be sent indicating this device is available. This
>> @@ -2018,6 +2019,9 @@ Add Device Command
>>        and if successful a Device Connected event will be sent. This
>>        action is only valid for LE Public and LE Random address types.
>> 
>> +       With the Action 3, the device is allowed to connect the same way
>> +       as with Action 1, but allows to wake up the system from suspend.
>> +
>>        When a device is blocked using Block Device command, then it is
>>        valid to add the device here, but all actions will be ignored
>>        until the device is unblocked.
>> 
>> Since we are really talking about incoming connections, then the Add Device command is the one that handles this. Giving a device the option to wake us up that is not set up for incoming connections makes no sense. We can discuss if certain LE advertising packets should wake us up, but that is a total different API in my book.
> 
> I originally tried implementing this with the Add Device api as you
> suggested in the RFC email back in November (when we first talked
> about this). I had trouble figuring out when/where in bluez to
> actually send the Add Device command.
> 
> Whether a device supports wake-up is a profile level setting (i.e. HID
> only so far). As far as I can tell, Add Device is called before the
> profile connection is established. Bluez has two apis that call
> MGMT_OP_ADD_DEVICE:
> * adapter_auto_connect_add (this seems to be LE)
> * adapter_whitelist_add (this seems to be BR/EDR)
> 
> Both seem to be called BEFORE the registered profiles have a chance to
> accept the connection.

this is something for Luiz or Johan to comment on. Maybe our code is not as good as I was thinking in this regard. Or maybe this is actually legacy code that I am trying to rid of by requiring a mgmt API revision that has Add Device support.

In general once we bonded with a device, we should be able to assign certain properties to it that are kept persistently.

Regards

Marcel

