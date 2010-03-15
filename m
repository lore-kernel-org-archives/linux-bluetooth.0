Return-Path: <cyrus@holtmann.org>
From: "Cooper Xu" <cooper.xu@mapleworks.com>
To: "'Nick Pelly'" <npelly@google.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <1660E2CC4AF24655A1FFE788570A34FF@mapleworks.com> <35c90d961003151435i6dc2a096j300198decb4844e6@mail.gmail.com>
Subject: RE: A strange compatible problem for eSCO audio with CSR USB Bluetooth dongle
Date: Mon, 15 Mar 2010 18:24:06 -0400
Message-ID: <AF001CBC42E74321BAACA4E800DC68E7@mapleworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <35c90d961003151435i6dc2a096j300198decb4844e6@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks, I will try it. 

The strange thing is the eSCO audio worked ok with Blackberry curve 8310,
which seems to use the same CSR BlueCore4 chipset and firmware version
0xc5c. I assume the library of Blackberry is not Bluez. 

But when I use a PC with CSR BlueCore4 dongle with USB interface and Bluez
library as the remote for testing, from the captured eSCO stream, I can not
see any real data I sent, I got all zero. 

However If I changed the USB dongle to Broadcom chipset, I can see a few
real data from captured eSCO stream (not all of data I sent, some seemed
lost or being replaced by zero). 


-----Original Message-----
From: Nick Pelly [mailto:npelly@google.com] 
Sent: Monday, March 15, 2010 5:35 PM
To: Cooper Xu
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: A strange compatible problem for eSCO audio with CSR USB
Bluetooth dongle


I wonder if this is some eSCO packet type incompatibility between
chipsets. Try setting /sys/module/sco/parameters/disable_esco to 1 to
see if this resolves the issue.

Nick

