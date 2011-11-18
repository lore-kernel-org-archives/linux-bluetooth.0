Return-Path: <cyrus@holtmann.org>
Message-ID: <4EC68909.40108@gmail.com>
Date: Fri, 18 Nov 2011 17:34:17 +0100
From: Michael Schmitt <tcwardrobe@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: 057c:3800 BlueFRITZ! Bluetooth Stick broken since 2.6.something
References: <4EC679A0.7050309@gmail.com> <20111118153652.GA3647@fusion.localdomain> <4EC67E88.6060202@gmail.com> <20111118162111.GA4680@fusion.localdomain>
In-Reply-To: <20111118162111.GA4680@fusion.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 18.11.2011 17:21, schrieb Johan Hedberg:
> Hi Michael,
>
> On Fri, Nov 18, 2011, Michael Schmitt wrote:
>> <  HCI Command: Read Local Version Information (0x04|0x0001) plen 0
>>> HCI Event: Command Complete (0x0e) plen 12
>>      Read Local Version Information (0x04|0x0001) ncmd 1
>>      status 0x00
>>      HCI Version: 1.2 (0x2) HCI Revision: 0x2006
>>      LMP Version: 1.2 (0x2) LMP Subversion: 0x1806
>>      Manufacturer: AVM Berlin (31)
>
> Ok, so this is a 1.2 adapter.
>
>> <  HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0
>>> HCI Event: Command Status (0x0f) plen 4
>>      Read Local Supported Commands (0x04|0x0002) status 0x01 ncmd 1
>>      Error: Unknown HCI Command
>
> This is the reason why you're getting a timeout. Since the adapter
> claims to support Bluetooth version 1.2 it should also support this HCI
> command, so from that perspective it's not conforming to the
> specification. Right now the kernel (lib/bluetooth/hci_event.c) is
> completely missing a command status handler for this command. If such a
> handler was in place instead of a timeout you would be getting an
> immediate error (the kernel maps this HCI status code to EBADRQC).
>
> However, since this is also not acceptable behavior (as the adapter
> still wouldn't work for you) I suspect the need for some
> adapter-specific quirk is in place or then the kernel should just ignore
> any errors for HCI_Read_Local_Supported_Commands.
>
> Johan

Thanks for the input. But do you know why the device works with older 
kernel / userland? As Debian stable may be old, but not THAT old ;) 
(bluetooth 1.2 was released somewhere around 2005 I think).

So, and what do we do from here on? Btw. I did mix up the two bt-sticks 
I have so the last info was from the wrong stick. Here is the right info 
but it looks almost the same (at least the version numbers...):

mschmitt@sogo:~$ /usr/sbin/hciconfig -a
hci0:    Type: BR/EDR  Bus: USB
     BD Address: 00:04:0E:8C:E2:93  ACL MTU: 120:20  SCO MTU: 24:5
     UP RUNNING PSCAN ISCAN
     RX bytes:695 acl:0 sco:0 events:23 errors:0
     TX bytes:97 acl:0 sco:0 commands:23 errors:0
     Features: 0xff 0xff 0x05 0x00 0x18 0x18 0x00 0x00
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
     Link policy:
     Link mode: SLAVE ACCEPT
     Name: ''
     Class: 0x4a0000
     Service Classes: Networking, Capturing, Telephony
     Device Class: Miscellaneous,
     HCI Version: 1.2 (0x2)  Revision: 0x2006
     LMP Version: 1.2 (0x2)  Subversion: 0x1806
     Manufacturer: AVM Berlin (31)

greetings
Michael

