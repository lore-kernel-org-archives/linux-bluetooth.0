Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH v1 3/4] Adding HCI_QUIRK_ADV_RSSI_DEDUP. When this quirk is set, the device, when in scan with deduplication is not sending advertising reports for device when RSSI value changes.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1414442504-14290-4-git-send-email-jpawlowski@google.com>
Date: Tue, 28 Oct 2014 09:33:05 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C237CFFC-FA4B-493F-8768-F5C08C750993@holtmann.org>
References: <1414442504-14290-1-git-send-email-jpawlowski@google.com> <1414442504-14290-4-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

so the subject line should be less than 52 characters. So it fits nicely. And the commit message should be less than 72 characters on each line.

You need to format this properly. Also kernel patches require signed-off-by.

> On Oct 27, 2014, at 13:41, Jakub Pawlowski <jpawlowski@google.com> wrote:
> 
> ---
> include/net/bluetooth/hci.h | 9 +++++++++
> 1 file changed, 9 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 6e8f249..69af571 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -129,6 +129,15 @@ enum {
> 	 * during the hdev->setup vendor callback.
> 	 */
> 	HCI_QUIRK_INVALID_BDADDR,
> +
> +	/* When this quirk is set, the device, when in scan with deduplication
> +	 * is not sending advertising reports for device when RSSI value
> +	 * changes.
> +	 *
> +	 * This quirk can be set before hci_register_dev is called or
> +	 * during the hdev->setup vendor callback.
> +	 */
> +	HCI_QUIRK_ADV_RSSI_DEDUP,
> };

The scan option is called duplicate filtering. I don't think that deduplication is a word. So just be verbose on what this is doing. And feel free to explain exactly that this quirk triggers.

Also HCI_QUIRK_ADV_RSSI_DEDUP is a really cryptic name. We need to come up with a better quirk name that explains what we are doing here. Right now I do not have a good proposal, but we need something clearer.

Regards

Marcel

