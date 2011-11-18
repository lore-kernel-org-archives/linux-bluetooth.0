Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Nov 2011 13:27:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH RFC BlueZ] serial: Fix bogus errno usage
Message-ID: <20111118112748.GA5971@x220>
References: <1321551160-8903-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321551160-8903-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Thu, Nov 17, 2011, Anderson Lizardo wrote:
> There is no previous function setting errno, thus the original code may
> return a undefined value.
> ---
> NOTE:
> Is bt_io_connect() supposed to set errno on error? If yes, then the code is
> correct and this patch is invalid.
> 
> But in this case, bt_io_connect() needs to be modified as there are at least
> two glib library calls before returning, and this may reset errno from the
> underlying connect call. So I think it needs to be saved before calling these
> library functions.
> 
>  serial/port.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/serial/port.c b/serial/port.c
> index 3b36d44..1ceda7b 100644
> --- a/serial/port.c
> +++ b/serial/port.c
> @@ -463,10 +463,8 @@ connect:
>  				BT_IO_OPT_DEST_BDADDR, &device->dst,
>  				BT_IO_OPT_CHANNEL, port->channel,
>  				BT_IO_OPT_INVALID);
> -	if (port->io)
> -		return 0;
>  
> -	return -errno;
> +	return 0;
>  }

bt_io_connect is not supposed to touch errno, so please don't send
patches for that. If you want to get the exact error you pass a GError
pointer, however even without that it's valid to check at least for a
NULL return. A simple fix if you don't want to add GError to this port.c
function is to return e.g. -EIO in case bt_io_connect returns NULL.

Johan
