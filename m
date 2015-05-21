Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH 2/2] Bluetooth: Reorder HCI user channel socket release
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1432219601-3663-2-git-send-email-loic.poulain@intel.com>
Date: Thu, 21 May 2015 21:55:29 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4929A894-9A29-4ACA-BD7F-CAA2C27518FA@holtmann.org>
References: <1432219601-3663-1-git-send-email-loic.poulain@intel.com> <1432219601-3663-2-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> The hci close method needs to know if we are in user channel context.
> Only add the index to mgmt once close is performed.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> net/bluetooth/hci_sock.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 56f9edb..e1beb4e 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -503,9 +503,9 @@ static int hci_sock_release(struct socket *sock)
> 
> 	if (hdev) {
> 		if (hci_pi(sk)->channel == HCI_CHANNEL_USER) {
> -			mgmt_index_added(hdev);
> -			hci_dev_clear_flag(hdev, HCI_USER_CHANNEL);
> 			hci_dev_close(hdev->id);
> +			hci_dev_clear_flag(hdev, HCI_USER_CHANNEL);
> +			mgmt_index_added(hdev);
> 		}

this way around looks so much more logical. However now I wonder if either I was confused when writing this code in the first place or I had a really good reason for it, but just forgot to document it.

Regards

Marcel

