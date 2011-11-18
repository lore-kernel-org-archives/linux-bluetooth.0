Return-Path: <cyrus@holtmann.org>
Message-ID: <4EC68502.6020407@gmail.com>
Date: Fri, 18 Nov 2011 17:17:06 +0100
From: Michael Schmitt <tcwardrobe@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: 057c:3800 BlueFRITZ! Bluetooth Stick broken since 2.6.something
References: <4EC679A0.7050309@gmail.com> <20111118153652.GA3647@fusion.localdomain>
In-Reply-To: <20111118153652.GA3647@fusion.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 18.11.2011 16:36, schrieb Johan Hedberg:
> Hi Michael,
>
> On Fri, Nov 18, 2011, Michael Schmitt wrote:
>> adrastea:~# hcitool dev
>> Devices:
>>      hci0    11:11:11:11:11:11
>> adrastea:~# hciconfig
>> hci0:    Type: BR/EDR  Bus: USB
>>      BD Address: 11:11:11:11:11:11  ACL MTU: 678:8  SCO MTU: 48:10
>>      UP RUNNING PSCAN ISCAN
>>      RX bytes:1461 acl:0 sco:0 events:44 errors:0
>>      TX bytes:697 acl:0 sco:0 commands:44 errors:0
>>
>> hci1:    Type: BR/EDR  Bus: USB
>>      BD Address: 00:04:0E:8C:E2:93  ACL MTU: 120:20  SCO MTU: 24:5
>>      DOWN
>>      RX bytes:1086 acl:0 sco:0 events:39 errors:0
>>      TX bytes:171 acl:0 sco:0 commands:39 errors:0
>>
>> adrastea:~# hciconfig hci1 up
>> Can't init device hci1: Connection timed out (110)
>> adrastea:~#
> I'm pretty sure we'll at least need to see the hcidump output for the
> initialization sequence of this adapter (i.e. start hcidump before
> calling hciconfig hci0 up) and show us the output. Which Bluetooth
> version does this adapter support and how old is it?
>
> Johan

I am not sure if this is the right version you were talking about, but 
here it is (from the squeeze box):

mschmitt@sogo:~$ /usr/sbin/hciconfig -a
hci0:    Type: BR/EDR  Bus: USB
     BD Address: 11:11:11:11:11:11  ACL MTU: 678:8  SCO MTU: 48:10
     UP RUNNING PSCAN
     RX bytes:969 acl:0 sco:0 events:27 errors:0
     TX bytes:361 acl:0 sco:0 commands:27 errors:0
     Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
     Link policy: RSWITCH HOLD SNIFF PARK
     Link mode: SLAVE ACCEPT
     Name: 'sogo-0'
     Class: 0x4a0100
     Service Classes: Networking, Capturing, Telephony
     Device Class: Computer, Uncategorized
     HCI Version: 1.2 (0x2)  Revision: 0x1fe
     LMP Version: 1.2 (0x2)  Subversion: 0x1fe
     Manufacturer: Integrated System Solution Corp. (57)

greetings
Michael

