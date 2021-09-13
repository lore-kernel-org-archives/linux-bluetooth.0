Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193E1C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 14:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F0F60E08
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 14:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345856AbhIMOgb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Sep 2021 10:36:31 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42773 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344589AbhIMOeE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Sep 2021 10:34:04 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id AFFE3CED1E;
        Mon, 13 Sep 2021 16:32:45 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v3 1/3] Bluetooth: btandroid: Support Android Bluetooth
 Quality Report
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210913152801.v3.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
Date:   Mon, 13 Sep 2021 16:32:45 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Joseph Hwang <josephsih@google.com>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <D38B22EC-EFC8-44A0-84BE-F3710380C022@holtmann.org>
References: <20210913152801.v3.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
To:     Joseph Hwang <josephsih@chromium.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

> Add the btandroid.c file to support Android BQR commands.
> 
> This module may be referenced by btusb, btrtl, and hci_qca when a
> Bluetooth controller supports the Android Bluetooth Quality Report.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> 
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> ---
> 
> Changes in v3:
> - Fix the auto build test ERROR
>  "undefined symbol: btandroid_set_quality_report" that occurred
>  with some kernel configs.
> - Note that the mgmt-tester "Read Exp Feature - Success" failed.
>  But on my test device, the same test passed. Please kindly let me
>  know what may be going wrong. These patches do not actually
>  modify read/set experimental features.
> - As to CheckPatch failed. No need to modify the MAINTAINERS file.
>  Thanks.
> 
> Changes in v2:
> - Fix the titles of patches 2/3 and 3/3 and reduce their lengths.
> 
> drivers/bluetooth/Kconfig     |   5 ++
> drivers/bluetooth/Makefile    |   1 +
> drivers/bluetooth/btandroid.c | 106 ++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btandroid.h |  10 ++++
> 4 files changed, 122 insertions(+)
> create mode 100644 drivers/bluetooth/btandroid.c
> create mode 100644 drivers/bluetooth/btandroid.h

I am confused now. Did you read my review comments? I do _not_ want it this way; so please read my previous response and don’t send the exact same patch again.

Regards

Marcel

