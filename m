Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1345537878.29868.185.camel@pohly-mobl1.fritz.box>
References: <1345533815-5611-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1345537878.29868.185.camel@pohly-mobl1.fritz.box>
Date: Wed, 22 Aug 2012 14:39:42 +0300
Message-ID: <CABBYNZLUS-BrZ=FN28gLgrA=1vS1JA-exECd3xgjj2EfPrAuyw@mail.gmail.com>
Subject: Re: [PATCH obexd v0] client-doc: Guarantee prefix in transfer paths
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Patrick,

On Tue, Aug 21, 2012 at 11:31 AM, Patrick Ohly <patrick.ohly@intel.com> wrote:
>> diff --git a/doc/client-api.txt b/doc/client-api.txt
>> index 839a78c..7ca65cc 100644
>> --- a/doc/client-api.txt
>> +++ b/doc/client-api.txt
>> @@ -466,7 +466,7 @@ Transfer hierarchy
>>
>>  Service              org.bluez.obex.client
>>  Interface    org.bluez.obex.Transfer
>> -Object path  [variable prefix]/{transfer0,transfer1,...}
>> +Object path  [variable prefix]/{session0,session1,...}/{transfer0,...}
>>
>>  Methods              dict GetProperties()
>
> It would be even better to explicitly mention that the "[variable
> prefix]" here is the same as the "[variable prefix]" in the Session.
>
> Or perhaps change it like this?
>
> -Object path    [variable prefix]/{transfer0,transfer1,...}
> +Object path    [session prefix]/{transfer0,...}

Hmm, I prefer the original proposal since that imo looks more clear
how the path is formatted, anyway the point here is that the transfers
are tied to sessions.

> Using this knowledge efficiently is not always possible, however. D-Bus
> itself has a "path_namespace" filter [1], but many D-Bus bindings don't
> expose it (Python [2], GIO D-Bus [3]). Therefore a client using those
> bindings still has to receive all Transfer signals and do its own
> filtering.
>
> [1] http://dbus.freedesktop.org/doc/dbus-specification.html#message-bus-routing-match-rules
> [2] http://dbus.freedesktop.org/doc/dbus-python/api/dbus.connection.Connection-class.html#add_signal_receiver
> [3] http://developer.gnome.org/gio/stable/GDBusConnection.html#g-dbus-connection-signal-subscribe

Apparently people are not doing a good job with bindings then, arg
matching is quite essential to things like NameOwnerChanged, anyway
for what is worth even properties have this race condition with values
changing in meantime while GetAll/Get/GetProperties is returning, so
it seems we need to solve this problem by making the transfer
properties unlikely to change so the application have enough time to
subscribe to signals.

-- 
Luiz Augusto von Dentz
