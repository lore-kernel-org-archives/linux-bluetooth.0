Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FC0C433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 08:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E50611CA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 08:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbhDWIEj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Apr 2021 04:04:39 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:33893 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhDWIEi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Apr 2021 04:04:38 -0400
Received: from marcel-macbook.holtmann.net (p4fefc624.dip0.t-ipconnect.de [79.239.198.36])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7D07BCECFB;
        Fri, 23 Apr 2021 10:11:48 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v3 3/3] Bluetooth: cache local supported codec
 capabilities
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210422141449.25155-3-kiran.k@intel.com>
Date:   Fri, 23 Apr 2021 10:04:00 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <349C0A6B-5E9C-4171-BFB5-C86AF4E8D698@holtmann.org>
References: <20210422141449.25155-1-kiran.k@intel.com>
 <20210422141449.25155-3-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> Cache the codec information in the driver and this data can
> be exposed to user space audio modules via getsockopt
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> * changes in v3
>  remove unwanted log
> 
> * changes in v2
>  add skb length check before accessing data
> 
> include/net/bluetooth/hci.h      | 11 +++++++++++
> include/net/bluetooth/hci_core.h | 13 +++++++++++++
> net/bluetooth/hci_core.c         | 31 +++++++++++++++++++++++++++++++
> net/bluetooth/hci_event.c        | 32 ++++++++++++++++++++++++++++++++
> 4 files changed, 87 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 34eb9f4b027f..6b4344639ff7 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1323,6 +1323,17 @@ struct hci_op_read_local_codec_caps {
> 	__u8	direction;
> } __packed;
> 
> +struct hci_codec_caps {
> +	__u8	len;
> +	__u8	caps[];
> +} __packed;
> +
> +struct hci_rp_read_local_codec_caps {
> +	__u8	status;
> +	__u8	num_caps;
> +	struct hci_codec_caps caps[];
> +} __packed;
> +
> #define HCI_OP_READ_PAGE_SCAN_ACTIVITY	0x0c1b
> struct hci_rp_read_page_scan_activity {
> 	__u8     status;
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 2c19b02a805d..b40c7ed38d18 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -131,6 +131,14 @@ struct bdaddr_list {
> 	u8 bdaddr_type;
> };
> 
> +struct codec_list {
> +	struct list_head list;
> +	u8	transport;
> +	u8	codec_id[5];
> +	u8	num_caps;
> +	struct hci_codec_caps caps[];
> +};
> +
> struct bdaddr_list_with_irk {
> 	struct list_head list;
> 	bdaddr_t bdaddr;
> @@ -534,6 +542,7 @@ struct hci_dev {
> 	struct list_head	pend_le_conns;
> 	struct list_head	pend_le_reports;
> 	struct list_head	blocked_keys;
> +	struct list_head	local_codecs;
> 
> 	struct hci_dev_stats	stat;
> 
> @@ -1843,6 +1852,10 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
> 
> void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
> 			       u8 *bdaddr_type);
> +int hci_codec_list_add(struct list_head *list, struct hci_rp_read_local_codec_caps *rp,
> +		       __u32 len,
> +		       struct hci_op_read_local_codec_caps *sent);

I think you need to redo the whole patch series, since 1/3 should have hci_codec_list_add in that it adds the codec id from reading the codec list.

And then reading the capabilities just updates the codec.

Our problem is that the whole init phase is rather async than sync in it procedure. And the reason for that is purely historic from the times when Linus had no work queues and we had to process everything in tasklets or spawn kthreads.

Frankly if we moved the whole init procedure to use __hci_cmd_sync we could fold the complete init{1-4} phases into one. And there is no reason we don’t do that. However one problem at a time.

Regards

Marcel

