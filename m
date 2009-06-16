Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 15 Jun 2009 22:01:13 -0700
Message-ID: <d4029b2f0906152201n29bd4ba9ld78a0d15ace21c44@mail.gmail.com>
Subject: SMS from PC to phone over Bluetooth
From: BlueZ Newbie <blueznewbie@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I am trying to send an SMS message from my PC with a Bluetooth Dongle
to my Samsung Blackjack cell phone. I tried to use OBEX to send a
vMessage (text/x-vMessage TYPE) with a .vmg file. But, the cell phone
does not seem to recognize this format. I can successfully send
pictures, media files, vCard, and vCalendar files over OBEX.

Are there any alternate methods to accomplish this? Please note that I
don't want to go through the service provider (ie., use of AT commands
to my cellphone modem over Bluetooth). I am trying to stay away from
all dependencies and purely use Bluetooth transport to accomplish
this.

Any help is much appreciated.

Kumar
