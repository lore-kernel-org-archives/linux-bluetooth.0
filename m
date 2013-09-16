Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Sep 2013 12:06:21 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/5] Bluetooth: Fix hci_add_sysfs
Message-ID: <20130916150621.GA4006@joana>
References: <1377288071-3664-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377288071-3664-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

2013-08-23 Andre Guedes <andre.guedes@openbossa.org>:

> The inquiry_cache and auto_accept_delay files should be added to
> debugfs only if controller is BR/EDR capable.
> 
> Since in hci_register_dev() hdev has not been initialized yet,
> we are not able to check if the controller is BR/EDR capable.
> Thus, we postpone exporting those two files to just after
> controller's initialization.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_core.c         | 17 ++++++++++++-----
>  net/bluetooth/hci_sysfs.c        | 16 +++++++++++-----
>  3 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 3ede820..879bf45 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -775,6 +775,7 @@ int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count);
>  void hci_init_sysfs(struct hci_dev *hdev);
>  int hci_add_sysfs(struct hci_dev *hdev);
>  void hci_del_sysfs(struct hci_dev *hdev);
> +void hci_sysfs_export_info(struct hci_dev *hdev);
>  void hci_conn_init_sysfs(struct hci_conn *conn);
>  void hci_conn_add_sysfs(struct hci_conn *conn);
>  void hci_conn_del_sysfs(struct hci_conn *conn);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 8d9b87d..e8be6ec 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1184,11 +1184,18 @@ int hci_dev_open(__u16 dev)
>  		hci_dev_hold(hdev);
>  		set_bit(HCI_UP, &hdev->flags);
>  		hci_notify(hdev, HCI_DEV_UP);
> -		if (!test_bit(HCI_SETUP, &hdev->dev_flags) &&
> -		    mgmt_valid_hdev(hdev)) {
> -			hci_dev_lock(hdev);
> -			mgmt_powered(hdev, 1);
> -			hci_dev_unlock(hdev);
> +		if (mgmt_valid_hdev(hdev)) {
> +			/* If we are in HCI_SETUP phase, meaning the device
> +			 * has just been registered, we should export the
> +			 * remaining infos to debugfs.
> +			 */
> +			if (test_bit(HCI_SETUP, &hdev->dev_flags)) {
> +				hci_sysfs_export_info(hdev);
> +			} else {
> +				hci_dev_lock(hdev);
> +				mgmt_powered(hdev, 1);
> +				hci_dev_unlock(hdev);
> +			}

These patches doesn't apply cleanly on bluetooth-next anymore. Please rebase
the set and resend. Thanks. 

	Gustavo
