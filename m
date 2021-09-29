Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F36AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 13:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AACE613A7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 13:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344366AbhI2Nwt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Sep 2021 09:52:49 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:50880 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344335AbhI2Nwr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Sep 2021 09:52:47 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id B6526CECFA;
        Wed, 29 Sep 2021 15:51:05 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2 2/3] Bluetooth: hci_vhci: Add force_suspend entry
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210928213653.3028439-2-luiz.dentz@gmail.com>
Date:   Wed, 29 Sep 2021 15:51:05 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <2F5C465D-1D47-4A16-B7E0-6FE32D6E9DC1@holtmann.org>
References: <20210928213653.3028439-1-luiz.dentz@gmail.com>
 <20210928213653.3028439-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This adds force_suspend which can be used to force the controller into
> suspend/resume state.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> drivers/bluetooth/hci_vhci.c | 49 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index cc3679f3491d..52f9106faeae 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -21,6 +21,7 @@
> 
> #include <linux/skbuff.h>
> #include <linux/miscdevice.h>
> +#include <linux/debugfs.h>
> 
> #include <net/bluetooth/bluetooth.h>
> #include <net/bluetooth/hci_core.h>
> @@ -91,6 +92,51 @@ static int vhci_get_codec_config_data(struct hci_dev *hdev, __u8 type,
> 	return 0;
> }
> 
> +static ssize_t force_suspend_read(struct file *file, char __user *user_buf,
> +				  size_t count, loff_t *ppos)
> +{
> +	struct hci_dev *hdev = file->private_data;
> +	char buf[3];
> +
> +	buf[0] = hdev->suspended ? 'Y' : 'N';
> +	buf[1] = '\n';
> +	buf[2] = '\0';
> +	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
> +}
> +
> +static ssize_t force_suspend_write(struct file *file,
> +				   const char __user *user_buf,
> +				   size_t count, loff_t *ppos)
> +{
> +	struct hci_dev *hdev = file->private_data;
> +	bool enable;
> +	int err;
> +
> +	err = kstrtobool_from_user(user_buf, count, &enable);
> +	if (err)
> +		return err;
> +
> +	if (hdev->suspended == enable)
> +		return -EALREADY;

I think that we have to have bool suspended in vhci_data struct here. It needs to be local to the driver.

> +
> +	if (enable)
> +		err = hci_suspend_dev(hdev);
> +	else
> +		err = hci_resume_dev(hdev);
> +
> +	if (err)
> +		return err;
> +
> +	return count;
> +}
> +
> +static const struct file_operations force_suspend_fops = {
> +	.open		= simple_open,
> +	.read		= force_suspend_read,
> +	.write		= force_suspend_write,
> +	.llseek		= default_llseek,
> +};
> +
> static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> {
> 	struct hci_dev *hdev;
> @@ -149,6 +195,9 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> 		return -EBUSY;
> 	}
> 
> +	debugfs_create_file("force_suspend", 0644, hdev->debugfs, hdev,
> +			    &force_suspend_fops);
> +
> 	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;

Regards

Marcel

