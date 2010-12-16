Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101216092432.GB4322@jh-x301>
References: <1292442852-26457-1-git-send-email-claudio.takahasi@openbossa.org>
	<1292442852-26457-2-git-send-email-claudio.takahasi@openbossa.org>
	<20101216092432.GB4322@jh-x301>
Date: Thu, 16 Dec 2010 14:16:26 -0300
Message-ID: <AANLkTikQOsuUH5NdmBgu47AJLcKMyQ08nRRruj+X8Lfc@mail.gmail.com>
Subject: Re: [PATCH 2/5] Change CreatePairedDevice to support LE devices
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org,
	Sheldon Demario <sheldon.demario@openbossa.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Dec 16, 2010 at 6:24 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Wed, Dec 15, 2010, Claudio Takahasi wrote:
>> CreatePairedDevice implements now the same behaviour of CreateDevice,
>> triggering Discover All Primary Services when needed. SMP negotiation
>> starts when the link is established. LE capable kernel is required to
>> test this method properly.
>>
>> Limitation: For dual mode devices, Discover All Primary Services is not
>> being executed after SDP search if GATT record is found.
>> ---
>>  src/adapter.c     |   46 ++++++++++++++++++++++++---
>>  src/device.c      |   89 +++++++++++++++++++++++++++-------------------------
>>  src/device.h      |    7 +++-
>>  src/glib-helper.c |    5 ++-
>>  src/glib-helper.h |    3 ++
>>  5 files changed, 98 insertions(+), 52 deletions(-)
>
> Couple of issue here:
>
>> @@ -1642,6 +1646,8 @@ static DBusMessage *create_paired_device(DBusConnection *conn,
>>       struct btd_device *device;
>>       const gchar *address, *agent_path, *capability, *sender;
>>       uint8_t cap;
>> +     device_type_t type;
>> +     int err;
>>
>>       if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &address,
>>                                       DBUS_TYPE_OBJECT_PATH, &agent_path,
>> @@ -1666,12 +1672,40 @@ static DBusMessage *create_paired_device(DBusConnection *conn,
>>       if (cap == IO_CAPABILITY_INVALID)
>>               return btd_error_invalid_args(msg);
>>
>> -     device = adapter_get_device(conn, adapter, address);
>> -     if (!device)
>> -             return btd_error_failed(msg,
>> -                             "Unable to create a new device object");
>> +     device = adapter_find_device(adapter, address);
>> +     if (!device) {
>> +             struct remote_dev_info *dev, match;
>> +
>> +             memset(&match, 0, sizeof(struct remote_dev_info));
>> +             str2ba(address, &match.bdaddr);
>> +             match.name_status = NAME_ANY;
>> +
>> +             dev = adapter_search_found_devices(adapter, &match);
>> +             if (dev && dev->flags)
>> +                     type = flags2type(dev->flags);
>> +             else
>> +                     type = DEVICE_TYPE_BREDR;
>> +
>> +             if (type == DEVICE_TYPE_LE &&
>> +                                     !event_is_connectable(dev->evt_type))
>> +                     return btd_error_failed(msg,
>> +                                     "Device is not connectable");
>> +
>> +             device = adapter_create_device(conn, adapter, address, type);
>> +             if (!device)
>> +                     return NULL;
>> +     } else
>> +             type = device_get_type(device);
>> +
>> +     if (type != DEVICE_TYPE_LE)
>> +             return device_create_bonding(device, conn, msg,
>> +                                                     agent_path, cap);
>>
>> -     return device_create_bonding(device, conn, msg, agent_path, cap);
>> +     err = device_browse_primary(device, conn, msg, BT_IO_SEC_HIGH);
>> +     if (err < 0)
>> +             return btd_error_failed(msg, strerror(-err));
>> +
>> +     return NULL;
>>  }
>
> I don't really like the way this makes the create_paired_device function
> quite long. Could you maybe refactor the if (!device) branch into a
> separate function?
ok. We will try. Maybe it will be possible to create a common function
to move shared code between CreateDevice and CreatePairedDevice.

>
>> diff --git a/src/device.h b/src/device.h
>> index 784e931..cafa529 100644
>> --- a/src/device.h
>> +++ b/src/device.h
>> @@ -24,6 +24,8 @@
>>
>>  #define DEVICE_INTERFACE     "org.bluez.Device"
>>
>> +#include "btio.h"
>> +
>
> Includes should be the first thing after the copyright/license comments
> in the file. However, to keep a clear visibility of potential circular
> dependencies Marcel has requested this kind of inclusion of an internal
> header file from within an internal header file to be avoided. Instead
> make sure you include btio.h from early enough in the respective .c
> file. You could also reconsider if you really need BtIOSecLevel here.
> Maybe a "gboolean secure" flag would be enough?
For now a boolean is enough, we can change it to boolean.

>
>> --- a/src/glib-helper.h
>> +++ b/src/glib-helper.h
>> @@ -21,6 +21,8 @@
>>   *
>>   */
>>
>> +#include "btio.h"
>> +
>
> Same here.
>
> I'm feeling a little bit ambivalent about your additions to
> glib-helper.c. It never had a clearly defined scope and I had been
> hoping to get rid of it completely. However now it seems you guys are
> constantly adding new stuff there. Is it really so that you can't find a
> more specific location for these functions? Could you describe in one or
> two sentences the purpose and scope that you think the glib-helper.c
> functions have?
>
> Johan
>

Currently, the purpose are service search functions and UUIDs utility functions.
glib-helper was originally created to implement some utility functions
to manage connections and sdp search abstractions.
Connection functions were moved/removed when btio was created. I have
two suggestions to try cleanup the code:
1. keep only sdp functions that use GLib types and rename the file to
gsdp or other convenient name
2. Or create a btd_device_search/cancel functions(moving them to
device.c) and try to remove glib-helper from the source tree, in the
worst case keep only functions to manipulate UUIDs

The bt_discover_primary can be moved to gatt.c if we split the
discover cancel function.
bt_discover_services() can be removed, there isn't reference in code.

Which approach do you prefer? Any other suggestion?

Regards,
Claudio
