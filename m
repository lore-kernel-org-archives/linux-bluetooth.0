Return-Path: <SRS0=nDLV=Y7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547E8C43331
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Nov 2019 18:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3359D2178F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Nov 2019 18:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfKGSnc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Nov 2019 13:43:32 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:37679 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfKGSnc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Nov 2019 13:43:32 -0500
Received: from marcel-macbook.fritz.box (p5B3D2BA4.dip0.t-ipconnect.de [91.61.43.164])
        by mail.holtmann.org (Postfix) with ESMTPSA id C6007CED0C;
        Thu,  7 Nov 2019 19:52:34 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] Bluetooth: Expose debugfs entry to allow illegal static
 address
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191107040656.29306-1-mike@ice9.us>
Date:   Thu, 7 Nov 2019 19:43:30 +0100
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <F5609867-4661-4190-BA65-96ADE72EA0FF@holtmann.org>
References: <20191107040656.29306-1-mike@ice9.us>
To:     mike@ice9.us
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mike,

> The first two bits of valid static addresses must both be 0 because
> other values are reserved for resolvable and non-resolvable private
> addresses (RPA and NRPA). In order to facilitate impersonation attacks
> against devices using RPAs, this debugfs entry allows the user to set
> the static address to an illegal value reserved for RPAs.
> 
> Signed-off-by: Mike Ryan <mike@ice9.us>
> ---
> include/net/bluetooth/hci.h |  1 +
> net/bluetooth/hci_debugfs.c | 43 +++++++++++++++++++++++++++++++++++++++++++
> net/bluetooth/mgmt.c        |  4 +++-
> 3 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 5bc1e30de..d1e477093 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -280,6 +280,7 @@ enum {
> 	HCI_DUT_MODE,
> 	HCI_VENDOR_DIAG,
> 	HCI_FORCE_BREDR_SMP,
> +	HCI_ALLOW_ILLEGAL_STATIC_ADDR,
> 	HCI_FORCE_STATIC_ADDR,
> 	HCI_LL_RPA_RESOLUTION,
> 	HCI_CMD_PENDING,
> diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
> index 402e2cc54..0d3006302 100644
> --- a/net/bluetooth/hci_debugfs.c
> +++ b/net/bluetooth/hci_debugfs.c
> @@ -667,6 +667,47 @@ static int static_address_show(struct seq_file *f, void *p)
> 
> DEFINE_SHOW_ATTRIBUTE(static_address);
> 
> +static ssize_t allow_illegal_static_address_read(struct file *file,
> +					 char __user *user_buf,
> +					 size_t count, loff_t *ppos)
> +{
> +	struct hci_dev *hdev = file->private_data;
> +	char buf[3];
> +
> +	buf[0] = hci_dev_test_flag(hdev, HCI_ALLOW_ILLEGAL_STATIC_ADDR) ? 'Y': 'N';
> +	buf[1] = '\n';
> +	buf[2] = '\0';
> +	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
> +}
> +
> +static ssize_t allow_illegal_static_address_write(struct file *file,
> +					  const char __user *user_buf,
> +					  size_t count, loff_t *ppos)
> +{
> +	struct hci_dev *hdev = file->private_data;
> +	bool enable;
> +	int err;
> +
> +	err = kstrtobool_from_user(user_buf, count, &enable);
> +	if (err)
> +		return err;
> +
> +	if (enable == hci_dev_test_flag(hdev, HCI_ALLOW_ILLEGAL_STATIC_ADDR))
> +		return -EALREADY;
> +
> +	hci_dev_change_flag(hdev, HCI_ALLOW_ILLEGAL_STATIC_ADDR);
> +
> +	return count;
> +
> +}
> +
> +static const struct file_operations allow_illegal_static_address_fops = {
> +	.open		= simple_open,
> +	.read		= allow_illegal_static_address_read,
> +	.write		= allow_illegal_static_address_write,
> +	.llseek		= default_llseek,
> +};
> +
> static ssize_t force_static_address_read(struct file *file,
> 					 char __user *user_buf,
> 					 size_t count, loff_t *ppos)
> @@ -1016,6 +1057,8 @@ void hci_debugfs_create_le(struct hci_dev *hdev)
> 			    &random_address_fops);
> 	debugfs_create_file("static_address", 0444, hdev->debugfs, hdev,
> 			    &static_address_fops);
> +	debugfs_create_file("allow_illegal_static_address", 0644, hdev->debugfs,
> +			    hdev, &allow_illegal_static_address_fops);
> 
> 	/* For controllers with a public address, provide a debug
> 	 * option to force the usage of the configured static
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index acb7c6d56..59945b850 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -4428,10 +4428,12 @@ static int set_static_address(struct sock *sk, struct hci_dev *hdev,
> 					       MGMT_STATUS_INVALID_PARAMS);
> 
> 		/* Two most significant bits shall be set */
> -		if ((cp->bdaddr.b[5] & 0xc0) != 0xc0)
> +		if ((cp->bdaddr.b[5] & 0xc0) != 0xc0 &&
> +		    !hci_dev_test_flag(hdev, HCI_ALLOW_ILLEGAL_STATIC_ADDR)) {
> 			return mgmt_cmd_status(sk, hdev->id,
> 					       MGMT_OP_SET_STATIC_ADDRESS,
> 					       MGMT_STATUS_INVALID_PARAMS);
> +		}
> 	}

this is too much stabbing in the back for my liking. It is really abusing the standard mgmt interface as we defined it. So a patch in this shape and form can not go upstream.

In debugfs we have the two files “static_address” to read out the current address and the “force_static_address” option to use the static address for dual-mode controllers. I would rather add another file that acts the same as “Set Static Address” command from mgmt, but will allow you to provide any random address. Maybe “set_static_address” as a file name, but I am not 100% convinced that this is a good idea.

If the goal is for faking an RPA, then it might be actually better to really require enabling Privacy first and then have a debugfs option to force the usage of a specific RPA. Since I am not sure what might break if we stop enforcing the usage for static address. Since the static address is also behind the identity address. And using a RPA as identity address is not allowed.

Regards

Marcel

