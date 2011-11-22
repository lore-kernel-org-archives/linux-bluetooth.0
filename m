Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Nov 2011 23:58:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Don't set LE flags in mgmt_start_discovery()
Message-ID: <20111122215822.GA23550@fusion.localdomain>
References: <1321991470-2201-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321991470-2201-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Tue, Nov 22, 2011, Andre Guedes wrote:
> Since LE based discovery procedures are not yet supported, we should
> not set the LE flags in mgmt_start_discovery(). Otherwise, we might
> get an error from management interface.
> ---
>  plugins/mgmtops.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
> index b9e9ad6..d28f89c 100644
> --- a/plugins/mgmtops.c
> +++ b/plugins/mgmtops.c
> @@ -1689,8 +1689,6 @@ static int mgmt_start_discovery(int index)
>  	hdr->index = htobs(index);
>  
>  	hci_set_bit(MGMT_ADDR_BREDR, &cp->type);
> -	hci_set_bit(MGMT_ADDR_LE_PUBLIC, &cp->type);
> -	hci_set_bit(MGMT_ADDR_LE_RANDOM, &cp->type);
>  
>  	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
>  		return -errno;

Since setting these bits is what user space needs to do anyway in the
long run I don't thing it's worth to remove them temporarily. Instead
I'd just make the kernel modifications initially so that an error is
only triggered of MGMT_ADDR_BREDR isn't set and in other cases just do
normal BR/EDR discovery (and ignore the LE bits).

Johan
