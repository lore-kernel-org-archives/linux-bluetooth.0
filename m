Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Aug 2015 23:07:12 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Norbert Holze <norbert.holze@web.de>
Cc: lkp@lists.01.org, linux-bluetooth@vger.kernel.org
Subject: Re: [LKP] btusb regression / 0a12:0001 CSR
Message-ID: <20150810150712.GA7341@wfg-t540p.sh.intel.com>
References: <55C5B3F6.8070701@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55C5B3F6.8070701@web.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

CC bluetooth mailing list.

On Sat, Aug 08, 2015 at 09:47:02AM +0200, Norbert Holze wrote:
> Hello mailing list,
> 
> my bluetooth usb-stick worked fine with kernel up to 3.19. With 4.x
> there is no hci device found.
> 
> lsusb
> Bus 004 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth
> Dongle (HCI mode)
> 
> hcitool dev
> Devices:
> 
> sudo hciconfig
> hci0:	Type: BR/EDR  Bus: USB
> 	BD Address: 00:15:83:15:A3:0B  ACL MTU: 672:4  SCO MTU: 48:1
> 	DOWN
> 	RX bytes:890 acl:0 sco:0 events:30 errors:0
> 	TX bytes:126 acl:0 sco:0 commands:30 errors:0
> 
> sudo hciconfig hci0 up
> Can't init device hci0: Operation not supported (95)
> 
> rfkill list
> 0: hci0: Bluetooth
> 	Soft blocked: no
> 	Hard blocked: no
> 1: phy0: Wireless LAN
> 	Soft blocked: no
> 	Hard blocked: no
> 
> 
> Is this a regression. Or does it work in different way with 4.x?
> 
> Regards,
> 
> Norbert
> _______________________________________________
> LKP mailing list
> LKP@lists.01.org
> https://lists.01.org/mailman/listinfo/lkp
