Return-Path: <cyrus@holtmann.org>
Subject: Re: PATCH for input/fakehid.c to fix PS3 remote unpairing
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: "Ruslan N. Marchenko" <rufferson@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <1250698578.11521.0.camel@localhost.localdomain>
References: <a70b8cd30908190910p35910657m28fe09905717d60@mail.gmail.com>
	 <1250698578.11521.0.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 22 Aug 2009 13:03:38 -0700
Message-Id: <1250971418.2950.24.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> > Here is the patch to correctly handle PS3 remote unpairing and manual
> > turning off.
> 
> How do you test this?
> 
> <snip>
> 
> > I'm also thinking on implementing keymapping through input.conf
> > configuration section. Will it be accepted or not worth trying?
> 
> You should handle this in the input user-space, or in X itself, rather
> than in bluez.

I am not sure about that. The PS3 remote has pretty clear keys and we
should just assign them to default key values. If anyone wants to do
something different with them, then they can use X support for
keymapping. In reality, I believe nobody will.

Regards

Marcel


