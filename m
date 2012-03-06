Return-Path: <cyrus@holtmann.org>
Message-ID: <1331044542.3392.168.camel@aeonflux>
Subject: Re: [RFC BlueZ 3/3] core: Add Interfaces property to
 org.bluez.Device
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Date: Tue, 06 Mar 2012 06:35:42 -0800
In-Reply-To: <CABBYNZL3tUpmqEHPx+6LJkJjZMDf7ajc0d-x_n51=i6HX03nng@mail.gmail.com>
References: <1331035658-10000-1-git-send-email-luiz.dentz@gmail.com>
	 <1331035658-10000-3-git-send-email-luiz.dentz@gmail.com>
	 <CAJdJm_OmpNXq-hhqAQTXn-rvOk1eJhfQzuGdt2pQLRaa4+F1og@mail.gmail.com>
	 <CABBYNZL3tUpmqEHPx+6LJkJjZMDf7ajc0d-x_n51=i6HX03nng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> > On Tue, Mar 6, 2012 at 8:07 AM, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> >> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >>
> >> This enables applications to be able to detect when an interface is
> >> enabled/disabled without depending on UUIDs.
> >> ---
> >>  doc/device-api.txt |    4 ++++
> >>  src/device.c       |   27 ++++++++++++++++++++++-----
> >>  2 files changed, 26 insertions(+), 5 deletions(-)
> >
> > I thought it was possible to achieve this by using D-Bus listeners?
> > E.g. similar to g_dbus_add_service_watch()
> 
> Afaik there is no such thing as introspection data changed or anything
> like that, we could in theory have local listeners, but at least in
> BlueZ there is no much use for them since it is not really dynamic
> after drivers are loaded, but perhaps for oFono and others it could be
> useful to have some way to watch when interfaces changes.
> 
> In case of oFono it does that by having e.g.
> ofono_modem_add_interface/ofono_modem_remove_interface.
> 
> > What happens when the interface is unregistered with
> > g_dbus_unregister_interface() ?
> 
> This should only be the case when removing the object so the driver
> .remove is called which then calls g_dbus_unregister_interface.

I was not planning to add this to our gdbus code and focus on getting
this right for ELL. However look into the D-Bus ObjectManager
specification since that is what you want actually.

Regards

Marcel


