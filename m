Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170426190728.GA14369@x1c>
References: <CAAu3APbw0JyPfKUi6PZ4Nr2Uh5WXtDprDVFBTj3xr+801b9L6w@mail.gmail.com>
 <CAAu3APbMKQY2dnD=TUAb_3BqFKk0s2bzuFFLX8=h-1g7gm8G=Q@mail.gmail.com>
 <20170408071834.GA12144@x1c> <CAAu3APahskA_b2Ydt8TzUWBQnkuC10UwjZ37RaOyhAt4s1iyiQ@mail.gmail.com>
 <20170422052644.GA31652@x1c> <CAAu3APZxRDoZhCU7QtWVNd05HbKzadoX=886r_REiebvmMj6vQ@mail.gmail.com>
 <CAAu3APYz+fP-f2S3XqV1EJLs4d=4-URTMG-bffNZmZNFQE+ROQ@mail.gmail.com> <20170426190728.GA14369@x1c>
From: Barry Byford <31baz66@gmail.com>
Date: Wed, 26 Apr 2017 23:47:35 +0100
Message-ID: <CAAu3APZoH-paWg1gqaT_mNwsiG8r6sUz=L2csvAY9=AjFCgJ6A@mail.gmail.com>
Subject: Re: Serial Port connection with DBus API
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Johan,

Thank you very much for taking the time to respond. It is very much appreciated.

On 26 April 2017 at 20:07, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Barry,
>
> On Tue, Apr 25, 2017, Barry Byford wrote:
>> I don't feel I'm making progress on this so I've attached the output
>> from btmon in the hope that someone has the time to cast an eye over
>> it.
>>
>> The values that are received into NewConnection are:
>> object device = /org/bluez/hci0/dev_64_BC_0C_F6_22_F8
>>  fd = 0
>> dict fd_properties = {}
>>
>> if I do a os.isatty(fd) then I get returned True
>> if I do a os.ttyname(fd) then I get returned /dev/pts/0
>
> Our test/test-profile script does the following:
>
>         def NewConnection(self, path, fd, properties):
>                 self.fd = fd.take()

Yes I had seen this and it confused me. fd has a signature of 'h'
which is a gint32 according to
https://developer.gnome.org/glib/stable/gvariant-format-strings.html
Integers have no method take() as part of it.

> Are you doing something similar? Otherwise it looks like file descriptor
> passing is somehow broken in your system.
On my system I don't have dbus-python as I am using the preferred
pydbus library.
I say preferred based on the comments at the bottom of
https://www.freedesktop.org/wiki/Software/DBusBindings/

Following your posting I have configured a new system and ran
test/test-profile using dbus-python

Running on the new system fd comes in to NewConnection as type 'dbus.UnixFd'
This type of object does have a take() method
https://dbus.freedesktop.org/doc/dbus-python/api/dbus.types.UnixFd-class.html

This seems to be consistent with type 'h' defined here
https://dbus.freedesktop.org/doc/dbus-specification.html#basic-types

I think this moves my investigation away from BlueZ and on to the
various Python DBus implementations.

Thanks again for your input.
