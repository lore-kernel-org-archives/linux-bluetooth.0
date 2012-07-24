Return-Path: <cyrus@holtmann.org>
Message-ID: <1343136978.24426.51.camel@aeonflux>
Subject: Re: [PATCH BlueZ v2 2/5] gdbus: Implement DBus.Properties.Get method
From: Marcel Holtmann <marcel@holtmann.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 24 Jul 2012 15:36:18 +0200
In-Reply-To: <1343126786-12628-3-git-send-email-lucas.demarchi@profusion.mobi>
References: <1343126786-12628-1-git-send-email-lucas.demarchi@profusion.mobi>
	 <1343126786-12628-3-git-send-email-lucas.demarchi@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

>  gdbus/gdbus.h  | 13 ++++++++++--
>  gdbus/object.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 72 insertions(+), 3 deletions(-)
> 
> diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
> index 0a8a27c..e2a8460 100644
> --- a/gdbus/gdbus.h
> +++ b/gdbus/gdbus.h
> @@ -55,6 +55,13 @@ typedef void (* GDBusDestroyFunction) (void *user_data);
>  typedef DBusMessage * (* GDBusMethodFunction) (DBusConnection *connection,
>  					DBusMessage *message, void *user_data);
>  
> +typedef struct GDBusPropertyTable GDBusPropertyTable;
> +typedef gboolean (*GDBusPropertyGetter)(const GDBusPropertyTable *property,
> +					DBusMessageIter *iter, void *data);
> +
> +typedef gboolean (*GDBusPropertyExists)(const GDBusPropertyTable *property,
> +								void *data);
> +
>  typedef guint32 GDBusPendingReply;
>  
>  typedef void (* GDBusSecurityFunction) (DBusConnection *connection,
> @@ -102,11 +109,13 @@ typedef struct {
>  	const GDBusArgInfo *args;
>  } GDBusSignalTable;
>  
> -typedef struct {
> +struct GDBusPropertyTable {
>  	const char *name;
>  	const char *type;
> +	GDBusPropertyGetter get;
> +	GDBusPropertyExists exists;
>  	GDBusPropertyFlags flags;
> -} GDBusPropertyTable;
> +};

can we make this a bit cleaner and do it similar for all structs +
typedefs and not just make GDBusPropertyTable special.

Regards

Marcel


