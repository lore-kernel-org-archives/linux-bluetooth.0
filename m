Return-Path: <cyrus@holtmann.org>
Message-ID: <1338987962.1817.107.camel@aeonflux>
Subject: Re: [PATCH 1/2 v2] Bluetooth: Fix SMP pairing method selection
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 06 Jun 2012 22:06:02 +0900
In-Reply-To: <1338980055-16205-1-git-send-email-johan.hedberg@gmail.com>
References: <1338979451-15851-1-git-send-email-johan.hedberg@gmail.com>
	 <1338980055-16205-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The tk_request function takes the local IO capability as the second last
> parameter and the remote IO capability as the last parameter. They were
> previously swapped: when we receive a pairing response
> req->io_capability contains the local one and rsp->io_capability the
> remote one.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v2: s/first/last/ in the commit message.
> 
>  net/bluetooth/smp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


