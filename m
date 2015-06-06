Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH 2/2] Bluetooth: Reorder HCI user channel socket release
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1432219601-3663-2-git-send-email-loic.poulain@intel.com>
Date: Sat, 6 Jun 2015 20:51:22 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EE8E372F-A6AD-4003-848E-1095148CD2F6@holtmann.org>
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

patch has been applied to bluetooth-next tree.

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

However I still do not remember why I did it the other way around in the first place. Can someone please double check that this will not break anything. I do not trust my own judgment in this case. It feels suspicious.

Regards

Marcel

