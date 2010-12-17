Return-Path: <cyrus@holtmann.org>
Subject: Re: EDR support
From: Marcel Holtmann <marcel@holtmann.org>
To: Manuel Naranjo <manuel@aircable.net>
Cc: BlueZ <linux-bluetooth@vger.kernel.org>
In-Reply-To: <4D03DC83.8010200@aircable.net>
References: <4D03DC83.8010200@aircable.net>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Dec 2010 12:27:06 +0100
Message-ID: <1292585241.2658.0.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Manuel,

> I was checking the latest BlueZ source code and the kernel source code, 
> and I noticed that by default EDR is disabled, when a dongle is detected 
> net/bluetooth/hci_core.c initializes the packet types with DM1, DH1 and 
> HV1, and then net/bluetooth/hci_event.c does it for DM3-5 DH3-5 and 
> HV3-5, but it never initializes the 2DHx or 3DHx. Was it made on purpose 
> or is it a bug in the code?

you have read the specification and realized that EDR uses inverse
values?

Regards

Marcel


