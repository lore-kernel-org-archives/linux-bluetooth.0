Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 07/15] Bluetooth: Add SMP function for generating RPAs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393088805-28658-8-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 22 Feb 2014 10:00:09 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <F40F50C3-6415-474C-BEFB-CA65966ED704@holtmann.org>
References: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com> <1393088805-28658-8-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> We need a function in smp.c to generate Resolvable Random Addresses in
> order to support privacy. The local RPA will need to be generated before
> advertising, scanning or connecting and regenerated at periodic
> intervals. This patch adds the necessary function for RPA generation.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 17 +++++++++++++++++
> net/bluetooth/smp.h |  1 +
> 2 files changed, 18 insertions(+)
> 
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 8ef50c790b96..7ec48e3d6065 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -124,6 +124,23 @@ bool smp_irk_matches(struct crypto_blkcipher *tfm, u8 irk[16],
> 	return !memcmp(bdaddr->b, hash, 3);
> }
> 
> +int smp_generate_rpa(struct crypto_blkcipher *tfm, u8 irk[16], bdaddr_t *rpa)
> +{
> +	int err;
> +
> +	get_random_bytes(&rpa->b[3], 3);
> +
> +	rpa->b[5] &= 0x7f;

I think this one is wrong. You can now end up with RPA or URPA based if the most significant bit coming from the random bytes is set or not. This is not reliably creating a RPA.

Regards

Marcel

