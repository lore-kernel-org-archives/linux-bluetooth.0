Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672E9236ECF;
	Tue, 14 Jan 2025 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736857998; cv=none; b=XwwnnwVzvtZ5+gJdEHnyQA95ZzUM1uUIbYcYZyrCbaDn0chVJburHEpouZP//1XVB+6w7e7htEHbC2ido/ztiCLua890Q2LCu3bOcb7gkrR3l4vTisb+4iXAoS36yXB6cZw0P5W7Q/fsPkVqF7betGXeLmk7v2syif514pLQPik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736857998; c=relaxed/simple;
	bh=nKZ7Tzh2kE1EilNO0rSGPVVS/9powO0rh8EVS8ij+94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePiWDeVJyWDsVS9gV/Jz52HWd+YtQ7FF7LgzMyswi4BBF/ZIKtqZT5RKaPHZ6zeTRVPDvCwzBfbnnLxbb/IbD16zxlOrq0v2qR4vxDg/qx8z9y2j+nAy2T71Ffc0xWjQxlqhsOELMl1B8WfUO+yFJ+1SNQouA0RWhO44N24S49I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUlYpyTT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUlYpyTT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A5CC4CEDD;
	Tue, 14 Jan 2025 12:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736857997;
	bh=nKZ7Tzh2kE1EilNO0rSGPVVS/9powO0rh8EVS8ij+94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hUlYpyTTiwzR/2cSmDRy7/EncwStQX1a7e8cIzDoWdGPqHscgd6GOtjGD+OnhP9Up
	 r+UjbpSemraMewyAq+tGUDoylfKDy3HB+9GVIRFhRtWEwYqBTipLwI32u5SK0Jxoew
	 qefHS1/xssloAUaRDuw//a5Ex3BqBNhK7w/0xzlfGJQT7xNsG7W32+YfOQlPQPmsmU
	 cxzuj2Bw1ULLQZRY2gNxcsIVZ/D+ij5t6gRMPHlWy9S6R2a6bajv+93ICvnfD+yazh
	 qVCQssXUz+gEIHSHjzKMGEX4bItIDAQo/XILw7hO2FtsgscGo6Glpdjqban8Wkm0xS
	 LNew02iac8SXg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tXg6i-000000003IN-08JE;
	Tue, 14 Jan 2025 13:33:20 +0100
Date: Tue, 14 Jan 2025 13:33:20 +0100
From: Johan Hovold <johan@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, pmenzel@molgen.mpg.de,
	jirislaby@kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>,
	tomi.valkeinen@ideasonboard.com,
	=?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@gmail.com>,
	robh@kernel.org, hns@goldelico.com
Subject: Re: [PATCH v4 3/4] gnss: Add driver for AI2 protocol
Message-ID: <Z4ZZkNyANEOUxaUD@hovoldconsulting.com>
References: <20240606183032.684481-1-andreas@kemnade.info>
 <20240606183032.684481-4-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606183032.684481-4-andreas@kemnade.info>

On Thu, Jun 06, 2024 at 08:30:31PM +0200, Andreas Kemnade wrote:
> Add a driver for the Air Independent Interface protocol used by some TI
> Wilink combo chips. Per default, send out just NMEA to userspace and turn
> on/off things at open()/close() but keep the door open for any
> sophisticated development regarding the AI2 protocol by having a kernel
> parameter to turn it into raw mode (ai2raw) resembling /dev/tigps provided
> by some TI vendor kernels.
> The fork used by the BT200 is at:
> http://epsonservice.goepson.com/downloads/VI-APS/BT200_kernel.tgz

Please amend with more details about the protocol. As I mentioned, I'm
not keen adding module parameters for this.

Do you have any pointers regarding the protocol? My searching seems to
come up with very little, hardly even a mention of what AI2 stands for.

Is it a TI protocol, or could it end up being used by other vendors?

Some comments based on a quick look below.

> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/gnss/Kconfig  |  13 ++
>  drivers/gnss/Makefile |   3 +
>  drivers/gnss/ai2.c    | 528 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 544 insertions(+)
>  create mode 100644 drivers/gnss/ai2.c
> 
> diff --git a/drivers/gnss/Kconfig b/drivers/gnss/Kconfig
> index d7fe265c28696..95fdab6e7ae94 100644
> --- a/drivers/gnss/Kconfig
> +++ b/drivers/gnss/Kconfig
> @@ -65,4 +65,17 @@ config GNSS_USB
>  
>  	  If unsure, say N.
>  
> +config GNSS_AI2

Please keep the entries sorted.

> +	tristate "TI AI2 procotol support"
> +	depends on BT_HCIUART_LL
> +	help
> +	  Say Y here if you have a Texas Instruments Wilink combo chip
> +	  containing among other things a GNSS receiver speaking the
> +	  Air Independent Interface (AI2) protocol.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called gnss-ai2.
> +
> +	  If unsure, say N.
> +
>  endif # GNSS
> diff --git a/drivers/gnss/Makefile b/drivers/gnss/Makefile
> index bb2cbada34359..bf6fefcb2e823 100644
> --- a/drivers/gnss/Makefile
> +++ b/drivers/gnss/Makefile
> @@ -20,3 +20,6 @@ gnss-ubx-y := ubx.o
>  
>  obj-$(CONFIG_GNSS_USB)			+= gnss-usb.o
>  gnss-usb-y := usb.o
> +
> +obj-$(CONFIG_GNSS_AI2)			+= gnss-ai2.o
> +gnss-ai2-y := ai2.o

Same here.

> diff --git a/drivers/gnss/ai2.c b/drivers/gnss/ai2.c
> new file mode 100644
> index 0000000000000..930c065050917
> --- /dev/null
> +++ b/drivers/gnss/ai2.c
> @@ -0,0 +1,528 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Texas Instruments AI2 (Air independent interface) protocol device driver
> + * Used for some TI WLAN/Bluetooth/GNSS combo chips.
> + *
> + * Copyright (C) 2024 Andreas Kemnade <andreas@kemnade.info>
> + */
> +#include <asm/byteorder.h>
> +#include <linux/errno.h>
> +#include <linux/gnss.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/ti_wilink_st.h>
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>

Without a vendor channel abstraction provided by Bluetooth core, I'm
sceptical about included Bluetooth headers here. A driver specific
interface should do.

> +
> +/* Channel-9 details for GPS */
> +#define GPS_CH9_PKT_NUMBER		0x9
> +#define GPS_CH9_OP_WRITE		0x1
> +#define GPS_CH9_OP_READ			0x2
> +#define GPS_CH9_OP_COMPLETED_EVT	0x3
> +
> +/* arbitarily chosen, should fit everything seen in the past */
> +#define MAX_AI2_FRAME_SIZE 2048
> +
> +#define AI2_ESCAPE 0x10 /* if sent as data, it is doubled */
> +#define AI2_END_MARKER 0x3
> +#define AI2_ACK 0x2
> +
> +/* reports */
> +#define AI2_REPORT_NMEA 0xd3
> +
> +#define NMEA_HEADER_LEN 4
> +
> +/* commands */
> +#define AI2_CMD_RECEIVER_STATE 2
> +
> +#define RECEIVER_STATE_OFF 1
> +#define RECEIVER_STATE_IDLE 2
> +#define RECEIVER_STATE_ON 3
> +
> +#define AI2_CMD_CONFIG_NMEA 0xe5
> +#define NMEA_MASK_GGA (1 << 0)
> +#define NMEA_MASK_GLL (1 << 1)
> +#define NMEA_MASK_GSA (1 << 2)
> +#define NMEA_MASK_GSV (1 << 3)
> +#define NMEA_MASK_RMC (1 << 4)
> +#define NMEA_MASK_VTG (1 << 5)

Please try to align the values above using tabs.

> +
> +#define NMEA_MASK_ALL (NMEA_MASK_GGA | \
> +		NMEA_MASK_GLL | \
> +		NMEA_MASK_GSA | \
> +		NMEA_MASK_GSV | \
> +		NMEA_MASK_RMC | \
> +		NMEA_MASK_VTG)
> +
> +
> +static bool ai2raw;
> +
> +struct ai2_device {
> +	struct mutex gdev_mutex;
> +	bool gdev_open;
> +	struct gnss_device *gdev;
> +	struct device *dev;
> +	struct sk_buff *recv_skb;
> +	bool recv_esc;
> +};
> +
> +static struct sk_buff *ai2_skb_alloc(unsigned int len, gfp_t how)

s/how/flags/

> +{
> +	struct sk_buff *skb;
> +
> +	skb = bt_skb_alloc(len + sizeof(struct gps_event_hdr), how);
> +	if (skb)
> +		skb_reserve(skb, sizeof(struct gps_event_hdr));
> +
> +	return skb;
> +}
> +
> +static int ai2_send_frame(struct ai2_device *ai2dev,
> +			  struct sk_buff *skb)
> +{
> +	int len;
> +	struct gps_event_hdr *gnssdrv_hdr;
> +	struct hci_dev *hdev;
> +
> +	if (skb->len >= U16_MAX)
> +		return -EINVAL;
> +
> +	/*
> +	 * note: fragmentation at this point not handled yet
> +	 * not needed for simple config commands
> +	 */

What's the implication of this? Isn't the length under the control of
user space here?

> +	len = skb->len;
> +	gnssdrv_hdr = skb_push(skb, sizeof(struct gps_event_hdr));
> +	gnssdrv_hdr->opcode = GPS_CH9_OP_WRITE;
> +	gnssdrv_hdr->plen = __cpu_to_le16(len);
> +
> +	hci_skb_pkt_type(skb) = GPS_CH9_PKT_NUMBER;
> +	hdev = st_get_hci(ai2dev->dev->parent);
> +	return hdev->send(hdev, skb);
> +}
> +
> +static void ai2_put_escaped(struct sk_buff *skb, u8 d)
> +{
> +	skb_put_u8(skb, d);
> +	if (d == 0x10)
> +		skb_put_u8(skb, d);
> +}
> +
> +static struct sk_buff *ai2_compose_frame(bool request_ack,
> +					u8 cmd,
> +					const u8 *data,
> +					int len)
> +{
> +	u16 sum;
> +	int i;
> +	/* duplicate the length to have space for worst case escaping */
> +	struct sk_buff *skb = ai2_skb_alloc(2 + len * 2 + 2 + 2, GFP_KERNEL);

Please don't mix declaration and non-trivial initialisation like this.

Also ai2_skb_alloc() can fail and return NULL.

> +
> +	skb_put_u8(skb, AI2_ESCAPE);
> +	skb_put_u8(skb, request_ack ? 1 : 0);
> +
> +	sum = AI2_ESCAPE;
> +	if (request_ack)
> +		sum++;
> +
> +	ai2_put_escaped(skb, cmd);
> +	sum += cmd;
> +
> +	ai2_put_escaped(skb, len & 0xff);
> +	sum += len & 0xff;
> +
> +	ai2_put_escaped(skb, len >> 8);
> +	sum += len >> 8;
> +
> +	for (i = 0; i < len; i++) {
> +		sum += data[i];
> +		ai2_put_escaped(skb, data[i]);
> +	}
> +
> +	ai2_put_escaped(skb, sum & 0xFF);
> +	ai2_put_escaped(skb, sum >> 8);
> +	skb_put_u8(skb, AI2_ESCAPE);
> +	skb_put_u8(skb, AI2_END_MARKER);
> +
> +	return skb;
> +}

> +static void gnss_ai2_close(struct gnss_device *gdev)
> +{
> +	struct ai2_device *ai2dev = gnss_get_drvdata(gdev);
> +
> +	/* TODO: find out on what kind of ack we should wait */
> +	if (!ai2raw) {
> +		msleep(50);
> +		ai2_set_receiver_state(ai2dev, RECEIVER_STATE_IDLE);
> +		msleep(50);
> +		ai2_set_receiver_state(ai2dev, RECEIVER_STATE_OFF);
> +		msleep(200); /* seen some longer response time here, so wait */
> +	}
> +
> +	mutex_lock(&ai2dev->gdev_mutex);
> +	ai2dev->gdev_open = false;
> +	if (ai2dev->recv_skb)
> +		kfree_skb(ai2dev->recv_skb);
> +
> +	ai2dev->recv_skb = NULL;
> +	mutex_unlock(&ai2dev->gdev_mutex);
> +}
> +
> +

Stray newline.

> +static int gnss_ai2_write_raw(struct gnss_device *gdev,
> +		const unsigned char *buf, size_t count)
> +{
> +	struct ai2_device *ai2dev = gnss_get_drvdata(gdev);
> +	int err = 0;
> +	struct sk_buff *skb = NULL;
> +
> +	if (!ai2raw)
> +		return -EPERM;
> +
> +	/* allocate packet */
> +	skb = ai2_skb_alloc(count, GFP_KERNEL);
> +	if (!skb) {
> +		BT_ERR("cannot allocate memory for HCILL packet");

This driver should use dev_err() and friends.

> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	skb_put_data(skb, buf, count);
> +
> +	err = ai2_send_frame(ai2dev, skb);
> +	if (err)
> +		goto out;
> +
> +	return count;
> +out:
> +	return err;
> +}
> +
> +static const struct gnss_operations gnss_ai2_ops = {
> +	.open		= gnss_ai2_open,
> +	.close		= gnss_ai2_close,
> +	.write_raw	= gnss_ai2_write_raw,
> +};
> +
> +static void process_ai2_packet(struct ai2_device *ai2dev,
> +			       u8 cmd, u8 *data, u16 len)
> +{
> +	if (cmd != AI2_REPORT_NMEA)
> +		return;
> +
> +	if (len <= NMEA_HEADER_LEN)
> +		return;
> +
> +	len -= NMEA_HEADER_LEN;
> +	data += NMEA_HEADER_LEN;
> +
> +	gnss_insert_raw(ai2dev->gdev, data, len);
> +}
> +
> +/* do some sanity checks and split frame into packets */
> +static void process_ai2_frame(struct ai2_device *ai2dev)
> +{
> +	u16 sum;
> +	int i;
> +	u8 *head;
> +	u8 *data;
> +
> +	sum = 0;
> +	data = ai2dev->recv_skb->data;
> +	for (i = 0; i < ai2dev->recv_skb->len - 2; i++)

skb->len is unsigned and it's not obvious that len is >= 2 here.

> +		sum += data[i];
> +
> +	print_hex_dump_bytes("ai2 frame: ", DUMP_PREFIX_OFFSET, data, ai2dev->recv_skb->len);
> +
> +	if (get_unaligned_le16(data + i) != sum) {
> +		dev_dbg(ai2dev->dev,
> +			"checksum error in reception, dropping frame\n");
> +		return;
> +	}
> +
> +	/* reached if byte 1 in the command packet is set to 1 */
> +	if (data[1] == AI2_ACK)
> +		return;
> +
> +	head = skb_pull(ai2dev->recv_skb, 2); /* drop frame start marker */
> +	while (head && (ai2dev->recv_skb->len >= 3)) {
> +		u8 cmd;
> +		u16 pktlen;
> +
> +		cmd = head[0];
> +		pktlen = get_unaligned_le16(head + 1);
> +		data = skb_pull(ai2dev->recv_skb, 3);
> +		if (!data)
> +			break;
> +
> +		if (pktlen > ai2dev->recv_skb->len)
> +			break;
> +
> +		head = skb_pull(ai2dev->recv_skb, pktlen);
> +
> +		process_ai2_packet(ai2dev, cmd, data, pktlen);
> +	}
> +}

> +static int gnss_ai2_probe(struct platform_device *pdev)
> +{
> +	struct gnss_device *gdev;
> +	struct ai2_device *ai2dev;
> +	int ret;
> +
> +	ai2dev = devm_kzalloc(&pdev->dev, sizeof(*ai2dev), GFP_KERNEL);
> +	if (!ai2dev)
> +		return -ENOMEM;
> +
> +	ai2dev->dev = &pdev->dev;
> +	gdev = gnss_allocate_device(&pdev->dev);
> +	if (!gdev)
> +		return -ENOMEM;
> +
> +	gdev->ops = &gnss_ai2_ops;
> +	gdev->type = ai2raw ? GNSS_TYPE_AI2 : GNSS_TYPE_NMEA;
> +	gnss_set_drvdata(gdev, ai2dev);
> +	platform_set_drvdata(pdev, ai2dev);
> +	st_set_gnss_recv_func(pdev->dev.parent, gnss_recv_frame);
> +	mutex_init(&ai2dev->gdev_mutex);
> +
> +	ret = gnss_register_device(gdev);
> +	if (ret)
> +		goto err;
> +
> +	ai2dev->gdev = gdev;
> +	return 0;
> +
> +err:
> +	st_set_gnss_recv_func(pdev->dev.parent, NULL);
> +
> +	if (ai2dev->recv_skb)
> +		kfree_skb(ai2dev->recv_skb);
> +
> +	gnss_put_device(gdev);
> +	return ret;
> +}
> +
> +static void gnss_ai2_remove(struct platform_device *pdev)
> +{
> +	struct ai2_device *ai2dev =  platform_get_drvdata(pdev);
> +
> +	st_set_gnss_recv_func(pdev->dev.parent, NULL);

This looks racy and may trigger a NULL pointer dereference.

> +	gnss_deregister_device(ai2dev->gdev);
> +	gnss_put_device(ai2dev->gdev);
> +	if (ai2dev->recv_skb)
> +		kfree_skb(ai2dev->recv_skb);
> +}
> +
> +static const struct platform_device_id gnss_ai2_id[] = {
> +	{
> +		.name = "ti-ai2-gnss"
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +MODULE_DEVICE_TABLE(platform, gnss_ai2_id);
> +
> +static struct platform_driver gnss_ai2_driver = {
> +	.driver = {
> +		.name = "gnss-ai2",
> +	},
> +	.probe		= gnss_ai2_probe,
> +	.remove_new	= gnss_ai2_remove,
> +	.id_table	= gnss_ai2_id,
> +};
> +module_platform_driver(gnss_ai2_driver);

This should be an auxiliary rather than platform driver.

Johan
