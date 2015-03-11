Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v1 1/5] Bluetooth: Introduce HCI_QUIRK_SIMULTAENOUS_DISCOVERY
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1425331850-31906-1-git-send-email-jpawlowski@google.com>
Date: Tue, 10 Mar 2015 19:55:18 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9FD55A16-B718-4FA5-959C-98B25E67B095@holtmann.org>
References: <1425331850-31906-1-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> Some controllers allow both le and classic scan to run at the same
> time, while others allow only one, le or classic at given time.

lets call it BR/EDR inquiry and LE scan.

> 
> Since this is specific to each controller, add a new quirk setting
> that allows drivers to tell the core wether given controller can
> do both le and classic discovery at same time.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
> include/net/bluetooth/hci.h | 9 +++++++++
> 1 file changed, 9 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 8e54f82..d64851a 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -160,6 +160,15 @@ enum {
> 	 * during the hdev->setup vendor callback.
> 	 */
> 	HCI_QUIRK_STRICT_DUPLICATE_FILTER,
> +
> +	/* When this quirk is set, scanning for both le and classic devices
> +	 * is done simoultaenously. If it's not set, the scan is
> +	 * interleaved.

	/* When this quirk is set, then the controller supports running
	 * BR/EDR inquiry and LE scanning simultaneously. If it is not
	 * set, then BR/EDR inquiry and LE scanning will be interleaved.
	 *
	 * ..

> +	 *
> +	 * This quirk can be set before hci_register_dev is called or
> +	 * during the hdev->setup vendor callback.
> +	 */
> +	HCI_QUIRK_SIMULTAENOUS_DISCOVERY,
> };

Regards

Marcel

