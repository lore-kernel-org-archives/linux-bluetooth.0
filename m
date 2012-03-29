Return-Path: <cyrus@holtmann.org>
Date: Thu, 29 Mar 2012 13:19:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 4/5] Fix device version in GetProperties
Message-ID: <20120329101914.GC23176@x220>
References: <1332948405-1104-1-git-send-email-chen.ganir@ti.com>
 <1332948405-1104-5-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332948405-1104-5-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Wed, Mar 28, 2012, chen.ganir@ti.com wrote:
> From: Chen Ganir <chen.ganir@ti.com>
> 
> Fix how device version is added to the property dictionay.
> ---
>  src/device.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/src/device.c b/src/device.c
> index eab7e4c..3b772ee 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -383,7 +383,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
>  							&device->product);
>  
>  	/* Version */
> -	if (device->product)
> +	if (device->version)
>  		dict_append_entry(&dict, "Version", DBUS_TYPE_UINT16,
>  							&device->version);
>  

This one has been pushed upstream so no need to resend it for v4 of this
set.

Johan
