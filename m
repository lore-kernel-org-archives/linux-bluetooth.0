Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLHG3XaADnoYAN7Zbr1bSn55UF-jjeVip6139ZZce2VMA@mail.gmail.com>
References: <1442551197-5374-1-git-send-email-jpawlowski@google.com>
	<CABBYNZLHG3XaADnoYAN7Zbr1bSn55UF-jjeVip6139ZZce2VMA@mail.gmail.com>
Date: Fri, 18 Sep 2015 00:52:43 -0700
Message-ID: <CAD0=r8zkuWD1pEC17+xtLkOU0CH0B0K=zcXbefPTa3ARNHSujg@mail.gmail.com>
Subject: Re: [PATCH 1/2] gdbus: add method for immediate property update
From: Jakub Pawlowski <jpawlowski@google.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Sep 18, 2015 at 12:15 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Jakub,
>
> On Fri, Sep 18, 2015 at 7:39 AM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> > g_dbus_emit_property_changed doesn't send dbus signal immediately. Instead
> > it stores changed properties, and schedule signal to be send at
> > g_iddle_add. Additionally, if this method is called few times for some
> > property, only last value will be sent in property changed signal.
> >
> > If remote device sends lots of notifications, they're all scheduled to be
> > notified using this method. This might result in some notifications being
> > lost.
> >
> > This patch adds new method, that immediately sends property changed
> > signal, instead of sheduling it for nearest iddle moment.
> > ---
> >  gdbus/gdbus.h  |  3 +++
> >  gdbus/object.c | 46 +++++++++++++++++++++++++++++++++++-----------
> >  2 files changed, 38 insertions(+), 11 deletions(-)
> >
> > diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
> > index d99c254..b31246a 100644
> > --- a/gdbus/gdbus.h
> > +++ b/gdbus/gdbus.h
> > @@ -300,6 +300,9 @@ void g_dbus_pending_property_error(GDBusPendingReply id, const char *name,
> >  void g_dbus_emit_property_changed(DBusConnection *connection,
> >                                 const char *path, const char *interface,
> >                                 const char *name);
> > +void g_dbus_emit_property_changed_immediate(DBusConnection *connection,
> > +                               const char *path, const char *interface,
> > +                               const char *name);
> >  gboolean g_dbus_get_properties(DBusConnection *connection, const char *path,
> >                                 const char *interface, DBusMessageIter *iter);
> >
> > diff --git a/gdbus/object.c b/gdbus/object.c
> > index 96db516..fff9e0d 100644
> > --- a/gdbus/object.c
> > +++ b/gdbus/object.c
> > @@ -1720,21 +1720,12 @@ static void process_property_changes(struct generic_data *data)
> >         }
> >  }
> >
> > -void g_dbus_emit_property_changed(DBusConnection *connection,
> > -                               const char *path, const char *interface,
> > -                               const char *name)
> > +static void prepare_property_changed(const char *interface, const char *name,
> > +                                               struct generic_data *data)
> >  {
> >         const GDBusPropertyTable *property;
> > -       struct generic_data *data;
> >         struct interface_data *iface;
> >
> > -       if (path == NULL)
> > -               return;
> > -
> > -       if (!dbus_connection_get_object_path_data(connection, path,
> > -                                       (void **) &data) || data == NULL)
> > -               return;
> > -
> >         iface = find_interface(data->interfaces, interface);
> >         if (iface == NULL)
> >                 return;
> > @@ -1759,10 +1750,43 @@ void g_dbus_emit_property_changed(DBusConnection *connection,
> >         data->pending_prop = TRUE;
> >         iface->pending_prop = g_slist_prepend(iface->pending_prop,
> >                                                 (void *) property);
> > +}
> > +
> > +void g_dbus_emit_property_changed(DBusConnection *connection, const char *path,
> > +                               const char *interface, const char *name)
> > +{
> > +       struct generic_data *data;
> > +
> > +       if (path == NULL)
> > +               return;
> > +
> > +       if (!dbus_connection_get_object_path_data(connection, path,
> > +                                       (void **) &data) || data == NULL)
> > +               return;
> > +
> > +       prepare_property_changed(interface, name, data);
> >
> >         add_pending(data);
> >  }
> >
> > +void g_dbus_emit_property_changed_immediate(DBusConnection *connection,
> > +                               const char *path, const char *interface,
> > +                                                       const char *name)
> > +{
>
> Perhaps we should call it g_dbus_emit_property_changed_full with flush
> flag and make g_dbus_emit_property_changed call it so we share more
> code. Too bad we cannot do this transparently by checking if the value
> was already schedule to change flushing if that happen, or perhaps we
> can do it but it means we need to read the value at the moment

Name fixed as suggested.

So we can check wether value was scheduled for update:
http://git.kernel.org/cgit/bluetooth/bluez.git/tree/gdbus/object.c?id=5783e002459bfb51488c6180c2e88b77c2ca2cbd#n1756

But now the logic is like this: "If value was scheduled for update,
and I schedule it again, then just send second update" which is not
good for notifications.


> g_dbus_emit_property_changed is called but that would probably need a
> temporary DBusMessageIter which complicate things so Im fine in having
> this way.
>
> > +       struct generic_data *data;
> > +
> > +       if (path == NULL)
> > +               return;
> > +
> > +       if (!dbus_connection_get_object_path_data(connection, path,
> > +                                       (void **) &data) || data == NULL)
> > +               return;
> > +
> > +       prepare_property_changed(interface, name, data);
> > +
> > +       process_property_changes(data);
> > +}
> > +
> >  gboolean g_dbus_get_properties(DBusConnection *connection, const char *path,
> >                                 const char *interface, DBusMessageIter *iter)
> >  {
> > --
> > 2.5.0
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz
