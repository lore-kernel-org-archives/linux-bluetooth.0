Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez-hcidump-1.42 fails to build against bluez-4.61
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: pacho@condmat1.ciencias.uniovi.es, linux-bluetooth@vger.kernel.org
In-Reply-To: <20100305203052.5dec1403@strolchi>
References: <1267814922.6970.19.camel@localhost.localdomain>
	 <20100305203052.5dec1403@strolchi>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 07 Mar 2010 13:43:59 -0800
Message-ID: <1267998239.3712.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

> > This is for recovering:
> > http://comments.gmane.org/gmane.linux.bluez.kernel/4619
> > 
> > since more users are getting this problem and I would like to know if
> > patches provided in that thread can be used and accepted by upstream or
> > they are not good enough.
> 
> In case they only got overlooked, I can of course resend them.
> 
> If they are not good enough, mentioning the problems might be
> helpful, so that I can do something about it ;)

they didn't get overlooked. It was my mistake that I broke hcidump and I
now put everything back in the library. So 4.62 should fix it. I was
under the assumption that nothing ever used these symbols, but as it
seems I was clearly wrong. Sorry about that.

Regards

Marcel


