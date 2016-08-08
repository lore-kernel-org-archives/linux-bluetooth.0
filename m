Return-Path: <hadess@hadess.net>
Message-ID: <1470671433.2492.14.camel@hadess.net>
Subject: Re: 3dsp sample app and Bluez v5
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>, Gary Mort <gary@mort.net>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 08 Aug 2016 17:50:33 +0200
In-Reply-To: <37075208-AE18-4114-8029-40930FE22DA7@holtmann.org>
References: <556CC928.60503@mort.net>	
	 <C1D5C485-4FA0-4221-9F1A-A1A0941FE5F8@holtmann.org>	
	 <556CF450.2030107@mort.net>	
	 <4CBFCC0A-794F-4F78-A499-DFD083F29378@holtmann.org>	
	 <556D3082.5060403@mort.net>
	 <37075208-AE18-4114-8029-40930FE22DA7@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2015-06-02 at 07:00 +0200, Marcel Holtmann wrote:
> 
<snip>
> then you need a controller with connectionless slave broadcast
> support in master mode. The only ones I know of are some Marvell
> PCIe/USB or SDIO based cards and one Broadcom dongle with the
> firmware update applied.
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commi
> t/?id=d049f4e513e861167361b06c7ca85f9e872c8cde
> 
> I wrote an extra long commit message for reference on how this dongle
> works and that its slave mode is actually broken. And I have run this
> against a 3D enabled TV and I can pretend to be 3D glasses.
> 
> However for the display side, I have never gotten any good timing
> values that would allow me to get the glasses do something useful.
> And hooking it up to a proper frame sync was then just too much work.
> Then again, the code is there and you can start toying with it.

Doing thread grave digging.

Are there any more Bluetooth adapters that would support the necessary
mode to use 3DS glasses? One that would be available as external USB
dongle would be nice.

Cheers
