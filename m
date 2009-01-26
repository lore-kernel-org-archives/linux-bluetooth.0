Return-Path: <cyrus@holtmann.org>
Subject: Re: Sony BD Remote Control still does not make input event, what
 part of the driver is driver missing?
From: Bastien Nocera <hadess@hadess.net>
To: Jelle de Jong <jelledejong@powercraft.nl>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <49750C60.4090001@powercraft.nl>
References: <49750C60.4090001@powercraft.nl>
Content-Type: text/plain
Date: Mon, 26 Jan 2009 15:09:21 +0000
Message-Id: <1232982561.3330.3777.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2009-01-20 at 00:27 +0100, Jelle de Jong wrote:
> Hi all,
> 
> I thought I gave my Sony PS3 Bluetooth remote an other try, see all my
> previous messages trials and bug reports back in the mail archive.
> 
> The device still does not create an input event that can be used out of
> the box. What parts are missing to get this working?

modprobe uinput?

> The device connects with the gnome bluetooth tool, you see the connect
> icon go on very short then the connect icons goes away. hcitool con also
> does not show the device and there is no input event created.
> 
> What is going on here? And what need to be done here.


