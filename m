Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090718055411.GA21651@piper.oerlikon.madduck.net>
References: <20090718055411.GA21651@piper.oerlikon.madduck.net>
Date: Sun, 19 Jul 2009 14:36:22 -0300
Message-ID: <2d5a2c100907191036o7c48c405r32f0292a9168cb92@mail.gmail.com>
Subject: Re: How to replace DUN with bluez 4?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux bluetooth mailinglist <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Jul 18, 2009 at 2:54 AM, martin f krafft<madduck@madduck.net> wrote:
> Hi list,
>
> I've searched the web, but short of
> http://wiki.bluez.org/HOWTO/SerialConnections (the wiki is broken
> currently btw), I could not find any information how one is supposed
> to provide a dial-up means (for a Palm Tungsten) via bluetooth with
> bluez 4. The wiki page shows me how to use the dbus services, but
> not how to link that with pppd or integrate it properly with
> a system.

You can make use of Serial interface by calling
Serial.Connect(''dun"), this will return you a bonded port to use, it
is up to you to use pppd or whatever you prefer to connect, note that
the port will not be stored permanently.  There are some plans to
integrate it with NetworkManager and connman, but there are some parts
missing like possible integrating it properly with the wizard and
store permanently.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
