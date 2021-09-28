Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95BFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 11:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97DB961159
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 11:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240293AbhI1LL0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Sep 2021 07:11:26 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43712 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240210AbhI1LL0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Sep 2021 07:11:26 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id CE470CECDA;
        Tue, 28 Sep 2021 13:09:45 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v4 3/4] Bluetooth: btrtl: enable Realtek 8822C/8852A to
 support AOSP extension
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210926150657.v4.3.Iba6327b2544d1904bbcb17f369dcd3761b566153@changeid>
Date:   Tue, 28 Sep 2021 13:09:45 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Joseph Hwang <josephsih@google.com>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <61F35FD1-C78A-4E50-80EA-D8098A859D26@holtmann.org>
References: <20210926150657.v4.1.Iaa4a0269e51d8e8d8784a6ac8e05899b49a1377d@changeid>
 <20210926150657.v4.3.Iba6327b2544d1904bbcb17f369dcd3761b566153@changeid>
To:     Joseph Hwang <josephsih@chromium.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

> This patch enables Realtek 8822C and 8852A to support the AOSP
> extension.
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
> drivers/bluetooth/btrtl.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

