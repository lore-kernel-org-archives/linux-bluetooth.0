Return-Path: <cyrus@holtmann.org>
Message-ID: <4EC67E88.6060202@gmail.com>
Date: Fri, 18 Nov 2011 16:49:28 +0100
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

Hi Johann,

let me fire up a machine that runs 2.6.32 (Debian squeeze) and where it 
works... or is there a way to get the bt-version it supports with the 
"broken" kernel? And no idea how old it is... at least some years as I 
got it for free from a buddy some time ago. It is from a AVM 
BlueTooth-ISDN-set which was in a box in the cellar and never used by 
the original owner (that was years ago too).
Anyway, here is the hcidump output as requested. Only the timespan since 
issueing hciconfig hci0 up and error message displayed in terminal:

adrastea:~# hcidump
HCI sniffer - Bluetooth packet analyzer ver 2.1
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Reset (0x03|0x0003) plen 0
 > HCI Event: Command Complete (0x0e) plen 4
     Reset (0x03|0x0003) ncmd 1
     status 0x00
< HCI Command: Read Local Supported Features (0x04|0x0003) plen 0
 > HCI Event: Command Complete (0x0e) plen 12
     Read Local Supported Features (0x04|0x0003) ncmd 1
     status 0x00
     Features: 0xff 0xff 0x05 0x00 0x18 0x18 0x00 0x00
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0
 > HCI Event: Command Complete (0x0e) plen 12
     Read Local Version Information (0x04|0x0001) ncmd 1
     status 0x00
     HCI Version: 1.2 (0x2) HCI Revision: 0x2006
     LMP Version: 1.2 (0x2) LMP Subversion: 0x1806
     Manufacturer: AVM Berlin (31)
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0
 > HCI Event: Command Complete (0x0e) plen 11
     Read Buffer Size (0x04|0x0005) ncmd 1
     status 0x00
     ACL MTU 120:20 SCO MTU 24:5
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0
 > HCI Event: Command Complete (0x0e) plen 10
     Read BD ADDR (0x04|0x0009) ncmd 1
     status 0x00 bdaddr 00:04:0E:8C:E2:93
< HCI Command: Read Class of Device (0x03|0x0023) plen 0
 > HCI Event: Command Complete (0x0e) plen 7
     Read Class of Device (0x03|0x0023) ncmd 1
     status 0x00 class 0x000000
< HCI Command: Read Local Name (0x03|0x0014) plen 0
 > HCI Event: Command Complete (0x0e) plen 252
     Read Local Name (0x03|0x0014) ncmd 1
     status 0x00 name ''
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
 > HCI Event: Command Complete (0x0e) plen 6
     Read Voice Setting (0x03|0x0025) ncmd 1
     status 0x00 voice setting 0x0060
< HCI Command: Set Event Filter (0x03|0x0005) plen 1
     type 0 condition 0
     Clear all filters
 > HCI Event: Command Complete (0x0e) plen 4
     Set Event Filter (0x03|0x0005) ncmd 1
     status 0x00
< HCI Command: Write Connection Accept Timeout (0x03|0x0016) plen 2
     timeout 32000
 > HCI Event: Command Complete (0x0e) plen 4
     Write Connection Accept Timeout (0x03|0x0016) ncmd 1
     status 0x00
< HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7
     bdaddr 00:00:00:00:00:00 all 1
 > HCI Event: Command Complete (0x0e) plen 6
     Delete Stored Link Key (0x03|0x0012) ncmd 1
     status 0x00 deleted 0
< HCI Command: Set Event Mask (0x03|0x0001) plen 8
     Mask: 0xfffffbff07180000
 > HCI Event: Command Complete (0x0e) plen 4
     Set Event Mask (0x03|0x0001) ncmd 1
     status 0x00
< HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0
 > HCI Event: Command Status (0x0f) plen 4
     Read Local Supported Commands (0x04|0x0002) status 0x01 ncmd 1
     Error: Unknown HCI Command

greetings
Michael
