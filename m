Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2A9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 08:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F856610C7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 08:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhJ2IeZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Oct 2021 04:34:25 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51683 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbhJ2IeZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Oct 2021 04:34:25 -0400
Received: from smtpclient.apple (p4ff9fd51.dip0.t-ipconnect.de [79.249.253.81])
        by mail.holtmann.org (Postfix) with ESMTPSA id D21FBCED10;
        Fri, 29 Oct 2021 10:31:55 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [RFC PATCH] Bluetooth: vhci: Add new packet type for VHCI
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211029061345.676005-1-hj.tedd.an@gmail.com>
Date:   Fri, 29 Oct 2021 10:31:55 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <C0F0EA05-A9BC-4E1C-ADDB-4B0BEBB8AF6E@holtmann.org>
References: <20211029061345.676005-1-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

> Current implementation uses the Vendor packet type (0xff) with opcode
> parameter. But there is no way to expand the opcode and no available bits
> to use. Also it cannot be changed due to the backward compatibility
> with older kernel.
> 
> So, this patch adds new packet type dedicated for VHCI(0xfe) to support
> configuring the VHCI device with quarks and flags while creating the
> VHCI driver.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/hci_vhci.c | 161 ++++++++++++++++++++++++++++++-----
> include/net/bluetooth/hci.h  |   1 +
> 2 files changed, 140 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index 49ac884d996e..4ae1e861b3a8 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -30,6 +30,20 @@
> 
> static bool amp;
> 
> +struct vhci_ext_create_device_req {
> +	__u8	dev_type;
> +	__u32	flags;
> +} __packed;
> +
> +#define VHCI_FLAG_QUIRK_RAW_DEVICE		0x01
> +#define VHCI_FLAG_QUIRK_EXTERNAL_CONFIG		0x02
> +#define VHCI_FLAG_QUIRKS_INVALID_BDADDR		0x04
> +
> +struct vhci_ext_create_device_resp {
> +	__u8	dev_type;
> +	__u16	index;
> +} __packed;
> +
> struct vhci_data {
> 	struct hci_dev *hdev;
> 
> @@ -278,6 +292,38 @@ static int vhci_setup(struct hci_dev *hdev)
> 	return 0;
> }
> 
> +static void vhci_create_debugfs(struct hci_dev *hdev)
> +{
> +	struct vhci_data *data = hci_get_drvdata(hdev);
> +
> +	debugfs_create_file("force_suspend", 0644, hdev->debugfs, data,
> +			    &force_suspend_fops);
> +
> +	debugfs_create_file("force_wakeup", 0644, hdev->debugfs, data,
> +			    &force_wakeup_fops);
> +
> +	if (IS_ENABLED(CONFIG_BT_MSFTEXT))
> +		debugfs_create_file("msft_opcode", 0644, hdev->debugfs, data,
> +				    &msft_opcode_fops);
> +
> +	if (IS_ENABLED(CONFIG_BT_AOSPEXT))
> +		debugfs_create_file("aosp_capable", 0644, hdev->debugfs, data,
> +				    &aosp_capable_fops);
> +}
> +
> +static void vhci_setup_hdev(struct hci_dev *hdev)
> +{
> +	hdev->open  = vhci_open_dev;
> +	hdev->close = vhci_close_dev;
> +	hdev->flush = vhci_flush;
> +	hdev->send  = vhci_send_frame;
> +	hdev->get_data_path_id = vhci_get_data_path_id;
> +	hdev->get_codec_config_data = vhci_get_codec_config_data;
> +	hdev->wakeup = vhci_wakeup;
> +	hdev->setup = vhci_setup;
> +	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
> +}
> +
> static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> {
> 	struct hci_dev *hdev;
> @@ -313,15 +359,7 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> 	hdev->dev_type = dev_type;
> 	hci_set_drvdata(hdev, data);
> 
> -	hdev->open  = vhci_open_dev;
> -	hdev->close = vhci_close_dev;
> -	hdev->flush = vhci_flush;
> -	hdev->send  = vhci_send_frame;
> -	hdev->get_data_path_id = vhci_get_data_path_id;
> -	hdev->get_codec_config_data = vhci_get_codec_config_data;
> -	hdev->wakeup = vhci_wakeup;
> -	hdev->setup = vhci_setup;
> -	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
> +	vhci_setup_hdev(hdev);
> 
> 	/* bit 6 is for external configuration */
> 	if (opcode & 0x40)
> @@ -339,19 +377,7 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> 		return -EBUSY;
> 	}
> 
> -	debugfs_create_file("force_suspend", 0644, hdev->debugfs, data,
> -			    &force_suspend_fops);
> -
> -	debugfs_create_file("force_wakeup", 0644, hdev->debugfs, data,
> -			    &force_wakeup_fops);
> -
> -	if (IS_ENABLED(CONFIG_BT_MSFTEXT))
> -		debugfs_create_file("msft_opcode", 0644, hdev->debugfs, data,
> -				    &msft_opcode_fops);
> -
> -	if (IS_ENABLED(CONFIG_BT_AOSPEXT))
> -		debugfs_create_file("aosp_capable", 0644, hdev->debugfs, data,
> -				    &aosp_capable_fops);
> +	vhci_create_debugfs(hdev);
> 
> 	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
> 
> @@ -364,6 +390,67 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> 	return 0;
> }
> 
> +static int __vhci_ext_create_device(struct vhci_data *data, __u8 dev_type,
> +								__u32 flags)
> +{
> +	struct hci_dev *hdev;
> +	struct sk_buff *skb;
> +	struct vhci_ext_create_device_resp *resp;
> +
> +	if (data->hdev)
> +		return -EBADFD;
> +
> +	if (dev_type != HCI_PRIMARY && dev_type != HCI_AMP)
> +		return -EINVAL;
> +
> +	skb = bt_skb_alloc(sizeof(*resp) + 1, GFP_KERNEL);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	hdev = hci_alloc_dev();
> +	if (!hdev) {
> +		kfree_skb(skb);
> +		return -ENOMEM;
> +	}
> +
> +	data->hdev = hdev;
> +
> +	hdev->bus = HCI_VIRTUAL;
> +	hdev->dev_type = dev_type;
> +	hci_set_drvdata(hdev, data);
> +
> +	vhci_setup_hdev(hdev);
> +
> +	/* Check quirks and set it for hdev */
> +	if (flags & VHCI_FLAG_QUIRK_EXTERNAL_CONFIG)
> +		set_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks);
> +
> +	if (flags & VHCI_FLAG_QUIRK_RAW_DEVICE)
> +		set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
> +
> +	if (flags & VHCI_FLAG_QUIRKS_INVALID_BDADDR)
> +		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
> +
> +	if (hci_register_dev(hdev) < 0) {
> +		BT_ERR("Can't register HCI device");
> +		hci_free_dev(hdev);
> +		data->hdev = NULL;
> +		kfree_skb(skb);
> +		return -EBUSY;
> +	}
> +
> +	vhci_create_debugfs(hdev);
> +
> +	hci_skb_pkt_type(skb) = HCI_VHCI_PKT;
> +	skb_put_u8(skb, HCI_VHCI_PKT);
> +	skb_put_u8(skb, dev_type);
> +	put_unaligned_le16(hdev->id, skb_put(skb, 2));
> +	skb_queue_tail(&data->readq, skb);
> +
> +	wake_up_interruptible(&data->read_wait);
> +	return 0;
> +}
> +
> static int vhci_create_device(struct vhci_data *data, __u8 opcode)
> {
> 	int err;
> @@ -375,6 +462,18 @@ static int vhci_create_device(struct vhci_data *data, __u8 opcode)
> 	return err;
> }
> 
> +static int vhci_ext_create_device(struct vhci_data *data, __u8 dev_type,
> +								__u32 flags)
> +{
> +	int err;
> +
> +	mutex_lock(&data->open_mutex);
> +	err = __vhci_ext_create_device(data, dev_type, flags);
> +	mutex_unlock(&data->open_mutex);
> +
> +	return err;
> +}
> +
> static inline ssize_t vhci_get_user(struct vhci_data *data,
> 				    struct iov_iter *from)
> {
> @@ -429,6 +528,24 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
> 		ret = vhci_create_device(data, opcode);
> 		break;
> 
> +	/* This packet type is for VHCI specific command */
> +	case HCI_VHCI_PKT:
> +		cancel_delayed_work_sync(&data->open_timeout);
> +		struct vhci_ext_create_device_req *req;
> +
> +		if (skb->len != sizeof(*req)) {
> +			kfree_skb(skb);
> +			return -EINVAL;
> +		}
> +
> +		req = (void *)skb->data;
> +		skb_pull(skb, sizeof(*req));
> +
> +		ret = vhci_ext_create_device(data, req->dev_type, req->flags);
> +
> +		kfree_skb(skb);
> +		break;
> +
> 	default:
> 		kfree_skb(skb);
> 		return -EINVAL;
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 63065bc01b76..35d720f9e17a 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -355,6 +355,7 @@ enum {
> #define HCI_EVENT_PKT		0x04
> #define HCI_ISODATA_PKT		0x05
> #define HCI_DIAG_PKT		0xf0
> +#define HCI_VHCI_PKT		0xfe
> #define HCI_VENDOR_PKT		0xff

that is the part that I don’t want to do in vhci. So in normal operation, only standard commands are supported. That is why there also is timeout when no 0xff is send in the beginning, then we fallback to a previous default device.

The 0xff is only briefly supported after opening the /dev/vhci and you can tell vhci what to create. I would like to keep it that way. And we should actually stay with that idea.

Now our problem is that we don’t have a “discover” / “read features” exchange so that we know what we can tell vhci to create. That would be generally useful and I totally ignored that portion when adding this extension.

My idea is not fully backed, but here goes what I have so far.

We use dev_type == 0x03 for request features. On current kernels it will return -EINVAL and we need to handle that in btvirt. Or we use bits 2-3 for ext_opcode. And then I would actually move over to providing the data via the same or similar structure used in virtio_bt.c.

As I said, this needs a bit of creative thinking to make this nice and easy and we don’t lock ourselves in again in the future.

Regards

Marcel


