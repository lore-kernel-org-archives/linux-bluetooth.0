Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 13/15] Bluetooth: Update local RPA if necessary before starting LE scan
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393088805-28658-14-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 22 Feb 2014 10:13:21 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <5053B9D1-E708-4203-8D8B-6633DE752E31@holtmann.org>
References: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com> <1393088805-28658-14-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When we start LE scanning we need to regenerate the local RPA in case it
> has expired. This patch adds the necessary code for doing this in the
> start_discovery function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index e3d8371a2493..2dd0c730f0e9 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3382,6 +3382,9 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
> 			goto failed;
> 		}
> 
> +		if (test_and_clear_bit(HCI_RPA_EXPIRED, &hdev->dev_flags))
> +			hci_update_rpa(&req);
> +

same comment here. We need to take care of the static address as well here.

Regards

Marcel

