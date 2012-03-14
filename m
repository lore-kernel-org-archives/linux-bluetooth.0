Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_PKA2eCSHDin6WLj4xTCONuURYfMkyBAeu=T1Sd74vBwQ@mail.gmail.com>
References: <1331215032-27695-1-git-send-email-arik@wizery.com>
 <1331215032-27695-9-git-send-email-arik@wizery.com> <CAJdJm_PKA2eCSHDin6WLj4xTCONuURYfMkyBAeu=T1Sd74vBwQ@mail.gmail.com>
From: Arik Nemtsov <arik@wizery.com>
Date: Wed, 14 Mar 2012 22:56:48 +0200
Message-ID: <CA+XVXfc7spLAM60gJVD-wjKR0P=mbv6TdPXtWkDmNvpMfSpOyA@mail.gmail.com>
Subject: Re: [PATCH 8/8] proximity: reporter: implement D-Bus API
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey Anderson,

On Wed, Mar 14, 2012 at 15:19, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
>> +       /*
>> +        * Register watches for getting device change events. We watch
>> +        * for existing, new and removed devices.
>> +        */
>> +       radapter->watch_added = g_dbus_add_signal_watch(radapter->conn,
>> +                                       BLUEZ_SERVICE, NULL, ADAPTER_INTERFACE,
>> +                                       "DeviceAdded", handle_device_change,
>> +                                       radapter, NULL);
>> +
>> +       radapter->watch_created = g_dbus_add_signal_watch(radapter->conn,
>> +                                       BLUEZ_SERVICE, NULL, ADAPTER_INTERFACE,
>> +                                       "DeviceCreated", handle_device_change,
>> +                                       radapter, NULL);
>> +
>> +       radapter->watch_removed = g_dbus_add_signal_watch(radapter->conn,
>> +                                       BLUEZ_SERVICE, NULL, ADAPTER_INTERFACE,
>> +                                       "DeviceRemoved", handle_device_change,
>> +                                       radapter, NULL);
>
> Again, setting a watcher for BlueZ own signals is strange. Why can't
> you use a device driver like other plugins?

For some strange reason I was convinced btd_device_drivers only get
notified when a device connects. But of course this isn't the case.
This will simplify the code a bit. I'll also remove the patch adding
the "DeviceAdded" signal.

Thanks,
Arik
