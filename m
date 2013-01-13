Return-Path: <cyrus@holtmann.org>
Message-ID: <1358111525.1806.89.camel@aeonflux>
Subject: Re: [PATCH BlueZ 2/7] gdbus: Add g_dbus_proxy_get_client function
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Sun, 13 Jan 2013 13:12:05 -0800
In-Reply-To: <CABBYNZKZ1kXbF7E5jJbPhduZcLmFcTT45jyA67KzoJeJVZiz3A@mail.gmail.com>
References: <1357905018-23237-1-git-send-email-luiz.dentz@gmail.com>
	 <1357905018-23237-2-git-send-email-luiz.dentz@gmail.com>
	 <1357937240.1806.83.camel@aeonflux>
	 <CABBYNZKZ1kXbF7E5jJbPhduZcLmFcTT45jyA67KzoJeJVZiz3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> >> This is convenient as some callbacks don't provide the client which
> >> the proxy belongs.
> >
> > and I did not add that one on purpose. You should know where your proxy
> > belongs to and worst case hand it over via user_data.
> 
> I understand this as the user_data will always be the client pointer,
> or a struct containing it, or you have to use a global variable, is
> that what you really want? The use application has given the client
> when registering the callbacks, so it is already passing it as
> context. Now that being said, Im not saying the design utterly broken,
> quite the contrary it work like a charm, it just could be more
> convenient and that is what Im trying to achieve with this patch.

it is a convenience for one special kind of quick-and-dirty hack that
normal application will never need. I have made these mistakes in the
past and rather have not sneaking up on me again. So lets not do this.

Regards

Marcel


