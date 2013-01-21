Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1358757002.7854.27.camel@pflykt-mobl1>
References: <1358757002.7854.27.camel@pflykt-mobl1>
Date: Mon, 21 Jan 2013 11:25:55 +0200
Message-ID: <CABBYNZ+qtdEP_mQWFppzQ0rj84djGXFrRR+yLY0qJqFyPUMVhQ@mail.gmail.com>
Subject: Re: Object manager properties on Network1 Connect method call reply
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Patrik Flykt <patrik.flykt@linux.intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Patrick,

On Mon, Jan 21, 2013 at 10:30 AM, Patrik Flykt
<patrik.flykt@linux.intel.com> wrote:
>
>         Hi,
>
> While implementing ConnMan Bluez 5 plugin using GDBusProxy from ./gdbus
> I noticed the following things.
>
> On org.bluez.Network1.Connect method call return the object properties
> 'Connected', 'Interface' and 'UUID' have not yet been updated. It is of
> course obvious that if no error occurs, the network is connected. And
> the interface is provided as an argument to the method call return
> function so that's fine as well.
>
> If the method call signals an error, then the network is of course not
> connected. Except if the error is 'AlreadyConnected', which means it is.
> Since it is not possible to send arguments in an error reply, the only
> way to figure out the interface is via the 'Interface' GDBusProxy
> property. 'Connected' and 'UUID' properties are also set properly in
> this case.

I suppose you also have a callback to properties changed signal so in
case of AlreadyConnected error I guess you should not even call it if
you happen to detect it is already connected.

> From the above it would be more consistent if the properties were
> already set to their intended values when the Connect method call
> returns independent of success or failure. Thus one set of logic would
> suffice on ConnMan side to handle both cases.
>
> Maybe the org.bluez.Network1 object properties could be updated only for
> the Network1 object in question before sending the method call return?
> Of course the devil may be in the details of the Bluez 5 API why the
> object property update should not or can not be done this way.

Yep, we discussed this before an came to a conclusion that we probably
need a way to propagate changes immediately in certain situations to
avoid swallow changes, one idea was to modify
g_dbus_emit_property_changed to take a flag or create another property
flag e.g. G_DBUS_PROPERTY_FLAG_CHANGE_IMMEDIATELY or
G_DBUS_PROPERTY_FLAG_NO_WAIT.


--
Luiz Augusto von Dentz
