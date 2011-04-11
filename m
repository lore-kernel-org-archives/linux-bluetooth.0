Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTinpZ4OsJMVjpMX=VYUfzG=sgTVk9uUUGFW0t=4Q@mail.gmail.com>
References: <1301510036-17282-1-git-send-email-andre.dieb@signove.com>
	<AANLkTinpZ4OsJMVjpMX=VYUfzG=sgTVk9uUUGFW0t=4Q@mail.gmail.com>
Date: Mon, 11 Apr 2011 10:08:20 -0300
Message-ID: <BANLkTimddZ5Kz8MM6SuTXVAVuYXb8zK+EQ@mail.gmail.com>
Subject: Re: [RFC 1/2] Add Type property to Device
From: Elvis Pfutzenreuter <epx@signove.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2011/3/31 Claudio Takahasi <claudio.takahasi@openbossa.org>
>
> Hi Marcel/Johan/Luiz,
>
> We need opinions for this change...
>
> Why this information is needed: Appearance characteristic is not
> available in the advertising. Currently, BlueZ implements interleaved
> discovery: 5.12sec inquiring + 5.12sec scanning.
> Found devices are reported through the DeviceFound() signal. The user
> space needs to check the "Broadcaster" property inside the DeviceFound
> signal to check if the device is Basic Rate or LE, which is not
> acceptable(in my opinion). We need a meaningful property to
> distinguish LE devices.
>
> Before we push these patches upstream we need to define which
> information it exposes: Operational Mode or host/controller
> capability?
>
> My opinion:
> 1. for the Adapter it should represent the operational mode, a
> controller can support LE, but the host can disable it. Setting
> EnableLE = false(main.conf) should "disable" LE functionalities.
> 2. for DeviceFound(), the UI needs this info only to distinguish LE
> devices. In my opinion UUIDs and Broadcaster properties are not
> enough/appropriated for this purpose. "Qualified" devices will not
> enable inquiry scan and advertising at same time. Our main target is
> to connect to LE only devices. "BR/EDR/LE" can be confusing in this
> context. Suggestions here?
> 3. for the Device, I am not sure if we need to expose this information
> to the users, appearance characteristic is mandatory, if a Device
> "object" exists in the system the appearance value will be
> available(it will be retrieved after discovery primary services)
>
> Comments?

Any news on this?

>
> Andre:
> You need to check the adapter features, old adapters doesn't support EDR.

Andre is on vacation (lucky guy), so I will do the fixes once we have
settled the other questions.

>
> Claudio.
>
> On Wed, Mar 30, 2011 at 6:33 PM, Andre Dieb Martins
> <andre.dieb@signove.com> wrote:
> > ---
> >  doc/device-api.txt |    4 ++++
> >  src/device.c       |   18 ++++++++++++++++++
> >  src/device.h       |    2 ++
> >  3 files changed, 24 insertions(+), 0 deletions(-)
> >
> > diff --git a/doc/device-api.txt b/doc/device-api.txt
> > index d1feb18..a667296 100644
> > --- a/doc/device-api.txt
> > +++ b/doc/device-api.txt
> > @@ -130,6 +130,10 @@ Properties string Address [readonly]
> >                        Proposed icon name according to the freedesktop.org
> >                        icon naming specification.
> >
> > +               string Type [readonly]
> > +
> > +                       Device type (BR/EDR, LE, BR/EDR/LE).
> > +
> >                uint32 Class [readonly]
> >
> >                        The Bluetooth class of device of the remote device.
> > diff --git a/src/device.c b/src/device.c
> > index d567952..96683de 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -228,6 +228,20 @@ static void device_free(gpointer user_data)
> >        g_free(device);
> >  }
> >
> > +const char *devtype2str(device_type_t type)
>
> If the plan is to use the same type(device_type_t) for devices and
> adapters we should rename this type.
>
>
> > +{
> > +       switch (type) {
> > +       case DEVICE_TYPE_BREDR:
> > +               return "BR/EDR";
> > +       case DEVICE_TYPE_LE:
> > +               return "LE";
> > +       case DEVICE_TYPE_DUALMODE:
> > +               return "BR/EDR/LE";
> > +       default:
> > +               return "Unknown";
> > +       }
> > +}
> > +
> >  gboolean device_is_paired(struct btd_device *device)
> >  {
> >        return device->paired;
> > @@ -302,6 +316,10 @@ static DBusMessage *get_properties(DBusConnection *conn,
> >                                                DBUS_TYPE_STRING, &icon);
> >        }
> >
> > +       /* Type */
> > +       ptr = devtype2str(device->type);
> > +       dict_append_entry(&dict, "Type", DBUS_TYPE_STRING, &ptr);
> > +
> >        /* Paired */
> >        boolean = device_is_paired(device);
> >        dict_append_entry(&dict, "Paired", DBUS_TYPE_BOOLEAN, &boolean);
> > diff --git a/src/device.h b/src/device.h
> > index 3ce212b..b385070 100644
> > --- a/src/device.h
> > +++ b/src/device.h
> > @@ -41,6 +41,8 @@ typedef enum {
> >        DEVICE_TYPE_DUALMODE
> >  } device_type_t;
> >
> > +const char *devtype2str(device_type_t type);
> > +
> >  struct btd_device *device_create(DBusConnection *conn,
> >                                struct btd_adapter *adapter,
> >                                const gchar *address, device_type_t type);
> > --
> > 1.7.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
