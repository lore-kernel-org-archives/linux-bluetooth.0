Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Limit OOB to P-256 values for Secure Connection Only mode
Date: Tue, 27 Jan 2015 21:13:01 +0100
Message-ID: <2080375.GZdINHllEn@leonov>
In-Reply-To: <1422386512-15819-1-git-send-email-marcel@holtmann.org>
References: <1422386512-15819-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tuesday 27 of January 2015 11:21:52 Marcel Holtmann wrote:
> When using Secure Connection Only mode, the P-192 hash and rand values
> for BR/EDR and the TK value for LE are not valid. The Secure Connections
> Only mode limits the encryption keys to P-256 derived values for both
> transports. To avoid accidentally loading weak values for pairing just
> restrict it to P-256 values.

If so, shouldn't enabling Secure Connection Only mode result in clearing OOB 
data (or at least removing legacy ones)?

> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 8417ab387d1a..5c7340b1cd66 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3660,6 +3660,21 @@ static int add_remote_oob_data(struct sock *sk,
> struct hci_dev *hdev, goto unlock;
>  		}
> 
> +		/* In case Secure Connections Only made has been enabled,

typo:  made -> mode

> +		 * do not allow providing P-192 hash and rand values.
> +		 *
> +		 * This actually means that in Secure Connections Only
> +		 * mode this command with the legacy parameter list
> +		 * is not supported at all.
> +		 */
> +		if (test_bit(HCI_SC_ONLY, &hdev->dev_flags)) {
> +			err = cmd_complete(sk, hdev->id,
> +					   MGMT_OP_ADD_REMOTE_OOB_DATA,
> +					   MGMT_STATUS_INVALID_PARAMS,
> +					   addr, sizeof(*addr));
> +			goto unlock;
> +		}
> +
>  		err = hci_add_remote_oob_data(hdev, &cp->addr.bdaddr,
>  					      cp->addr.type, cp->hash,
>  					      cp->rand, NULL, NULL);
> @@ -3675,10 +3690,17 @@ static int add_remote_oob_data(struct sock *sk,
> struct hci_dev *hdev, u8 *rand192, *hash192;
>  		u8 status;
> 
> -		if (bdaddr_type_is_le(cp->addr.type)) {
> -			/* Enforce zero-valued 192-bit parameters as
> -			 * long as legacy SMP OOB isn't implemented.
> -			 */
> +		/* For Bluetooth LE, currently only P-256 hash and rand
> +		 * values are allowed. The P-192 hash and rand values
> +		 * are required to be zero. This is required since Legacy
> +		 * Pairing for LE with OOB is not implemented yet.
> +		 *
> +		 * In case Secure Connections Only made has been enabled,

same typo

> +		 * do not allow providing P-192 hash and rand values. It
> +		 * is required that the values are zero here as well.
> +		 */
> +		if (bdaddr_type_is_le(cp->addr.type) ||
> +		    test_bit(HCI_SC_ONLY, &hdev->dev_flags)) {
>  			if (memcmp(cp->rand192, ZERO_KEY, 16) ||
>  			    memcmp(cp->hash192, ZERO_KEY, 16)) {
>  				err = cmd_complete(sk, hdev->id,

-- 
BR
Szymon Janc
