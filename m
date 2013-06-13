Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Jun 2013 11:15:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>,
	Timo Mueller <timo.mueller@bmw-carit.de>
Subject: Re: [RFC v2 1/2] Bluetooth: Use defines instead of integer literals
Message-ID: <20130613081550.GA15607@x220>
References: <1369906016-17006-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1369906016-17006-2-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369906016-17006-2-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Thu, May 30, 2013, Mikel Astiz wrote:
> Make the code in hci_get_auth_req() more readable by using the
> defined macros instead of inlining magic numbers.
> 
> Signed-off-by: Timo Mueller <timo.mueller@bmw-carit.de>
> Signed-off-by: Mikel Astiz <mikel.astiz@bmw-carit.de>
> ---
>  net/bluetooth/hci_event.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 0437200..777a040 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -31,6 +31,7 @@
>  #include <net/bluetooth/mgmt.h>
>  #include <net/bluetooth/a2mp.h>
>  #include <net/bluetooth/amp.h>
> +#include <net/bluetooth/smp.h>
>  
>  /* Handle HCI Event packets */
>  
> @@ -3024,17 +3025,18 @@ unlock:
>  static u8 hci_get_auth_req(struct hci_conn *conn)
>  {
>  	/* If remote requests dedicated bonding follow that lead */
> -	if (conn->remote_auth == 0x02 || conn->remote_auth == 0x03) {
> +	if ((conn->remote_auth & ~0x01) == HCI_AT_DEDICATED_BONDING) {
>  		/* If both remote and local IO capabilities allow MITM
>  		 * protection then require it, otherwise don't */
> -		if (conn->remote_cap == 0x03 || conn->io_capability == 0x03)
> +		if (conn->remote_cap == SMP_IO_NO_INPUT_OUTPUT ||
> +		    conn->io_capability == SMP_IO_NO_INPUT_OUTPUT)

Why are you using SMP_* defines here and not HCI_*? If the HCI ones are
missing in some header file please feel free to add them.

Johan
