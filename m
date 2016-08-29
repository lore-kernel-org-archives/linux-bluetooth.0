Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 29 Aug 2016 12:31:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Per Thomas Jahr <perja@extern.uio.no>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] client: Include UUID when listing attributes
Message-ID: <20160829093154.GA7410@t440s.lan>
References: <1472462089-22900-1-git-send-email-perja@extern.uio.no>
 <1472462089-22900-2-git-send-email-perja@extern.uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472462089-22900-2-git-send-email-perja@extern.uio.no>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Per,

On Mon, Aug 29, 2016, Per Thomas Jahr wrote:
> Show the full UUID for services, characteristics and descriptors.
> ---
>  client/gatt.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

The general idea is fine with me but you've managed to change the
whitespace to something incompatible with the coding style - this needs
to be fixed before the patch is merged. I'd also suggest that you
provide some sample output of your changes in the commit message so that
reviewers can easily see how the result looks like in practice.

> diff --git a/client/gatt.c b/client/gatt.c
> index fee1cf9..201d668 100644
> --- a/client/gatt.c
> +++ b/client/gatt.c
> @@ -75,12 +75,13 @@ static void print_service(GDBusProxy *proxy, const char *description)
>  	if (!text)
>  		text = uuid;
>  
> -	rl_printf("%s%s%s%s Service\n\t%s\n\t%s\n",
> +        rl_printf("%s%s%s%s Service\n\t%s\n\t%s\n\t%s\n",

Here the indentation of rl_printf has changed from a tab to spaces.

>  				description ? "[" : "",
>  				description ? : "",
>  				description ? "] " : "",
>  				primary ? "Primary" : "Secondary",
> -				g_dbus_proxy_get_path(proxy),
> +                                g_dbus_proxy_get_path(proxy),
> +                                uuid,

Here the indentation is also spaces when it should be tabs. Also, you
can put 'text' on the same line as uuid to save some vertical space.

> @@ -118,12 +119,13 @@ static void print_characteristic(GDBusProxy *proxy, const char *description)
>  	if (!text)
>  		text = uuid;
>  
> -	rl_printf("%s%s%sCharacteristic\n\t%s\n\t%s\n",
> +        rl_printf("%s%s%sCharacteristic\n\t%s\n\t%s\n\t%s\n",
>  				description ? "[" : "",
>  				description ? : "",
>  				description ? "] " : "",
>  				g_dbus_proxy_get_path(proxy),
> -				text);
> +                                uuid,
> +                                text);

Same thing here.

> @@ -186,12 +188,13 @@ static void print_descriptor(GDBusProxy *proxy, const char *description)
>  	if (!text)
>  		text = uuid;
>  
> -	rl_printf("%s%s%sDescriptor\n\t%s\n\t%s\n",
> +        rl_printf("%s%s%sDescriptor\n\t%s\n\t%s\n\t%s\n",
>  				description ? "[" : "",
>  				description ? : "",
>  				description ? "] " : "",
>  				g_dbus_proxy_get_path(proxy),
> -				text);
> +                                uuid,
> +                                text);

And here.

Once these issues are fixed the patch should be good to go in (at least
on my behalf).

Johan
