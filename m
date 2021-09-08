Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A0EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Sep 2021 20:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C33A61157
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Sep 2021 20:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349575AbhIHUiC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Sep 2021 16:38:02 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:33165 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhIHUiC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Sep 2021 16:38:02 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 46058CED13;
        Wed,  8 Sep 2021 22:36:52 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v1 1/3] Bluetooth: btandroid: Support Android Bluetooth
 Quality Report
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210908165017.v1.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
Date:   Wed, 8 Sep 2021 22:36:51 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Joseph Hwang <josephsih@google.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <223749E3-DF27-425C-A971-411B314E758A@holtmann.org>
References: <20210908165017.v1.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
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
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> ---
> 
> drivers/bluetooth/Makefile    |   1 +
> drivers/bluetooth/btandroid.c | 106 ++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btandroid.h |  10 ++++
> 3 files changed, 117 insertions(+)
> create mode 100644 drivers/bluetooth/btandroid.c
> create mode 100644 drivers/bluetooth/btandroid.h

so please lets not do this. Nothing AOSP specific belongs into drivers/bluetooth/. Doing this multitudes of dependencies for the drivers will cause long term so much pain and complexity that it is not worth it. If more than one manufacturer supports it, it has earned the right to be in net/bluetooth/ as a pseudo standard.

Like with the MSFT extensions, I expect this to be in net/bluetooth/aosp.c and enabled based on hci_set_aosp_capable() being set by a driver or not.

And I choose “aosp” for prefix on purpose and not “android”.

Regards

Marcel

