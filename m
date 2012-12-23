Return-Path: <cyrus@holtmann.org>
Message-ID: <1356280239.29264.28.camel@aeonflux>
Subject: Re: [PATCH BlueZ 3/6] gdbus: Introduce GDBusInterfaceFlags
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Sun, 23 Dec 2012 08:30:39 -0800
In-Reply-To: <CABBYNZ+set-vvzf+6whfPt5zE8c7X_t2DB4vJS6p8v2X0i_U-A@mail.gmail.com>
References: <1356276298-13795-1-git-send-email-luiz.dentz@gmail.com>
	 <1356276298-13795-3-git-send-email-luiz.dentz@gmail.com>
	 <1356278946.29264.24.camel@aeonflux>
	 <CABBYNZ+set-vvzf+6whfPt5zE8c7X_t2DB4vJS6p8v2X0i_U-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> >> The flags should be passed in g_dbus_register_interface_with_flags,
> >> currently there only one flag which is G_DBUS_INTERFACE_FLAG_EXPERIMENTAL
> >> which works similarly to G_DBUS_METHOD_FLAG_EXPERIMENTAL but for the
> >> whole interface.
> >> ---
> >>  gdbus/gdbus.h  | 13 +++++++++++++
> >>  gdbus/object.c | 20 ++++++++++++++++++++
> >>  2 files changed, 33 insertions(+)
> >
> > can we not just check if the interface contains any non experimental
> > method, signals and properties and base that decision around that?
> 
> It can work, but we would have to iterate on every single item, so in
> terms of code is quite a bit more complex so I favored adding a new
> function even though we might replace it in the long run.

we have to iterate over every single item in the success case anyway, so
why bother trying to optimize this.

> > I am not really in favor of introducing a version with flags.
> 
> The final solution I was thinking is passing another interface
> containing the table as this tend to be quite static e.g.:

If this is not the final solution you are heading for, then lets not
even bother introducing it. Lets go with the the simple approach that
does not introduce any new functions.

It has the advantage that you only need to change one place. Otherwise
you need to check the method structs and the calling register function.

Regards

Marcel


