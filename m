Return-Path: <cyrus@holtmann.org>
Message-ID: <1358111392.1806.87.camel@aeonflux>
Subject: Re: [PATCH BlueZ 1/7] gdbus: Add g_dbus_client_get_proxy
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Sun, 13 Jan 2013 13:09:52 -0800
In-Reply-To: <CABBYNZJyaBUt+oRSzyYJ0PNLTys8BfODLJFNY5NzC5touoraGA@mail.gmail.com>
References: <1357905018-23237-1-git-send-email-luiz.dentz@gmail.com>
	 <1357937184.1806.82.camel@aeonflux>
	 <CABBYNZJyaBUt+oRSzyYJ0PNLTys8BfODLJFNY5NzC5touoraGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> >> g_dbus_client_get_proxy gives the possibilitity to just check if a
> >> proxy exist for the given path and interface pair instead of using
> >> g_dbus_proxy_new which end up creating a proxy if it doesn't exists
> >> which is not always necessary.
> >
> > why would we do that. You get the proxy via the client callbacks for
> > proxy created or proxy removed.
> 
> That way we the user don't have to maintain a list of found proxies,
> such a list exist and is maintained by GDBusClient.

see how bluetoothctl does it. Pretty damn simple. So I am not convinced
that this is a good idea.

> > The proxy_new method is for dealing with services that do not have
> > ObjectManager support.
> 
> Yep, so in one way or the other you are already letting the user
> application search in the list of proxies maintained by GDBusClient,
> the only thing this does is to make the proxy_lookup public so the
> client don't have to maintain its how list only to be able to look
> back when a proxy point to another, btw the reason proxy_new is not
> enough is because it may lead to extra calls when the user application
> may just want to bail out if the proxy is not found.

Still not convinced. What kind of application would this. This seems to
be all half thought trough. I am really failing to see the real purpose
here. Either you go all the way with ObjectManager and do it the right
way or you don't have an object manager, then you need to manually
trigger the get all properties.

Regards

Marcel


