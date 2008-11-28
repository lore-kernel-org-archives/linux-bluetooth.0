Return-Path: <cyrus@holtmann.org>
Message-ID: <492FB646.3010808@parrot.com>
Date: Fri, 28 Nov 2008 10:13:42 +0100
From: Matthieu CASTET <matthieu.castet@parrot.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: btusb and HCI_RAW
References: <491868E6.6000406@parrot.com> <F9029075-34B5-4DE1-98EA-E990C82C7495@holtmann.org> <492ED29E.1060702@parrot.com> <E076769D-FF2D-4ADC-8E00-4CCAFD5A53FA@holtmann.org>
In-Reply-To: <E076769D-FF2D-4ADC-8E00-4CCAFD5A53FA@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Marcel Holtmann a écrit :
> Hi Matthieu,
> 
>> But hci_usb wasn't doing that (ie always use max alternate setting +
>> submit sco/alc urb), and I wasn't under the impression that it costs too
>> much CPU power.
> 
> there is not concept of max alternate setting. You just have to use the
> right one and powertop showed the difference in power consumption.
> 
Ok, but in normal case HCI_RAW isn't enabled ?
So the high power consumption only happen when you use this mode, which
shouldn't happen for normal users ?

>>> So this is a little bit
>>> pointless here and before just worked by pure luck. Why do you want this
>>> support in the first place?
>>>
>> This can be helpful to test userspace bluetooth stack or do some fuzzing.
> 
> I seriously couldn't care less about any userspace Bluetooth stack. Also
> why is RAW not working for ACL packets.
Do you mean HCI_RAW or l2cap raw ?

For HCI_RAW case, what will call hci_connect for ACL_LINK ?
This seems need to have "hdev->conn_hash.acl_num > 0" .

> adapter is brought up properly and switched to RUNNING state. SCO will
> not be possible without magic.
Also why in hci_sock_sendmsg there isn't check to return error if it is
impossible to send raw sco/acl ?

Regards,
Matthieu
