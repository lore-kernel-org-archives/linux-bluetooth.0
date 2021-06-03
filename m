Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3A9C47082
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 14:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3395613D6
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 14:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhFCObU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Jun 2021 10:31:20 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:54518 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhFCObT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Jun 2021 10:31:19 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id D07EECED1F;
        Thu,  3 Jun 2021 16:37:31 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v8 4/9] Bluetooth: btitnel: Add a callback function to
 retireve data path
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210518104232.5431-4-kiran.k@intel.com>
Date:   Thu, 3 Jun 2021 16:29:33 +0200
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <F2618817-65E3-40E2-AB94-CFB7BE11A9FB@holtmann.org>
References: <20210518104232.5431-1-kiran.k@intel.com>
 <20210518104232.5431-4-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> There is no standard HCI command to retrieve data path for transport.
> Add a new callback function to retrieve data path which is used
> in offload usecase.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> 
> This callback gets called when audio module queries codecs suppoted
> on SCO socket. For Intel controllers, data_path is always 1
> 
> drivers/bluetooth/btintel.c      | 8 ++++++++
> drivers/bluetooth/btintel.h      | 6 ++++++
> drivers/bluetooth/btusb.c        | 1 +
> include/net/bluetooth/hci_core.h | 1 +
> 4 files changed, 16 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index e3ad19244054..8407e9736c62 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -1300,6 +1300,14 @@ int btintel_read_offload_usecases(struct hci_dev *hdev)
> }
> EXPORT_SYMBOL_GPL(btintel_read_offload_usecases);
> 
> +int btintel_get_data_path_id(struct hci_dev *hdev)
> +{
> +	if (!test_bit(HCI_QUIRK_HFP_OFFLOAD_CODECS_SUPPORTED, &hdev->quirks))
> +		return -EOPNOTSUPP;
> +	return 1;
> +}
> +EXPORT_SYMBOL_GPL(btintel_get_data_path_id);
> +

actually lets not do it this way. Only set the get_data_path_id callback if offloading is supported and with that we don’t actually need to quirk either. If it is set, we know that we can offload.

Regards

Marcel

