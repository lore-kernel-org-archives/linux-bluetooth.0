Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D35C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Nov 2021 15:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbhKXP1i convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Nov 2021 10:27:38 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:48859 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhKXP1h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Nov 2021 10:27:37 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 95022CED24;
        Wed, 24 Nov 2021 16:24:26 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v3 2/4] Bluetooth: hci_core: Rework hci_conn_params flags
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211120012448.1476960-2-luiz.dentz@gmail.com>
Date:   Wed, 24 Nov 2021 16:24:26 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <993976EC-5477-43A5-AE2E-97EEFECF0E17@holtmann.org>
References: <20211120012448.1476960-1-luiz.dentz@gmail.com>
 <20211120012448.1476960-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This reworks hci_conn_params flags to use bitmap_* helpers and add
> support for setting the supported flags in hdev->conn_flags so it can
> easily be accessed.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/hci_core.h | 48 +++++++++++++++++++-------------
> net/bluetooth/hci_core.c         |  8 +++++-
> net/bluetooth/hci_request.c      |  4 +--
> net/bluetooth/hci_sync.c         |  7 ++---
> net/bluetooth/mgmt.c             | 30 +++++++++++++-------
> 5 files changed, 61 insertions(+), 36 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 2560cfe80db8..fc93a1907c90 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -151,22 +151,21 @@ struct bdaddr_list_with_irk {
> 	u8 local_irk[16];
> };
> 
> -struct bdaddr_list_with_flags {
> -	struct list_head list;
> -	bdaddr_t bdaddr;
> -	u8 bdaddr_type;
> -	u32 current_flags;
> -};
> -
> enum hci_conn_flags {
> 	HCI_CONN_FLAG_REMOTE_WAKEUP,
> -	HCI_CONN_FLAG_MAX
> -};
> 
> -#define hci_conn_test_flag(nr, flags) ((flags) & (1U << nr))
> +	__HCI_CONN_NUM_FLAGS,
> +};
> 
> /* Make sure number of flags doesn't exceed sizeof(current_flags) */
> -static_assert(HCI_CONN_FLAG_MAX < 32);
> +static_assert(__HCI_CONN_NUM_FLAGS < 32);
> +
> +struct bdaddr_list_with_flags {
> +	struct list_head list;
> +	bdaddr_t bdaddr;
> +	u8 bdaddr_type;
> +	DECLARE_BITMAP(flags, __HCI_CONN_NUM_FLAGS);
> +};
> 
> struct bt_uuid {
> 	struct list_head list;
> @@ -559,6 +558,7 @@ struct hci_dev {
> 	struct rfkill		*rfkill;
> 
> 	DECLARE_BITMAP(dev_flags, __HCI_NUM_FLAGS);
> +	DECLARE_BITMAP(conn_flags, __HCI_CONN_NUM_FLAGS);
> 
> 	__s8			adv_tx_power;
> 	__u8			adv_data[HCI_MAX_EXT_AD_LENGTH];
> @@ -754,7 +754,7 @@ struct hci_conn_params {
> 
> 	struct hci_conn *conn;
> 	bool explicit_connect;
> -	u32 current_flags;
> +	DECLARE_BITMAP(flags, __HCI_CONN_NUM_FLAGS);
> };
> 
> extern struct list_head hci_dev_list;
> @@ -762,13 +762,20 @@ extern struct list_head hci_cb_list;
> extern rwlock_t hci_dev_list_lock;
> extern struct mutex hci_cb_list_lock;
> 
> -#define hci_dev_set_flag(hdev, nr)             set_bit((nr), (hdev)->dev_flags)
> -#define hci_dev_clear_flag(hdev, nr)           clear_bit((nr), (hdev)->dev_flags)
> -#define hci_dev_change_flag(hdev, nr)          change_bit((nr), (hdev)->dev_flags)
> -#define hci_dev_test_flag(hdev, nr)            test_bit((nr), (hdev)->dev_flags)
> -#define hci_dev_test_and_set_flag(hdev, nr)    test_and_set_bit((nr), (hdev)->dev_flags)
> -#define hci_dev_test_and_clear_flag(hdev, nr)  test_and_clear_bit((nr), (hdev)->dev_flags)
> -#define hci_dev_test_and_change_flag(hdev, nr) test_and_change_bit((nr), (hdev)->dev_flags)
> +#define hci_dev_set_flag(hdev, nr) \
> +	set_bit((nr), (hdev)->dev_flags)
> +#define hci_dev_clear_flag(hdev, nr) \
> +	clear_bit((nr), (hdev)->dev_flags)
> +#define hci_dev_change_flag(hdev, nr) \
> +	change_bit((nr), (hdev)->dev_flags)
> +#define hci_dev_test_flag(hdev, nr) \
> +	test_bit((nr), (hdev)->dev_flags)
> +#define hci_dev_test_and_set_flag(hdev, nr) \
> +	test_and_set_bit((nr), (hdev)->dev_flags)
> +#define hci_dev_test_and_clear_flag(hdev, nr) \
> +	test_and_clear_bit((nr), (hdev)->dev_flags)
> +#define hci_dev_test_and_change_flag(hdev, nr) \
> +	test_and_change_bit((nr), (hdev)->dev_flags)

actually in these cases, break the 80 column rule.

> 
> #define hci_dev_clear_volatile_flags(hdev)			\
> 	do {							\
> @@ -1465,6 +1472,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
> #define use_ll_privacy(dev) (ll_privacy_capable(dev) && \
> 			     hci_dev_test_flag(dev, HCI_ENABLE_LL_PRIVACY))
> 
> +#define privacy_mode_capable(dev) (use_ll_privacy(dev) && \
> +				   (hdev->commands[39] & 0x04))
> +

This shouldn’t be in this patch then.

> /* Use enhanced synchronous connection if command is supported */
> #define enhanced_sco_capable(dev) ((dev)->commands[29] & 0x08)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index fdc0dcf8ee36..7c4af0b34b62 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2153,7 +2153,7 @@ int hci_bdaddr_list_add_with_flags(struct list_head *list, bdaddr_t *bdaddr,
> 
> 	bacpy(&entry->bdaddr, bdaddr);
> 	entry->bdaddr_type = type;
> -	entry->current_flags = flags;
> +	bitmap_from_u64(entry->flags, flags);
> 
> 	list_add(&entry->list, list);
> 
> @@ -2629,6 +2629,12 @@ int hci_register_dev(struct hci_dev *hdev)
> 	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
> 		hci_dev_set_flag(hdev, HCI_UNCONFIGURED);
> 
> +	/* Mark Remote Wakeup connection flag as supported if driver has wakeup
> +	 * callback.
> +	 */
> +	if (hdev->wakeup)
> +		set_bit(HCI_CONN_FLAG_REMOTE_WAKEUP, hdev->conn_flags);
> +
> 	hci_sock_dev_event(hdev, HCI_DEV_REG);
> 	hci_dev_hold(hdev);
> 
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 8b3205e4b23e..fee88214606e 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -492,8 +492,8 @@ static int add_to_accept_list(struct hci_request *req,
> 	}
> 
> 	/* During suspend, only wakeable devices can be in accept list */
> -	if (hdev->suspended && !hci_conn_test_flag(HCI_CONN_FLAG_REMOTE_WAKEUP,
> -						   params->current_flags))
> +	if (hdev->suspended &&
> +	    !test_bit(HCI_CONN_FLAG_REMOTE_WAKEUP, params->flags))
> 		return 0;
> 
> 	*num_entries += 1;
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index ad86caf41f91..5f44ff0b8910 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -1606,8 +1606,8 @@ static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
> 	}
> 
> 	/* During suspend, only wakeable devices can be in acceptlist */
> -	if (hdev->suspended && !hci_conn_test_flag(HCI_CONN_FLAG_REMOTE_WAKEUP,
> -						   params->current_flags))
> +	if (hdev->suspended &&
> +	    !test_bit(HCI_CONN_FLAG_REMOTE_WAKEUP, params->flags))
> 		return 0;
> 
> 	/* Attempt to program the device in the resolving list first to avoid
> @@ -4749,8 +4749,7 @@ static int hci_update_event_filter_sync(struct hci_dev *hdev)
> 	hci_clear_event_filter_sync(hdev);
> 
> 	list_for_each_entry(b, &hdev->accept_list, list) {
> -		if (!hci_conn_test_flag(HCI_CONN_FLAG_REMOTE_WAKEUP,
> -					b->current_flags))
> +		if (!test_bit(HCI_CONN_FLAG_REMOTE_WAKEUP, b->flags))
> 			continue;
> 
> 		bt_dev_dbg(hdev, "Adding event filters for %pMR", &b->bdaddr);
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 0f91bf15e260..0f4b620bc630 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -4349,8 +4349,6 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
> 			       MGMT_STATUS_NOT_SUPPORTED);
> }
> 
> -#define SUPPORTED_DEVICE_FLAGS() ((1U << HCI_CONN_FLAG_MAX) - 1)
> -
> static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
> 			    u16 data_len)
> {
> @@ -4358,7 +4356,7 @@ static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
> 	struct mgmt_rp_get_device_flags rp;
> 	struct bdaddr_list_with_flags *br_params;
> 	struct hci_conn_params *params;
> -	u32 supported_flags = SUPPORTED_DEVICE_FLAGS();
> +	u32 supported_flags;
> 	u32 current_flags = 0;
> 	u8 status = MGMT_STATUS_INVALID_PARAMS;
> 
> @@ -4367,6 +4365,9 @@ static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
> 
> 	hci_dev_lock(hdev);
> 
> +	bitmap_to_arr32(&supported_flags, hdev->conn_flags,
> +			__HCI_CONN_NUM_FLAGS);
> +
> 	memset(&rp, 0, sizeof(rp));
> 
> 	if (cp->addr.type == BDADDR_BREDR) {
> @@ -4376,7 +4377,8 @@ static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
> 		if (!br_params)
> 			goto done;
> 
> -		current_flags = br_params->current_flags;
> +		bitmap_to_arr32(&current_flags, br_params->flags,
> +				__HCI_CONN_NUM_FLAGS);
> 	} else {
> 		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
> 						le_addr_type(cp->addr.type));
> @@ -4384,7 +4386,8 @@ static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
> 		if (!params)
> 			goto done;
> 
> -		current_flags = params->current_flags;
> +		bitmap_to_arr32(&current_flags, params->flags,
> +				__HCI_CONN_NUM_FLAGS);
> 	}
> 
> 	bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
> @@ -4422,13 +4425,16 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
> 	struct bdaddr_list_with_flags *br_params;
> 	struct hci_conn_params *params;
> 	u8 status = MGMT_STATUS_INVALID_PARAMS;
> -	u32 supported_flags = SUPPORTED_DEVICE_FLAGS();
> +	u32 supported_flags;
> 	u32 current_flags = __le32_to_cpu(cp->current_flags);
> 
> 	bt_dev_dbg(hdev, "Set device flags %pMR (type 0x%x) = 0x%x",
> 		   &cp->addr.bdaddr, cp->addr.type,
> 		   __le32_to_cpu(current_flags));
> 
> +	bitmap_to_arr32(&supported_flags, hdev->conn_flags,
> +			__HCI_CONN_NUM_FLAGS);
> +
> 	if ((supported_flags | current_flags) != supported_flags) {
> 		bt_dev_warn(hdev, "Bad flag given (0x%x) vs supported (0x%0x)",
> 			    current_flags, supported_flags);
> @@ -4443,7 +4449,7 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
> 							      cp->addr.type);
> 
> 		if (br_params) {
> -			br_params->current_flags = current_flags;
> +			bitmap_from_u64(br_params->flags, current_flags);
> 			status = MGMT_STATUS_SUCCESS;
> 		} else {
> 			bt_dev_warn(hdev, "No such BR/EDR device %pMR (0x%x)",
> @@ -4453,7 +4459,7 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
> 		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
> 						le_addr_type(cp->addr.type));
> 		if (params) {
> -			params->current_flags = current_flags;
> +			bitmap_from_u64(params->flags, current_flags);
> 			status = MGMT_STATUS_SUCCESS;
> 		} else {
> 			bt_dev_warn(hdev, "No such LE device %pMR (0x%x)",
> @@ -6979,6 +6985,7 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
> 	struct hci_conn_params *params;
> 	int err;
> 	u32 current_flags = 0;
> +	u32 supported_flags;
> 
> 	bt_dev_dbg(hdev, "sock %p", sk);
> 
> @@ -7050,7 +7057,8 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
> 		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
> 						addr_type);
> 		if (params)
> -			current_flags = params->current_flags;
> +			bitmap_to_arr32(&current_flags, params->flags,
> +					__HCI_CONN_NUM_FLAGS);
> 	}
> 
> 	err = hci_cmd_sync_queue(hdev, add_device_sync, NULL, NULL);
> @@ -7059,8 +7067,10 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
> 
> added:
> 	device_added(sk, hdev, &cp->addr.bdaddr, cp->addr.type, cp->action);
> +	bitmap_to_arr32(&supported_flags, hdev->conn_flags,
> +			__HCI_CONN_NUM_FLAGS);
> 	device_flags_changed(NULL, hdev, &cp->addr.bdaddr, cp->addr.type,
> -			     SUPPORTED_DEVICE_FLAGS(), current_flags);
> +			     supported_flags, current_flags);
> 
> 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
> 				MGMT_STATUS_SUCCESS, &cp->addr,

Regards

Marcel

