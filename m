Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Fix unconditional call to mgmt interface in
 hci_event.c
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
In-Reply-To: <1302087740-18244-1-git-send-email-szymon.janc@tieto.com>
References: <1302087740-18244-1-git-send-email-szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 06 Apr 2011 07:08:27 -0700
Message-ID: <1302098907.2572.174.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> hci_cc_read_local_oob_data_reply funtion should call
> mgmt_read_local_oob_data_reply_complete only if management interface
> is enabled.
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/hci_event.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 7a3398d..9062e1b 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -831,7 +831,8 @@ static void hci_cc_read_local_oob_data_reply(struct hci_dev *hdev,
>  
>  	BT_DBG("%s status 0x%x", hdev->name, rp->status);
>  

please just exit the function if flag is not set:

	if (!test_bit(...))
		return

> -	mgmt_read_local_oob_data_reply_complete(hdev->id, rp->hash,
> +	if (test_bit(HCI_MGMT, &hdev->flags))
> +		mgmt_read_local_oob_data_reply_complete(hdev->id, rp->hash,
>  						rp->randomizer, rp->status);
>  }
>  

Regards

Marcel


