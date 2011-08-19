Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Aug 2011 15:49:17 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] serial: add Serial.ConnectFD()
Message-ID: <20110819184917.GB24573@joana>
References: <1313698203-13201-1-git-send-email-padovan@profusion.mobi>
 <CABBYNZ+_oSZ2f_dBv4P9hY_ORNaPK_mObwCA1oW_A0RH_woVRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CABBYNZ+_oSZ2f_dBv4P9hY_ORNaPK_mObwCA1oW_A0RH_woVRA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

* Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-08-19 10:07:30 +0300]:

> Hi Gustavo,
> 
> On Thu, Aug 18, 2011 at 11:09 PM, Gustavo F. Padovan
> <padovan@profusion.mobi> wrote:
> > From: "Gustavo F. Padovan" <padovan@profusion.mobi>
> >
> > It's similar to Serial.Connect() but returns the actual RFCOMM file
> > descriptor instead of creating a device in /dev
> > ---
> >  doc/serial-api.txt |   16 ++++++++++++++++
> >  serial/port.c      |   36 ++++++++++++++++++++++++++++++++++--
> >  2 files changed, 50 insertions(+), 2 deletions(-)
> >
> > diff --git a/doc/serial-api.txt b/doc/serial-api.txt
> > index 5f9bd5f..635b3ec 100644
> > --- a/doc/serial-api.txt
> > +++ b/doc/serial-api.txt
> > @@ -26,6 +26,22 @@ Methods              string Connect(string pattern)
> >                                         org.bluez.Error.ConnectionAttemptFailed
> >                                         org.bluez.Error.NotSupported
> >
> > +Methods                fd ConnectFD(string pattern)
> > +
> > +                       Connects to a specific RFCOMM based service on a
> > +                       remote device and returns a file descriptor to talk
> > +                        with this device.
> > +
> > +                       Possible patterns: UUID 128 bit as string
> > +                                          Profile short names, e.g: spp, dun
> > +                                          RFCOMM channel as string, 1-30
> > +
> > +                       Possible errors: org.bluez.Error.InvalidArguments
> > +                                        org.bluez.Error.InProgress
> > +                                        org.bluez.Error.ConnectionAttemptFailed
> > +                                        org.bluez.Error.NotSupported
> > +
> > +
> 
> Please mark ConnectFD as experimental, I guess we might want to
> complete remove the old Connect with this one when we are allowed to
> break the API.
> 
> >                void Disconnect(string device)
> >
> >                        Disconnect a RFCOMM TTY device that has been
> > diff --git a/serial/port.c b/serial/port.c
> > index d011084..e359716 100644
> > --- a/serial/port.c
> > +++ b/serial/port.c
> > @@ -63,6 +63,10 @@
> >  #define MAX_OPEN_TRIES         5
> >  #define OPEN_WAIT              300     /* ms. udev node creation retry wait */
> >
> > +#ifndef DBUS_TYPE_UNIX_FD
> > +#define DBUS_TYPE_UNIX_FD -1
> > +#endif
> > +
> >  struct serial_device {
> >        DBusConnection  *conn;          /* for name listener handling */
> >        bdaddr_t        src;            /* Source (local) address */
> > @@ -80,6 +84,7 @@ struct serial_port {
> >        int             fd;             /* Opened file descriptor */
> >        GIOChannel      *io;            /* BtIO channel */
> >        guint           listener_id;
> > +       gboolean        fd_passing;
> >        struct serial_device *device;
> >  };
> >
> > @@ -329,6 +334,14 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *conn_err,
> >        port->io = NULL;
> >
> >        sk = g_io_channel_unix_get_fd(chan);
> > +       if (port->fd_passing) {
> > +               reply = g_dbus_create_reply(port->msg,
> > +                               DBUS_TYPE_UNIX_FD, &sk,
> > +                               DBUS_TYPE_INVALID);
> > +               g_dbus_send_message(device->conn, reply);
> > +               return;
> > +       }
> > +
> 
> Since you have the message you may just check what is the method call
> which triggered the connect, so instead of creating a flag you just do
> e.g. if (g_str_equal(dbus_message_get_member(msg), "ConnectFD")).

I want to use fd_passing flag in the Disconnect part. We can't rely on the DBus
msg for this, once it freed (one of the following patches).

	Gustavo
