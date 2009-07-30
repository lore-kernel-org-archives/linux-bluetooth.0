Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090729214412.GA24031@jh-x301>
References: <1248798884.23466.12024.camel@localhost.localdomain>
	 <1248880408.28327.906.camel@localhost.localdomain>
	 <1248896967.28545.236.camel@violet>
	 <1248898544.28327.1539.camel@localhost.localdomain>
	 <1248899010.28545.241.camel@violet> <20090729214412.GA24031@jh-x301>
Date: Wed, 29 Jul 2009 23:10:34 -0300
Message-ID: <2d5a2c100907291910k20778781m3b37e510f4a5d4c2@mail.gmail.com>
Subject: Re: [PATCH] Add rfkill plugin
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, Bastien Nocera <hadess@hadess.net>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jul 29, 2009 at 6:44 PM, Johan Hedberg<johan.hedberg@gmail.com> wro=
te:
> adapter_up() is more of a callback that's responsible for doing the
> necessary initializations *after* adapter has just gone up, so it's not
> the right function to call when you want to bring it up (i.e. call the
> ioctl). I believe all code paths for bringing the adapter up call set_mod=
e
> in src/adapter.c which in turn calls adapter_ops->set_powered (which call=
s
> the ioctl in the case of hciops).
>
> So having a btd_adapter_set_powered exported to plugins (which is what
> Bastien's patch seems to do) makes sense to me in this case. I might
> actually need something similar for maemo in order to handle our offline
> mode better (maemo specific plugin to catch the MCE offline mode signal
> and then call btd_adapter_set_powered).

Yep, sounds good to me too, plugins can have references to adapters so
I guess this is perfectly fine. Also I don't think there is much to be
protected here since powered property is readwrite and can be changed
by any dbus client. This also makes me wonder what is the purpose of
rfkill when we can anyone can set powered directly?


--=20
Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o
