Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: Enforce zero-valued hash/rand192 for LE OOB
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422277671-26069-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 26 Jan 2015 10:46:00 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4114F7BB-C37B-4D42-B182-7F2685817ED3@holtmann.org>
References: <1422277671-26069-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Until legacy SMP OOB pairing is implemented user space should be given a
> clear error when trying to use it. This patch adds a corresponding check
> to the Add Remote OOB Data handler function which returns "invalid
> parameters" if non-zero Rand192 or Hash192 parameters were given for an
> LE address.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 25e40e82b9a2..cf257cc0e09d 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3673,6 +3673,20 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
> 		u8 status;
> 
> 		if (bdaddr_type_is_le(cp->addr.type)) {
> +			static const u8 z16[16] = { 0 };

aren't these suppose to be done as = { 0, }; to ensure that the whole array is zeroed?

> +
> +			/* Enforce zero-valued 192-bit parameters as
> +			 * long as legacy SMP OOB isn't implemented.
> +			 */
> +			if (memcmp(cp->rand192, z16, 16) ||
> +			    memcmp(cp->hash192, z16, 16)) {
> +				err = cmd_complete(sk, hdev->id,
> +						   MGMT_OP_ADD_REMOTE_OOB_DATA,
> +						   MGMT_STATUS_INVALID_PARAMS,
> +						   addr, sizeof(*addr));
> +				goto unlock;
> +			}
> +
> 			rand192 = NULL;
> 			hash192 = NULL;
> 		} else {

Regards

Marcel

