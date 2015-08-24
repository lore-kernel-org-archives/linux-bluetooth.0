Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Aug 2015 12:54:26 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Nicholas Krause <xerofoify@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetooth:Fix NULL pointer deference issue in the
 function load_irks
Message-ID: <20150824095426.GB6958@t440s.lan>
References: <1439994330-27508-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1439994330-27508-1-git-send-email-xerofoify@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nicholas,

(dropping unneeded recipients from CC - in the future linux-bluetooth
should be enough for patches like this)

On Wed, Aug 19, 2015, Nicholas Krause wrote:
> This fixes a possible NULL pointer deference issue in the function
> load_irks if the call to the function hci_add_link fails and returns
> NULL

I don't see what NULL dereference this is fixing. The load_irk()
function doesn't do anything with the returned pointer from
hci_add_irk().

>  net/bluetooth/mgmt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 92720f3..e286d63 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -5602,8 +5602,9 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
>  		else
>  			addr_type = ADDR_LE_DEV_RANDOM;
>  
> -		hci_add_irk(hdev, &irk->addr.bdaddr, addr_type, irk->val,
> -			    BDADDR_ANY);
> +		if (!hci_add_irk(hdev, &irk->addr.bdaddr, addr_type, irk->val,
> +				 BDADDR_ANY))
> +			return -ENOMEM;

This could result in a partial IRK list being stored in the kernel, i.e.
you should at least make a call to hci_smp_irks_clear() before returning
a failure.

Johan
