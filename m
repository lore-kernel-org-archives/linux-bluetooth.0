Return-Path: <cyrus@holtmann.org>
Subject: Re: SMS from PC to phone over Bluetooth
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Newbie <blueznewbie@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <d4029b2f0906152201n29bd4ba9ld78a0d15ace21c44@mail.gmail.com>
References: <d4029b2f0906152201n29bd4ba9ld78a0d15ace21c44@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 16 Jun 2009 10:27:53 +0100
Message-Id: <1245144473.11069.8151.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2009-06-15 at 22:01 -0700, BlueZ Newbie wrote:
> Hi All,
> 
> I am trying to send an SMS message from my PC with a Bluetooth Dongle
> to my Samsung Blackjack cell phone. I tried to use OBEX to send a
> vMessage (text/x-vMessage TYPE) with a .vmg file. But, the cell phone
> does not seem to recognize this format. I can successfully send
> pictures, media files, vCard, and vCalendar files over OBEX.
> 
> Are there any alternate methods to accomplish this? Please note that I
> don't want to go through the service provider (ie., use of AT commands
> to my cellphone modem over Bluetooth). I am trying to stay away from
> all dependencies and purely use Bluetooth transport to accomplish
> this.

Try gnome-phone-manager and gnokii for this.

Cheers

