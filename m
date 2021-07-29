Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A045C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 19:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21CDB6056C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 19:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhG2TbN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 15:31:13 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:45472 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbhG2TbN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 15:31:13 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id D3E80CED1E;
        Thu, 29 Jul 2021 21:31:08 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v5 04/11] Bluetooth: btintel: Add btintel data struct
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210729183600.281586-5-hj.tedd.an@gmail.com>
Date:   Thu, 29 Jul 2021 21:31:08 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <A6DDD812-0F80-4A85-BDBD-4BEE9119B500@holtmann.org>
References: <20210729183600.281586-1-hj.tedd.an@gmail.com>
 <20210729183600.281586-5-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

> This patch adds a data structure for btintel for btintel object, and the
> definition of bootloder states.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/btintel.c |  8 ++++++++
> drivers/bluetooth/btintel.h | 15 +++++++++++++++
> drivers/bluetooth/btusb.c   |  6 ++++--
> 3 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index cfc097694b53..bf0ad05b80fe 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -1753,6 +1753,14 @@ int btintel_shutdown_combined(struct hci_dev *hdev)
> }
> EXPORT_SYMBOL_GPL(btintel_shutdown_combined);
> 
> +void btintel_set_flags(struct hci_dev *hdev, unsigned int flag)
> +{
> +	struct btintel_data *intel = hci_get_priv(hdev);
> +
> +	set_bit(flag, &intel->flags);
> +}
> +EXPORT_SYMBOL_GPL(btintel_set_flags);
> +
> MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
> MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
> MODULE_VERSION(VERSION);
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index 68ffa84fa87a..df7aa30142b4 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -138,6 +138,16 @@ struct intel_debug_features {
> #define INTEL_CNVX_TOP_STEP(cnvx_top)	(((cnvx_top) & 0x0f000000) >> 24)
> #define INTEL_CNVX_TOP_PACK_SWAB(t, s)	__swab16(((__u16)(((t) << 4) | (s))))
> 
> +#define INTEL_BOOTLOADER		0
> +#define INTEL_DOWNLOADING		1
> +#define INTEL_FIRMWARE_LOADED		2
> +#define INTEL_FIRMWARE_FAILED		3
> +#define INTEL_BOOTING			4
> +
> +struct btintel_data {
> +	unsigned long flags;

So I don’t know how many flags we have for this to matter. But maybe DECLARE_BITMAP(flags, __NUM); might be a good idea.

We also do things like #define hci_dev_set_flag(hdev, nr) set_bit((nr), (hdev)->dev_flags) and it looks like using a define is a better approach than a function.

#define btintel_set_flag(hdev, nr) do { \
	struct btintel_data *intel = hci_get_priv((hdev)); \
	set_bit(nr, &intel->flags); \
} while (0)

> +};
> +
> #if IS_ENABLED(CONFIG_BT_INTEL)
> 
> int btintel_check_bdaddr(struct hci_dev *hdev);
> @@ -167,6 +177,7 @@ int btintel_download_firmware(struct hci_dev *dev, struct intel_version *ver,
> 			      const struct firmware *fw, u32 *boot_param);
> int btintel_setup_combined(struct hci_dev *hdev);
> int btintel_shutdown_combined(struct hci_dev *hdev);
> +void btintel_set_flags(struct hci_dev *hdev, unsigned int flag);
> int btintel_download_firmware_newgen(struct hci_dev *hdev,
> 				     struct intel_version_tlv *ver,
> 				     const struct firmware *fw,
> @@ -295,6 +306,10 @@ static inline int btintel_shutdown_combined(struct hci_dev *hdev)
> 	return -EOPNOTSUPP;
> }
> 
> +static inline void btintel_set_flags(struct hci_dev *hdev, unsigned int flag)
> +{
> +}
> +
> static inline int btintel_download_firmware_newgen(struct hci_dev *hdev,
> 						   const struct firmware *fw,
> 						   u32 *boot_param,
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 42f7176a6c70..8c54ab03ee63 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4133,7 +4133,7 @@ static int btusb_probe(struct usb_interface *intf,
> 	struct btusb_data *data;
> 	struct hci_dev *hdev;
> 	unsigned ifnum_base;
> -	int i, err;
> +	int i, err, priv_size;
> 
> 	BT_DBG("intf %p id %p", intf, id);
> 
> @@ -4219,6 +4219,8 @@ static int btusb_probe(struct usb_interface *intf,
> 	init_usb_anchor(&data->ctrl_anchor);
> 	spin_lock_init(&data->rxlock);
> 
> +	priv_size = 0;
> +
> 	if (id->driver_info & BTUSB_INTEL_NEW) {
> 		data->recv_event = btusb_recv_event_intel;
> 		data->recv_bulk = btusb_recv_bulk_intel;
> @@ -4228,7 +4230,7 @@ static int btusb_probe(struct usb_interface *intf,
> 		data->recv_bulk = btusb_recv_bulk;
> 	}
> 

But your are not setting the size in case of BTUSB_INTEL_COMBINED.

> -	hdev = hci_alloc_dev();
> +	hdev = hci_alloc_dev_priv(priv_size);
> 	if (!hdev)
> 		return -ENOMEM;

Regards

Marcel

