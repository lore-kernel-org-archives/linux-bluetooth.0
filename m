Return-Path: <cyrus@holtmann.org>
Message-ID: <1356305714.29264.37.camel@aeonflux>
Subject: Re: [PATCH BlueZ 1/8] gdbus: Introduce
 G_DBUS_METHOD_FLAG_EXPERIMENTAL
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Sun, 23 Dec 2012 15:35:14 -0800
In-Reply-To: <CABBYNZJCA6ompsqzjPcBT-=z20QgrL_ynGR2aDsN=q3rknt=vw@mail.gmail.com>
References: <1356293718-9348-1-git-send-email-luiz.dentz@gmail.com>
	 <1356296297.29264.34.camel@aeonflux>
	 <CABBYNZJCA6ompsqzjPcBT-=z20QgrL_ynGR2aDsN=q3rknt=vw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> >> This flag can be used to mark methods as experimental, the marked
> >> methods with this flag can be enabled by setting the environment variable
> >> GDBUS_EXPERIMENTAL=1
> >> ---
> >>  gdbus/gdbus.h  | 21 ++++++++++++++++++---
> >>  gdbus/object.c | 17 +++++++++++++++++
> >>  2 files changed, 35 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
> >> index 0e5c012..00fbb1c 100644
> >> --- a/gdbus/gdbus.h
> >> +++ b/gdbus/gdbus.h
> >> @@ -89,9 +89,10 @@ typedef void (* GDBusSecurityFunction) (DBusConnection *connection,
> >>                                               GDBusPendingReply pending);
> >>
> >>  enum GDBusMethodFlags {
> >> -     G_DBUS_METHOD_FLAG_DEPRECATED = (1 << 0),
> >> -     G_DBUS_METHOD_FLAG_NOREPLY    = (1 << 1),
> >> -     G_DBUS_METHOD_FLAG_ASYNC      = (1 << 2),
> >> +     G_DBUS_METHOD_FLAG_DEPRECATED   = (1 << 0),
> >> +     G_DBUS_METHOD_FLAG_NOREPLY      = (1 << 1),
> >> +     G_DBUS_METHOD_FLAG_ASYNC        = (1 << 2),
> >> +     G_DBUS_METHOD_FLAG_EXPERIMENTAL = (1 << 3),
> >>  };
> >>
> >>  enum GDBusSignalFlags {
> >> @@ -173,6 +174,20 @@ struct GDBusSecurityTable {
> >>       .function = _function, \
> >>       .flags = G_DBUS_METHOD_FLAG_ASYNC | G_DBUS_METHOD_FLAG_DEPRECATED
> >>
> >> +#define GDBUS_EXPERIMENTAL_METHOD(_name, _in_args, _out_args, _function) \
> >> +     .name = _name, \
> >> +     .in_args = _in_args, \
> >> +     .out_args = _out_args, \
> >> +     .function = _function, \
> >> +     .flags = G_DBUS_METHOD_FLAG_EXPERIMENTAL
> >> +
> >> +#define GDBUS_EXPERIMENTAL_ASYNC_METHOD(_name, _in_args, _out_args, _function) \
> >> +     .name = _name, \
> >> +     .in_args = _in_args, \
> >> +     .out_args = _out_args, \
> >> +     .function = _function, \
> >> +     .flags = G_DBUS_METHOD_FLAG_ASYNC | G_DBUS_METHOD_FLAG_EXPERIMENTAL
> >> +
> >>  #define GDBUS_NOREPLY_METHOD(_name, _in_args, _out_args, _function) \
> >>       .name = _name, \
> >>       .in_args = _in_args, \
> >> diff --git a/gdbus/object.c b/gdbus/object.c
> >> index 776d35e..30dbbc2 100644
> >> --- a/gdbus/object.c
> >> +++ b/gdbus/object.c
> >> @@ -129,6 +129,14 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
> >>                                               G_DBUS_METHOD_FLAG_DEPRECATED;
> >>               gboolean noreply = method->flags &
> >>                                               G_DBUS_METHOD_FLAG_NOREPLY;
> >> +             gboolean experimental = method->flags &
> >> +                                     G_DBUS_METHOD_FLAG_EXPERIMENTAL;
> >> +
> >> +             if (experimental) {
> >> +                     const char *env = g_getenv("GDBUS_EXPERIMENTAL");
> >> +                     if (g_strcmp0(env, "1") != 0)
> >> +                             continue;
> >> +             }
> >
> > actually since this is a library, doing it this way is a bad idea.
> 
> I thought it was a common practice to use environment variables with
> libraries to change certain defaults, glib does that with things like
> G_SLICE=always-malloc, and it is quite convenient since you can change
> easily without recompiling.

GLib does this, but we never did this. GAtChat, GDHCP, GWeb etc.
provided a function to enable it. The hooking up to environment variable
is then the responsibility of the main program.

> > Lets do something like g_dbus_enable_experimental(DBusConnection)
> 
> But this is not really per connection, anyway doing so you have to
> handle this directly on the application code which IMO is not as
> convenient.

Making this per connection would be pretty convenient if you are
connected to more than one bus.

Regards

Marcel


