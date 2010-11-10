Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Nov 2010 22:51:49 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/9] Create __btd_error_invalid_args()
Message-ID: <20101110005149.GA22606@vigoh>
References: <1289197787-16715-1-git-send-email-padovan@profusion.mobi>
 <1289197787-16715-2-git-send-email-padovan@profusion.mobi>
 <AANLkTimnfiUYD0b=bMLN=A218=zwUAWkZ7aWM9GBxoKr@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTimnfiUYD0b=bMLN=A218=zwUAWkZ7aWM9GBxoKr@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jose,

* Jose Antonio Santos Cadenas <santoscadenas@gmail.com> [2010-11-09 09:20:33 +0100]:

> Hi Gustavo,
> 
> 2010/11/8 Gustavo F. Padovan <padovan@profusion.mobi>:
> > DBus error handling in BlueZ is a mess. This is the first patch to unify
> > all DBus error handling like in ConnMan and oFono. This unifies all
> > .InvalidArguments errors.
> > ---
> >  attrib/client.c          |   20 +++++----------
> >  audio/gateway.c          |    8 +----
> >  audio/headset.c          |   18 ++++---------
> >  audio/media.c            |    9 ++----
> >  audio/telephony-dummy.c  |   25 ++++++++------------
> >  audio/telephony-maemo5.c |   11 ++------
> >  audio/telephony-maemo6.c |   11 ++------
> >  audio/transport.c        |   14 +++--------
> >  health/hdp.c             |   58 ++++++++++++----------------------------------
> >  network/server.c         |    7 -----
> >  plugins/service.c        |    8 +-----
> >  serial/port.c            |    8 ------
> >  serial/proxy.c           |   19 ++++----------
> >  src/adapter.c            |   52 ++++++++++++++++++-----------------------
> >  src/device.c             |   22 ++++++-----------
> >  src/error.c              |    7 +++++
> >  src/error.h              |    2 +
> >  src/manager.c            |    7 -----
> >  18 files changed, 100 insertions(+), 206 deletions(-)
> >
> > diff --git a/attrib/client.c b/attrib/client.c
> > index 1f2c217..cd6e401 100644
> > --- a/attrib/client.c
> > +++ b/attrib/client.c
> > @@ -190,12 +190,6 @@ static int watcher_cmp(gconstpointer a, gconstpointer b)
> >        return g_strcmp0(watcher->path, match->path);
> >  }
> >
> > -static inline DBusMessage *invalid_args(DBusMessage *msg)
> > -{
> > -       return g_dbus_create_error(msg, ERROR_INTERFACE ".InvalidArguments",
> > -                       "Invalid arguments in method call");
> > -}
> > -
> >  static inline DBusMessage *not_authorized(DBusMessage *msg)
> >  {
> >        return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAuthorized",
> > @@ -465,7 +459,7 @@ static DBusMessage *register_watcher(DBusConnection *conn,
> >
> >        if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
> >                                                        DBUS_TYPE_INVALID))
> > -               return invalid_args(msg);
> > +               return __btd_error_invalid_args(msg);
> >
> >        if (l2cap_connect(prim->gatt, &gerr, TRUE) < 0) {
> >                DBusMessage *reply;
> > @@ -499,7 +493,7 @@ static DBusMessage *unregister_watcher(DBusConnection *conn,
> >
> >        if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
> >                                                        DBUS_TYPE_INVALID))
> > -               return invalid_args(msg);
> > +               return __btd_error_invalid_args(msg);
> >
> >        match = g_new0(struct watcher, 1);
> >        match->name = g_strdup(sender);
> > @@ -537,7 +531,7 @@ static DBusMessage *set_value(DBusConnection *conn, DBusMessage *msg,
> >
> >        if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY ||
> >                        dbus_message_iter_get_element_type(iter) != DBUS_TYPE_BYTE)
> > -               return invalid_args(msg);
> > +               return __btd_error_invalid_args(msg);
> >
> >        dbus_message_iter_recurse(iter, &sub);
> >
> > @@ -586,23 +580,23 @@ static DBusMessage *set_property(DBusConnection *conn,
> >        const char *property;
> >
> >        if (!dbus_message_iter_init(msg, &iter))
> > -               return invalid_args(msg);
> > +               return __btd_error_invalid_args(msg);
> >
> >        if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
> > -               return invalid_args(msg);
> > +               return __btd_error_invalid_args(msg);
> >
> >        dbus_message_iter_get_basic(&iter, &property);
> >        dbus_message_iter_next(&iter);
> >
> >        if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
> > -               return invalid_args(msg);
> > +               return __btd_error_invalid_args(msg);
> >
> >        dbus_message_iter_recurse(&iter, &sub);
> >
> >        if (g_str_equal("Value", property))
> >                return set_value(conn, msg, &sub, chr);
> >
> > -       return invalid_args(msg);
> > +       return __btd_error_invalid_args(msg);
> >  }
> >
> >  static GDBusMethodTable char_methods[] = {
> > diff --git a/audio/gateway.c b/audio/gateway.c
> > index 07ebdd4..ab7d310 100644
> > --- a/audio/gateway.c
> > +++ b/audio/gateway.c
> > @@ -494,9 +494,7 @@ static DBusMessage *register_agent(DBusConnection *conn,
> >
> >        if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
> >                                                DBUS_TYPE_INVALID))
> > -               return g_dbus_create_error(msg,
> > -                                       ERROR_INTERFACE ".InvalidArguments",
> > -                                       "Invalid argument");
> > +               return __btd_error_invalid_args(msg);
> >
> >        name = dbus_message_get_sender(msg);
> >        agent = g_new0(struct hf_agent, 1);
> > @@ -529,9 +527,7 @@ static DBusMessage *unregister_agent(DBusConnection *conn,
> >        if (!dbus_message_get_args(msg, NULL,
> >                                DBUS_TYPE_OBJECT_PATH, &path,
> >                                DBUS_TYPE_INVALID))
> > -               return g_dbus_create_error(msg,
> > -                               ERROR_INTERFACE ".InvalidArguments",
> > -                               "Invalid argument");
> > +               return __btd_error_invalid_args(msg);
> >
> >        if (strcmp(gw->agent->path, path) != 0)
> >                return g_dbus_create_error(msg,
> > diff --git a/audio/headset.c b/audio/headset.c
> > index 0763585..2cca5ca 100644
> > --- a/audio/headset.c
> > +++ b/audio/headset.c
> > @@ -180,12 +180,6 @@ struct event {
> >
> >  static GSList *headset_callbacks = NULL;
> >
> > -static inline DBusMessage *invalid_args(DBusMessage *msg)
> > -{
> > -       return g_dbus_create_error(msg, ERROR_INTERFACE ".InvalidArguments",
> > -                       "Invalid arguments in method call");
> > -}
> > -
> >  static DBusHandlerResult error_not_supported(DBusConnection *conn,
> >                                                        DBusMessage *msg)
> >  {
> > @@ -2026,35 +2020,35 @@ static DBusMessage *hs_set_property(DBusConnection *conn,
> >        uint16_t gain;
> >
> >        if (!dbus_message_iter_init(msg, &iter))
> > -               return invalid_args(msg);
> > +               return __btd_error_invalid_args(msg);
> >
> >        if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
> > -               return invalid_args(msg);
> > +               return __btd_error_invalid_args(msg);
> >
> >        dbus_message_iter_get_basic(&iter, &property);
> >        dbus_message_iter_next(&iter);
> >
> >        if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
> > -               return invalid_args(msg);
> > +               return __btd_error_invalid_args(msg);
> >        dbus_message_iter_recurse(&iter, &sub);
> >
> >        if (g_str_equal("SpeakerGain", property)) {
> >                if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_UINT16)
> > -                       return invalid_args(msg);
> > +                       return __btd_error_invalid_args(msg);
> >
> >                dbus_message_iter_get_basic(&sub, &gain);
> >                return hs_set_gain(conn, msg, data, gain,
> >                                        HEADSET_GAIN_SPEAKER);
> >        } else if (g_str_equal("MicrophoneGain", property)) {
> >                if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_UINT16)
> > -                       return invalid_args(msg);
> > +                       return __btd_error_invalid_args(msg);
> >
> >                dbus_message_iter_get_basic(&sub, &gain);
> >                return hs_set_gain(conn, msg, data, gain,
> >                                        HEADSET_GAIN_MICROPHONE);
> >        }
> >
> > -       return invalid_args(msg);
> > +       return __btd_error_invalid_args(msg);
> >  }
> >  static GDBusMethodTable headset_methods[] = {
> >        { "Connect",            "",     "",     hs_connect,
> > diff --git a/audio/media.c b/audio/media.c
> > index b6c90f9..862cee6 100644
> > --- a/audio/media.c
> > +++ b/audio/media.c
> > @@ -323,18 +323,15 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
> >
> >        dbus_message_iter_recurse(&args, &props);
> >        if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_DICT_ENTRY)
> > -               return g_dbus_create_error(msg, ERROR_INTERFACE
> > -                                       ".Failed", "Invalid argument");
> > +               return __btd_error_invalid_args(msg);
> >
> >        if (parse_properties(&props, &uuid, &delay_reporting, &codec,
> >                                &capabilities, &size) || uuid == NULL)
> > -               return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
> > -                                               "Invalid argument");
> > +               return __btd_error_invalid_args(msg);
> >
> >        if (media_endpoint_create(adapter, sender, path, uuid, delay_reporting,
> >                                codec, capabilities, size) == FALSE)
> > -               return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
> > -                                               "Invalid argument");
> > +               return __btd_error_invalid_args(msg);
> >
> >        return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
> >  }
> > diff --git a/audio/telephony-dummy.c b/audio/telephony-dummy.c
> > index 06cb798..b56b6e7 100644
> > --- a/audio/telephony-dummy.c
> > +++ b/audio/telephony-dummy.c
> > @@ -35,6 +35,7 @@
> >
> >  #include "log.h"
> >  #include "telephony.h"
> > +#include "error.h"
> >
> >  #define TELEPHONY_DUMMY_IFACE "org.bluez.TelephonyTest"
> >  #define TELEPHONY_DUMMY_PATH "/org/bluez/test"
> > @@ -69,12 +70,6 @@ static struct indicator dummy_indicators[] =
> >        { NULL }
> >  };
> >
> > -static inline DBusMessage *invalid_args(DBusMessage *msg)
> > -{
> > -       return g_dbus_create_error(msg, "org.bluez.Error.InvalidArguments",
> > -                                       "Invalid arguments in method call");
> > -}
> > -
> >  void telephony_device_connected(void *telephony_device)
> >  {
> >        DBG("telephony-dummy: device %p connected", telephony_device);
> > @@ -236,7 +231,7 @@ static DBusMessage *outgoing_call(DBusConnection *conn, DBusMessage *msg,
> >
> >        if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
> >                                                DBUS_TYPE_INVALID))
> > -               return invalid_args(msg);
> > +               return __btd_error_invalid_args(msg);
> >
> >        DBG("telephony-dummy: outgoing call to %s", number);
> >
> > @@ -261,7 +256,7 @@ static DBusMessage *incoming_call(DBusConnection *conn, DBusMessage *msg,
> >
> >        if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
> >                                                DBUS_TYPE_INVALID))
> > -               return invalid_args(msg);
> > +               return __btd_error_invalid_args(msg);
> >
> >        DBG("telephony-dummy: incoming call to %s", number);
> >
> > @@ -307,10 +302,10 @@ static DBusMessage *signal_strength(DBusConnection *conn, DBusMessage *msg,
> >
> >        if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT32, &strength,
> >                                                DBUS_TYPE_INVALID))
> > -               return invalid_args(msg);
> > +               return __btd_error_invalid_args(msg);
> >
> >        if (strength > 5)
> > -               return invalid_args(msg);
> > +               return __btd_error_invalid_args(msg);
> >
> >        telephony_update_indicator(dummy_indicators, "signal", strength);
> >
> > @@ -326,10 +321,10 @@ static DBusMessage *battery_level(DBusConnection *conn, DBusMessage *msg,
> >
> >        if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT32, &level,
> >                                                DBUS_TYPE_INVALID))
> > -               return invalid_args(msg);
> > +               return __btd_error_invalid_args(msg);
> >
> >        if (level > 5)
> > -               return invalid_args(msg);
> > +               return __btd_error_invalid_args(msg);
> >
> >        telephony_update_indicator(dummy_indicators, "battchg", level);
> >
> > @@ -346,7 +341,7 @@ static DBusMessage *roaming_status(DBusConnection *conn, DBusMessage *msg,
> >
> >        if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_BOOLEAN, &roaming,
> >                                                DBUS_TYPE_INVALID))
> > -               return invalid_args(msg);
> > +               return __btd_error_invalid_args(msg);
> >
> >        val = roaming ? EV_ROAM_ACTIVE : EV_ROAM_INACTIVE;
> >
> > @@ -365,7 +360,7 @@ static DBusMessage *registration_status(DBusConnection *conn, DBusMessage *msg,
> >
> >        if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_BOOLEAN, &registration,
> >                                                DBUS_TYPE_INVALID))
> > -               return invalid_args(msg);
> > +               return __btd_error_invalid_args(msg);
> >
> >        val = registration ? EV_SERVICE_PRESENT : EV_SERVICE_NONE;
> >
> > @@ -384,7 +379,7 @@ static DBusMessage *set_subscriber_number(DBusConnection *conn,
> >
> >        if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
> >                                                DBUS_TYPE_INVALID))
> > -               return invalid_args(msg);
> > +               return __btd_error_invalid_args(msg);
> >
> >        g_free(subscriber_number);
> >        subscriber_number = g_strdup(number);
> > diff --git a/audio/telephony-maemo5.c b/audio/telephony-maemo5.c
> > index 4d0134c..0f9819c 100644
> > --- a/audio/telephony-maemo5.c
> > +++ b/audio/telephony-maemo5.c
> > @@ -38,6 +38,7 @@
> >
> >  #include "log.h"
> >  #include "telephony.h"
> > +#include "error.h"
> >
> >  /* SSC D-Bus definitions */
> >  #define SSC_DBUS_NAME  "com.nokia.phone.SSC"
> > @@ -1880,12 +1881,6 @@ static void csd_init(void)
> >        }
> >  }
> >
> > -static inline DBusMessage *invalid_args(DBusMessage *msg)
> > -{
> > -       return g_dbus_create_error(msg,"org.bluez.Error.InvalidArguments",
> > -                                       "Invalid arguments in method call");
> > -}
> > -
> >  static uint32_t get_callflag(const char *callerid_setting)
> >  {
> >        if (callerid_setting != NULL) {
> > @@ -1950,7 +1945,7 @@ static DBusMessage *set_callerid(DBusConnection *conn, DBusMessage *msg,
> >        if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING,
> >                                                &callerid_setting,
> >                                                DBUS_TYPE_INVALID) == FALSE)
> > -               return invalid_args(msg);
> > +               return __btd_error_invalid_args(msg);
> >
> >        if (g_str_equal(callerid_setting, "allowed") ||
> >                        g_str_equal(callerid_setting, "restricted") ||
> > @@ -1964,7 +1959,7 @@ static DBusMessage *set_callerid(DBusConnection *conn, DBusMessage *msg,
> >
> >        error("telephony-maemo: invalid argument %s for method call"
> >                                        " SetCallerId", callerid_setting);
> > -               return invalid_args(msg);
> > +               return __btd_error_invalid_args(msg);
> >  }
> >
> >  static GDBusMethodTable telephony_maemo_methods[] = {
> > diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
> > index 72c8e36..4663b4d 100644
> > --- a/audio/telephony-maemo6.c
> > +++ b/audio/telephony-maemo6.c
> > @@ -38,6 +38,7 @@
> >
> >  #include "log.h"
> >  #include "telephony.h"
> > +#include "error.h"
> >
> >  /* SSC D-Bus definitions */
> >  #define SSC_DBUS_NAME  "com.nokia.phone.SSC"
> > @@ -1760,12 +1761,6 @@ static void csd_init(void)
> >        }
> >  }
> >
> > -static inline DBusMessage *invalid_args(DBusMessage *msg)
> > -{
> > -       return g_dbus_create_error(msg,"org.bluez.Error.InvalidArguments",
> > -                                       "Invalid arguments in method call");
> > -}
> > -
> >  static uint32_t get_callflag(const char *callerid_setting)
> >  {
> >        if (callerid_setting != NULL) {
> > @@ -1830,7 +1825,7 @@ static DBusMessage *set_callerid(DBusConnection *conn, DBusMessage *msg,
> >        if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING,
> >                                                &callerid_setting,
> >                                                DBUS_TYPE_INVALID) == FALSE)
> > -               return invalid_args(msg);
> > +               return __btd_error_invalid_args(msg);
> >
> >        if (g_str_equal(callerid_setting, "allowed") ||
> >                        g_str_equal(callerid_setting, "restricted") ||
> > @@ -1844,7 +1839,7 @@ static DBusMessage *set_callerid(DBusConnection *conn, DBusMessage *msg,
> >
> >        error("telephony-maemo6: invalid argument %s for method call"
> >                                        " SetCallerId", callerid_setting);
> > -               return invalid_args(msg);
> > +               return __btd_error_invalid_args(msg);
> >  }
> >
> >  static DBusMessage *clear_lastnumber(DBusConnection *conn, DBusMessage *msg,
> > diff --git a/audio/transport.c b/audio/transport.c
> > index eda46e1..0c865f7 100644
> > --- a/audio/transport.c
> > +++ b/audio/transport.c
> > @@ -93,12 +93,6 @@ struct media_transport {
> >                                        DBusMessageIter *value);
> >  };
> >
> > -static inline DBusMessage *invalid_args(DBusMessage *msg)
> > -{
> > -       return g_dbus_create_error(msg, ERROR_INTERFACE ".InvalidArguments",
> > -                                       "Invalid arguments in method call");
> > -}
> > -
> >  static inline DBusMessage *error_failed(DBusMessage *msg, const char *desc)
> >  {
> >        return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed", "%s", desc);
> > @@ -549,16 +543,16 @@ static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
> >        int err;
> >
> >        if (!dbus_message_iter_init(msg, &iter))
> > -               return invalid_args(msg);
> > +               return __btd_error_invalid_args(msg);
> >
> >        if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
> > -               return invalid_args(msg);
> > +               return __btd_error_invalid_args(msg);
> >
> >        dbus_message_iter_get_basic(&iter, &property);
> >        dbus_message_iter_next(&iter);
> >
> >        if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
> > -               return invalid_args(msg);
> > +               return __btd_error_invalid_args(msg);
> >        dbus_message_iter_recurse(&iter, &value);
> >
> >        sender = dbus_message_get_sender(msg);
> > @@ -577,7 +571,7 @@ static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
> >
> >        if (err < 0) {
> >                if (err == -EINVAL)
> > -                       return invalid_args(msg);
> > +                       return __btd_error_invalid_args(msg);
> >                return error_failed(msg, strerror(-err));
> >        }
> >
> > diff --git a/health/hdp.c b/health/hdp.c
> > index 1eba8e1..6c1fd98 100644
> > --- a/health/hdp.c
> > +++ b/health/hdp.c
> > @@ -321,15 +321,8 @@ static DBusMessage *manager_create_application(DBusConnection *conn,
> >
> >        dbus_message_iter_init(msg, &iter);
> >        app = hdp_get_app_config(&iter, &err);
> > -       if (err) {
> > -               DBusMessage *reply;
> > -
> > -               reply = g_dbus_create_error(msg,
> > -                                       ERROR_INTERFACE ".InvalidArguments",
> > -                                       "Invalid arguments: %s", err->message);
> > -               g_error_free(err);
> > -               return reply;
> > -       }
> > +       if (err)
> > +               return __btd_error_invalid_args(msg);
> 
> 
> You are leaking memory here, err should be freed before return. Also
> the message that we add to the error is for clarify the user the kind
> of error, it will be great to keep it.

Sure.

> 
> >
> >        name = dbus_message_get_sender(msg);
> >        if (!name) {
> > @@ -368,11 +361,8 @@ static DBusMessage *manager_destroy_application(DBusConnection *conn,
> >        GSList *l;
> >
> >        if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
> > -                                               DBUS_TYPE_INVALID)){
> > -               return g_dbus_create_error(msg,
> > -                                       ERROR_INTERFACE ".InvalidArguments",
> > -                                       "Invalid arguments in method call");
> > -       }
> > +                                               DBUS_TYPE_INVALID))
> > +               return __btd_error_invalid_args(msg);
> >
> >        l = g_slist_find_custom(applications, path, cmp_app);
> >
> > @@ -1801,18 +1791,13 @@ static DBusMessage *device_create_channel(DBusConnection *conn,
> >
> >        if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &app_path,
> >                                                        DBUS_TYPE_STRING, &conf,
> > -                                                       DBUS_TYPE_INVALID)) {
> > -               return g_dbus_create_error(msg,
> > -                                       ERROR_INTERFACE ".InvalidArguments",
> > -                                       "Invalid arguments in method call");
> > -       }
> > +                                                       DBUS_TYPE_INVALID))
> > +               return __btd_error_invalid_args(msg);
> >
> >        l = g_slist_find_custom(applications, app_path, cmp_app);
> >        if (!l)
> > -               return g_dbus_create_error(msg,
> > -                                       ERROR_INTERFACE ".InvalidArguments",
> > -                                       "Invalid arguments in method call, "
> > -                                       "no such application");
> > +               return __btd_error_invalid_args(msg);
> > +
> >        app = l->data;
> >
> >        if (g_ascii_strcasecmp("Reliable", conf) == 0)
> > @@ -1822,25 +1807,16 @@ static DBusMessage *device_create_channel(DBusConnection *conn,
> >        else if (g_ascii_strcasecmp("Any", conf) == 0)
> >                config = HDP_NO_PREFERENCE_DC;
> >        else
> > -               return g_dbus_create_error(msg,
> > -                                       ERROR_INTERFACE ".InvalidArguments",
> > -                                       "Invalid arguments in method call");
> > +               return __btd_error_invalid_args(msg);
> >
> >        if (app->role == HDP_SINK && config != HDP_NO_PREFERENCE_DC)
> > -               return g_dbus_create_error(msg,
> > -                                       ERROR_INTERFACE ".InvalidArguments",
> > -                                       "Configuration not valid for sinks");
> > +               return __btd_error_invalid_args(msg);
> 
> Also here the message we tried to clarify the kind of "Invalid
> Arguments" error with a different message.

I'm not really caring about those messages, I'm fine on removing all of
them. The idea is to just have a __btd_error_failed_str() to report
string messages in some more generic errors.

