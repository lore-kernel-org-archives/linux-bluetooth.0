Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46431C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 08:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2261260F70
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 08:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhKBIdu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Nov 2021 04:33:50 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:35665 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKBIds (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Nov 2021 04:33:48 -0400
Received: from smtpclient.apple (p4fefc15c.dip0.t-ipconnect.de [79.239.193.92])
        by mail.holtmann.org (Postfix) with ESMTPSA id 38E60CECEA;
        Tue,  2 Nov 2021 09:31:13 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [RFC PATCH V2] Bluetooth: vhci: Add support extended opcode for
 HCI Vendor packet
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211102025623.826277-1-hj.tedd.an@gmail.com>
Date:   Tue, 2 Nov 2021 09:31:12 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <F77C7BC5-4C6E-439F-8FEC-209E54F7BAAC@holtmann.org>
References: <20211102025623.826277-1-hj.tedd.an@gmail.com>
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
> THis patch adds new opcode(0x03) for HCI Vendor packet for VHCI for
> extended device creation. This new opcode will not conflict with
> existing legacy opcode because the legacy expects to set either bit 0 or
> bit 1, but not both of bits.
> 
> It aslo requires new extra parameters for device type and flags to apply
> to the VHCI device.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/hci_vhci.c | 65 ++++++++++++++++++++++++++++++++----
> 1 file changed, 58 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index 49ac884d996e..5fccab136543 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -30,6 +30,16 @@
> 
> static bool amp;
> 
> +#define VHCI_EXT_OPCODE				0x03
> +struct vhci_ext_config {
> +	__u8  dev_type;
> +	__u32 flags;
> +} __packed;
> +
> +#define VHCI_FLAG_QUIRK_RAW_DEVICE		0x01
> +#define VHCI_FLAG_QUIRK_EXTERNAL_CONFIG		0x02
> +#define VHCI_FLAG_QUIRKS_INVALID_BDADDR		0x04
> +
> struct vhci_data {
> 	struct hci_dev *hdev;
> 
> @@ -278,7 +288,8 @@ static int vhci_setup(struct hci_dev *hdev)
> 	return 0;
> }
> 
> -static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> +static int __vhci_create_device(struct vhci_data *data, __u8 opcode,
> +				struct vhci_ext_config *ext_config)
> {
> 	struct hci_dev *hdev;
> 	struct sk_buff *skb;
> @@ -287,8 +298,20 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> 	if (data->hdev)
> 		return -EBADFD;
> 
> -	/* bits 0-1 are dev_type (Primary or AMP) */
> -	dev_type = opcode & 0x03;
> +	/* In case of legacy opcode, it doesn't allow to have 0x03 as an opcode,
> +	 * So, it is ok to assume that device is in the extended device
> +	 * creation mode when the opcode is 0x03. Also, it is required to have
> +	 * a ext_config and check it here.
> +	 */
> +	if (ext_config && opcode != VHCI_EXT_OPCODE)
> +		return -EINVAL;
> +
> +	if (opcode == VHCI_EXT_OPCODE)
> +		dev_type = ext_config->dev_type;
> +	else {
> +		/* bits 0-1 are dev_type (Primary or AMP) */
> +		dev_type = opcode & 0x03;
> +	}
> 
> 	if (dev_type != HCI_PRIMARY && dev_type != HCI_AMP)
> 		return -EINVAL;
> @@ -331,6 +354,16 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> 	if (opcode & 0x80)
> 		set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
> 
> +	/* Flags for extended configuration */
> +	if (ext_config && opcode == VHCI_EXT_OPCODE) {
> +		if (ext_config->flags & VHCI_FLAG_QUIRK_EXTERNAL_CONFIG)
> +			set_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks);
> +		if (ext_config->flags & VHCI_FLAG_QUIRK_RAW_DEVICE)
> +			set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
> +		if (ext_config->flags & VHCI_FLAG_QUIRKS_INVALID_BDADDR)
> +			set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
> +	}
> +
> 	if (hci_register_dev(hdev) < 0) {
> 		BT_ERR("Can't register HCI device");
> 		hci_free_dev(hdev);
> @@ -364,12 +397,13 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> 	return 0;
> }
> 
> -static int vhci_create_device(struct vhci_data *data, __u8 opcode)
> +static int vhci_create_device(struct vhci_data *data, __u8 opcode,
> +			      struct vhci_ext_config *ext_config)
> {
> 	int err;
> 
> 	mutex_lock(&data->open_mutex);
> -	err = __vhci_create_device(data, opcode);
> +	err = __vhci_create_device(data, opcode, ext_config);
> 	mutex_unlock(&data->open_mutex);
> 
> 	return err;
> @@ -379,6 +413,7 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
> 				    struct iov_iter *from)
> {
> 	size_t len = iov_iter_count(from);
> +	struct vhci_ext_config *ext_config;
> 	struct sk_buff *skb;
> 	__u8 pkt_type, opcode;
> 	int ret;
> @@ -419,6 +454,21 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
> 		opcode = *((__u8 *) skb->data);
> 		skb_pull(skb, 1);
> 
> +		/* This opcode(0x03) is for extended device creation and it
> +		 * requires the extra parameters for extra configuration.
> +		 */
> +		if (opcode == 0x03) {
> +			if (skb->len != sizeof(*ext_config)) {
> +				kfree_skb(skb);
> +				return -EINVAL;
> +			}
> +
> +			ext_config = (void *) (skb->data);
> +			ret = vhci_create_device(data, opcode, ext_config);
> +			kfree_skb(skb);
> +			goto done;
> +		}
> +
> 		if (skb->len > 0) {
> 			kfree_skb(skb);
> 			return -EINVAL;
> @@ -426,7 +476,7 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
> 
> 		kfree_skb(skb);
> 
> -		ret = vhci_create_device(data, opcode);
> +		ret = vhci_create_device(data, opcode, NULL);
> 		break;
> 
> 	default:
> @@ -434,6 +484,7 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
> 		return -EINVAL;
> 	}
> 
> +done:
> 	return (ret < 0) ? ret : len;
> }
> 
> @@ -526,7 +577,7 @@ static void vhci_open_timeout(struct work_struct *work)
> 	struct vhci_data *data = container_of(work, struct vhci_data,
> 					      open_timeout.work);
> 
> -	vhci_create_device(data, amp ? HCI_AMP : HCI_PRIMARY);
> +	vhci_create_device(data, amp ? HCI_AMP : HCI_PRIMARY, NULL);
> }

I think this is a bit convoluted in the end.

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 49ac884d996e..ce33ed63d021 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -419,14 +419,22 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
                opcode = *((__u8 *) skb->data);
                skb_pull(skb, 1);
 
-               if (skb->len > 0) {
-                       kfree_skb(skb);
-                       return -EINVAL;
+               /* The dev_type 3 is used as an escape opcode for extension
+                * handling. If dev_type is set to 3 all other bits must be
+                * set to zero.
+                */
+               if (opcode == 0x03) {
+                       if (skb->len < 1)
+                               ret = -EINVAL;
+                       else
+                               ret = vhci_create_extended_device(data, skb);
+               } else {
+                       if (skb->len > 0)
+                               ret = -EINVAL;
+                       else
+                               ret = vhci_create_device(data, opcode);
                }
-
                kfree_skb(skb);
-
-               ret = vhci_create_device(data, opcode);
                break;
 
I don’t fully like the nesting yet, but I would do it something like that.

Main point is that we keep the old way as it is and create a new clean path since otherwise the code becomes really hard to follow if you have to look at it in a few month.

I would also just include virtio_bt.h since that is actually an UAPI header and shared with userspace properly. I currently made extension struct just >= 1 and that might be good enough. We can check what the flags size is in virtio space. Otherwise we might just to a flexible flags array after 0x03 opcode.

Something that Bluetooth uses for EIR/AD flags data type. So you have {opcode}, {flag_len}, {flags}[0..n], {bt_config} as your structure. That means the default is then 0x03, 0x00, 0x00 packet to be sent. And if you want to enable AOSP, you send 0x03, 0x01, 0x04, 0x00.

Regards

Marcel

