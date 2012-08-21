Return-Path: <cyrus@holtmann.org>
Message-ID: <1345537878.29868.185.camel@pohly-mobl1.fritz.box>
Subject: Re: [PATCH obexd v0] client-doc: Guarantee prefix in transfer paths
From: Patrick Ohly <patrick.ohly@intel.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Date: Tue, 21 Aug 2012 10:31:18 +0200
In-Reply-To: <1345533815-5611-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1345533815-5611-1-git-send-email-mikel.astiz.oss@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2012-08-21 at 09:23 +0200, Mikel Astiz wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> 
> The client D-Bus documentation should mention that all transfer paths
> contain a prefix consisting of the path of the session they belong to.
> 
> This can be conveniently used by clients to install D-Bus signal matches
> that concentrate on the relevant signals.
> ---
>  doc/client-api.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/doc/client-api.txt b/doc/client-api.txt
> index 839a78c..7ca65cc 100644
> --- a/doc/client-api.txt
> +++ b/doc/client-api.txt
> @@ -466,7 +466,7 @@ Transfer hierarchy
>  
>  Service		org.bluez.obex.client
>  Interface	org.bluez.obex.Transfer
> -Object path	[variable prefix]/{transfer0,transfer1,...}
> +Object path	[variable prefix]/{session0,session1,...}/{transfer0,...}
>  
>  Methods		dict GetProperties()

It would be even better to explicitly mention that the "[variable
prefix]" here is the same as the "[variable prefix]" in the Session.

Or perhaps change it like this?

-Object path	[variable prefix]/{transfer0,transfer1,...}
+Object path	[session prefix]/{transfer0,...}

Using this knowledge efficiently is not always possible, however. D-Bus
itself has a "path_namespace" filter [1], but many D-Bus bindings don't
expose it (Python [2], GIO D-Bus [3]). Therefore a client using those
bindings still has to receive all Transfer signals and do its own
filtering.

[1] http://dbus.freedesktop.org/doc/dbus-specification.html#message-bus-routing-match-rules
[2] http://dbus.freedesktop.org/doc/dbus-python/api/dbus.connection.Connection-class.html#add_signal_receiver
[3] http://developer.gnome.org/gio/stable/GDBusConnection.html#g-dbus-connection-signal-subscribe

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.


