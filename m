Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
Date: Tue, 12 Aug 2008 22:53:45 +0200
Cc: linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <200807311452.24166.oliver@neukum.org> <1218230070.25524.7.camel@californication>
In-Reply-To: <1218230070.25524.7.camel@californication>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808122253.45829.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Freitag 08 August 2008 23:14:30 schrieb Marcel Holtmann:
> Hi Oliver,
> 
> > here's my current version of btusb with SCO support. This is preliminary.
> > I am still looking at a way to delay using the higher altsettings until SCO
> > is actually used, but the timeouts seem to be too long to do the obvious.
> 
> the module parameter and blacklist/quirks stuff has been merged upstream
> with Linus now. Feel free to update your SCO support patch and then lets
> get this merged.

Still testing. I am new to bluetooth so getting a sound testing environment
up takes a bit of time. I am getting iso urbs to complete now.

	Regards
		Oliver
 
