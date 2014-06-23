Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Jun 2014 11:54:52 -0400
From: Greg KH <greg@kroah.com>
To: Loic Poulain <loic.poulain@intel.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, gustavo@padovan.org,
	linux-bluetooth@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCHv2] Bluetooth: Ignore H5 non-link packets in non-active
 state
Message-ID: <20140623155452.GA19203@kroah.com>
References: <1403538164-11505-1-git-send-email-loic.poulain@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403538164-11505-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jun 23, 2014 at 05:42:44PM +0200, Loic Poulain wrote:
> When detecting a non-link packet, h5_reset_rx() frees the Rx skb.
> Not returning after that will cause the upcoming h5_rx_payload()
> call to dereference a now NULL Rx skb and trigger a kernel oops.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
>  v2: commit message update (pointer deref)
> 
>  drivers/bluetooth/hci_h5.c | 1 +
>  1 file changed, 1 insertion(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
