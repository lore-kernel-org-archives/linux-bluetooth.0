Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0AFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 13:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E28CE613A7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 13:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344338AbhI2NzP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Sep 2021 09:55:15 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:37080 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344297AbhI2NzO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Sep 2021 09:55:14 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id DE1D4CECF9;
        Wed, 29 Sep 2021 15:53:32 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2 3/3] Bluetooth: hci_vhci: Add force_prevent_wake entry
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210928213653.3028439-3-luiz.dentz@gmail.com>
Date:   Wed, 29 Sep 2021 15:53:32 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <F70A6EDE-0E0A-4D4C-8C4A-7262D0FD9CC5@holtmann.org>
References: <20210928213653.3028439-1-luiz.dentz@gmail.com>
 <20210928213653.3028439-3-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This adds force_prevent_wake which can be used to force a certain state
> while interacting with force_suspend.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> drivers/bluetooth/hci_vhci.c | 48 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index 52f9106faeae..60a408a49828 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -137,6 +137,51 @@ static const struct file_operations force_suspend_fops = {
> 	.llseek		= default_llseek,
> };
> 
> +static bool prevent_wake;

this needs to be in vhci_data since it should be per vhci.

> +
> +static ssize_t force_prevent_wake_read(struct file *file, char __user *user_buf,
> +				       size_t count, loff_t *ppos)
> +{
> +	char buf[3];
> +
> +	buf[0] = prevent_wake ? 'Y' : 'N';
> +	buf[1] = '\n';
> +	buf[2] = '\0';
> +	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
> +}
> +
> +static bool hci_debugfs_prevent_wake(struct hci_dev *hdev)
> +{
> +	return prevent_wake;
> +}

The hci_debugfs prefix here is rather misleading. This is vhci_prevent_wake actually. And just move it to a more closer position with all the other hdev-> callbacks.

> +
> +static ssize_t force_prevent_wake_write(struct file *file,
> +					const char __user *user_buf,
> +					size_t count, loff_t *ppos)
> +{
> +	struct hci_dev *hdev = file->private_data;
> +	bool enable;
> +	int err;
> +
> +	err = kstrtobool_from_user(user_buf, count, &enable);
> +	if (err)
> +		return err;
> +
> +	if (prevent_wake == enable)
> +		return -EALREADY;
> +
> +	hdev->prevent_wake = hci_debugfs_prevent_wake;

You need to set these with the other hdev-> callback and not in debugfs callback.

> +
> +	return count;
> +}
> +
> +static const struct file_operations force_prevent_wake_fops = {
> +	.open		= simple_open,
> +	.read		= force_prevent_wake_read,
> +	.write		= force_prevent_wake_write,
> +	.llseek		= default_llseek,
> +};
> +
> static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> {
> 	struct hci_dev *hdev;
> @@ -198,6 +243,9 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> 	debugfs_create_file("force_suspend", 0644, hdev->debugfs, hdev,
> 			    &force_suspend_fops);
> 
> +	debugfs_create_file("force_prevent_wake", 0644, hdev->debugfs, hdev,
> +			    &force_prevent_wake_fops);
> +

Regards

Marcel

