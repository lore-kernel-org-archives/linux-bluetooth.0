Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56ACC48BE5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jun 2021 19:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A98BB60231
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jun 2021 19:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhFOT2l convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Jun 2021 15:28:41 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52760 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhFOT2j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Jun 2021 15:28:39 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id C50C8CECFB;
        Tue, 15 Jun 2021 21:34:33 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v9 03/10] Bluetooth: Add a callback function to retireve
 data path
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210608122455.19583-3-kiran.k@intel.com>
Date:   Tue, 15 Jun 2021 21:26:32 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <3C9F25C0-3122-4208-938A-3C3094E018BA@holtmann.org>
References: <20210608122455.19583-1-kiran.k@intel.com>
 <20210608122455.19583-3-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> There is no standard HCI command to retrieve data path for transport.
> Add a new callback function to retrieve data path which is used
> in offload usecase. This needs to be set at setup stage if controller
> supports offload codecs
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> * changes in v9:
>  - define a separate patch for core changes
> 
> include/net/bluetooth/hci_core.h | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 3284044c3dd7..641477396da3 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -617,6 +617,7 @@ struct hci_dev {
> 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
> 	void (*cmd_timeout)(struct hci_dev *hdev);
> 	bool (*prevent_wake)(struct hci_dev *hdev);
> +	int (*get_data_path)(struct hci_dev *hdev);
> };

and where is the code using hdev->get_data_path. That code needs to be in this patch.

Regards

Marcel

