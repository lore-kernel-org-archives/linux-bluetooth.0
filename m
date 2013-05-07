Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 May 2013 09:06:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Fix not sending link key negative reply
Message-ID: <20130507060630.GA3766@x220.ger.corp.intel.com>
References: <1367848235-19452-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367848235-19452-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, May 06, 2013, Andrei Emeltchenko wrote:
> If Link Keys are not loaded then HCI_LINK_KEYS is not set
> and for HCI Event "Link Key Request" reply is not sent.
> --
> send as RFC since I did not get why we need this flag really.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_event.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index db58e72..e7de1df 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2611,11 +2611,11 @@ static void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  
>  	BT_DBG("%s", hdev->name);
>  
> -	if (!test_bit(HCI_LINK_KEYS, &hdev->dev_flags))
> -		return;
> -
>  	hci_dev_lock(hdev);
>  
> +	if (!test_bit(HCI_LINK_KEYS, &hdev->dev_flags))
> +		goto not_found;
> +
>  	key = hci_find_link_key(hdev, &ev->bdaddr);
>  	if (!key) {
>  		BT_DBG("%s link key not found for %pMR", hdev->name,

Nack.

This check is there for backwards compatibility with older user space
versions. Your patch would break all user space versions that do not use
the management interface (and hence do not have the HCI_LINK_KEYS flag
set).

That said, the flag is in a way redundant with the HCI_MGMT flag, so the
check could be changed for that and the HCI_LINK_KEYS flag could then be
completely removed.

Johan
