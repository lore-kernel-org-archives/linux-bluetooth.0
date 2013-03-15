Return-Path: <cyrus@holtmann.org>
Message-ID: <5143228B.1000405@kamens.us>
Date: Fri, 15 Mar 2013 09:30:51 -0400
From: Jonathan Kamens <jik@kamens.us>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: HFP/HSP Telephony profile doesn't work with Bluetooth USB dongle
References: <51100E6E.8070804@kamens.us> <CAJdJm_MsOBOGTBoG+Nua49DbwuXx5Pu5KRm9zMp2ma3_nhF2CQ@mail.gmail.com> <512A82B3.405@kamens.us> <CABBYNZLRZkosRo95TDGMOwfD4-QB5NgP7erT1CoWzGbdq=o-ig@mail.gmail.com> <512E15F5.4010909@kamens.us>
In-Reply-To: <512E15F5.4010909@kamens.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

FYI, the folks at BlueRigger sent me BTD-300 ("Product=Broadcom Bluetooh 
3.0 Device" in usb-devices output, as opposed to "Product=BCM20702A0" 
for the BTD-400 that wasn't working with HSP/HFP), and it works with 
HSP/HFP just fine.

This means I've got one USB Bluetooth dongle (the BTD-300) that works 
with the HSP/HFP profile, and two that don't (the BTD-400 and a cheap 
Cambridge Research dongle).

In the spirit of supporting open source software, I am willing to mail 
either or both of the dongles that don't work with HSP/HFP at my expense 
to anyone on this list who is willing to commit to (a) checking whether 
this problem still exists with the most recent kernel and bluez code) 
and (b) debugging and fixing it if it does. You can keep the dongles.

If you are willing to commit to doing these things, send me your mailing 
address in private email and let me know whether you want just one of 
the dongles or both of them.

Bonus points if you're willing to specifically make sure it works with 
Fedora 19, which just went into early testing, but I won't make that a 
hard requirement for the free dongles. :-)

Thanks,

Jonathan Kamens

