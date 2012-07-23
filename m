Return-Path: <cyrus@holtmann.org>
Message-ID: <500CF1C2.8010200@ti.com>
Date: Mon, 23 Jul 2012 09:40:02 +0300
From: Chen Ganir <chen.ganir@ti.com>
MIME-Version: 1.0
To: Ajay KV <ajay.kv@globaledgesoft.com>
CC: Andre Guedes <andre.guedes@openbossa.org>,
	<linux-bluetooth@vger.kernel.org>
Subject: Re: BLE - multiple connections
References: <5008F67F.5030604@globaledgesoft.com> <CACJA=fUW4a-B-1SGQmPbh+J5YKJ9bVEFbz8ZUezPOD3w0Hmsxw@mail.gmail.com> <500CE1BE.2080107@globaledgesoft.com>
In-Reply-To: <500CE1BE.2080107@globaledgesoft.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/23/2012 08:31 AM, Ajay KV wrote:
> Hi,
>        So that means at  a time i can not able to establish  two LE
> active connections.   One more  task i wanna   try is  to send L2cap
> data packets through L2cap signalling channel (cid 0x05) . But as per my
> knowledge kernel has designed it to work only on cid 0x05
>
>
>
> Andre Guedes wrote:
>> Hi Ajay,
>>
>> On Fri, Jul 20, 2012 at 3:11 AM, Ajay KV <ajay.kv@globaledgesoft.com>
>> wrote:
>>> Hi all,
>>>
>>> Since im new to bluetooth low energy technology , i need some
>>> guidance from
>>> you . Following are the issues that im searching for a solution
>>>
>>>
>>> 1 : Is it possible to establish mutiple LE connection at a time . Im
>>> using
>>> fedora 13 , linux 2.6.39 version with 4.0 LE supported dongles
>>>
>>> 2: now im not concentrating on user profiles like GATT and ATT . i
>>> wanted to
>>> do it using HCI and L2cap connections
>>
>> You are able to establish one LE connection at a time. If you have
>> more than one device you want to connect to, you can use whitelist.
>> Add the devices to whitelist and issue the LE connection command. As
>> soon as one of the devices starts advertising, the connection will be
>> established.
>>
>> You can use hcitool to add devices to whitelist and issue LE
>> connection command.
>>
>> BR,
>>
>> Andre
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

As Andre said - you can not create multiple connections at the same 
time, but you can have multiple active connections at the same time. The 
only limitation is during the connection creation procedure. After an LE 
connection has been established to device A, you can create a second LE 
connection to device B.

BR,
Chen Ganir
Texas Instruments.

