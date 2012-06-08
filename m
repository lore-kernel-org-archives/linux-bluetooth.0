Return-Path: <cyrus@holtmann.org>
Message-ID: <1339144316.1817.140.camel@aeonflux>
Subject: Re: [PATCHv1 1/4] Bluetooth: Use standard HCI cmd timeout for RESET
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 08 Jun 2012 17:31:56 +0900
In-Reply-To: <1339143166-6523-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1339143166-6523-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Remove magic and use standard HCI cmd timeout
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index a2e15436c..e5a9a09 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -783,7 +783,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
>  	    test_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks)) {
>  		set_bit(HCI_INIT, &hdev->flags);
>  		__hci_request(hdev, hci_reset_req, 0,
> -			      msecs_to_jiffies(250));
> +			      msecs_to_jiffies(HCI_CMD_TIMEOUT));
>  		clear_bit(HCI_INIT, &hdev->flags);
>  	}

And while you are at it, can we please move over to put the
msecs_to_jiffies into the #define itself. So we get more readable code
here. A bunch of location have already been changed, but seems we have a
few leftovers.

Regards

Marcel


