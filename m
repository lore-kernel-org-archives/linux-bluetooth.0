Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4a221c10908120710y1ad31540ib5b16f27d2af4751@mail.gmail.com>
References: <4A82B32E.3020903@gmail.com>
	 <2d5a2c100908120559h1a3ed5acn26b8a07ab41cd95@mail.gmail.com>
	 <4a221c10908120710y1ad31540ib5b16f27d2af4751@mail.gmail.com>
Date: Thu, 13 Aug 2009 14:10:45 -0300
Message-ID: <2d5a2c100908131010r7b077b49i4c495d864cae6667@mail.gmail.com>
Subject: Re: NAP/GN with bluez-4
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Dmitry A. Yanko" <y.dmitry@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HI,

On Wed, Aug 12, 2009 at 11:10 AM, Dmitry A. Yanko<y.dmitry@gmail.com> wrote:
> router = dbus.Interface(bus.get_object("org.bluez", manager.DefaultAdapter()),
>                "org.bluez.NetworkRouter")
> ...
> print router.dbus_interface
> props = router.GetProperties()
> for pname in props.keys():
>        print pname,props[pname]
> ...

What does the command sdptool browse local gives to you? About the
pan2 you should create it yourself, as I explained before we don't
handle the routing/dhcp which is required for NAP, this can be the
problem here but in the other hand there is probably a bug since
enabled is set to true.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
