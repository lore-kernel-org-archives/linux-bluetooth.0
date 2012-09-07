Return-Path: <cyrus@holtmann.org>
Message-ID: <1346996989.21200.120.camel@aeonflux>
Subject: Re: [PATCH BlueZ v3 06/15] gdbus: Implement DBus.Properties.Set
 method
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Date: Thu, 06 Sep 2012 22:49:49 -0700
In-Reply-To: <CABBYNZLZJTcw1Swp-Le25+F8fAweTDy=733PTVffc4sRJbFikQ@mail.gmail.com>
References: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi>
	 <1345272662-2850-7-git-send-email-lucas.demarchi@profusion.mobi>
	 <1346961700.21200.116.camel@aeonflux>
	 <CABBYNZLZJTcw1Swp-Le25+F8fAweTDy=733PTVffc4sRJbFikQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> >> Contrary to Get() and GetAll(), Set is asynchronous so we pass on the
> >> DBusMessage so user is able to create the response. It's the only use of
> >> this parameter.
> >> ---
> >>  gdbus/gdbus.h  |  7 +++++++
> >>  gdbus/object.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
> >>  2 files changed, 64 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
> >> index b2e78c4..3e4aa16 100644
> >> --- a/gdbus/gdbus.h
> >> +++ b/gdbus/gdbus.h
> >> @@ -31,6 +31,8 @@ extern "C" {
> >>  #include <dbus/dbus.h>
> >>  #include <glib.h>
> >>
> >> +typedef enum GDBusPropertySetReturn GDBusPropertySetReturn;
> >> +
> >>  typedef enum GDBusMethodFlags GDBusMethodFlags;
> >>  typedef enum GDBusSignalFlags GDBusSignalFlags;
> >>  typedef enum GDBusPropertyFlags GDBusPropertyFlags;
> >> @@ -69,6 +71,10 @@ typedef DBusMessage * (* GDBusMethodFunction) (DBusConnection *connection,
> >>  typedef gboolean (*GDBusPropertyGetter)(const GDBusPropertyTable *property,
> >>                                       DBusMessageIter *iter, void *data);
> >>
> >> +typedef DBusMessage *(*GDBusPropertySetter)(const GDBusPropertyTable *property,
> >> +                                     DBusMessageIter *value,
> >> +                                     DBusMessage *msg, void *data);
> >> +
> >
> > I am not really happy with this. We just need a unique handle here since
> > the return value is either success or an error. I rather don't send
> > messages around for no other reason to create the error.
> >
> > Inside the authorization code I am using GDBusPendingReply as unique
> > token. What about using the same approach?
> 
> It would be perfect, but Im afraid sometimes the properties can have
> restriction on which sender can set them, so perhaps we need to add
> the name of the sender as parameter in addiction to just the handle?

that should be done through the same security handling we have for the
method calls. Don't try to invent something new.

Regards

Marcel


