Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1447071693.24088.24.camel@hadess.net>
Subject: Re: PS3 remote battery drain
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Veit Guna <veit.guna@gmx.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 09 Nov 2015 13:21:33 +0100
In-Reply-To: <CABBYNZJ5GD9PHmruEwcoPbh54r2CzwidV-_-TkRiF3sbh061qg@mail.gmail.com>
References: <563F3739.7030405@gmx.de>
	 <CABBYNZJ5GD9PHmruEwcoPbh54r2CzwidV-_-TkRiF3sbh061qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2015-11-09 at 14:11 +0200, Luiz Augusto von Dentz wrote:
> 
<snip>
> Check that you have the following patch:
> 
> http://www.spinics.net/lists/linux-bluetooth/msg64073.html
> 
> This will make sure all the references to the sockets are released
> which means the device can be disconnected if nothing else is using
> the link.

I was about to make a reference to that patch. Do we have any way to
make this automatic for this device? I couldn't find a way to
automatically disconnect a device after a period of idleness, and even
less for a particular device. Do we have something like that?

Cheers
