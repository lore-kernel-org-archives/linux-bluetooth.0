Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: bdaddr
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <c81eae29-b2bd-f1df-9066-d51591ac6d8f@mnementh.co.uk>
Date: Sat, 8 Jul 2017 09:54:14 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <16D39FFA-DA31-4996-B848-FF7B1A9356DB@holtmann.org>
References: <c81eae29-b2bd-f1df-9066-d51591ac6d8f@mnementh.co.uk>
To: Ian Molton <ian@mnementh.co.uk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ian,

> When changing the BDADDR why must I down/up the device after doing so?
> is it not possible/sensible to change it whilst remaining up?
> 
> Could it be possible to allow the BDADDR to be written whilst the device
> is down, and inject it when it comes up? Would a patch to do this be
> acceptable?
> 
> Otherwise, the sequence for programming the BDADDR looks a bit naff;
> 
> hciconfig hci0 up
> bdaddr -i hci0 <foo>
> hciconfig hci0 down
> hciconfig hci0 up
> 
> To me, it would make more sense if I could do:
> 
> hciconfig hci0 down
> bdaddr -i hci0 <foo>
> hciconfig hci0 up

there is a btmgmt public-addr command that does this correctly if the hdev->set_bdaddr is supported by the hardware. Using the bdaddr tool is a hack.

Regards

Marcel

