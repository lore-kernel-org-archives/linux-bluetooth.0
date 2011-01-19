Return-Path: <cyrus@holtmann.org>
Subject: Re: rfkill behavior for internal bluetooth adapters on thinkpads
From: Marcel Holtmann <marcel@holtmann.org>
To: connman@connman.net
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
In-Reply-To: <AANLkTimyT9UEfaC+G4ic7iyzcemOt11pYPvLQEG3P1uG@mail.gmail.com>
References: <AANLkTimyT9UEfaC+G4ic7iyzcemOt11pYPvLQEG3P1uG@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 19 Jan 2011 12:26:54 +0100
Message-ID: <1295436414.3873.242.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alok,

> I have a lenovo thinkpad T410 with integrated bluetooth.
> When I do a rfkill block bluetooth, the internal bluetooth device disappears
> from the list.
> A external USB bluetooth adapter on the system does not disappear.
> 
> here are the observations :
> 
> A. rfkill list shows 2 bluetooth adapters. hci0 is the internal one and hci1
> is a external bluetooth adapter.
> 
> barsode@tatooine:~$ rfkill list
> 1: phy0: Wireless LAN
> Soft blocked: no
> Hard blocked: no
> 2: tpacpi_bluetooth_sw: Bluetooth
> Soft blocked: no
> Hard blocked: no
> 5: hci1: Bluetooth
> Soft blocked: no
> Hard blocked: no
> 8: hci0: Bluetooth
> Soft blocked: no
> Hard blocked: no
> 
> B. then I do rfkill block bluetooth. Now rfkill list shows only 1 bluetooth
> device.
> 
> barsode@tatooine:~$ rfkill block bluetooth
> barsode@tatooine:~$ rfkill list
> 1: phy0: Wireless LAN
> Soft blocked: no
> Hard blocked: no
> 2: tpacpi_bluetooth_sw: Bluetooth
> Soft blocked: yes
> Hard blocked: no
> 5: hci1: Bluetooth
> Soft blocked: yes
> Hard blocked: no
> 
> C. hciconfig -a shows only hci1.
> barsode@tatooine:~$ hciconfig -a
> hci1: Type: USB
> BD Address: 00:1A:9F:92:B3:FC ACL MTU: 1021:7 SCO MTU: 64:1
> DOWN
> RX bytes:3986 acl:0 sco:0 events:128 errors:0
> TX bytes:3909 acl:0 sco:0 commands:128 errors:0
> Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x83
> Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
> Link policy: RSWITCH HOLD SNIFF PARK
> Link mode: SLAVE ACCEPT
> 
> This is a problem for offline mode in connman (which would do "rfkill block
> bluetooth" or "rfkill block all") & the internal bluetooth adapter would
> disappear, which is not expected.

as mentioned on IRC, the way do here is OP_CHANGE_ALL with
TYPE_BLUETOOTH and that fits nicely into the technology concept that
ConnMan already imposes.

So yes, devices might drop of the bus, but the RFKILL switch for
platform devices stays.

Regards

Marcel


