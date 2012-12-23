Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1356278946.29264.24.camel@aeonflux>
References: <1356276298-13795-1-git-send-email-luiz.dentz@gmail.com>
	<1356276298-13795-3-git-send-email-luiz.dentz@gmail.com>
	<1356278946.29264.24.camel@aeonflux>
Date: Sun, 23 Dec 2012 18:27:29 +0200
Message-ID: <CABBYNZ+set-vvzf+6whfPt5zE8c7X_t2DB4vJS6p8v2X0i_U-A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/6] gdbus: Introduce GDBusInterfaceFlags
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Dec 23, 2012 at 6:09 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>> The flags should be passed in g_dbus_register_interface_with_flags,
>> currently there only one flag which is G_DBUS_INTERFACE_FLAG_EXPERIMENTAL
>> which works similarly to G_DBUS_METHOD_FLAG_EXPERIMENTAL but for the
>> whole interface.
>> ---
>>  gdbus/gdbus.h  | 13 +++++++++++++
>>  gdbus/object.c | 20 ++++++++++++++++++++
>>  2 files changed, 33 insertions(+)
>
> can we not just check if the interface contains any non experimental
> method, signals and properties and base that decision around that?

It can work, but we would have to iterate on every single item, so in
terms of code is quite a bit more complex so I favored adding a new
function even though we might replace it in the long run.

> I am not really in favor of introducing a version with flags.

The final solution I was thinking is passing another interface
containing the table as this tend to be quite static e.g.:

struct GDBusInteface {
  const char *name;
  GDBusInterfaceFlags flags;
  const GDBusMethodTable *methods;
  const GDBusSignalTable *signals;
  const GDBusPropertiesTable *properties;
};

Obviously this would break g_dbus_register_interface and generate
quite a bit more changes to the daemon code.


--
Luiz Augusto von Dentz
