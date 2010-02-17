Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2a9506371002161634h71ef3517pdc8be4f4e400c82e@mail.gmail.com>
References: <2d5a2c101002160659j1fd3fff8hc5418ddb7481b25d@mail.gmail.com>
	 <2d5a2c101002160715l7f9a2f07y4a40b19e31fa98b3@mail.gmail.com>
	 <1266334628.8849.5.camel@localhost.localdomain>
	 <2d5a2c101002160758k131bd0f1y3477958780d11a02@mail.gmail.com>
	 <2a9506371002161634h71ef3517pdc8be4f4e400c82e@mail.gmail.com>
Date: Wed, 17 Feb 2010 11:06:43 +0200
Message-ID: <2d5a2c101002170106t68e7ab17nbed678c7a4f62f9e@mail.gmail.com>
Subject: Re: [PATCH] Fix signal watch when a service name is given
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinicius Gomes <vinicius.gomes@openbossa.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Wed, Feb 17, 2010 at 2:34 AM, Vinicius Gomes
<vinicius.gomes@openbossa.org> wrote:
> Hi Luiz,
>
> On Tue, Feb 16, 2010 at 12:58 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Marcel,
>>
>> On Tue, Feb 16, 2010 at 5:37 PM, Marcel Holtmann <marcel@holtmann.org> w=
rote:
>>> Hi Luiz,
>>>
>>>> > This should fix g_dbus_add_signal_watch when a service like org.blue=
z is given.
>>>>
>>>>
>>>> Updating since the last one was broken.
>>>
>>> I also think that in check_service() we actually have a missing call to
>>> dbus_pending_unref(). That would cause a memory leak.
>>
>> There is a call to =A0dbus_pending_call_unref on check_service after
>> dbus_pending_call_set_notify, which I took a look and seems correct
>> but we have another problem there since we never cancel the pending
>> call if the filter is unregister. Anyway there is a leak on
>> service_reply where I don't call dbus_message_unref, so I will come up
>> with another update soon.
>>
>
> This is fixed on obexd, but as far as I could see it is not (yet?)
> applied on the other users
> of gdbus.

Hmm, that why I see it, I used obexd to test this not bluetoothd as
(probably) Marcel did, anyway we still need to store and cancel the
pending call if we really want the watches to be truly cancelable.

> And, from what I tested the greater problem is that the timeout of the
> pending call would still
> trigger. This would cause libdbus to terminate the application, if
> libdbus was built with debug enabled,
> because one assert would fail (the message is "trying to remove an
> nonexistent timeout" or
> =A0something like it). The timeout still triggering is the reason we
> don't see the pending call leaking.

@Marcel: So before you apply this you should really apply Vinicius
patch to the rest of projects: bluez, ofono, connman...

--=20
Luiz Augusto von Dentz
Computer Engineer
