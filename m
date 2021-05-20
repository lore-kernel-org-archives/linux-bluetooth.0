Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D285C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 20:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 107A460FD9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 20:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237889AbhETUTB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 May 2021 16:19:01 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51586 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbhETUS6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 May 2021 16:18:58 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 39E83CECEF;
        Thu, 20 May 2021 22:25:26 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: [PATCH 2/2] Bluetooth: hci_sync: Make use of hci_cmd_sync_queue
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210520164213.1381518-2-luiz.dentz@gmail.com>
Date:   Thu, 20 May 2021 22:17:31 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <F97186B5-BC6D-48F9-A07C-3E128C5E5CB4@holtmann.org>
References: <20210520164213.1381518-1-luiz.dentz@gmail.com>
 <20210520164213.1381518-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This make use of hci_cmd_sync_queue for the following MGMT commands:
> 
> Set Device Class
> Set Device ID
> Add UUID
> Remove UUID
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/hci_core.h |   2 +
> net/bluetooth/Makefile           |   2 +-
> net/bluetooth/hci_request.c      |  18 +++
> net/bluetooth/hci_sync.c         | 241 +++++++++++++++++++++++++++++++
> net/bluetooth/hci_sync.h         |   9 ++
> net/bluetooth/mgmt.c             | 123 ++++++++--------
> 6 files changed, 328 insertions(+), 67 deletions(-)
> create mode 100644 net/bluetooth/hci_sync.c
> create mode 100644 net/bluetooth/hci_sync.h

I was thinking to put things into hci_bredr.c and hci_le.c.

> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index aecbdf99c216..2494c547a622 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1699,6 +1699,8 @@ struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
> 			       const void *param, u32 timeout);
> struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
> 				  const void *param, u8 event, u32 timeout);
> +int __hci_cmd_sync_status(struct hci_dev *hdev, u16 opcode, u32 plen,
> +			  const void *param, u32 timeout);
> int __hci_cmd_send(struct hci_dev *hdev, u16 opcode, u32 plen,
> 		   const void *param);
> 
> diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
> index cc0995301f93..ab46b2b4f3cb 100644
> --- a/net/bluetooth/Makefile
> +++ b/net/bluetooth/Makefile
> @@ -14,7 +14,7 @@ bluetooth_6lowpan-y := 6lowpan.o
> 
> bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
> 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o lib.o \
> -	ecdh_helper.o hci_request.o mgmt_util.o mgmt_config.o
> +	ecdh_helper.o hci_request.o hci_sync.o mgmt_util.o mgmt_config.o
> 
> bluetooth-$(CONFIG_BT_BREDR) += sco.o
> bluetooth-$(CONFIG_BT_HS) += a2mp.o amp.o
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index fa9125b782f8..f390ac33ced9 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -189,6 +189,24 @@ struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
> }
> EXPORT_SYMBOL(__hci_cmd_sync);
> 
> +int __hci_cmd_sync_status(struct hci_dev *hdev, u16 opcode, u32 plen,
> +			  const void *param, u32 timeout)
> +{
> +	struct sk_buff *skb;
> +	uint8_t status;

Use u8 here since that is not user space. And drop the timeout parameter. We always use the same anyway.

> +
> +	skb = __hci_cmd_sync(hdev, opcode, plen, param, timeout);
> +	if (IS_ERR(skb))
> +		return PTR_ERR(skb);
> +
> +	status = skb->data[0];
> +
> +	kfree_skb(skb);
> +
> +	return status;
> +}
> +EXPORT_SYMBOL(__hci_cmd_sync_status);

Either we use u8 as return value or we convert it to the matching errno value.

> +
> /* Execute request and wait for completion. */
> int __hci_req_sync(struct hci_dev *hdev, int (*func)(struct hci_request *req,
> 						     unsigned long opt),
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> new file mode 100644
> index 000000000000..5b73fcf09c18
> --- /dev/null
> +++ b/net/bluetooth/hci_sync.c
> @@ -0,0 +1,241 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * BlueZ - Bluetooth protocol stack for Linux
> + *
> + * Copyright (C) 2021 Intel Corporation
> + */
> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +
> +#include "hci_request.h"
> +#include "hci_sync.h"
> +
> +#define PNP_INFO_SVCLASS_ID		0x1200
> +
> +static u8 *create_uuid16_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
> +{
> +	u8 *ptr = data, *uuids_start = NULL;
> +	struct bt_uuid *uuid;
> +
> +	if (len < 4)
> +		return ptr;
> +
> +	list_for_each_entry(uuid, &hdev->uuids, list) {
> +		u16 uuid16;
> +
> +		if (uuid->size != 16)
> +			continue;
> +
> +		uuid16 = get_unaligned_le16(&uuid->uuid[12]);
> +		if (uuid16 < 0x1100)
> +			continue;
> +
> +		if (uuid16 == PNP_INFO_SVCLASS_ID)
> +			continue;
> +
> +		if (!uuids_start) {
> +			uuids_start = ptr;
> +			uuids_start[0] = 1;
> +			uuids_start[1] = EIR_UUID16_ALL;
> +			ptr += 2;
> +		}
> +
> +		/* Stop if not enough space to put next UUID */
> +		if ((ptr - data) + sizeof(u16) > len) {
> +			uuids_start[1] = EIR_UUID16_SOME;
> +			break;
> +		}
> +
> +		*ptr++ = (uuid16 & 0x00ff);
> +		*ptr++ = (uuid16 & 0xff00) >> 8;
> +		uuids_start[0] += sizeof(uuid16);
> +	}
> +
> +	return ptr;
> +}
> +
> +static u8 *create_uuid32_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
> +{
> +	u8 *ptr = data, *uuids_start = NULL;
> +	struct bt_uuid *uuid;
> +
> +	if (len < 6)
> +		return ptr;
> +
> +	list_for_each_entry(uuid, &hdev->uuids, list) {
> +		if (uuid->size != 32)
> +			continue;
> +
> +		if (!uuids_start) {
> +			uuids_start = ptr;
> +			uuids_start[0] = 1;
> +			uuids_start[1] = EIR_UUID32_ALL;
> +			ptr += 2;
> +		}
> +
> +		/* Stop if not enough space to put next UUID */
> +		if ((ptr - data) + sizeof(u32) > len) {
> +			uuids_start[1] = EIR_UUID32_SOME;
> +			break;
> +		}
> +
> +		memcpy(ptr, &uuid->uuid[12], sizeof(u32));
> +		ptr += sizeof(u32);
> +		uuids_start[0] += sizeof(u32);
> +	}
> +
> +	return ptr;
> +}
> +
> +static u8 *create_uuid128_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
> +{
> +	u8 *ptr = data, *uuids_start = NULL;
> +	struct bt_uuid *uuid;
> +
> +	if (len < 18)
> +		return ptr;
> +
> +	list_for_each_entry(uuid, &hdev->uuids, list) {
> +		if (uuid->size != 128)
> +			continue;
> +
> +		if (!uuids_start) {
> +			uuids_start = ptr;
> +			uuids_start[0] = 1;
> +			uuids_start[1] = EIR_UUID128_ALL;
> +			ptr += 2;
> +		}
> +
> +		/* Stop if not enough space to put next UUID */
> +		if ((ptr - data) + 16 > len) {
> +			uuids_start[1] = EIR_UUID128_SOME;
> +			break;
> +		}
> +
> +		memcpy(ptr, uuid->uuid, 16);
> +		ptr += 16;
> +		uuids_start[0] += 16;
> +	}
> +
> +	return ptr;
> +}
> +
> +static void create_eir(struct hci_dev *hdev, u8 *data)
> +{
> +	u8 *ptr = data;
> +	size_t name_len;
> +
> +	name_len = strlen(hdev->dev_name);
> +
> +	if (name_len > 0) {
> +		/* EIR Data type */
> +		if (name_len > 48) {
> +			name_len = 48;
> +			ptr[1] = EIR_NAME_SHORT;
> +		} else
> +			ptr[1] = EIR_NAME_COMPLETE;
> +
> +		/* EIR Data length */
> +		ptr[0] = name_len + 1;
> +
> +		memcpy(ptr + 2, hdev->dev_name, name_len);
> +
> +		ptr += (name_len + 2);
> +	}
> +
> +	if (hdev->inq_tx_power != HCI_TX_POWER_INVALID) {
> +		ptr[0] = 2;
> +		ptr[1] = EIR_TX_POWER;
> +		ptr[2] = (u8) hdev->inq_tx_power;
> +
> +		ptr += 3;
> +	}
> +
> +	if (hdev->devid_source > 0) {
> +		ptr[0] = 9;
> +		ptr[1] = EIR_DEVICE_ID;
> +
> +		put_unaligned_le16(hdev->devid_source, ptr + 2);
> +		put_unaligned_le16(hdev->devid_vendor, ptr + 4);
> +		put_unaligned_le16(hdev->devid_product, ptr + 6);
> +		put_unaligned_le16(hdev->devid_version, ptr + 8);
> +
> +		ptr += 10;
> +	}
> +
> +	ptr = create_uuid16_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
> +	ptr = create_uuid32_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
> +	ptr = create_uuid128_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
> +}
> +
> +int __hci_update_eir_sync(struct hci_dev *hdev)
> +{
> +	struct hci_cp_write_eir cp;
> +
> +	bt_dev_dbg(hdev, "");
> +
> +	if (!hdev_is_powered(hdev))
> +		return 0;
> +
> +	if (!lmp_ext_inq_capable(hdev))
> +		return 0;
> +
> +	if (!hci_dev_test_flag(hdev, HCI_SSP_ENABLED))
> +		return 0;
> +
> +	if (hci_dev_test_flag(hdev, HCI_SERVICE_CACHE))
> +		return 0;
> +
> +	memset(&cp, 0, sizeof(cp));
> +
> +	create_eir(hdev, cp.data);
> +
> +	if (memcmp(cp.data, hdev->eir, sizeof(cp.data)) == 0)
> +		return 0;
> +
> +	memcpy(hdev->eir, cp.data, sizeof(cp.data));
> +
> +	return __hci_cmd_sync_status(hdev, HCI_OP_WRITE_EIR, sizeof(cp), &cp,
> +				     HCI_CMD_TIMEOUT);
> +}
> +
> +static u8 get_service_classes(struct hci_dev *hdev)
> +{
> +	struct bt_uuid *uuid;
> +	u8 val = 0;
> +
> +	list_for_each_entry(uuid, &hdev->uuids, list)
> +		val |= uuid->svc_hint;
> +
> +	return val;
> +}
> +
> +int __hci_update_class_sync(struct hci_dev *hdev)
> +{
> +	u8 cod[3];
> +
> +	bt_dev_dbg(hdev, "");
> +
> +	if (!hdev_is_powered(hdev))
> +		return 0;
> +
> +	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
> +		return 0;
> +
> +	if (hci_dev_test_flag(hdev, HCI_SERVICE_CACHE))
> +		return 0;
> +
> +	cod[0] = hdev->minor_class;
> +	cod[1] = hdev->major_class;
> +	cod[2] = get_service_classes(hdev);
> +
> +	if (hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE))
> +		cod[1] |= 0x20;
> +
> +	if (memcmp(cod, hdev->dev_class, 3) == 0)
> +		return 0;
> +
> +	return __hci_cmd_sync_status(hdev, HCI_OP_WRITE_CLASS_OF_DEV,
> +				     sizeof(cod), cod, HCI_CMD_TIMEOUT);
> +}
> diff --git a/net/bluetooth/hci_sync.h b/net/bluetooth/hci_sync.h
> new file mode 100644
> index 000000000000..735ff4b46e86
> --- /dev/null
> +++ b/net/bluetooth/hci_sync.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * BlueZ - Bluetooth protocol stack for Linux
> + *
> + * Copyright (C) 2021 Intel Corporation
> + */
> +
> +int __hci_update_eir_sync(struct hci_dev *hdev);
> +int __hci_update_class_sync(struct hci_dev *hdev);
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index b44e19c69c44..96759c166678 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -34,6 +34,7 @@
> #include <net/bluetooth/mgmt.h>
> 
> #include "hci_request.h"
> +#include "hci_sync.h"
> #include "smp.h"
> #include "mgmt_util.h"
> #include "mgmt_config.h"
> @@ -950,25 +951,21 @@ bool mgmt_get_connectable(struct hci_dev *hdev)
> 	return hci_dev_test_flag(hdev, HCI_CONNECTABLE);
> }
> 
> +static void __service_cache_sync(struct hci_dev *hdev, void *data)
> +{
> +	__hci_update_eir_sync(hdev);
> +	__hci_update_class_sync(hdev);
> +}
> +
> static void service_cache_off(struct work_struct *work)
> {
> 	struct hci_dev *hdev = container_of(work, struct hci_dev,
> 					    service_cache.work);
> -	struct hci_request req;
> 
> 	if (!hci_dev_test_and_clear_flag(hdev, HCI_SERVICE_CACHE))
> 		return;
> 
> -	hci_req_init(&req, hdev);
> -
> -	hci_dev_lock(hdev);
> -
> -	__hci_req_update_eir(&req);
> -	__hci_req_update_class(&req);
> -
> -	hci_dev_unlock(hdev);
> -
> -	hci_req_run(&req, NULL);
> +	hci_cmd_sync_queue(hdev, __service_cache_sync, NULL);
> }
> 
> static void rpa_expired(struct work_struct *work)
> @@ -2093,8 +2090,17 @@ static void mgmt_class_complete(struct hci_dev *hdev, u16 mgmt_op, u8 status)
> 	hci_dev_unlock(hdev);
> }
> 
> -static void add_uuid_complete(struct hci_dev *hdev, u8 status, u16 opcode)
> +static void __add_uuid_sync(struct hci_dev *hdev, void *data)
> {
> +	uint8_t status;
> +
> +	status = __hci_update_class_sync(hdev);
> +	if (status)
> +		goto done;
> +
> +	status = __hci_update_eir_sync(hdev);
> +
> +done:
> 	bt_dev_dbg(hdev, "status 0x%02x", status);
> 
> 	mgmt_class_complete(hdev, MGMT_OP_ADD_UUID, status);
> @@ -2104,7 +2110,6 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
> {
> 	struct mgmt_cp_add_uuid *cp = data;
> 	struct mgmt_pending_cmd *cmd;
> -	struct hci_request req;
> 	struct bt_uuid *uuid;
> 	int err;
> 
> @@ -2130,20 +2135,9 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
> 
> 	list_add_tail(&uuid->list, &hdev->uuids);
> 
> -	hci_req_init(&req, hdev);
> -
> -	__hci_req_update_class(&req);
> -	__hci_req_update_eir(&req);
> -
> -	err = hci_req_run(&req, add_uuid_complete);
> -	if (err < 0) {
> -		if (err != -ENODATA)
> -			goto failed;
> -
> -		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_UUID, 0,
> -					hdev->dev_class, 3);
> +	err = hci_cmd_sync_queue(hdev, __add_uuid_sync, NULL);
> +	if (err < 0)
> 		goto failed;
> -	}
> 
> 	cmd = mgmt_pending_add(sk, MGMT_OP_ADD_UUID, hdev, data, len);
> 	if (!cmd) {
> @@ -2172,8 +2166,17 @@ static bool enable_service_cache(struct hci_dev *hdev)
> 	return false;
> }
> 
> -static void remove_uuid_complete(struct hci_dev *hdev, u8 status, u16 opcode)
> +static void __remove_uuid_sync(struct hci_dev *hdev, void *data)
> {
> +	uint8_t status;
> +
> +	status = __hci_update_class_sync(hdev);
> +	if (status)
> +		goto done;
> +
> +	status = __hci_update_eir_sync(hdev);
> +
> +done:
> 	bt_dev_dbg(hdev, "status 0x%02x", status);
> 
> 	mgmt_class_complete(hdev, MGMT_OP_REMOVE_UUID, status);
> @@ -2186,7 +2189,6 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
> 	struct mgmt_pending_cmd *cmd;
> 	struct bt_uuid *match, *tmp;
> 	u8 bt_uuid_any[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
> -	struct hci_request req;
> 	int err, found;
> 
> 	bt_dev_dbg(hdev, "sock %p", sk);
> @@ -2230,20 +2232,9 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
> 	}
> 
> update_class:
> -	hci_req_init(&req, hdev);
> -
> -	__hci_req_update_class(&req);
> -	__hci_req_update_eir(&req);
> -
> -	err = hci_req_run(&req, remove_uuid_complete);
> -	if (err < 0) {
> -		if (err != -ENODATA)
> -			goto unlock;
> -
> -		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_UUID, 0,
> -					hdev->dev_class, 3);
> +	err = hci_cmd_sync_queue(hdev, __remove_uuid_sync, NULL);
> +	if (err < 0)
> 		goto unlock;
> -	}
> 
> 	cmd = mgmt_pending_add(sk, MGMT_OP_REMOVE_UUID, hdev, data, len);
> 	if (!cmd) {
> @@ -2258,8 +2249,24 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
> 	return err;
> }
> 
> -static void set_class_complete(struct hci_dev *hdev, u8 status, u16 opcode)
> +static void __set_class_sync(struct hci_dev *hdev, void *data)
> {
> +	uint8_t status = 0;
> +
> +	hci_dev_lock(hdev);
> +
> +	if (hci_dev_test_and_clear_flag(hdev, HCI_SERVICE_CACHE)) {
> +		hci_dev_unlock(hdev);
> +		cancel_delayed_work_sync(&hdev->service_cache);
> +		hci_dev_lock(hdev);
> +		status = __hci_update_eir_sync(hdev);
> +	}
> +
> +	hci_dev_unlock(hdev);
> +
> +	if (!status)
> +		status = __hci_update_class_sync(hdev);
> +
> 	bt_dev_dbg(hdev, "status 0x%02x", status);
> 
> 	mgmt_class_complete(hdev, MGMT_OP_SET_DEV_CLASS, status);
> @@ -2270,7 +2277,6 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
> {
> 	struct mgmt_cp_set_dev_class *cp = data;
> 	struct mgmt_pending_cmd *cmd;
> -	struct hci_request req;
> 	int err;
> 
> 	bt_dev_dbg(hdev, "sock %p", sk);
> @@ -2302,26 +2308,9 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
> 		goto unlock;
> 	}
> 
> -	hci_req_init(&req, hdev);
> -
> -	if (hci_dev_test_and_clear_flag(hdev, HCI_SERVICE_CACHE)) {
> -		hci_dev_unlock(hdev);
> -		cancel_delayed_work_sync(&hdev->service_cache);
> -		hci_dev_lock(hdev);
> -		__hci_req_update_eir(&req);
> -	}
> -
> -	__hci_req_update_class(&req);
> -
> -	err = hci_req_run(&req, set_class_complete);
> -	if (err < 0) {
> -		if (err != -ENODATA)
> -			goto unlock;
> -
> -		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_DEV_CLASS, 0,
> -					hdev->dev_class, 3);
> +	err = hci_cmd_sync_queue(hdev, __set_class_sync, NULL);
> +	if (err < 0)
> 		goto unlock;
> -	}
> 
> 	cmd = mgmt_pending_add(sk, MGMT_OP_SET_DEV_CLASS, hdev, data, len);
> 	if (!cmd) {
> @@ -5263,11 +5252,15 @@ static int unblock_device(struct sock *sk, struct hci_dev *hdev, void *data,
> 	return err;
> }
> 
> +static void __set_device_id_sync(struct hci_dev *hdev, void *data)
> +{
> +	__hci_update_eir_sync(hdev);
> +}
> +
> static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
> 			 u16 len)
> {
> 	struct mgmt_cp_set_device_id *cp = data;
> -	struct hci_request req;
> 	int err;
> 	__u16 source;
> 
> @@ -5289,9 +5282,7 @@ static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
> 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_DEVICE_ID, 0,
> 				NULL, 0);
> 
> -	hci_req_init(&req, hdev);
> -	__hci_req_update_eir(&req);
> -	hci_req_run(&req, NULL);
> +	hci_cmd_sync_queue(hdev, __set_device_id_sync, NULL);
> 
> 	hci_dev_unlock(hdev);

I dislike the prefix __sync. They are in a separate anyway. So keep is simple and also scrap the __ prefix.

Regards

Marcel

