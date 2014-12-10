Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: Fix missing hci_dev_lock/unlock
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418203896-21580-1-git-send-email-jaganath.k@samsung.com>
Date: Wed, 10 Dec 2014 12:36:14 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D2F95124-01CD-4548-BB2C-94F3D80BE799@holtmann.org>
References: <1418203896-21580-1-git-send-email-jaganath.k@samsung.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> mgmt_pending_remove() should be called with hci_dev_lock protection
> and this patch fixes the same in the missing places.
> 
> Without this patch there is a chance of invalid memory access while
> accessing the mgmt_pending list like below
> 
> bluetoothd:  392] [0] Backtrace:
> bluetoothd:  392] [0] [<c04ec770>] (pending_eir_or_class+0x0/0x68) from [<c04f1830>] (add_uuid+0x34/0x1c4)
> bluetoothd:  392] [0] [<c04f17fc>] (add_uuid+0x0/0x1c4) from [<c04f3cc4>] (mgmt_control+0x204/0x274)
> bluetoothd:  392] [0] [<c04f3ac0>] (mgmt_control+0x0/0x274) from [<c04f609c>] (hci_sock_sendmsg+0x80/0x308)
> bluetoothd:  392] [0] [<c04f601c>] (hci_sock_sendmsg+0x0/0x308) from [<c03d4d68>] (sock_aio_write+0x144/0x174)
> bluetoothd:  392] [0]  r8:00000000 r7 7c1be90 r6 7c1be18 r5:00000017 r4 a90ea80
> bluetoothd:  392] [0] [<c03d4c24>] (sock_aio_write+0x0/0x174) from [<c00e2d4c>] (do_sync_write+0xb0/0xe0)
> bluetoothd:  392] [0] [<c00e2c9c>] (do_sync_write+0x0/0xe0) from [<c00e371c>] (vfs_write+0x134/0x13c)
> bluetoothd:  392] [0]  r8:00000000 r7 7c1bf70 r6:beeca5c8 r5:00000017 r4 7c05900
> bluetoothd:  392] [0] [<c00e35e8>] (vfs_write+0x0/0x13c) from [<c00e3910>] (sys_write+0x44/0x70)
> bluetoothd:  392] [0]  r8:00000000 r7:00000004 r6:00000017 r5:beeca5c8 r4 7c05900
> bluetoothd:  392] [0] [<c00e38cc>] (sys_write+0x0/0x70) from [<c000e3c0>] (ret_fast_syscall+0x0/0x30)
> bluetoothd:  392] [0]  r9 7c1a000 r8:c000e568 r6:400b5f10 r5:403896d8 r4:beeca604
> bluetoothd:  392] [0] Code: e28cc00c e152000c 0a00000f e3a00001 (e1d210b8)
> bluetoothd:  392] [0] ---[ end trace 67b6ac67435864c4 ]---
> bluetoothd:  392] [0] Kernel panic - not syncing: Fatal exception
> 
> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
> ---
> net/bluetooth/hci_core.c  |    2 ++
> net/bluetooth/hci_event.c |   22 ++++++++++++++++++++--
> net/bluetooth/mgmt.c      |   18 ++++++++++++------
> 3 files changed, 34 insertions(+), 8 deletions(-)

I would split this into two patches. One for the mgmt.c and hci_core.c changes and one for hci_event.c changes.

> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 96e7321..ecd7c01 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3083,7 +3083,9 @@ static void hci_power_on(struct work_struct *work)
> 
> 	err = hci_dev_do_open(hdev);
> 	if (err < 0) {
> +		hci_dev_lock(hdev);
> 		mgmt_set_powered_failed(hdev, err);
> +		hci_dev_unlock(hdev);
> 		return;
> 	}

I wonder is some of the mgmt_ function should just take the hci_dev lock. Are there cases where we don't want them to take the look?

> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 322abbb..baa6c96 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -257,6 +257,8 @@ static void hci_cc_write_auth_enable(struct hci_dev *hdev, struct sk_buff *skb)
> 	if (!sent)
> 		return;
> 
> +	hci_dev_lock(hdev);
> +
> 	if (!status) {
> 		__u8 param = *((__u8 *) sent);
> 
> @@ -268,6 +270,8 @@ static void hci_cc_write_auth_enable(struct hci_dev *hdev, struct sk_buff *skb)
> 
> 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
> 		mgmt_auth_enable_complete(hdev, status);
> +
> +	hci_dev_unlock(hdev);
> }
> 
> static void hci_cc_write_encrypt_mode(struct hci_dev *hdev, struct sk_buff *skb)
> @@ -443,6 +447,8 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
> 	if (!sent)
> 		return;
> 
> +	hci_dev_lock(hdev);
> +
> 	if (!status) {
> 		if (sent->mode)
> 			hdev->features[1][0] |= LMP_HOST_SSP;
> @@ -458,6 +464,8 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
> 		else
> 			clear_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
> 	}
> +
> +	hci_dev_unlock(hdev);
> }
> 
> static void hci_cc_write_sc_support(struct hci_dev *hdev, struct sk_buff *skb)
> @@ -471,6 +479,8 @@ static void hci_cc_write_sc_support(struct hci_dev *hdev, struct sk_buff *skb)
> 	if (!sent)
> 		return;
> 
> +	hci_dev_lock(hdev);
> +
> 	if (!status) {
> 		if (sent->support)
> 			hdev->features[1][0] |= LMP_HOST_SC;
> @@ -486,6 +496,8 @@ static void hci_cc_write_sc_support(struct hci_dev *hdev, struct sk_buff *skb)
> 		else
> 			clear_bit(HCI_SC_ENABLED, &hdev->dev_flags);
> 	}
> +
> +	hci_dev_unlock(hdev);
> }
> 
> static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
> @@ -1172,9 +1184,11 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
> 		 * re-enable it again if necessary.
> 		 */
> 		if (test_and_clear_bit(HCI_LE_SCAN_INTERRUPTED,
> -				       &hdev->dev_flags))
> +				       &hdev->dev_flags)) {
> +			hci_dev_lock(hdev);
> 			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> -		else if (!test_bit(HCI_LE_ADV, &hdev->dev_flags) &&
> +			hci_dev_unlock(hdev);
> +		} else if (!test_bit(HCI_LE_ADV, &hdev->dev_flags) &&
> 			 hdev->discovery.state == DISCOVERY_FINDING)

This is now a coding style violation. You need to move this line as well.

> 			mgmt_reenable_advertising(hdev);
> 
> @@ -1278,6 +1292,8 @@ static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
> 	if (!sent)
> 		return;
> 
> +	hci_dev_lock(hdev);
> +
> 	if (sent->le) {
> 		hdev->features[1][0] |= LMP_HOST_LE;
> 		set_bit(HCI_LE_ENABLED, &hdev->dev_flags);
> @@ -1291,6 +1307,8 @@ static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
> 		hdev->features[1][0] |= LMP_HOST_LE_BREDR;
> 	else
> 		hdev->features[1][0] &= ~LMP_HOST_LE_BREDR;
> +
> +	hci_dev_unlock(hdev);
> }
> 
> static void hci_cc_set_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 44b20de..16ac037 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2199,12 +2199,14 @@ static void le_enable_complete(struct hci_dev *hdev, u8 status)
> {
> 	struct cmd_lookup match = { NULL, hdev };
> 
> +	hci_dev_lock(hdev);
> +
> 	if (status) {
> 		u8 mgmt_err = mgmt_status(status);
> 
> 		mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, cmd_status_rsp,
> 				     &mgmt_err);
> -		return;
> +		goto unlock;
> 	}
> 
> 	mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, settings_rsp, &match);
> @@ -2222,17 +2224,16 @@ static void le_enable_complete(struct hci_dev *hdev, u8 status)
> 	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
> 		struct hci_request req;
> 
> -		hci_dev_lock(hdev);
> -
> 		hci_req_init(&req, hdev);
> 		update_adv_data(&req);
> 		update_scan_rsp_data(&req);
> 		hci_req_run(&req, NULL);
> 
> 		hci_update_background_scan(hdev);
> -
> -		hci_dev_unlock(hdev);
> 	}
> +
> +unlock:
> +	hci_dev_unlock(hdev);
> }
> 
> static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
> @@ -4279,12 +4280,14 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status)
> {
> 	struct cmd_lookup match = { NULL, hdev };
> 
> +	hci_dev_lock(hdev);
> +
> 	if (status) {
> 		u8 mgmt_err = mgmt_status(status);
> 
> 		mgmt_pending_foreach(MGMT_OP_SET_ADVERTISING, hdev,
> 				     cmd_status_rsp, &mgmt_err);
> -		return;
> +		goto unlock;
> 	}
> 
> 	if (test_bit(HCI_LE_ADV, &hdev->dev_flags))
> @@ -4299,6 +4302,9 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status)
> 
> 	if (match.sk)
> 		sock_put(match.sk);
> +
> +unlock:
> +	hci_dev_unlock(hdev);
> }
> 

Regards

Marcel

