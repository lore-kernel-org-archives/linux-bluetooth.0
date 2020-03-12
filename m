Return-Path: <SRS0=41cZ=45=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC1DC1975A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 14:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D80C20716
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 14:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgCLOI5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:08:57 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36155 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbgCLOI4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 10:08:56 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 444DFCECF4;
        Thu, 12 Mar 2020 15:18:24 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] Bluetooth: print fw build version in power-on boot
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200312102142.26538-1-amit.k.bag@intel.com>
Date:   Thu, 12 Mar 2020 15:08:54 +0100
List-Id: <linux-firmware.lore.kernel.org>
Cc:     linux-firmware@kernel.org, linux-bluetooth@vger.kernel.org,
        ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Sukumar Ghorai <sukumar.ghorai@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <63E6C606-A941-4FA4-B21D-DCC564DB41F3@holtmann.org>
References: <20200312102142.26538-1-amit.k.bag@intel.com>
To:     Amit K Bag <amit.k.bag@intel.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Amit,

> To determine the build version of Bluetooth firmware to ensure reported
> issue related to a particular release. This is very helpful for every fw
> downloaded to BT controller and issue reported from field test.
> 
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> ---
> drivers/bluetooth/btusb.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index f5924f3e8b8d..d4328008a714 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1930,7 +1930,12 @@ static int btusb_setup_intel(struct hci_dev *hdev)
> 	if (err)
> 		return err;
> 
> -	bt_dev_info(hdev, "Intel firmware patch completed and activated");
> +       /* Need build number for downloaded fw patches in every power-on boot */
> +       err = btintel_read_version(hdev, &ver);
> +       if (err)
> +               return err;
> +       BT_INFO("%s: Intel Bluetooth fw patch 0x%02x completed and activated",
> +               hdev->name, ver.fw_patch_num);

don’t re-introduce the usage of BT_INFO, we have bt_dev_info.

Regards

Marcel

