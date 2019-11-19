Return-Path: <SRS0=5+i7=ZL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9D7C432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 17:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3AC2230F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 17:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfKSRB5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Nov 2019 12:01:57 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:43846 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfKSRB4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Nov 2019 12:01:56 -0500
Received: from marcel-macbook.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id A3438CECF6;
        Tue, 19 Nov 2019 18:11:01 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] Bluetooth: Expose debugfs entry to force resolvable
 private address
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191111052231.31527-1-mike@ice9.us>
Date:   Tue, 19 Nov 2019 18:01:54 +0100
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <05B1CD3B-543B-4296-A043-335FCE1FD292@holtmann.org>
References: <20191111052231.31527-1-mike@ice9.us>
To:     mike@ice9.us
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mike,

> In order to facilitate impersonation attacks against devices using
> resolvable private addresses (RPAs), this debugfs entry allows the user
> to set a fixed RPA that is used during undirected and directed
> advertising. Writing 00:00:00:00:00:00 disables the forced address and
> will resume generating valid RPAs.
> 
> Signed-off-by: Mike Ryan <mike@ice9.us>
> ---
> include/net/bluetooth/bluetooth.h |  1 +
> include/net/bluetooth/hci_core.h  |  1 +
> net/bluetooth/hci_debugfs.c       | 53 +++++++++++++++++++++++++++++++++++++++
> net/bluetooth/hci_request.c       | 23 +++++++++++------
> net/bluetooth/lib.c               | 52 ++++++++++++++++++++++++++++++++++++++
> 5 files changed, 123 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index fabee6db0..c6417d15c 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -237,6 +237,7 @@ static inline void bacpy(bdaddr_t *dst, const bdaddr_t *src)
> }
> 
> void baswap(bdaddr_t *dst, const bdaddr_t *src);
> +int str2ba(const char *str, bdaddr_t *ba);
> 
> /* Common socket structures and functions */
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index b689aceb6..a822914d7 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -428,6 +428,7 @@ struct hci_dev {
> 	__u32			rpa_timeout;
> 	struct delayed_work	rpa_expired;
> 	bdaddr_t		rpa;
> +	bdaddr_t		force_rpa;
> 
> #if IS_ENABLED(CONFIG_BT_LEDS)
> 	struct led_trigger	*power_led;
> diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
> index 402e2cc54..2363ae9bb 100644
> --- a/net/bluetooth/hci_debugfs.c
> +++ b/net/bluetooth/hci_debugfs.c
> @@ -710,6 +710,57 @@ static const struct file_operations force_static_address_fops = {
> 	.llseek		= default_llseek,
> };
> 
> +static ssize_t force_rpa_read(struct file *file,
> +					 char __user *user_buf,
> +					 size_t count, loff_t *ppos)
> +{
> +	struct hci_dev *hdev = file->private_data;
> +	char buf[19];
> +	bdaddr_t *ba = &hdev->force_rpa;
> +
> +	sprintf(buf, "%pMR\n", ba);
> +
> +	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
> +}
> +
> +static ssize_t force_rpa_write(struct file *file, const char __user *user_buf,
> +			       size_t count, loff_t *ppos)
> +{
> +	struct hci_dev *hdev = file->private_data;
> +	char buf[18];
> +	size_t buf_size = min(count, (sizeof(buf)-1));
> +	bdaddr_t rpa;
> +
> +	if (test_bit(HCI_UP, &hdev->flags))
> +		return -EBUSY;
> +
> +	if (copy_from_user(buf, user_buf, buf_size))
> +		return -EFAULT;
> +
> +	buf[buf_size] = '\0';
> +	if (str2ba(buf, &rpa))
> +		return -EINVAL;
> +
> +	// the two most significant bits shall be 01 unless the address is
> +	// 00:00:00:00:00:00

comment style is 

	/* foo */

Or 

	/* foo
	 * bar */

> +	if ((rpa.b[5] & 0xc0) != 0x40 && bacmp(&rpa, BDADDR_ANY))
> +		return -EINVAL;
> +
> +	if (!bacmp(&hdev->force_rpa, &rpa))
> +		return -EALREADY;
> +
> +	bacpy(&hdev->force_rpa, &rpa);
> +
> +	return count;
> +}

Lets use scanf here instead of truing to copy str2ba from userspace.

> +
> +static const struct file_operations force_rpa_fops = {
> +	.open		= simple_open,
> +	.read		= force_rpa_read,
> +	.write		= force_rpa_write,
> +	.llseek		= default_llseek,
> +};
> +
> static int white_list_show(struct seq_file *f, void *ptr)
> {
> 	struct hci_dev *hdev = f->private;
> @@ -1026,6 +1077,8 @@ void hci_debugfs_create_le(struct hci_dev *hdev)
> 				    hdev->debugfs, hdev,
> 				    &force_static_address_fops);
> 
> +	debugfs_create_file("force_rpa", 0644, hdev->debugfs, hdev,
> +			    &force_rpa_fops);
> 	debugfs_create_u8("white_list_size", 0444, hdev->debugfs,
> 			  &hdev->le_white_list_size);
> 	debugfs_create_file("white_list", 0444, hdev->debugfs, hdev,
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 2a1b64dbf..8fabb1bb1 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -1910,14 +1910,23 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
> 
> 		*own_addr_type = ADDR_LE_DEV_RANDOM;
> 
> -		if (!hci_dev_test_and_clear_flag(hdev, HCI_RPA_EXPIRED) &&
> -		    !bacmp(&hdev->random_addr, &hdev->rpa))
> -			return 0;
> +		/* If force_rpa is set to 00:00:00:00:00:00, generate a valid
> +		 * RPA using IRK. Otherwise use the forced value.
> +		 */
> +		if (!bacmp(&hdev->force_rpa, BDADDR_ANY)) {
> +			if (!hci_dev_test_and_clear_flag(hdev, HCI_RPA_EXPIRED) &&
> +			    !bacmp(&hdev->random_addr, &hdev->rpa))
> +				return 0;
> 
> -		err = smp_generate_rpa(hdev, hdev->irk, &hdev->rpa);
> -		if (err < 0) {
> -			bt_dev_err(hdev, "failed to generate new RPA");
> -			return err;
> +			err = smp_generate_rpa(hdev, hdev->irk, &hdev->rpa);
> +			if (err < 0) {
> +				bt_dev_err(hdev, "failed to generate new RPA");
> +				return err;
> +			}
> +		} else {
> +			if (!bacmp(&hdev->rpa, &hdev->force_rpa))
> +				return 0;
> +			bacpy(&hdev->rpa, &hdev->force_rpa);
> 		}

Isn’t this going to be enough (minus the required comment).

-               err = smp_generate_rpa(hdev, hdev->irk, &hdev->rpa);
-               if (err < 0) {
-                       bt_dev_err(hdev, "failed to generate new RPA");
-                       return err;
+               if (!bacmp(&hdev->force_rpa, BDADDR_ANY)) {
+                       err = smp_generate_rpa(hdev, hdev->irk, &hdev->rpa);
+                       if (err < 0) {
+                               bt_dev_err(hdev, "failed to generate new RPA");
+                               return err;
+                       }
+               } else {
+                       bacpy(&hdev->rpa, &hdev->force_rpa);
                }

Regards

Marcel

