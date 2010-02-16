Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1266334628.8849.5.camel@localhost.localdomain>
References: <2d5a2c101002160659j1fd3fff8hc5418ddb7481b25d@mail.gmail.com>
	 <2d5a2c101002160715l7f9a2f07y4a40b19e31fa98b3@mail.gmail.com>
	 <1266334628.8849.5.camel@localhost.localdomain>
Date: Tue, 16 Feb 2010 17:58:04 +0200
Message-ID: <2d5a2c101002160758k131bd0f1y3477958780d11a02@mail.gmail.com>
Subject: Re: [PATCH] Fix signal watch when a service name is given
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Feb 16, 2010 at 5:37 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>> > This should fix g_dbus_add_signal_watch when a service like org.bluez is given.
>>
>>
>> Updating since the last one was broken.
>
> I also think that in check_service() we actually have a missing call to
> dbus_pending_unref(). That would cause a memory leak.

There is a call to  dbus_pending_call_unref on check_service after
dbus_pending_call_set_notify, which I took a look and seems correct
but we have another problem there since we never cancel the pending
call if the filter is unregister. Anyway there is a leak on
service_reply where I don't call dbus_message_unref, so I will come up
with another update soon.

-- 
Luiz Augusto von Dentz
Computer Engineer
