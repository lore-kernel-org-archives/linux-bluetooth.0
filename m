Return-Path: <cyrus@holtmann.org>
Message-ID: <1436245912.26954.15.camel@hadess.net>
Subject: Re: Why doesn't plugins/sixaxis.c set devices as Trusted?
From: Bastien Nocera <hadess@hadess.net>
To: Alexander Holler <holler@ahsoftware.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Szymon Janc <szymon.janc@tieto.com>
Date: Tue, 07 Jul 2015 07:11:52 +0200
In-Reply-To: <559B5633.8000102@ahsoftware.de>
References: <1436188651.26954.9.camel@hadess.net>
	 <559B5633.8000102@ahsoftware.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2015-07-07 at 06:31 +0200, Alexander Holler wrote:
> Am 06.07.2015 um 15:17 schrieb Bastien Nocera:
> > Hey,
> > 
> > I don't understand the reason why plugins/sixaxis.c doesn't set the
> > device as trusted when plugged in.
> 
> It's because of security. If you trust a bluetooth device on Linux, 
> you're trusting it for all services. In case of the sixaxis it means 
> you're not only trusting it (the BT-MAC) as an input device, but also 
> as 
> a network device.
> 
> Now if you trust any plugged in device which says it's a sixaxis, I 
> would tell my arduino to say it's an sixaxis with a MAC from one of 
> my 
> BT-dongles to get a magic device which gives me wireless remote 
> access 
> on every linux box with BT when I plug it in once.
> 
> That means you want user interaction, besides just plugging in a 
> device.

What should the pairing process look like then? Because the current
workflow is absolutely dreadful.
