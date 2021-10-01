Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85679C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 09:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65B3B61A08
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 09:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353010AbhJAJit convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:38:49 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:39448 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352790AbhJAJit (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Oct 2021 05:38:49 -0400
Received: from smtpclient.apple (62-134-92-74.business.static.de.bt.net [62.134.92.74])
        by mail.holtmann.org (Postfix) with ESMTPSA id 48FCBCED29;
        Fri,  1 Oct 2021 11:37:04 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC] Bluetooth: Rename driver .prevent_wake to .wakeup
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211001004716.3447880-1-luiz.dentz@gmail.com>
Date:   Fri, 1 Oct 2021 11:37:03 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <2CB9BA6C-7E40-420B-8AFC-0D18EB74CBFE@holtmann.org>
References: <20211001004716.3447880-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> prevent_wake logic is backward since what it is really checking is
> if the device may wakeup the system or not, not that it can prevent
> the system to be awaken.
> 
> Also looking on how other subsystems have the entry as power/wakeup
> this also renames the force_prevent_wake to just wakeup in vhci driver.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> drivers/bluetooth/btusb.c        |  4 ++--
> drivers/bluetooth/hci_vhci.c     | 25 ++++++++++++-------------
> include/net/bluetooth/hci_core.h |  2 +-
> net/bluetooth/hci_core.c         | 13 +++++++------
> 4 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 34363d3c85e5..bd09b91bb1ea 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3636,7 +3636,7 @@ static void btusb_check_needs_reset_resume(struct usb_interface *intf)
> 		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
> }
> 
> -static bool btusb_prevent_wake(struct hci_dev *hdev)
> +static bool btusb_wakeup(struct hci_dev *hdev)
> {
> 	struct btusb_data *data = hci_get_drvdata(hdev);
> 
> @@ -3797,7 +3797,7 @@ static int btusb_probe(struct usb_interface *intf,
> 	hdev->flush  = btusb_flush;
> 	hdev->send   = btusb_send_frame;
> 	hdev->notify = btusb_notify;
> -	hdev->prevent_wake = btusb_prevent_wake;
> +	hdev->wakeup = btusb_wakeup;
> 
> #ifdef CONFIG_PM
> 	err = btusb_config_oob_wake(hdev);
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index acf2544dbb05..5c27c27e54a0 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -40,7 +40,7 @@ struct vhci_data {
> 	struct delayed_work open_timeout;
> 
> 	bool suspended;
> -	bool prevent_wake;
> +	bool wakeup;
> };
> 
> static int vhci_open_dev(struct hci_dev *hdev)
> @@ -95,11 +95,11 @@ static int vhci_get_codec_config_data(struct hci_dev *hdev, __u8 type,
> 	return 0;
> }
> 
> -static bool vhci_prevent_wake(struct hci_dev *hdev)
> +static bool vhci_wakeup(struct hci_dev *hdev)
> {
> 	struct vhci_data *data = hci_get_drvdata(hdev);
> 
> -	return data->prevent_wake;
> +	return data->wakeup;
> }
> 
> static ssize_t force_suspend_read(struct file *file, char __user *user_buf,
> @@ -149,19 +149,19 @@ static const struct file_operations force_suspend_fops = {
> 	.llseek		= default_llseek,
> };
> 
> -static ssize_t force_prevent_wake_read(struct file *file, char __user *user_buf,
> +static ssize_t wakeup_read(struct file *file, char __user *user_buf,
> 				       size_t count, loff_t *ppos)
> {
> 	struct vhci_data *data = file->private_data;
> 	char buf[3];
> 
> -	buf[0] = data->prevent_wake ? 'Y' : 'N';
> +	buf[0] = data->wakeup ? 'Y' : 'N';
> 	buf[1] = '\n';
> 	buf[2] = '\0';
> 	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
> }
> 
> -static ssize_t force_prevent_wake_write(struct file *file,
> +static ssize_t wakeup_write(struct file *file,
> 					const char __user *user_buf,
> 					size_t count, loff_t *ppos)
> {
> @@ -173,16 +173,16 @@ static ssize_t force_prevent_wake_write(struct file *file,
> 	if (err)
> 		return err;
> 
> -	if (data->prevent_wake == enable)
> +	if (data->wakeup == enable)
> 		return -EALREADY;
> 
> 	return count;
> }
> 
> -static const struct file_operations force_prevent_wake_fops = {
> +static const struct file_operations wakeup_fops = {
> 	.open		= simple_open,
> -	.read		= force_prevent_wake_read,
> -	.write		= force_prevent_wake_write,
> +	.read		= wakeup_read,
> +	.write		= wakeup_write,
> 	.llseek		= default_llseek,
> };
> 
> @@ -227,7 +227,7 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> 	hdev->send  = vhci_send_frame;
> 	hdev->get_data_path_id = vhci_get_data_path_id;
> 	hdev->get_codec_config_data = vhci_get_codec_config_data;
> -	hdev->prevent_wake = vhci_prevent_wake;
> +	hdev->wakeup = vhci_wakeup;
> 
> 	/* bit 6 is for external configuration */
> 	if (opcode & 0x40)
> @@ -248,8 +248,7 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> 	debugfs_create_file("force_suspend", 0644, hdev->debugfs, data,
> 			    &force_suspend_fops);
> 
> -	debugfs_create_file("force_prevent_wake", 0644, hdev->debugfs, data,
> -			    &force_prevent_wake_fops);
> +	debugfs_create_file("wakeup", 0644, hdev->debugfs, data, &wakeup_fops);
> 

don’t we better name this force_wakeup?

Regards

Marcel

