Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Apr 2012 12:51:20 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 07/19] hci: Retrieve the bluetooth name correctly
Message-ID: <20120413095120.GB11639@x220.ger.corp.intel.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
 <1334243001-17016-8-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334243001-17016-8-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Thu, Apr 12, 2012, Syam Sidhardhan wrote:
> If we set the bluetooth name length as maximum 248 bytes,
> then while retrieving back we were getting only 247 bytes.
> This problem can be verified using hciconfig tool.
> ---
>  lib/hci.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/hci.c b/lib/hci.c
> index 269c021..9f829c9 100644
> --- a/lib/hci.c
> +++ b/lib/hci.c
> @@ -1417,8 +1417,9 @@ int hci_read_local_name(int dd, int len, char *name, int to)
>  		return -1;
>  	}
>  
> -	rp.name[247] = '\0';
> -	strncpy(name, (char *) rp.name, len);
> +	strncpy(name, (char *) rp.name, len - 1);
> +	name[len - 1] = '\0';
> +
>  	return 0;
>  }

This doesn't look quite right to me. What if the local name is not nul
terminated (exactly 248 characters) and an application passes a buffer
greater than 249 characters. It seems to me like you'd get a buffer over
flow with the strncpy call in that case.

Also, since this is a public library function we need to be very careful
not to break the ABI. Some application might be "depending" on the
brokeness of this function and break if we fix it.

Since we're planning on making almost everything of libbluetooth private
to BlueZ starting with 5.0 (I believe the socket structs and definitions
may be the only exception) I'm not sure these two patches are worth it.

Johan
