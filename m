Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E088C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 07:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 079F123106
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 07:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbhAFHvd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Jan 2021 02:51:33 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:57326 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbhAFHvd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Jan 2021 02:51:33 -0500
Received: from marcel-macbook.holtmann.net (p5b3d23d0.dip0.t-ipconnect.de [91.61.35.208])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7B6FDCED14;
        Wed,  6 Jan 2021 08:57:43 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH v2] Bluetooth: btrtl: Add null check in setup
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210105205855.v2.1.I9438ef1f79fa1132e74c67b489123291080b9a8c@changeid>
Date:   Wed, 6 Jan 2021 08:50:22 +0100
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Daniel Winkler <danielwinkler@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <A18585F8-9261-45B7-81C1-F305A03CE0FB@holtmann.org>
References: <20210105205855.v2.1.I9438ef1f79fa1132e74c67b489123291080b9a8c@changeid>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

> btrtl_dev->ic_info is only available from the controller on cold boot
> (the lmp subversion matches the device model and this is used to look up
> the ic_info). On warm boots (firmware already loaded),
> btrtl_dev->ic_info is null.
> 
> Fixes: 05672a2c14a4 (Bluetooth: btrtl: Enable central-peripheral role)
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
> Changes in v2:
> - Added nullcheck with goto done
> 
> drivers/bluetooth/btrtl.c | 4 ++++
> 1 file changed, 4 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

