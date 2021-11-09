Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E30C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 09:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DC5961177
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 09:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244960AbhKIJiL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Nov 2021 04:38:11 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:47617 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244931AbhKIJiH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Nov 2021 04:38:07 -0500
Received: from smtpclient.apple (p4fefc15c.dip0.t-ipconnect.de [79.239.193.92])
        by mail.holtmann.org (Postfix) with ESMTPSA id BD971CED1E;
        Tue,  9 Nov 2021 10:35:20 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [RFC PATCH V5] Bluetooth: vhci: Add support creating extended
 device mode
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211109031343.87728-1-hj.tedd.an@gmail.com>
Date:   Tue, 9 Nov 2021 10:35:20 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <FFABFC0E-7ED7-417D-9AEF-DDD9D09FF77D@holtmann.org>
References: <20211109031343.87728-1-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

> This patch adds new opcode(0x03) for HCI Vendor packet to support
> creating extended device mode. In order to avoid the conflict with the
> legacy opcode, it has to be 0x03 only and all other bits must be set to
> zero.
> 
> Then, it is followed by the extended configuration data that contains
> the device type and the flags to be used.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/hci_vhci.c | 200 ++++++++++++++++++++++++++++-------
> 1 file changed, 162 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index 49ac884d996e..4c0cfb29c0e8 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -30,6 +30,24 @@
> 
> static bool amp;
> 
> +/* This is the struct for extended device configuration.
> + * The opcode 0x03 is used for creating an extended device and followed by
> + * the configuration data below.
> + * dev_type is Primay or AMP.
> + * flag_len is the length of flag array
> + * flag array contains the flag to use/set while creating the device.
> + */
> +struct vhci_ext_config {
> +	__u8	dev_type;
> +	__u8	flag_len;
> +	__u8	flags[0];
> +};
> +
> +#define VHCI_EXT_FLAG_ENABLE_AOSP		0x01
> +#define VHCI_EXT_FLAG_QUIRK_RAW_DEVICE		0x02
> +#define VHCI_EXT_FLAG_QUIARK_EXTERNAL_CONFIG	0x03
> +#define VHCI_EXT_FLAG_QUIRK_INVALID_BDADDR	0x04

QUIARK ;)

> +
> struct vhci_data {
> 	struct hci_dev *hdev;
> 
> @@ -278,11 +296,52 @@ static int vhci_setup(struct hci_dev *hdev)
> 	return 0;
> }
> 
> +static int vhci_register_hdev(struct hci_dev *hdev, __u8 opcode)
> +{
> +	struct vhci_data *data = hci_get_drvdata(hdev);
> +	struct sk_buff *skb;
> +
> +	skb = bt_skb_alloc(4, GFP_KERNEL);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	if (hci_register_dev(hdev) < 0) {
> +		BT_ERR("Can't register HCI device");
> +		kfree_skb(skb);
> +		return -EBUSY;
> +	}
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
> +
> +	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
> +
> +	skb_put_u8(skb, 0xff);
> +	skb_put_u8(skb, opcode);
> +	put_unaligned_le16(hdev->id, skb_put(skb, 2));
> +	skb_queue_tail(&data->readq, skb);
> +
> +	wake_up_interruptible(&data->read_wait);
> +
> +	return 0;
> +}
> +

I don’t think it is the best idea to generalize this. I have the feeling we need to discuss the return packet and format as well. So in the initial patch, I would not much mess with existing code. We can optimize that once we have a good handle on this. Especially since this makes the review more complicated.

That said, I was also keeping in mind something Luiz and I discussed a while back that we might want to use the 0xff channel (or some other defined channel) for extra protocols running between hci_vhci and btvirt.

> static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> {
> 	struct hci_dev *hdev;
> -	struct sk_buff *skb;
> 	__u8 dev_type;
> +	int ret;
> 
> 	if (data->hdev)
> 		return -EBADFD;
> @@ -297,15 +356,9 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> 	if (opcode & 0x3c)
> 		return -EINVAL;
> 
> -	skb = bt_skb_alloc(4, GFP_KERNEL);
> -	if (!skb)
> -		return -ENOMEM;
> -
> 	hdev = hci_alloc_dev();
> -	if (!hdev) {
> -		kfree_skb(skb);
> +	if (!hdev)
> 		return -ENOMEM;
> -	}
> 
> 	data->hdev = hdev;
> 
> @@ -331,45 +384,108 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> 	if (opcode & 0x80)
> 		set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
> 
> -	if (hci_register_dev(hdev) < 0) {
> -		BT_ERR("Can't register HCI device");
> +	/* Legacy method returns opcode instead of dev type */
> +	ret = vhci_register_hdev(hdev, opcode);
> +	if (ret < 0) {
> 		hci_free_dev(hdev);
> 		data->hdev = NULL;
> -		kfree_skb(skb);
> -		return -EBUSY;
> 	}
> 
> -	debugfs_create_file("force_suspend", 0644, hdev->debugfs, data,
> -			    &force_suspend_fops);
> +	return ret;
> +}
> 
> -	debugfs_create_file("force_wakeup", 0644, hdev->debugfs, data,
> -			    &force_wakeup_fops);
> +static int vhci_create_device(struct vhci_data *data, __u8 opcode)
> +{
> +	int err;
> 
> -	if (IS_ENABLED(CONFIG_BT_MSFTEXT))
> -		debugfs_create_file("msft_opcode", 0644, hdev->debugfs, data,
> -				    &msft_opcode_fops);
> +	mutex_lock(&data->open_mutex);
> +	err = __vhci_create_device(data, opcode);
> +	mutex_unlock(&data->open_mutex);
> 
> -	if (IS_ENABLED(CONFIG_BT_AOSPEXT))
> -		debugfs_create_file("aosp_capable", 0644, hdev->debugfs, data,
> -				    &aosp_capable_fops);
> +	return err;
> +}
> 
> -	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
> +static int __vhci_create_extended_device(struct vhci_data *data,
> +							struct sk_buff *skb)
> +{
> +	struct hci_dev *hdev;
> +	struct vhci_ext_config *config;
> +	int i, ret;
> +	__u8 flag;
> 
> -	skb_put_u8(skb, 0xff);
> -	skb_put_u8(skb, opcode);
> -	put_unaligned_le16(hdev->id, skb_put(skb, 2));
> -	skb_queue_tail(&data->readq, skb);
> +	if (data->hdev)
> +		return -EBADFD;
> 
> -	wake_up_interruptible(&data->read_wait);
> -	return 0;
> +	/* Make sure the skb has a minimum valid length */
> +	if (skb->len < sizeof(*config))
> +		return -EINVAL;
> +
> +	config = (void *)(skb->data);
> +	if (skb->len < sizeof(*config) + config->flag_len)
> +		return -EINVAL;
> +
> +	if (config->dev_type != HCI_PRIMARY && config->dev_type != HCI_AMP)
> +		return -EINVAL;
> +
> +	hdev = hci_alloc_dev();
> +	if (!hdev)
> +		return -ENOMEM;
> +
> +	data->hdev = hdev;
> +
> +	hdev->bus = HCI_VIRTUAL;
> +	hdev->dev_type = config->dev_type;
> +	hci_set_drvdata(hdev, data);
> +
> +	hdev->open  = vhci_open_dev;
> +	hdev->close = vhci_close_dev;
> +	hdev->flush = vhci_flush;
> +	hdev->send  = vhci_send_frame;
> +	hdev->get_data_path_id = vhci_get_data_path_id;
> +	hdev->get_codec_config_data = vhci_get_codec_config_data;
> +	hdev->wakeup = vhci_wakeup;
> +	hdev->setup = vhci_setup;
> +	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
> +
> +	for (i = 0; i < config->flag_len; i++) {
> +		flag = config->flags[i];
> +		switch (flag) {
> +		case VHCI_EXT_FLAG_ENABLE_AOSP:
> +			data->aosp_capable = 1;
> +			break;
> +		case VHCI_EXT_FLAG_QUIRK_RAW_DEVICE:
> +			set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
> +			break;
> +		case VHCI_EXT_FLAG_QUIARK_EXTERNAL_CONFIG:
> +			set_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks);
> +			break;
> +		case VHCI_EXT_FLAG_QUIRK_INVALID_BDADDR:
> +			set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
> +			break;
> +		default:
> +			BT_ERR("Invalid flag");
> +			hci_free_dev(hdev);
> +			data->hdev = NULL;
> +			return -EINVAL;
> +		}
> +	}

So this part, I think you misunderstood me.

struct virtio_bt_config {
	__u8  type;
	__u16 vendor;
	__u16 msft_opcode;
} __attribute__((packed));

This part above is a flexible struct. I can be extended over time. However the validity of fields are defined by flags.

/* Feature bits */
#define VIRTIO_BT_F_VND_HCI	0	/* Indicates vendor command support */
#define VIRTIO_BT_F_MSFT_EXT	1	/* Indicates MSFT vendor support */
#define VIRTIO_BT_F_AOSP_EXT	2	/* Indicates AOSP vendor support */

These feature bits need to have its space. If we want more features, then we should add them here and also enable in virtio_bt.

With that in mind, scrap EXTERNAL_CONFIG and RAW_DEVICE since that you can do via existing legacy mode. And also they make no real sense. The raw device part is really legacy that I rather completely remove. We have User Channel these days and that is a lot better. The external config is something we haven’t used at all and so keep it in the legacy realm.

For the invalid bd_addr quirk, I need to consider if it is better to say 00:00:.. address is concluded as invalid or we allow providing a magic invalid address to match against or just a flag as above. The problem is also that we need to define the vendor opcode that is used to set the public address. Otherwise such a flag is useless.

Regards

Marcel

