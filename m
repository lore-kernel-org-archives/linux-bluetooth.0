Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Dec 2011 16:23:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 3/3] map: Add basic GetMessage support
Message-ID: <20111216142326.GA6469@x220>
References: <1324041790-17559-1-git-send-email-bulislaw@linux.com>
 <1324041790-17559-3-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324041790-17559-3-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Fri, Dec 16, 2011, Bartosz Szatkowski wrote:
>  static GDBusMethodTable map_methods[] = {
>  	{ "SetFolder",		"s", "",	map_setpath,
>  						G_DBUS_METHOD_FLAG_ASYNC },
> @@ -188,6 +232,7 @@ static GDBusMethodTable map_methods[] = {
>  						G_DBUS_METHOD_FLAG_ASYNC },
>  	{ "GetMessageListing",	"sa{ss}", "s",	map_get_message_listing,
>  						G_DBUS_METHOD_FLAG_ASYNC },
> +	{ "GetMessage",		"sa{ss}s", "o",	map_get_message },

Before adding new methods could you please send a patch to add them to
the Message Access section in doc/client-api.txt. It should contain all
entries in this map_methods table but right now only contains SetFolder.
This will also help me understand the API, and particularly parameters
like "sa{ss}s" faster than by reading the code.

Johan
