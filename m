Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753EFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 06:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 558F161039
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 06:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238095AbhJMGsG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 02:48:06 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49410 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238066AbhJMGsF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 02:48:05 -0400
Received: from smtpclient.apple (p4ff9f2d2.dip0.t-ipconnect.de [79.249.242.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8F002CECFC;
        Wed, 13 Oct 2021 08:45:59 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2 4/4] Bluetooth: vhci: Add support for setting
 aosp_capable
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211013003055.2664728-4-luiz.dentz@gmail.com>
Date:   Wed, 13 Oct 2021 08:45:59 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <C7BF6917-DDB0-4B3A-87CD-46E5A68A9C12@holtmann.org>
References: <20211013003055.2664728-1-luiz.dentz@gmail.com>
 <20211013003055.2664728-4-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This adds a debugfs entry to set aosp_capable enabling vhci to emulate
> controllers with AOSP extension support.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> drivers/bluetooth/hci_vhci.c | 68 +++++++++++++++++++++++++++++++++---
> 1 file changed, 64 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index 68a970db8db1..f9aa3fe14995 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -45,6 +45,9 @@ struct vhci_data {
> #if IS_ENABLED(CONFIG_BT_MSFTEXT)
> 	__u16 msft_opcode;
> #endif
> +#if IS_ENABLED(CONFIG_BT_AOSPEXT)
> +	__u16 aosp_capable;
> +#endif
> };
> 
> static int vhci_open_dev(struct hci_dev *hdev)
> @@ -223,18 +226,68 @@ static int msft_opcode_get(void *data, u64 *val)
> DEFINE_DEBUGFS_ATTRIBUTE(msft_opcode_fops, msft_opcode_get, msft_opcode_set,
> 			 "%llu\n");
> 
> +#endif /* CONFIG_BT_MSFTEXT */
> +
> +#if IS_ENABLED(CONFIG_BT_AOSPEXT)
> +
> +static ssize_t aosp_capable_read(struct file *file, char __user *user_buf,
> +				 size_t count, loff_t *ppos)
> +{
> +	struct vhci_data *vhci = file->private_data;
> +	char buf[3];
> +
> +	buf[0] = vhci->aosp_capable ? 'Y' : 'N';
> +	buf[1] = '\n';
> +	buf[2] = '\0';
> +	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
> +}
> +
> +static ssize_t aosp_capable_write(struct file *file,
> +				  const char __user *user_buf, size_t count,
> +				  loff_t *ppos)
> +{
> +	struct vhci_data *vhci = file->private_data;
> +	bool enable;
> +	int err;
> +
> +	err = kstrtobool_from_user(user_buf, count, &enable);
> +	if (err)
> +		return err;
> +
> +	if (vhci->aosp_capable == enable)
> +		return -EALREADY;
> +
> +	vhci->aosp_capable = enable;
> +
> +	return count;
> +}
> +
> +static const struct file_operations aosp_capable_fops = {
> +	.open		= simple_open,
> +	.read		= aosp_capable_read,
> +	.write		= aosp_capable_write,
> +	.llseek		= default_llseek,
> +};
> +
> +#endif /* CONFIG_BT_AOSEXT */
> +
> static int vhci_setup(struct hci_dev *hdev)
> {
> 	struct vhci_data *vhci = hci_get_drvdata(hdev);
> 
> +#if IS_ENABLED(CONFIG_BT_MSFTEXT)
> 	if (vhci->msft_opcode)
> 		hci_set_msft_opcode(hdev, vhci->msft_opcode);
> +#endif
> +
> +#if IS_ENABLED(CONFIG_BT_AOSPEXT)
> +	if (vhci->aosp_capable)
> +		hci_set_aosp_capable(hdev);
> +#endif

this is too much ifdef for me. And you are not really saving anything here since this is a test driver and who cares if we waste an additional 3 bytes memory for vhci_data struct.

So really just do this unconditionally

	hci_set_msft_opcode(hdev, vhci->msft_opcode);
	hci_set_aosp_capable(hdev);

And frankly, do both vendor extensions in one patch.

> 
> 	return 0;
> }
> 
> -#endif /* CONFIG_BT_MSFTEXT */
> -
> static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> {
> 	struct hci_dev *hdev;
> @@ -278,8 +331,10 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> 	hdev->get_codec_config_data = vhci_get_codec_config_data;
> 	hdev->wakeup = vhci_wakeup;
> 
> -	/* Enable custom setup if CONFIG_BT_MSFTEXT is selected */
> -#if IS_ENABLED(CONFIG_BT_MSFTEXT)
> +	/* Enable custom setup if CONFIG_BT_MSFTEXT or CONFIG_BT_AOSPEXT is
> +	 * selected.
> +	 */
> +#if IS_ENABLED(CONFIG_BT_MSFTEXT) || IS_ENABLED(CONFIG_BT_AOSPEXT)
> 	hdev->setup = vhci_setup;
> 	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
> #endif

Even this one is not worth it, just have it run through hdev->setup all the time. If nothing is run, then there is no harm.

> @@ -311,6 +366,11 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> 			    &msft_opcode_fops);
> #endif
> 
> +#if IS_ENABLED(CONFIG_BT_AOSPEXT)
> +	debugfs_create_file("aosp_capable", 0644, hdev->debugfs, data,
> +			    &aosp_capable_fops);
> +#endif
> +

This is the ifdef check we should keep. If not enabled, then we should not expose the debugfs setting. Just wrap it in an if-clause from C so that the compiler doesn’t warn us for unused functions.

Regards

Marcel

