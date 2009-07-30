Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add rfkill plugin
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <2d5a2c100907291910k20778781m3b37e510f4a5d4c2@mail.gmail.com>
References: <1248798884.23466.12024.camel@localhost.localdomain>
	 <1248880408.28327.906.camel@localhost.localdomain>
	 <1248896967.28545.236.camel@violet>
	 <1248898544.28327.1539.camel@localhost.localdomain>
	 <1248899010.28545.241.camel@violet> <20090729214412.GA24031@jh-x301>
	 <2d5a2c100907291910k20778781m3b37e510f4a5d4c2@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 30 Jul 2009 04:27:48 +0200
Message-Id: <1248920868.28545.245.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> > adapter_up() is more of a callback that's responsible for doing the
> > necessary initializations *after* adapter has just gone up, so it's not
> > the right function to call when you want to bring it up (i.e. call the
> > ioctl). I believe all code paths for bringing the adapter up call set_mode
> > in src/adapter.c which in turn calls adapter_ops->set_powered (which calls
> > the ioctl in the case of hciops).
> >
> > So having a btd_adapter_set_powered exported to plugins (which is what
> > Bastien's patch seems to do) makes sense to me in this case. I might
> > actually need something similar for maemo in order to handle our offline
> > mode better (maemo specific plugin to catch the MCE offline mode signal
> > and then call btd_adapter_set_powered).
> 
> Yep, sounds good to me too, plugins can have references to adapters so
> I guess this is perfectly fine. Also I don't think there is much to be
> protected here since powered property is readwrite and can be changed
> by any dbus client. This also makes me wonder what is the purpose of
> rfkill when we can anyone can set powered directly?

if it is rfkilled, then hciconfig hci0 up will return -ERFKILL. We fixed
this for the 2.6.31 kernel. WiFi behaves the same now. So you can't just
go ahead and bring it up again, you do have to unblock it. And you can
only unblock softkilled devices. If it is hardkilled via a hardware
switch for example, there is nothing you can do to bring it back up
except flipping the hardware switch.

Regards

Marcel


