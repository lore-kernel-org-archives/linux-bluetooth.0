Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v4 1/7] Bluetooth: Introduce HCI_QUIRK_SIMULTANEOUS_DISCOVERY
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426556254-1480-1-git-send-email-jpawlowski@google.com>
Date: Mon, 16 Mar 2015 19:18:39 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3BD6A4E7-75B5-4306-8D3D-6CD2443036A2@holtmann.org>
References: <1426556254-1480-1-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> Some controllers allow both LE scan and BR/EDR inquiry to run at
> the same time, while others allow only one, LE SCAN or BR/EDR
> inquiry at given time.
> 
> Since this is specific to each controller, add a new quirk setting
> that allows drivers to tell the core wether given controller can
> do both LE scan and BR/EDR inquiry at same time.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
> include/net/bluetooth/hci.h | 9 +++++++++
> 1 file changed, 9 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index ce75730..7091601 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -160,6 +160,15 @@ enum {
> 	 * during the hdev->setup vendor callback.
> 	 */
> 	HCI_QUIRK_STRICT_DUPLICATE_FILTER,
> +
> +	/* When this quirk is set, LE scan and BR/EDR inquiry is done
> +	 * simultaneously, otherwise it's interleaved.
> +	 * .

you might to remove this line with the lonely dot. Looks like a leftover.

> +	 *
> +	 * This quirk can be set before hci_register_dev is called or
> +	 * during the hdev->setup vendor callback.
> +	 */
> +	HCI_QUIRK_SIMULTANEOUS_DISCOVERY,
> };

Regards

Marcel

