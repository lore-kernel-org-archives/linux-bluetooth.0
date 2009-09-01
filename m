Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1251827623.3326.167.camel@localhost.localdomain>
References: <f0a7afec0909010916s1977725dk46cc34c545f3424c@mail.gmail.com>
	 <1251822966.3326.92.camel@localhost.localdomain>
	 <f0a7afec0909011023p512d5820h10a5264743593845@mail.gmail.com>
	 <f0a7afec0909011038x1d22f6abxe894dee39e91439@mail.gmail.com>
	 <1251827623.3326.167.camel@localhost.localdomain>
Date: Tue, 1 Sep 2009 14:58:26 -0400
Message-ID: <f0a7afec0909011158p37fc8dcdg9eada1e8dc138d6c@mail.gmail.com>
Subject: Re: Fwd: Unable to pair keyboard
From: Carlos Romero <kcrashcore@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

updated to 4.50-2 and rebooted, running 2.6.31-0.190.rc8.fc12.x86_64

output of hcidump -t -X -V

HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
2009-09-01 14:47:40.476657 < HCI Command: Periodic Inquiry Mode
(0x01|0x0003) plen 9
    max 24 min 16 lap 0x9e8b33 len 8 num 0
2009-09-01 14:47:40.524274 > HCI Event: Command Complete (0x0e) plen 4
    Periodic Inquiry Mode (0x01|0x0003) ncmd 1
    status 0x00
2009-09-01 14:47:43.095290 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:1A:D5:F0:18:9F mode 1 clkoffset 0x1332 class 0x24041c rssi -60
2009-09-01 14:47:49.251295 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:02:76:10:3B:E5 mode 1 clkoffset 0x6fc3 class 0x002540 rssi -57
2009-09-01 14:47:50.767333 > HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
2009-09-01 14:47:59.829337 < HCI Command: Create Connection
(0x01|0x0005) plen 13
    bdaddr 00:02:76:10:3B:E5 ptype 0xcc18 rswitch 0x01 clkoffset 0x6fc3 (valid)
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2009-09-01 14:47:59.899289 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2009-09-01 14:48:01.002313 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 11 bdaddr 00:02:76:10:3B:E5 type ACL encrypt 0x00
2009-09-01 14:48:01.002986 < HCI Command: Read Remote Supported
Features (0x01|0x001b) plen 2
    handle 11
2009-09-01 14:48:01.004308 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
2009-09-01 14:48:01.005329 > HCI Event: Read Remote Supported Features
(0x0b) plen 11
    status 0x00 handle 11
    Features: 0xbc 0x02 0x04 0x38 0x08 0x00 0x00 0x00
2009-09-01 14:48:01.108091 < HCI Command: Remote Name Request
(0x01|0x0019) plen 10
    bdaddr 00:02:76:10:3B:E5 mode 2 clkoffset 0x0000
2009-09-01 14:48:01.109333 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2009-09-01 14:48:01.140479 < HCI Command: Authentication Requested
(0x01|0x0011) plen 2
    handle 11
2009-09-01 14:48:01.155283 > HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:02:76:10:3B:E5 name 'Rocketfish Bluetooth Keyboard'
2009-09-01 14:48:01.157319 > HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
2009-09-01 14:48:01.200335 > HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 11
2009-09-01 14:48:02.283273 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:1A:D5:F0:18:9F mode 1 clkoffset 0x1333 class 0x24041c rssi -53
2009-09-01 14:48:12.546307 > HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
2009-09-01 14:48:31.323580 < HCI Command: Exit Periodic Inquiry Mode
(0x01|0x0004) plen 0
2009-09-01 14:48:31.372303 > HCI Event: Command Complete (0x0e) plen 4
    Exit Periodic Inquiry Mode (0x01|0x0004) ncmd 1
    status 0x00
2009-09-01 14:48:33.323985 < HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 11 reason 0x13
    Reason: Remote User Terminated Connection
2009-09-01 14:48:33.325332 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
2009-09-01 14:48:33.411330 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 11 reason 0x16
    Reason: Connection Terminated by Local Host
Tue Sep  1 14:48:47 EDT 2009

On Tue, Sep 1, 2009 at 1:53 PM, Bastien Nocera<hadess@hadess.net> wrote:
> On Tue, 2009-09-01 at 13:38 -0400, Carlos Romero wrote:
>> I did follow the instructions on the dialog, just like I did when
>> setting it up in f11.
>> right code and wrong code, main and number pad, nothing happens when I
>> press enter.
>
> Then please attach the output of "hcidump -X" when reproducing the
> problem, and mention your kernel version. You might also want to upgrade
> to the latest bluez[1] and see if it helps.
>
> You could also test with a known working Fedora 11 kernel, if at all
> possible.
>
> Cheers
>
> [1]: http://koji.fedoraproject.org/koji/buildinfo?buildID=130161
>
>
