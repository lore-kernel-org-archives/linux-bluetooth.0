Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110215195937.GB7219@joana>
References: <1297798306-32591-1-git-send-email-padovan@profusion.mobi>
 <AANLkTimDQtwuYvdLYr3mTXygHLHYaQCCrFC6LYj6ajHT@mail.gmail.com> <20110215195937.GB7219@joana>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Date: Wed, 16 Feb 2011 13:18:49 +0100
Message-ID: <AANLkTinwxkx2f+awGVuhrXF5JT42+vmA+xovLo-9XhXs@mail.gmail.com>
Subject: Re: [PATCH] Move HealthManager Interface to "/" path
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

2011/2/15 Gustavo F. Padovan <padovan@profusion.mobi>:
> Hi Luiz,
>
> * Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-02-15 21:35:20 +0200]:
>
>> Hi,
>>
>> On Tue, Feb 15, 2011 at 9:31 PM, Gustavo F. Padovan
>> <padovan@profusion.mobi> wrote:
>> > Yeah, this breaks the API, but health is still disabled by default and it
>> > is not a good idea create a new path only for it. So moving it to "/"
>> > ---
>> >  doc/health-api.txt    |    2 +-
>> >  health/hdp.c          |    4 ++--
>> >  test/test-health      |    2 +-
>> >  test/test-health-sink |    2 +-
>> >  4 files changed, 5 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/doc/health-api.txt b/doc/health-api.txt
>> > index 3d0a717..9d5a54d 100644
>> > --- a/doc/health-api.txt
>> > +++ b/doc/health-api.txt
>> > @@ -10,7 +10,7 @@ Health Device Profile hierarchy
>> >
>> >  Service                org.bluez
>> >  Interface      org.bluez.HealthManager
>> > -Object path    /org/bluez/
>> > +Object path    /
>> >
>> >  Methods:
>> >
>> > diff --git a/health/hdp.c b/health/hdp.c
>> > index d4a2a30..e58bd55 100644
>> > --- a/health/hdp.c
>> > +++ b/health/hdp.c
>> > @@ -2171,7 +2171,7 @@ int hdp_manager_start(DBusConnection *conn)
>> >  {
>> >        DBG("Starting Health manager");
>> >
>> > -       if (!g_dbus_register_interface(conn, MANAGER_PATH,
>> > +       if (!g_dbus_register_interface(conn, "/",
>> >                                        HEALTH_MANAGER,
>> >                                        health_manager_methods, NULL, NULL,
>> >                                        NULL, manager_path_unregister)) {
>> > @@ -2186,7 +2186,7 @@ int hdp_manager_start(DBusConnection *conn)
>> >
>> >  void hdp_manager_stop()
>> >  {
>> > -       g_dbus_unregister_interface(connection, MANAGER_PATH, HEALTH_MANAGER);
>> > +       g_dbus_unregister_interface(connection, "/", HEALTH_MANAGER);
>> >
>> >        dbus_connection_unref(connection);
>> >        DBG("Stopped Health manager");
>> > diff --git a/test/test-health b/test/test-health
>> > index 28cc894..7820a24 100755
>> > --- a/test/test-health
>> > +++ b/test/test-health
>> > @@ -47,7 +47,7 @@ def enter_mainloop():
>> >        finally:
>> >                print "Exiting, bye"
>> >
>> > -hdp_manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
>> > +hdp_manager = dbus.Interface(bus.get_object("org.bluez", "/"),
>> >                                                "org.bluez.HealthManager")
>> >
>> >  role = None
>> > diff --git a/test/test-health-sink b/test/test-health-sink
>> > index cb9d434..50eb74c 100755
>> > --- a/test/test-health-sink
>> > +++ b/test/test-health-sink
>> > @@ -12,7 +12,7 @@ loop = gobject.MainLoop()
>> >
>> >  bus = dbus.SystemBus()
>> >
>> > -hdp_manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
>> > +hdp_manager = dbus.Interface(bus.get_object("org.bluez", "/"),
>> >                                                "org.bluez.HealthManager")
>> >  app_path = hdp_manager.CreateApplication({"DataType": dbus.types.UInt16(4103),
>> >                                        "Role": "sink"})
>> > --
>> > 1.7.4
>>
>> Any reasons why this is not per adapter? This is supposed to be very
>> similar to Media API which is used in a per adapter fashion.
>
> IIRC In the first versions of the API Marcel tried to abstract the concept of
> adapter and have the API works with Health Applications.

Just what Gustavo said the aim is to be adapter independent, you just
register an application and HDP do all the job for you. This way you
don't have to check if an adapter is removed or if a new adapter is
plugged.

> But not sure if after
>
> http://www.spinics.net/lists/linux-bluetooth/msg06788.html
>
> this is still valid.

I think that this is still valid even after this discussion.

Regards.

>
> --
> Gustavo F. Padovan
> http://profusion.mobi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
