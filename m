Return-Path: <cyrus@holtmann.org>
Date: Sat, 18 Aug 2012 15:25:00 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH BlueZ v3 08/15] gdbus: Add support for
 org.freedesktop.DBus.ObjectManager interface
Message-ID: <20120818182459.GB30527@echo>
References: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1345272662-2850-9-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345272662-2850-9-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 03:50 Sat 18 Aug, Lucas De Marchi wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This implements initial support for ObjectManager, it automatically adds
> objects to its parents so no action is needed by daemons to get their
> objects managed by this interface.
> 
> ObjectManager is part of D-Bus spec since revision 0.17:
> http://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-objectmanager
> ---
>  gdbus/object.c | 248 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 238 insertions(+), 10 deletions(-)
> 

[snip]

>  
>  static const GDBusMethodTable introspect_methods[] = {
> @@ -617,6 +655,7 @@ static DBusMessage *properties_get_all(DBusConnection *connection,
>  		return NULL;
>  
>  	dbus_message_iter_init_append(reply, &iter);
> +

The code looks a little better without this extra line.

>  	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
>  			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
>  			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
> @@ -737,7 +776,158 @@ static const GDBusSignalTable properties_signals[] = {
>  	{ }
>  };
>  

Cheers,
-- 
Vinicius
