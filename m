Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [PATCH v2 7/7] Bluetooth: btqcomsmd: Qualcomm WCNSS HCI driver
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1444423685-14717-8-git-send-email-bjorn.andersson@sonymobile.com>
Date: Fri, 9 Oct 2015 23:35:25 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Andy Gross <agross@codeaurora.org>,
	Fengwei Yin <fengwei.yin@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org
Message-Id: <5119BCF9-EE94-416C-AEFE-B375EF8617DF@holtmann.org>
References: <1444423685-14717-1-git-send-email-bjorn.andersson@sonymobile.com> <1444423685-14717-8-git-send-email-bjorn.andersson@sonymobile.com>
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bjorn,

> The Qualcomm WCNSS chip provides two SMD channels to the BT core; one
> for command and one for event packets. This driver exposes the two
> channels as a hci device.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---
> 
> Changes since v1:
> - With the introduction of qcom_smd_open_channel() the two drivers are now one
> - No more global state
> - Corrected memory management of sk_buffs
> - Reverted to __hci_cmd_sync_ev() for set_bdaddr
> - Renamed the driver to btqcomsmd
> - Split out the addition of HCI_SMD to separate patch
> 
> drivers/bluetooth/Kconfig     |  11 +++
> drivers/bluetooth/Makefile    |   1 +
> drivers/bluetooth/btqcomsmd.c | 198 ++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 210 insertions(+)
> create mode 100644 drivers/bluetooth/btqcomsmd.c
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 62999546a301..1652997e59cc 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -169,6 +169,17 @@ config BT_HCIUART_QCA
> 
> 	  Say Y here to compile support for QCA protocol.
> 
> +config BT_QCOMSMD
> +	tristate "Qualcomm SMD based HCI support"
> +	depends on QCOM_SMD
> +	help
> +	  Qualcomm SMD based HCI driver.
> +	  This driver is used to bridge HCI data onto the shared memory
> +	  channels to the WCNSS core.
> +
> +	  Say Y here to compile support for HCI over Qualcomm SMD into the
> +	  kernelor say M to compile as a module.
> +
> config BT_HCIBCM203X
> 	tristate "HCI BCM203x USB driver"
> 	depends on USB
> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index 07c9cf381e5a..19e313bf8c39 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_BT_WILINK)		+= btwilink.o
> obj-$(CONFIG_BT_BCM)		+= btbcm.o
> obj-$(CONFIG_BT_RTL)		+= btrtl.o
> obj-$(CONFIG_BT_QCA)		+= btqca.o
> +obj-$(CONFIG_BT_QCOMSMD)	+= btqcomsmd.o
> 
> btmrvl-y			:= btmrvl_main.o
> btmrvl-$(CONFIG_DEBUG_FS)	+= btmrvl_debugfs.o
> diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
> new file mode 100644
> index 000000000000..4b91c830531e
> --- /dev/null
> +++ b/drivers/bluetooth/btqcomsmd.c
> @@ -0,0 +1,198 @@
> +/*
> + * Copyright (c) 2015, Sony Mobile Communications Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/soc/qcom/smd.h>
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +#include <net/bluetooth/hci.h>
> +
> +#define EDL_NVM_ACCESS_SET_REQ_CMD	0x01
> +#define EDL_NVM_ACCESS_OPCODE		0xfc0b
> +
> +struct btqcomsmd {
> +	struct qcom_smd_channel *acl_channel;
> +	struct qcom_smd_channel *cmd_channel;
> +};
> +
> +static int btqcomsmd_recv(struct hci_dev *hdev,
> +			  unsigned type,
> +			  const void *data,
> +			  size_t count)

you are overdoing it here. Place as many parameters in one line as long as they are below 80 chars. Only then put them on the next line. One param per line is too much.

> +{
> +	struct sk_buff *skb;
> +	void *buf;
> +
> +	/* Use GFP_ATOMIC as we're in IRQ context */
> +	skb = bt_skb_alloc(count, GFP_ATOMIC);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	bt_cb(skb)->pkt_type = type;
> +
> +	/* Use io accessor as data might be ioremapped */
> +	buf = skb_put(skb, count);
> +	memcpy_fromio(buf, data, count);

memcpy_fromio(skb_put(skb, count), data, count);

Avoid the extra buf variable.

> +
> +	return hci_recv_frame(hdev, skb);
> +}
> +
> +static int btqcomsmd_acl_callback(struct qcom_smd_device *qsdev,
> +				  const void *data,
> +				  size_t count)
> +{
> +	struct hci_dev *hdev = dev_get_drvdata(&qsdev->dev);
> +
> +	return btqcomsmd_recv(hdev, HCI_ACLDATA_PKT, data, count);
> +}
> +
> +static int btqcomsmd_cmd_callback(struct qcom_smd_device *qsdev,
> +				  const void *data,
> +				  size_t count)
> +{
> +	struct hci_dev *hdev = dev_get_drvdata(&qsdev->dev);
> +
> +	return btqcomsmd_recv(hdev, HCI_EVENT_PKT, data, count);
> +}
> +
> +static int btqcomsmd_send(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	struct btqcomsmd *btq = hci_get_drvdata(hdev);
> +	int ret;
> +
> +	switch (bt_cb(skb)->pkt_type) {
> +	case HCI_ACLDATA_PKT:
> +	case HCI_SCODATA_PKT:
> +		ret = qcom_smd_send(btq->acl_channel, skb->data, skb->len);
> +		break;
> +	case HCI_COMMAND_PKT:
> +		ret = qcom_smd_send(btq->cmd_channel, skb->data, skb->len);
> +		break;

You need to update hdev->stat for each packet type.

> +	default:
> +		ret = -ENODEV;

Please use -EILSEQ here.

> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int btqcomsmd_open(struct hci_dev *hdev)
> +{
> +	set_bit(HCI_RUNNING, &hdev->flags);

You didn't look at bluetooth-next changes and the HCI_RUNNING is now handling in the core. You can turn open and close into empty functions.

> +	return 0;
> +}
> +
> +static int btqcomsmd_close(struct hci_dev *hdev)
> +{
> +	clear_bit(HCI_RUNNING, &hdev->flags);
> +	return 0;
> +}
> +
> +static int btqcomsmd_set_bdaddr(struct hci_dev *hdev,
> +			      const bdaddr_t *bdaddr)
> +{
> +	struct sk_buff *skb;
> +	u8 cmd[9];
> +	int err;
> +
> +	cmd[0] = EDL_NVM_ACCESS_SET_REQ_CMD;
> +	cmd[1] = 0x02;			/* TAG ID */
> +	cmd[2] = sizeof(bdaddr_t);	/* size */
> +	memcpy(cmd + 3, bdaddr, sizeof(bdaddr_t));
> +	skb = __hci_cmd_sync_ev(hdev,
> +				EDL_NVM_ACCESS_OPCODE,
> +				sizeof(cmd), cmd,
> +				HCI_VENDOR_PKT, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +		BT_ERR("%s: Change address command failed (%d)",
> +		       hdev->name, err);
> +		return err;
> +	}
> +
> +	kfree_skb(skb);
> +
> +	return 0;
> +}

I would actually prefer that you not copy the function here. And instead just #include "btqca.h" and just use qca_set_bdaddr_rome instead. Remember to add select BT_QCA to your Kconfig change.

> +
> +static int btqcomsmd_probe(struct qcom_smd_device *sdev)
> +{
> +	struct qcom_smd_channel *acl;
> +	struct btqcomsmd *btq;
> +	struct hci_dev *hdev;
> +	int ret;
> +
> +	acl = qcom_smd_open_channel(sdev,
> +				    "APPS_RIVA_BT_ACL",
> +				    btqcomsmd_acl_callback);

Same here. Do not overdo the splitting lines. If the second parameter fits into previous line, put it there.

> +	if (IS_ERR(acl))
> +		return PTR_ERR(acl);
> +
> +	btq = devm_kzalloc(&sdev->dev, sizeof(*btq), GFP_KERNEL);
> +	if (!btq)
> +		return -ENOMEM;
> +
> +	btq->acl_channel = acl;
> +	btq->cmd_channel = sdev->channel;
> +
> +	hdev = hci_alloc_dev();
> +	if (!hdev)
> +		return -ENOMEM;
> +
> +	hdev->bus = HCI_SMD;

I prefer if this looks like this:

	hdev->bus = HCI_SMD;
	hci_set_drvdata(dev, btq);

	btq->hdev = hdev;

	SET_HCIDEV_DEV(hdev, &sdev->dev);

The SET_HCIDEV_DEV is actually important so that it gets its right place in sysfs.

> +	hdev->open = btqcomsmd_open;
> +	hdev->close = btqcomsmd_close;
> +	hdev->send = btqcomsmd_send;
> +	hdev->set_bdaddr = btqcomsmd_set_bdaddr;
> +
> +	ret = hci_register_dev(hdev);
> +	if (ret < 0) {
> +		hci_free_dev(hdev);
> +		return ret;
> +	}
> +
> +	hci_set_drvdata(hdev, btq);
> +	dev_set_drvdata(&sdev->dev, hdev);

And here you just set drvdata of sdev to btq.

This is more in line how the other drivers are written. So it would be best if we keep them that way and not try to do too many things differently.

> +
> +	return 0;
> +}
> +
> +static void btqcomsmd_remove(struct qcom_smd_device *sdev)
> +{
> +	struct hci_dev *hdev = dev_get_drvdata(&sdev->dev);;
> +

I think you really want to do this here:

	dev_set_drvdata(&sdev, NULL);

The btsdio.c has most likely the most simple version of a remove function.

> +	hci_unregister_dev(hdev);
> +	hci_free_dev(hdev);
> +}
> +
> +static const struct qcom_smd_id btqcomsmd_match[] = {
> +	{ .name = "APPS_RIVA_BT_CMD" },
> +	{}
> +};
> +
> +static struct qcom_smd_driver btqcomsmd_cmd_driver = {
> +	.probe = btqcomsmd_probe,
> +	.remove = btqcomsmd_remove,
> +	.callback = btqcomsmd_cmd_callback,
> +	.smd_match_table = btqcomsmd_match,
> +	.driver  = {
> +		.name  = "btqcomsmd",
> +		.owner = THIS_MODULE,
> +	},
> +};
> +
> +module_qcom_smd_driver(btqcomsmd_cmd_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm SMD HCI driver");
> +MODULE_LICENSE("GPL v2");

Can we get MODULE_VERSION and MODULE_AUTHOR added here as well. See the other drivers on how we do the version thing. Start with 1.0 since it looks pretty simple. However it is nice to have that in case anybody ever needs to figure out which version we have here.

Regards

Marcel

