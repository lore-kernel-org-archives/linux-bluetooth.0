Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCHv2] Bluetooth: Ignore H5 non-link packets in non-active state
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403538164-11505-1-git-send-email-loic.poulain@intel.com>
Date: Mon, 23 Jun 2014 17:54:54 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Linux Bluetooth mailing list
	<linux-bluetooth@vger.kernel.org>, stable@vger.kernel.org
Message-Id: <3A6B22EC-A3BC-4686-873B-962490A11575@holtmann.org>
References: <1403538164-11505-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> When detecting a non-link packet, h5_reset_rx() frees the Rx skb.
> Not returning after that will cause the upcoming h5_rx_payload()
> call to dereference a now NULL Rx skb and trigger a kernel oops.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> v2: commit message update (pointer deref)
> 
> drivers/bluetooth/hci_h5.c | 1 +
> 1 file changed, 1 insertion(+)

I applied the updated patch to bluetooth-next with a proper tag for stable.

Regards

Marcel

