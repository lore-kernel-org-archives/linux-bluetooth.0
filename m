Return-Path: <cyrus@holtmann.org>
Date: Thu, 29 Mar 2012 13:18:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 3/5] DeviceInfo: Discover Characteristics
Message-ID: <20120329101803.GB23176@x220>
References: <1332948405-1104-1-git-send-email-chen.ganir@ti.com>
 <1332948405-1104-4-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332948405-1104-4-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Wed, Mar 28, 2012, chen.ganir@ti.com wrote:
> +static void char_free(gpointer user_data)
> +{
> +	struct characteristic *c = user_data;
> +
> +	g_free(c);
> +}
> +
>  static void deviceinfo_free(gpointer user_data)
>  {
>  	struct deviceinfo *d = user_data;
> @@ -55,7 +71,11 @@ static void deviceinfo_free(gpointer user_data)
>  	if (d->attrib != NULL)
>  		g_attrib_unref(d->attrib);
>  
> +	if (d->chars != NULL)
> +		g_slist_free_full(d->chars, char_free);

You don't need to check for NULL before calling g_slist_free_full since
NULL is a valid GSList (signifying an empty list). You also don't really
need the char_free function but could simply do:

	g_slist_free_full(d->chars, g_free);

Johan
