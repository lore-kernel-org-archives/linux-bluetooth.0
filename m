Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468F9C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 12:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E7FB60E8B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 12:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbhGWLb1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jul 2021 07:31:27 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36693 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbhGWLb1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jul 2021 07:31:27 -0400
Received: from smtpclient.apple (p5b3d2eb8.dip0.t-ipconnect.de [91.61.46.184])
        by mail.holtmann.org (Postfix) with ESMTPSA id DAFAFCECFB;
        Fri, 23 Jul 2021 14:11:58 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v3 3/3] Bluetooth: hci_h5: Add runtime suspend
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210723193137.v3.3.I4b323d2adf1dca62777c41de344a7d2f79b7f908@changeid>
Date:   Fri, 23 Jul 2021 14:11:58 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Hilda Wu <hildawu@realtek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <5D556B00-620B-4AEA-B2C9-DB18A5AAF033@holtmann.org>
References: <20210723193137.v3.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
 <20210723193137.v3.3.I4b323d2adf1dca62777c41de344a7d2f79b7f908@changeid>
To:     Archie Pusaka <apusaka@google.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

> This patch allows the controller to suspend after a short period of
> inactivity.
> 
> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Reviewed-by: Hilda Wu <hildawu@realtek.com>
> 
> ---
> 
> Changes in v3:
> * Reordering #include
> 
> drivers/bluetooth/hci_h5.c | 20 ++++++++++++++++++++
> 1 file changed, 20 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

