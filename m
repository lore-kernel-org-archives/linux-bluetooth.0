Return-Path: <cyrus@holtmann.org>
Date: Sat, 12 Nov 2011 11:54:33 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 6/6] Bluetooth: Support LE-Only discovery procedure
Message-ID: <20111112095433.GA6578@fusion.localdomain>
References: <1321051824-5216-1-git-send-email-andre.guedes@openbossa.org>
 <1321051824-5216-7-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321051824-5216-7-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Fri, Nov 11, 2011, Andre Guedes wrote:
> @@ -1669,7 +1678,16 @@ static int start_discovery(struct sock *sk, u16 index)
>  		goto failed;
>  	}
>  
> -	err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
> +	if (lmp_host_le_capable(hdev)) {
> +		if (lmp_bredr_capable(hdev))
> +			err = -ENOSYS;
> +		else
> +			err = hci_do_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT,
> +					LE_SCAN_WIN, LE_SCAN_TIMEOUT_LE_ONLY);
> +	} else {
> +		err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
> +	}

This should really be looking at type parameter that gets passed in the
mgmt_start_discovery command. User space has been sending it already for
some time but the kernel side wasn't yet updated to care about it. I
just sent a patch to add the necessary mgmt.h struct and to pass the
data to the start_discovery function.

Johan
