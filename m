Return-Path: <SRS0=ehmo=RB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF73C4360F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Feb 2019 09:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CAF421848
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Feb 2019 09:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfBZJGI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:06:08 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:43350 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfBZJGI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Feb 2019 04:06:08 -0500
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de [79.249.243.97])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7082CCF2A3;
        Tue, 26 Feb 2019 10:14:02 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 1/5] Bluetooth: Expose supported LE states via debugfs
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190220101428.3086-1-andrzej.kaczmarek@codecoup.pl>
Date:   Tue, 26 Feb 2019 10:06:06 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <176433CA-5971-48CF-B550-4516D92DD014@holtmann.org>
References: <20190220101428.3086-1-andrzej.kaczmarek@codecoup.pl>
To:     Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andrzej,

> It may be useful for debugging purposes to quickly retrieve supported LE
> stated bit mask for controller.
> 
> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
> ---
> net/bluetooth/hci_debugfs.c | 25 +++++++++++++++++++++++++
> 1 file changed, 25 insertions(+)
> 
> diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
> index 51f5b1efc3a5..c0b11ebacf7d 100644
> --- a/net/bluetooth/hci_debugfs.c
> +++ b/net/bluetooth/hci_debugfs.c
> @@ -679,6 +679,29 @@ static const struct file_operations force_static_address_fops = {
> 	.llseek		= default_llseek,
> };
> 
> +static int le_states_show(struct seq_file *f, void *ptr)
> +{
> +	struct hci_dev *hdev = f->private;
> +
> +	hci_dev_lock(hdev);
> +	seq_printf(f, "LE: %8ph\n", hdev->le_states);
> +	hci_dev_unlock(hdev);
> +
> +	return 0;
> +}
> +
> +static int le_states_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, le_states_show, inode->i_private);
> +}
> +
> +static const struct file_operations le_states_fops = {
> +	.open		= le_states_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
> static int white_list_show(struct seq_file *f, void *ptr)
> {
> 	struct hci_dev *hdev = f->private;
> @@ -956,6 +979,8 @@ void hci_debugfs_create_le(struct hci_dev *hdev)
> 			    &random_address_fops);
> 	debugfs_create_file("static_address", 0444, hdev->debugfs, hdev,
> 			    &static_address_fops);
> +	debugfs_create_file("le_states", 0444, hdev->debugfs, hdev,
> +			    &le_states_fops);

we have not used le_ prefixed files yet and so maybe better use supported_states here.

Regards

Marcel

