Return-Path: <cyrus@holtmann.org>
Date: Fri, 10 Feb 2012 14:21:05 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove needless HCI_MGMT flag check
Message-ID: <20120210162105.GC5022@joana>
References: <1328881778-23527-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328881778-23527-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2012-02-10 10:49:38 -0300]:

> This patch removes HCI_MGMT flag check in hci_cs_inquiry. There is
> no need to check this flag before calling mgmt_start_discovery_failed
> since if the hdev is not managed by mgmt interface this function does
> nothing.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index b0784ee..5f93fdd 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1143,8 +1143,7 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
>  		hci_req_complete(hdev, HCI_OP_INQUIRY, status);
>  		hci_conn_check_pending(hdev);
>  		hci_dev_lock(hdev);
> -		if (test_bit(HCI_MGMT, &hdev->dev_flags))
> -			mgmt_start_discovery_failed(hdev, status);
> +		mgmt_start_discovery_failed(hdev, status);
>  		hci_dev_unlock(hdev);
>  		return;
>  	}

Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

	Gustavo
