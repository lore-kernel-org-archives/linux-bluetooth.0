Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 7/7] Bluetooth: btqcomsmd: Qualcomm WCNSS HCI driver
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>,
 Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
 <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
 Andy Gross <agross@codeaurora.org>
References: <1444423685-14717-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1444423685-14717-8-git-send-email-bjorn.andersson@sonymobile.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org
From: yfw <fengwei.yin@linaro.org>
Message-ID: <561E7067.2070007@linaro.org>
Date: Wed, 14 Oct 2015 23:10:31 +0800
MIME-Version: 1.0
In-Reply-To: <1444423685-14717-8-git-send-email-bjorn.andersson@sonymobile.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>



On 2015/10/10 4:48, Bjorn Andersson wrote:
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
>   drivers/bluetooth/Kconfig     |  11 +++
>   drivers/bluetooth/Makefile    |   1 +
>   drivers/bluetooth/btqcomsmd.c | 198 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 210 insertions(+)
>   create mode 100644 drivers/bluetooth/btqcomsmd.c
>
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 62999546a301..1652997e59cc 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -169,6 +169,17 @@ config BT_HCIUART_QCA
>
>   	  Say Y here to compile support for QCA protocol.
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
>   config BT_HCIBCM203X
>   	tristate "HCI BCM203x USB driver"
>   	depends on USB
> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index 07c9cf381e5a..19e313bf8c39 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_BT_WILINK)		+= btwilink.o
>   obj-$(CONFIG_BT_BCM)		+= btbcm.o
>   obj-$(CONFIG_BT_RTL)		+= btrtl.o
>   obj-$(CONFIG_BT_QCA)		+= btqca.o
> +obj-$(CONFIG_BT_QCOMSMD)	+= btqcomsmd.o
>
>   btmrvl-y			:= btmrvl_main.o
>   btmrvl-$(CONFIG_DEBUG_FS)	+= btmrvl_debugfs.o
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
> +	default:
> +		ret = -ENODEV;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int btqcomsmd_open(struct hci_dev *hdev)
> +{
> +	set_bit(HCI_RUNNING, &hdev->flags);
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
> +	if (IS_ERR(acl))
> +		return PTR_ERR(acl);
Do we need to close acl channel in following failure path and
btqcomsmd_remove?

Regards
Yin, Fengwei

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
> +
> +	return 0;
> +}
> +
> +static void btqcomsmd_remove(struct qcom_smd_device *sdev)
> +{
> +	struct hci_dev *hdev = dev_get_drvdata(&sdev->dev);;
> +
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
>
