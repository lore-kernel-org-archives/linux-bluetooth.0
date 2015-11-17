Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 17 Nov 2015 10:54:59 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Prabhu Chawandi <foss.chaws@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: HoG device : Authentication Failure while connecting after
 reboot.
Message-ID: <20151117085459.GA12500@t440s.lan>
References: <CAKafyqqXugV5ceP2i=a9UEeYU1VR4yDNjqFFkQw5mv6kzraiCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKafyqqXugV5ceP2i=a9UEeYU1VR4yDNjqFFkQw5mv6kzraiCA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prabhu,

On Tue, Nov 17, 2015, Prabhu Chawandi wrote:
>   I have a HoG device, first time I pair and connect work fine...
> in the next reboot while connecting I saw multiple disconnection,
> after looking into hcidump
> I found that disconnection was due to authentication failure.  After
> multiple attempts (which it does) one attempt will succeed to
> establish the connection.
> 
> I also found that while initializing adapter stored link keys are
> being deleted. is this the reason for Authentication failure ?
> 
> > HCI Event: Command Complete (0x0e) plen 14
>     Read Local Extended Features (0x04|0x0004) ncmd 1
>     status 0x00 page 1 max 1
>     Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> < HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7
>     bdaddr 00:00:00:00:00:00 all 1

I can't really help you with the cause of your issue (not enough
information) but regarding the above: Link Keys are for BR/EDR, so
nothing to do with HoG or LE. Also, the above command just requests the
controller to clear its memory, i.e. it doesn't affect the keys that
BlueZ manages.

Johan
