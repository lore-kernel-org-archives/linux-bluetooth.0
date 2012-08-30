Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Aug 2012 16:34:51 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v4 01/15] core: Fix missing g_io_channel_ref
Message-ID: <20120830233451.GA972@x220.sheraton.com>
References: <1346364960-7699-1-git-send-email-jprvita@openbossa.org>
 <1346364960-7699-2-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1346364960-7699-2-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi João Paulo,

On Thu, Aug 30, 2012, João Paulo Rechi Vita wrote:
> ---
>  src/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/device.c b/src/device.c
> index 3b44d9b..2c40ec2 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -2027,7 +2027,7 @@ static gboolean att_connect(gpointer user_data)
>  		return FALSE;
>  	}
>  
> -	device->att_io = io;
> +	device->att_io = g_io_channel_ref(io);
>  
>  	return FALSE;
>  }

This doesn't look right to me. bt_io_connect returns a reference for the
caller and you shouldn't need to re-increment the ref count again unless
you store a pointer in multiple places (which you don't). If this patch
fixes some behavior the real bug must be somewhere else.

Johan
