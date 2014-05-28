Return-Path: <cyrus@holtmann.org>
Message-ID: <5385F341.1070508@cogentembedded.com>
Date: Wed, 28 May 2014 18:31:29 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Kiran Kumar Raparthy <kiran.kumar@linaro.org>,
 linux-kernel@vger.kernel.org
CC: "hyungseoung.yoo" <hyungseoung.yoo@samsung.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, open@holtmann.org,
	list@holtmann.org:BLUETOOTH SUBSYSTEM <linux-bluetooth@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	Android Kernel Team <kernel-team@android.com>,
	John Stultz <john.stultz@linaro.org>,
	Jaikumar Ganesh <jaikumarg@android.com>
Subject: Re: [RFC] Bluetooth: Keep master role when SCO or eSCO is active
References: <1401256588-1467-1-git-send-email-kiran.kumar@linaro.org>
In-Reply-To: <1401256588-1467-1-git-send-email-kiran.kumar@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello.

On 05/28/2014 09:56 AM, Kiran Kumar Raparthy wrote:

> From: "hyungseoung.yoo" <hyungseoung.yoo@samsung.com>

> Preserve the master role when SCO or eSCO is active
> as this improves compatability with lots of

    Compatibility.

> headset and chipset combinations.

> This is one of the number of patches from the Android AOSP
> common.git tree, which is used on almost all Android devices.
> It looks like it would improve support for compatibility with
> lot of headset,so I wanted to submit it for review to see
> if it should go upstream.

> Cc: Marcel Holtmann <marcel@holtmann.org> (maintainer:BLUETOOTH SUBSYSTEM)
> Cc: Gustavo Padovan <gustavo@padovan.org> (maintainer:BLUETOOTH SUBSYSTEM)
> Cc: Johan Hedberg <johan.hedberg@gmail.com> (maintainer:BLUETOOTH SUBSYSTEM)
> Cc: "David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING [GENERAL])
> Cc: linux-bluetooth@vger.kernel.org (open list:BLUETOOTH SUBSYSTEM)
> Cc: netdev@vger.kernel.org (open list:NETWORKING [GENERAL])
> Cc: linux-kernel@vger.kernel.org (open list)
> Cc: Android Kernel Team <kernel-team@android.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Signed-off-by: hyungseoung.yoo <hyungseoung.yoo@samsung.com>
> Signed-off-by: Jaikumar Ganesh <jaikumarg@android.com>
> [kiran: Added context to commit message]
> Signed-off-by: Kiran Raparthy <kiran.kumar@linaro.org>
> ---
>   net/bluetooth/hci_event.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)

> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 15010a2..6f944d5 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1915,6 +1915,15 @@ unlock:
>   	hci_conn_check_pending(hdev);
>   }
>
> +static inline bool is_sco_active(struct hci_dev *hdev)
> +{
> +	if (hci_conn_hash_lookup_state(hdev, SCO_LINK, BT_CONNECTED) ||
> +			(hci_conn_hash_lookup_state(hdev, ESCO_LINK,

    () around function/macro invocation not needed (if this is a macro, 
consider enclosing its definition in parens instead). Also, this line should
start under 'hdev' on the previous one.

> +						    BT_CONNECTED)))
> +		return true;
> +	return false;
> +}
> +
>   static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
>   {
>   	struct hci_ev_conn_request *ev = (void *) skb->data;
> @@ -1961,7 +1970,8 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
>
>   			bacpy(&cp.bdaddr, &ev->bdaddr);
>
> -			if (lmp_rswitch_capable(hdev) && (mask & HCI_LM_MASTER))
> +			if (lmp_rswitch_capable(hdev) && ((mask & HCI_LM_MASTER)
> +						|| is_sco_active(hdev)))

   Don't start the line with ||, leave it on the previous line instead.

WBR, Sergei
