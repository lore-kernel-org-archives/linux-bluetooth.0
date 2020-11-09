Return-Path: <SRS0=/O/j=EP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133D7C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 12:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C06D220789
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 12:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgKIMjb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Nov 2020 07:39:31 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:35266 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKIMjb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Nov 2020 07:39:31 -0500
Received: from marcel-macbook.fritz.box (p4fefcf0f.dip0.t-ipconnect.de [79.239.207.15])
        by mail.holtmann.org (Postfix) with ESMTPSA id C0F81CECC5;
        Mon,  9 Nov 2020 13:46:37 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2] Bluetooth: btrtl: Ask 8821C to drop old firmware
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201026082838.26532-1-kai.heng.feng@canonical.com>
Date:   Mon, 9 Nov 2020 13:39:28 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, max.chou@realtek.com,
        alex_lu@realsil.com.cn,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <6F687D4D-95CB-47F5-80DE-DCB2EEDCA80F@holtmann.org>
References: <20201026082838.26532-1-kai.heng.feng@canonical.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kai-Heng,

> Some platforms keep USB power even when they are powered off and in S5,
> this makes Realtek 8821C keep its firmware even after a cold boot, and
> make 8821C never load new firmware.
> 
> So use vendor specific HCI command to ask 8821C drop its firmware after
> system shutdown.
> 
> Newer firmware doesn't have this issue so we only use this trick for old
> 8821C firmware version.
> 
> Suggested-by: Max Chou <max.chou@realtek.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
> - Fix incorrect parAnthesis on le16_to_cpu.
> - Ensure firmware gets re-uploaded in initialization.
> 
> drivers/bluetooth/btrtl.c | 46 +++++++++++++++++++++++++++++++++++++++
> 1 file changed, 46 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

