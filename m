Return-Path: <cyrus@holtmann.org>
Message-ID: <1357937184.1806.82.camel@aeonflux>
Subject: Re: [PATCH BlueZ 1/7] gdbus: Add g_dbus_client_get_proxy
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 11 Jan 2013 12:46:24 -0800
In-Reply-To: <1357905018-23237-1-git-send-email-luiz.dentz@gmail.com>
References: <1357905018-23237-1-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> g_dbus_client_get_proxy gives the possibilitity to just check if a
> proxy exist for the given path and interface pair instead of using
> g_dbus_proxy_new which end up creating a proxy if it doesn't exists
> which is not always necessary.

why would we do that. You get the proxy via the client callbacks for
proxy created or proxy removed.

The proxy_new method is for dealing with services that do not have
ObjectManager support.

Regards

Marcel


