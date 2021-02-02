Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783DAC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Feb 2021 16:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4742A64E31
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Feb 2021 16:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbhBBQ0N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Feb 2021 11:26:13 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:42717 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236139AbhBBQXo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Feb 2021 11:23:44 -0500
Received: from marcel-macbook.holtmann.net (p4fefcdd8.dip0.t-ipconnect.de [79.239.205.216])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3631DCECDE;
        Tue,  2 Feb 2021 17:30:19 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH v4 0/2] Bluetooth: btusb: Add protocol for MediaTek
 bluetooth devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210202102618.27640-1-mark-yw.chen@mediatek.com>
Date:   Tue, 2 Feb 2021 17:22:52 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, Sean.Wang@mediatek.com,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, robin.chiu@mediatek.com,
        Eric.liang@mediatek.com
Content-Transfer-Encoding: 7bit
Message-Id: <F933AA60-A9AA-48FC-8F59-4338891C50B6@holtmann.org>
References: <20210202102618.27640-1-mark-yw.chen@mediatek.com>
To:     Mark-YW.Chen@mediatek.com
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mark,

> v4:
> 1. add read chip info. from MediaTek bluetooth devices.
> 2. support download firmware for MT7921U.
> 
> mark-yw.chen (2):
>  Bluetooth: btusb: Fine-tune mt7663 mechanism.
>  Bluetooth: btusb: Add protocol support for MediaTek MT7921U USB
>    devices
> 
> drivers/bluetooth/btusb.c | 211 +++++++++++++++++++++++++++++++++++++-
> 1 file changed, 206 insertions(+), 5 deletions(-)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

