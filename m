Return-Path: <cyrus@holtmann.org>
Date: Sun, 26 Aug 2012 10:28:02 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Power the device up after a rfkill unblock
Message-ID: <20120826072802.GA32318@x220>
References: <20120824122800.GA27292@x220.ger.corp.intel.com>
 <1345838290-26796-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345838290-26796-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Aug 24, 2012, Vinicius Costa Gomes wrote:
> With the HCI_SETUP patches, this is all that is needed to make the
> case when a adapter is added with Bluetooth blocked in rfkill to work.
> 
> When rfkill is unblocked, the device will be powered on if the device
> is in HCI_SETUP state, meaning that it was never properly initialized.
> If the device is not used by userspace, the HCI_AUTO_OFF flag will
> take care of powering it off.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/hci_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index fa974a1..ef69d8b 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1061,8 +1061,10 @@ static int hci_rfkill_set_block(void *data, bool blocked)
>  
>  	BT_DBG("%p name %s blocked %d", hdev, hdev->name, blocked);
>  
> -	if (!blocked)
> +	if (!blocked && test_bit(HCI_SETUP, &hdev->dev_flags)) {
> +		schedule_work(&hdev->power_on);
>  		return 0;
> +	}
>  
>  	hci_dev_do_close(hdev);

This still isn't right. Now you'd be calling hci_dev_do_close() when
unblocking a device that doesn't have HCI_SETUP set. The test_bit needs
to be inside the if-branch. Btw, this all implies that you're not
properly testing your patches. Please always do that.

Johan
