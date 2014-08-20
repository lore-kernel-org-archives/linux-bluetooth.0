Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] android/bluetooth: Update pairing status on pair complete event
Date: Wed, 20 Aug 2014 12:02:21 +0200
Message-ID: <2178802.c2DUHlZXv8@leonov>
In-Reply-To: <1407400740-29565-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1407400740-29565-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Thursday 07 of August 2014 10:39:00 Lukasz Rymanowski wrote:
> So far BfA updates android bond state after link key(s) are
> distributed. With LE pairing it might happen that no keys are
> distributed e.g remote device has Initiator Key Distribution and
> Responder Key Distribution set to 0. In such case link is encrypted with
> STK and after its disconnected, pairing needs to be done again.
> 
> With this patch Android will get update about pairing complete just
> after BfA gets pairing complete from the kernel. It solve issue with not
> updated Android settings application, which is hanging on "Pairing", in
> case when no keys are distributed.
> 
> However, bacause Android does not see the difference between bonded /
> paired devices and because Android does not allow to update its bond
> state if it is not in bonding state, BfA updates Android with BONDED
> state on pair_complete with success. This is how we are doing so far
> for bonding and non-bonding pairing.
> 
> Note: BfA will update its bonded state after link key(s) are
> distribiuted.
> ---
>  android/bluetooth.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 655844d..8c32d48 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -4065,19 +4065,16 @@ static void pair_device_complete(uint8_t status,
> uint16_t length,
> 
>  	DBG("status %u", status);
> 
> -	/*
> -	 * On success bond state change will be send when new link key or LTK
> -	 * event is received
> -	 */
> -	if (status == MGMT_STATUS_SUCCESS)
> -		return;
> -
>  	dev = find_device(&rp->addr.bdaddr);
>  	if (!dev)
>  		return;
> 
> +	/*
> +	 * Update pairing and paired status. Bonded status will be updated once
> +	 * any link key come
> +	 */
>  	update_device_state(dev, rp->addr.type, status_mgmt2hal(status), false,
> -								false, false);
> +								!status, false);
>  }
> 
>  static uint8_t select_device_bearer(struct device *dev)

Patch applied, thanks.

-- 
BR
Szymon Janc
