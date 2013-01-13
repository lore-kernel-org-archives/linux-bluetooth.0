Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1357937184.1806.82.camel@aeonflux>
References: <1357905018-23237-1-git-send-email-luiz.dentz@gmail.com>
	<1357937184.1806.82.camel@aeonflux>
Date: Sun, 13 Jan 2013 18:09:47 +0200
Message-ID: <CABBYNZJyaBUt+oRSzyYJ0PNLTys8BfODLJFNY5NzC5touoraGA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/7] gdbus: Add g_dbus_client_get_proxy
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jan 11, 2013 at 10:46 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>> g_dbus_client_get_proxy gives the possibilitity to just check if a
>> proxy exist for the given path and interface pair instead of using
>> g_dbus_proxy_new which end up creating a proxy if it doesn't exists
>> which is not always necessary.
>
> why would we do that. You get the proxy via the client callbacks for
> proxy created or proxy removed.

That way we the user don't have to maintain a list of found proxies,
such a list exist and is maintained by GDBusClient.

> The proxy_new method is for dealing with services that do not have
> ObjectManager support.

Yep, so in one way or the other you are already letting the user
application search in the list of proxies maintained by GDBusClient,
the only thing this does is to make the proxy_lookup public so the
client don't have to maintain its how list only to be able to look
back when a proxy point to another, btw the reason proxy_new is not
enough is because it may lead to extra calls when the user application
may just want to bail out if the proxy is not found.


--
Luiz Augusto von Dentz
