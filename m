Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] bluetooth: ask for MWS transport config only if
 controller supports 4.1
To: Marcel Holtmann <marcel@holtmann.org>
References: <1442309091-1088-1-git-send-email-simon.fels@canonical.com>
 <6C5C6E24-A663-4A52-B38E-3AA2E8742779@holtmann.org>
 <55F7EEA0.7030504@canonical.com>
 <D76DBD6B-2DDD-4B96-B5F9-59A93B65D78E@holtmann.org>
 <55F8FD62.8090703@canonical.com>
 <59683CC2-7C39-497D-95FA-45776916E691@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
From: Simon Fels <simon.fels@canonical.com>
Message-ID: <55F93B6F.5020402@canonical.com>
Date: Wed, 16 Sep 2015 11:50:39 +0200
MIME-Version: 1.0
In-Reply-To: <59683CC2-7C39-497D-95FA-45776916E691@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 16.09.2015 11:01, Marcel Holtmann wrote:
> Hi Simon,
>
>>> so it is actually not that this chip does not understand this command, it is that it is being stupid.
>>
>> It lead me to the assumption that the chip does something pretty wired here as I didn't found this command in the 4.0 spec and when saying "I am supporting 4.0" I would assume it doesn't mix any of the new commands from newer spec versions in. However didn't saw that it was added in the addendum ...
>>
>>> < HCI Command: Get MWS Transport Layer.. (0x05|0x000c) plen 0
>>>> HCI Event: Command Complete (0x0e) plen 5
>>>        Get MWS Transport Layer Configuration (0x05|0x000c) ncmd 1
>>>          Status: Unknown Connection Identifier (0x02)
>>>          Number of transports: 0
>>>          Baud rate list: 0 entries
>>>
>>> The command is properly supported. I just don't know why it needs to return with an error. And especially error 0x02 which makes no sense in this case since the command is not even taking a connection handle in the first place.
>>>
>>> < HCI Command: Read Local Version Info.. (0x04|0x0001) plen 0
>>>> HCI Event: Command Complete (0x0e) plen 12
>>>        Read Local Version Information (0x04|0x0001) ncmd 1
>>>          Status: Success (0x00)
>>>          HCI version: Bluetooth 4.0 (0x06) - Revision 0 (0x0000)
>>>          LMP version: Bluetooth 4.0 (0x06) - Subversion 0 (0x0000)
>>>          Manufacturer: MediaTek, Inc. (70)
>>> < HCI Command: Read BD ADDR (0x04|0x0009) plen 0
>>>> HCI Event: Command Complete (0x0e) plen 10
>>>        Read BD ADDR (0x04|0x0009) ncmd 1
>>>          Status: Success (0x00)
>>>          Address: 38:BC:1A:1F:7E:96 (Meizu technology co.,ltd)
>>>
>>> So it seems that MediaTek needs to work a bit on their HCI command support. Which module is this anyway? Who builds it and where can it be found? Is this USB or UART? If it is USB, please provide /sys/kernel/debug/usb/devices entry for this one.
>>
>> As far as I know it is the MT6630QP chip and its connected over UART.
>>
>>> I have the feeling we are missing some sort of firmware update here that would allow to fix this controller.
>>
>> Generally I would say this is the way to go too but that isn't really an option in this case. So either we come up with a general solution by adding a quirk for this or I patch this just on our kernel.
>
> if this an UART chip, what hciattach command are you using? Plain H:4 or 3-Wire UART?
>
> We started supporting multiple manufactures inside the upstream kernel with proper baud rate switching, flow control, low power modes and also firmware loading. With these properly integrated devices the new btattach command can be used.
>
> So where did you get this hardware from anyway? And we need to get Mediatek to support this in the upstream kernel. Otherwise this is not sustainable. These days you need to have firmware patching support at least to fix all the nasty issues you can run into after the chips have been includes in devices.

As summary: I had a quick discussion with Marcel on IRC and I will go 
with a small workaround on our tree for now.

regards,
Simon
