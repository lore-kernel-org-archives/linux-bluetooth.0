Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Feb 2012 14:24:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove needless HCI_MGMT flag check
Message-ID: <20120214122442.GA12437@x220.ger.corp.intel.com>
References: <1328881778-23527-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328881778-23527-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Fri, Feb 10, 2012, Andre Guedes wrote:
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

There are lots of checks like this in hci_event.c. If there's going to
be a patch for them I'd remove all of them in one go instead of
addressing individual ones like this.

There is some benefit of keeping them though: the code doesn't need to
check for pending mgmt commands, encode event messages and iterate
through all HCI sockets just to figure out that that that nothing needs
to be done.

Johan
