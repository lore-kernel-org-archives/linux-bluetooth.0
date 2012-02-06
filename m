Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Feb 2012 17:21:13 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix device reset
Message-ID: <20120206152113.GA12729@x220>
References: <1328536743-8343-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328536743-8343-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Feb 06, 2012, Emeltchenko Andrei wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index e77cc79..3f30714 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -822,7 +822,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
>  	skb_queue_purge(&hdev->cmd_q);
>  	atomic_set(&hdev->cmd_cnt, 1);
>  	if (!test_bit(HCI_RAW, &hdev->flags) &&
> -				test_bit(HCI_QUIRK_NO_RESET, &hdev->quirks)) {
> +			!test_bit(HCI_QUIRK_NO_RESET, &hdev->quirks)) {
>  		set_bit(HCI_INIT, &hdev->flags);
>  		__hci_request(hdev, hci_reset_req, 0,
>  					msecs_to_jiffies(250));

Nack. The NO_RESET quirk is supposed to prevent reset during the device
init sequence. The purpose of the test in hci_dev_do_close() is to let
the reset be done there instead.

Johan
