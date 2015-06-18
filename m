Return-Path: <cyrus@holtmann.org>
Message-ID: <55828D2D.8040208@ubnt.com>
Date: Thu, 18 Jun 2015 12:19:41 +0300
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
MIME-Version: 1.0
To: dogan yazar <doganyazar@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Detect client connection using dbus api
References: <CANzaTi4s93PcjitnF-HWEo02SkYj+Z8rY5uNb9cjiySVnE1MiQ@mail.gmail.com>	<558281D4.4080304@ubnt.com> <CANzaTi6FBqUARP7iqSMfYMJmE6L-6cp2DKAzrMBzn948+dSs4w@mail.gmail.com>
In-Reply-To: <CANzaTi6FBqUARP7iqSMfYMJmE6L-6cp2DKAzrMBzn948+dSs4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



On 06/18/2015 12:02 PM, dogan yazar wrote:
> Thanks for the answer. How does it differentiate if it is a client or
> a server? If bluez work as a client and connect to a device, same
> property will be set anyway.
Just an idea: If BlueZ is a client, then someone does initiate the connect
explicitly by calling Connect() D-Bus method on a given device path, so we
know whom we are connecting to. But there may be a better way...

> 
> On Thu, Jun 18, 2015 at 10:31 AM, Andrejs Hanins
> <andrejs.hanins@ubnt.com> wrote:
>> Hi,
>>
>> On 06/18/2015 11:24 AM, dogan yazar wrote:
>>> I use gatt-api to register my services but then could not find a way
>>> to detect that a client is connected and discovering my services.
>>> Any ideas?
>> In case of connected client, there will be a org.bluez.Device1 object created
>> with Connected propery set to "true". So if you would like to track connect/disconnect
>> events, you should listed for this property changes. At least, this is how I do it.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
