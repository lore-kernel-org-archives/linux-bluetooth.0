Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLiB6tO8748w=Qr16Or2FJQ6jh0Q1oa4NKDU1DhDK+NQg@mail.gmail.com>
References: <1367829810-8262-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1367829810-8262-9-git-send-email-mikel.astiz.oss@gmail.com>
	<CABBYNZLiB6tO8748w=Qr16Or2FJQ6jh0Q1oa4NKDU1DhDK+NQg@mail.gmail.com>
Date: Tue, 7 May 2013 09:49:20 +0200
Message-ID: <CANT-zCVYo3aiFL9YxZ11R4Q8KCYRrxzns=tcSffWjN1epN3vNQ@mail.gmail.com>
Subject: Re: [RFC BlueZ v0 08/13] dbus: Add state property to org.bluez.Service1
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, May 6, 2013 at 12:00 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Mikel,
>
> On Mon, May 6, 2013 at 11:43 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
>> +static gboolean service_get_state(const GDBusPropertyTable *property,
>> +                                       DBusMessageIter *iter, void *data)
>> +{
>> +       struct btd_service *service = data;
>> +       const char *str;
>> +
>> +       str = state2dbus(service->state);
>> +
>> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &str);
>
> The code about would break if state2dbus returns NULL for
> BTD_SERVICE_STATE_UNAVAILABLE, perhaps if service is unavailable it
> should not have an object path representing it?

That's exactly the case. The service is exposed in D-Bus only while
it's *not* unavailable, i.e. it's probed and usable.

The code already implements this behavior but if it's not clear enough
we could make it more explicit by adding assertions here and there.

Cheers,
Mikel
