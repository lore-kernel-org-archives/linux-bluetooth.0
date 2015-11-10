Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH 01/12] Bluetooth: Add stubs for synchronous HCI request functionality
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1447179274-12276-2-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 11 Nov 2015 07:24:09 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <136B456C-E638-4868-8718-8899B2FCC505@holtmann.org>
References: <1447179274-12276-1-git-send-email-johan.hedberg@gmail.com> <1447179274-12276-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Prepare hci_request.c to have code for doing synchronous HCI requests,
> such as LE scanning or advertising changes. The necessary work
> callbacks will be set up in hci_request_setup() and cleaned up in
> hci_request_cleanup().
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c    | 4 ++++
> net/bluetooth/hci_request.c | 8 ++++++++
> net/bluetooth/hci_request.h | 3 +++
> 3 files changed, 15 insertions(+)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index ea7cad5a161c..955b907f7ed8 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1604,6 +1604,8 @@ int hci_dev_do_close(struct hci_dev *hdev)
> 
> 	hci_req_sync_unlock(hdev);
> 
> +	hci_request_cleanup(hdev);
> +
> 	hci_dev_put(hdev);
> 	return 0;
> }
> @@ -3156,6 +3158,8 @@ struct hci_dev *hci_alloc_dev(void)
> 
> 	INIT_DELAYED_WORK(&hdev->cmd_timer, hci_cmd_timeout);
> 
> +	hci_request_setup(hdev);
> +
> 	hci_init_sysfs(hdev);
> 	discovery_init(hdev);

so this is an imbalance. It might be intended, but then the naming is confusing. So hci_alloc_dev is called once for the lifetime of the controller and hci_dev_do_close is called every time the transport is shutdown.

Regards

Marcel

