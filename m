Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC47AC47082
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 14:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9395C613F3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 14:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhFCOZX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Jun 2021 10:25:23 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:50399 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhFCOZX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Jun 2021 10:25:23 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4C1A6CED1F;
        Thu,  3 Jun 2021 16:31:35 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v8 1/9] Bluetooth: enumerate local supported codec and
 cache details
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210518104232.5431-1-kiran.k@intel.com>
Date:   Thu, 3 Jun 2021 16:23:37 +0200
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <23D52481-5703-48EC-93DC-1674C0B3CBB8@holtmann.org>
References: <20210518104232.5431-1-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> Move reading of supported local codecs into a separate init function,
> query codecs capabilities and cache the data
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> * changes in v8:
>  - add comments
>  - split __u8 codec_id[5] into {__u8 id; __le16 cid, vid }
>  - address review comment related codec caps structure
> 
> * changes in v7:
>  - keep codec enumeration call in hci_init instead of having a separate
>    function
>  - Remove unused bitmasks defined for LE transports
> 
> * changes  in v6:
>  - fix compiler warning reported for ARCH=arc
> 
> * changes in v5:
>  - fix review comments
>  - move code used to read standard/vendor codecs caps into single function
> 
> * changes in v4:
>  - convert  reading of codecs and codecs caps calls from async to sync
> 
> * changes in v3
>  move codec enumeration into a new init function
> 
> * changes in v2
>  add skb length check before accessing data
> 
> include/net/bluetooth/hci.h      |  41 +++++++
> include/net/bluetooth/hci_core.h |  17 +++
> net/bluetooth/hci_core.c         | 199 ++++++++++++++++++++++++++++++-
> 3 files changed, 253 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index c4b0650fb9ae..6cb9340a2d51 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1307,6 +1307,28 @@ struct hci_rp_read_data_block_size {
> } __packed;
> 
> #define HCI_OP_READ_LOCAL_CODECS	0x100b
> +struct hci_std_codecs {
> +	__u8	num;
> +	__u8	codec[];
> +} __packed;
> +
> +struct hci_ven_codec {
> +	/* company id */
> +	__le16	cid;
> +	/* vendor codec id */
> +	__le16	vid;
> +} __packed;

I am pretty sure that I said to use vnd and not ven. The shortcut ven for vendor is not something we used at all.

Regards

Marcel

