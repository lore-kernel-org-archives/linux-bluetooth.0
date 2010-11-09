Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Nov 2010 18:30:58 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/9] Add __btd_error_already_exists()
Message-ID: <20101109203058.GB29174@vigoh>
References: <1289197787-16715-1-git-send-email-padovan@profusion.mobi>
 <1289197787-16715-2-git-send-email-padovan@profusion.mobi>
 <1289197787-16715-3-git-send-email-padovan@profusion.mobi>
 <AANLkTinK_6hrW+FJMdfoUPuq+V5EcqaXVQNd0mWu4vZR@mail.gmail.com>
 <20101109171317.GA29174@vigoh>
 <AANLkTi=7Ou9+j1rEt=d6b9Fc2eHx4L=4aMvGD2OPYooY@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTi=7Ou9+j1rEt=d6b9Fc2eHx4L=4aMvGD2OPYooY@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HI Jose,

* Jose Antonio Santos Cadenas <santoscadenas@gmail.com> [2010-11-09 21:13:57 +0100]:

> Hi Gustavo,
> 
> 2010/11/9 Gustavo F. Padovan <padovan@profusion.mobi>:
> > Hi Jose,
> >
> > * Jose Antonio Santos Cadenas <santoscadenas@gmail.com> [2010-11-09 09:22:56 +0100]:
> >
> >> Hi,
> >>
> >> 2010/11/8 Gustavo F. Padovan <padovan@profusion.mobi>:
> >> > ---
> >> >  audio/gateway.c  |    4 +---
> >> >  audio/media.c    |    3 +--
> >> >  network/server.c |    2 +-
> >> >  serial/proxy.c   |    3 +--
> >> >  src/adapter.c    |    8 ++------
> >> >  src/device.c     |    4 +---
> >> >  src/error.c      |    7 +++++++
> >> >  src/error.h      |    1 +
> >> >  8 files changed, 15 insertions(+), 17 deletions(-)
> >> >
> >> > diff --git a/audio/gateway.c b/audio/gateway.c
> >> > index ab7d310..ae0ee75 100644
> >> > --- a/audio/gateway.c
> >> > +++ b/audio/gateway.c
> >> > @@ -488,9 +488,7 @@ static DBusMessage *register_agent(DBusConnection *conn,
> >> >        const char *path, *name;
> >> >
> >> >        if (gw->agent)
> >> > -               return g_dbus_create_error(msg,
> >> > -                                       ERROR_INTERFACE ".AlreadyExists",
> >> > -                                       "Agent already exists");
> >> > +               return __btd_error_already_exists(msg);
> >> >
> >> >        if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
> >> >                                                DBUS_TYPE_INVALID))
> >> > diff --git a/audio/media.c b/audio/media.c
> >> > index 862cee6..8821ee1 100644
> >> > --- a/audio/media.c
> >> > +++ b/audio/media.c
> >> > @@ -318,8 +318,7 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
> >> >        dbus_message_iter_next(&args);
> >> >
> >> >        if (media_adapter_find_endpoint(adapter, sender, path, NULL) != NULL)
> >> > -               return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
> >> > -                               "Endpoint already registered");
> >> > +               return __btd_error_already_exists(msg);
> >> >
> >> >        dbus_message_iter_recurse(&args, &props);
> >> >        if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_DICT_ENTRY)
> >> > diff --git a/network/server.c b/network/server.c
> >> > index ce1fe5e..41c9ec3 100644
> >> > --- a/network/server.c
> >> > +++ b/network/server.c
> >> > @@ -605,7 +605,7 @@ static DBusMessage *register_server(DBusConnection *conn,
> >> >                return failed(msg, "Invalid UUID");
> >> >
> >> >        if (ns->record_id)
> >> > -               return failed(msg, "Already registered");
> >> > +               return __btd_error_already_exists(msg);
> >> >
> >> >        reply = dbus_message_new_method_return(msg);
> >> >        if (!reply)
> >> > diff --git a/serial/proxy.c b/serial/proxy.c
> >> > index 8e182b6..de82f9a 100644
> >> > --- a/serial/proxy.c
> >> > +++ b/serial/proxy.c
> >> > @@ -1058,8 +1058,7 @@ static DBusMessage *create_proxy(DBusConnection *conn,
> >> >        if (err == -EINVAL)
> >> >                return __btd_error_invalid_args(msg);
> >> >        else if (err == -EALREADY)
> >> > -               return g_dbus_create_error(msg, ERROR_INTERFACE ".AlreadyExist",
> >> > -                                               "Proxy already exists");
> >> > +               return __btd_error_already_exists(msg);
> >> >        else if (err < 0)
> >> >                return g_dbus_create_error(msg, ERROR_INTERFACE "Failed",
> >> >                                "Proxy creation failed (%s)", strerror(-err));
> >> > diff --git a/src/adapter.c b/src/adapter.c
> >> > index cc51816..ffbc943 100644
> >> > --- a/src/adapter.c
> >> > +++ b/src/adapter.c
> >> > @@ -1742,9 +1742,7 @@ static DBusMessage *create_device(DBusConnection *conn,
> >> >                return __btd_error_invalid_args(msg);
> >> >
> >> >        if (adapter_find_device(adapter, address))
> >> > -               return g_dbus_create_error(msg,
> >> > -                               ERROR_INTERFACE ".AlreadyExists",
> >> > -                               "Device already exists");
> >> > +               return __btd_error_already_exists(msg);
> >> >
> >> >        DBG("%s", address);
> >> >
> >> > @@ -1906,9 +1904,7 @@ static DBusMessage *register_agent(DBusConnection *conn, DBusMessage *msg,
> >> >                return NULL;
> >> >
> >> >        if (adapter->agent)
> >> > -               return g_dbus_create_error(msg,
> >> > -                               ERROR_INTERFACE ".AlreadyExists",
> >> > -                               "Agent already exists");
> >> > +               return __btd_error_already_exists(msg);
> >> >
> >> >        cap = parse_io_capability(capability);
> >> >        if (cap == IO_CAPABILITY_INVALID)
> >> > diff --git a/src/device.c b/src/device.c
> >> > index ef1a910..6d110dc 100644
> >> > --- a/src/device.c
> >> > +++ b/src/device.c
> >> > @@ -1944,9 +1944,7 @@ DBusMessage *device_create_bonding(struct btd_device *device,
> >> >        str = textfile_caseget(filename, dstaddr);
> >> >        if (str) {
> >> >                free(str);
> >> > -               return g_dbus_create_error(msg,
> >> > -                               ERROR_INTERFACE ".AlreadyExists",
> >> > -                               "Bonding already exists");
> >> > +               return __btd_error_already_exists(msg);
> >> >        }
> >> >
> >> >        /* If our IO capability is NoInputNoOutput use medium security
> >> > diff --git a/src/error.c b/src/error.c
> >> > index a30c050..e268163 100644
> >> > --- a/src/error.c
> >> > +++ b/src/error.c
> >> > @@ -55,3 +55,10 @@ DBusMessage *__btd_error_invalid_args(DBusMessage *msg)
> >> >                                        ".InvalidArguments",
> >> >                                        "Invalid arguments in method call");
> >> >  }
> >> > +
> >> > +DBusMessage *__btd_error_already_exists(DBusMessage *msg)
> >>
> >> I also think that an additional message will be great for a better description.
> >
> > I'm not seeing any case when we need that for already_exists(). All
> > messages were saying the same thing. We don't need them.
> 
> 
> The messages are different for each case: (ie: "Bonding already
> exists", "Agent already exists", etc), they are nearly the same but
> they are a little bit more expressive. Also if we keep the additional
> message, we are following the same behaviour than in the other error
> funtions, this way this API is easy to use.

Yes, they are, but you always know the DBus funcion you called. If you
call RegisterAgent() and it replies .AlreadyExists you will know that is
a Agent that already exists, and not a Bonding, Device, etc. So no need
to explain the error in theses cases.

