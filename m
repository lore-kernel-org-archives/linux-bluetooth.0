Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562AAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 11:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15AD26108F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 11:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240255AbhI1LLZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Sep 2021 07:11:25 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40658 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239068AbhI1LLZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Sep 2021 07:11:25 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9D077CECD9;
        Tue, 28 Sep 2021 13:09:44 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v4 2/4] Bluetooth: hci_qca: enable Qualcomm WCN399x for
 AOSP extension
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210926150657.v4.2.I287dfe4fd9801db8ea35dc095ea05c23e8b9129d@changeid>
Date:   Tue, 28 Sep 2021 13:09:44 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        kernel test robot <lkp@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <60268061-A64F-4D5F-B6F1-C707E1EFE38B@holtmann.org>
References: <20210926150657.v4.1.Iaa4a0269e51d8e8d8784a6ac8e05899b49a1377d@changeid>
 <20210926150657.v4.2.I287dfe4fd9801db8ea35dc095ea05c23e8b9129d@changeid>
To:     Joseph Hwang <josephsih@chromium.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

> This patch enables Qualcomm WCN399x to support the AOSP extension.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> 
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> 
> ---
> 
> Changes in v4:
> - Call hci_set_aosp_capable in the driver.
> 
> Changes in v3:
> - Fix the auto build test ERROR
>  "undefined symbol: btandroid_set_quality_report" that occurred
>  with some kernel configs.
> 
> Changes in v2:
> - Fix the title
> 
> drivers/bluetooth/hci_qca.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

