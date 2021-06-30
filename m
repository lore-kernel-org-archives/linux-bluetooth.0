Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2B8C11F65
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jun 2021 20:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7504C6100B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jun 2021 20:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbhF3UPX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Jun 2021 16:15:23 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:54027 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhF3UPX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Jun 2021 16:15:23 -0400
Received: from smtpclient.apple (tmo-122-159.customers.d1-online.com [80.187.122.159])
        by mail.holtmann.org (Postfix) with ESMTPSA id 68983CED24;
        Wed, 30 Jun 2021 22:12:51 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v3 1/1] Bluetooth: btusb: Record debug log for Mediatek
 Chip.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210629190934.11710-1-mark-yw.chen@mediatek.com>
Date:   Wed, 30 Jun 2021 22:12:48 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, chris.lu@mediatek.com,
        will-cy.lee@mediatek.com, Sean Wang <sean.wang@mediatek.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        michaelfsun@google.com, shawnku@google.com, jemele@google.com,
        apusaka@google.com
Content-Transfer-Encoding: 8BIT
Message-Id: <54B58ECB-2931-4020-BE22-0DCEFD1F1ABA@holtmann.org>
References: <20210629190934.11710-1-mark-yw.chen@mediatek.com>
To:     Mark-YW.Chen@mediatek.com
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mark,

> Mediatek Bluetooth Controller send the fw log via EP2, this patch
> create callback(data->recv_acl) for processing acl packet.
> 
> 1. create callback(data->recv_acl) for processing acl packet.
> 2. Add btusb_recv_acl_mtk to dispatch acl packet.
> 3. Send mediatek debug log and coredump via hci_recv_diag channel.
> 4. The upper layerd can use hci_channel_minitor to receive
>   these packets.

can you be more specific in what the logs do. I think the changes are easy to understand. I rather have an example btmon from this or more details on what is in these traces. Or even how they can be enabled etc.

> 
> Signed-off-by: mark-yw.chen <mark-yw.chen@mediatek.com>
> ---
> drivers/bluetooth/btusb.c | 37 ++++++++++++++++++++++++++++++++++++-
> 1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index b015dcecfb13..cabf6eba2d95 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -569,6 +569,7 @@ struct btusb_data {
> 	int suspend_count;
> 
> 	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
> +	int (*recv_acl)(struct hci_dev *hdev, struct sk_buff *skb);
> 	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
> 
> 	int (*setup_on_usb)(struct hci_dev *hdev);
> @@ -776,7 +777,7 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
> 
> 		if (!hci_skb_expect(skb)) {
> 			/* Complete frame */
> -			hci_recv_frame(data->hdev, skb);
> +			data->recv_acl(data->hdev, skb);
> 			skb = NULL;
> 		}
> 	}
> @@ -3075,6 +3076,10 @@ static int btusb_shutdown_intel_new(struct hci_dev *hdev)
> 	return 0;
> }
> 
> +#define MTK_FW_DUMP	0xfc6f
> +#define MTK_FW_LOG_1	0x05ff
> +#define MTK_FW_LOG_2	0x05fe
> +
> #define FIRMWARE_MT7663		"mediatek/mt7663pr2h.bin"
> #define FIRMWARE_MT7668		"mediatek/mt7668pr2h.bin"
> 
> @@ -3851,6 +3856,33 @@ static int btusb_mtk_shutdown(struct hci_dev *hdev)
> 	return 0;
> }
> 
> +static int btusb_recv_acl_mtk(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	struct btusb_data *data = hci_get_drvdata(hdev);
> +	int err;
> +	u16 handle = le16_to_cpu(hci_acl_hdr(skb)->handle);
> +
> +	switch (handle) {
> +	case MTK_FW_DUMP:
> +		/* It's MediaTek firmware dump from device. When the firmware
> +		 * hang, the device can't be suspend successfully.
> +		 */
> +		usb_disable_autosuspend(data->udev);
> +		err = hci_recv_diag(data->hdev, skb);
> +		break;
> +	case MTK_FW_LOG_1:
> +	case MTK_FW_LOG_2:
> +		/* It's MediaTek fw debug log */
> +		err = hci_recv_diag(data->hdev, skb);
> +		break;
> +	default:
> +		err = hci_recv_frame(data->hdev, skb);
> +		break;
> +	}
> +
> +	return err;


	switch (handle) {
	case 0xfc6f:		/* Firmware dump from device */
		/* When the firmware hangs, the device can no longer
		 * suspend and thus disable auto-suspend.
		 */
		usb_disable_autosuspend(data->udev);
		/* fall through */

	case 0x05ff:		/* Firmware debug logging 1 */
	case 0x05fe:		/* Firmware debug logging 2 */
		return hci_recv_diag(data->hdev, skb);
	}

	return hci_recv_frame(data->hdev, skb);
}

> +}
> +
> MODULE_FIRMWARE(FIRMWARE_MT7663);
> MODULE_FIRMWARE(FIRMWARE_MT7668);
> 
> @@ -4543,6 +4575,8 @@ static int btusb_probe(struct usb_interface *intf,
> 		data->recv_bulk = btusb_recv_bulk;
> 	}
> 
> +	data->recv_acl = hci_recv_frame;
> +
> 	hdev = hci_alloc_dev();
> 	if (!hdev)
> 		return -ENOMEM;
> @@ -4669,6 +4703,7 @@ static int btusb_probe(struct usb_interface *intf,
> 		hdev->setup = btusb_mtk_setup;
> 		hdev->shutdown = btusb_mtk_shutdown;
> 		hdev->manufacturer = 70;
> +		data->recv_acl = btusb_recv_acl_mtk;
> 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);

Move this change after the quirk setting since it is local to btusb and not the hdev.

> 	}

Regards

Marcel

