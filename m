Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1357937240.1806.83.camel@aeonflux>
References: <1357905018-23237-1-git-send-email-luiz.dentz@gmail.com>
	<1357905018-23237-2-git-send-email-luiz.dentz@gmail.com>
	<1357937240.1806.83.camel@aeonflux>
Date: Sun, 13 Jan 2013 18:24:37 +0200
Message-ID: <CABBYNZKZ1kXbF7E5jJbPhduZcLmFcTT45jyA67KzoJeJVZiz3A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/7] gdbus: Add g_dbus_proxy_get_client function
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jan 11, 2013 at 10:47 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>> This is convenient as some callbacks don't provide the client which
>> the proxy belongs.
>
> and I did not add that one on purpose. You should know where your proxy
> belongs to and worst case hand it over via user_data.

I understand this as the user_data will always be the client pointer,
or a struct containing it, or you have to use a global variable, is
that what you really want? The use application has given the client
when registering the callbacks, so it is already passing it as
context. Now that being said, Im not saying the design utterly broken,
quite the contrary it work like a charm, it just could be more
convenient and that is what Im trying to achieve with this patch.

--
Luiz Augusto von Dentz
