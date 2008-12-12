Return-Path: <cyrus@holtmann.org>
Subject: Re: How to set link policy with Logitech diNovo dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: Thomas Liebetraut <thomas@tommie-lie.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <493D9EA5.5000101@tommie-lie.de>
References: <493D7110.1020508@tommie-lie.de>
	 <1228765907.28839.95.camel@violet.holtmann.net>
	 <493D9EA5.5000101@tommie-lie.de>
Content-Type: text/plain
Date: Fri, 12 Dec 2008 02:48:43 +0100
Message-Id: <1229046523.22285.25.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thomas,

> > However to be sure what is going on you have to run "hcidump -X -V" and
> > you can set the link policy manually via "hciconfig hci0 lp".
> Using "hciconfig hci0 lp RSWITCH,SNIFF" results in
> | Can't set link policy on hci0: Connection timed out (110)
> And I get this output from hcidump when issuing this command:
> | HCI sniffer - Bluetooth packet analyzer ver 1.42
> | device: hci0 snap_len: 1028 filter: 0xffffffff
> | < HCI Command: Write Default Link Policy Settings (0x02|0x000f) plen 2
> |     policy 0x05
> |     Link policy: RSWITCH SNIFF
> | > HCI Event: Command Status (0x0f) plen 4
> |     Write Default Link Policy Settings (0x02|0x000f) status 0x01 ncmd 1
> |     Error: Unknown HCI Command
> 
> I hope I find some time tomorrow to play around with other versions of
> bluez-utils.

this is a serious problem. Please show me hciconfig -a of your dongle. I
have never seen a dongle that doesn't support Default Link Policy.

Regards

Marcel


