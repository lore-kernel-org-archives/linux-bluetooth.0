Return-Path: <SRS0=Cjqc=2H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEF1C2D0C8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 07:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C757121775
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 07:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfLQHkZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Dec 2019 02:40:25 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:46606 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbfLQHkZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Dec 2019 02:40:25 -0500
Received: from marcel-macbook.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5EEE2CED35;
        Tue, 17 Dec 2019 08:49:34 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH v1 1/2] Bluetooth: hci_bcm: Add device-tree compatible for
 BCM4329
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191215185253.14024-1-digetx@gmail.com>
Date:   Tue, 17 Dec 2019 08:40:21 +0100
Cc:     Rob Herring <robh+dt@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <027DD19D-719E-490F-BDBC-D38939AA3F55@holtmann.org>
References: <20191215185253.14024-1-digetx@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dmitry,

> Driver supports BCM4329, but there is no device-tree compatible for
> that chip. Let's add it in order to allow boards to specify Bluetooth
> in theirs device-trees, in particular this is useful for NVIDIA Tegra20
> boards.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> drivers/bluetooth/hci_bcm.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

