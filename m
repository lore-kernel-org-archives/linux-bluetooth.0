Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090719175737.GA9278@piper.oerlikon.madduck.net>
References: <20090718055411.GA21651@piper.oerlikon.madduck.net>
	 <2d5a2c100907191036o7c48c405r32f0292a9168cb92@mail.gmail.com>
	 <20090719175737.GA9278@piper.oerlikon.madduck.net>
Date: Sun, 19 Jul 2009 15:20:31 -0300
Message-ID: <2d5a2c100907191120g79980cebme985bbff2fbb6ef5@mail.gmail.com>
Subject: Re: How to replace DUN with bluez 4?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux bluetooth mailinglist <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HI,

On Sun, Jul 19, 2009 at 2:57 PM, martin f krafft<madduck@madduck.net> wrote:
> So you are saying that it should not be too hard to write a little
> programme that got the port and which fires off pppd on connect?

Have you tried this:
https://help.ubuntu.com/community/BluetoothDialup#Configuring%20PPP

> Is there any non-"wizard" and non-GUI support planned? I really
> appreciated how dund just ran as a daemon.

You can write a shell script wizard if you prefer, it is basically a
DBus client to talk to bluetoothd. Linux desktop already have much
better alternatives (NM and connman) to what dund does they just need
some adaptations, so no we don't consider writing an alternative to
dund on BlueZ.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
