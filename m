Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Oct 2012 11:41:32 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Steffen Becker <steffen.becker@tu-ilmenau.de>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth3.0: No HS Speed
Message-ID: <20121008084124.GE2456@aemeltch-MOBL1>
References: <d38b6bd21b40254327824c73f662a4fd@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d38b6bd21b40254327824c73f662a4fd@localhost>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steffen,

On Mon, Oct 08, 2012 at 10:22:11AM +0200, Steffen Becker wrote:
> Hello,
> When I send datafiles (.mp3, .wav or .avi ; size >10 MB) then it is
> transfered only with Bluetooth-speed (~2MBit/s), and not with
> "Highspeed". I have two Bluetooth 3.0+HS Dongles and also the
> integrated wlan-chip is recognized: "ifconfig displays a
> wlan-adapter; and I don't have any wlan-card or -dongle in my PC, so
> I think this displayed wlan-adapter is the one from the
> Bluetooth-dongle.
> 
> I have a Windows PC with two virtual machines in it: Two Ubuntu12.04
> systems. I inserted the two Bluetooth 3.0+HS dongles in my Windows
> PC and created an USB-filter for each dongle to one Ubuntu system.
> So as I said before, datatransfer via Bluetooth between these two
> virtual Ubuntu systems works fine and also the wlan-adapter is
> displayed under ifconfig - but I only have bluetooth-speed =(

First you need High Speed support in the dongle. When you insert dongle
you should see 2 HCI devices: BREDR and HCI_AMP - which is High Speed
controller. Second you have to wait till we merge our patches upstream and
add High Speed support maybe later this year...

Best regards 
Andrei Emeltchenko 

