Return-Path: <SRS0=BHgP=2Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D64C2D0C2
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jan 2020 09:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7B8217F4
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jan 2020 09:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgADJwq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 4 Jan 2020 04:52:46 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:52179 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgADJwq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 4 Jan 2020 04:52:46 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id F0BE0CED13;
        Sat,  4 Jan 2020 11:02:00 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [RFC 3/3] Bluetooth: Auto tune if input MTU is set to 0
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200102230057.31326-3-luiz.dentz@gmail.com>
Date:   Sat, 4 Jan 2020 10:52:44 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <CBD1124A-0C1D-499E-88F5-5E9993000AE1@holtmann.org>
References: <20200102230057.31326-1-luiz.dentz@gmail.com>
 <20200102230057.31326-3-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This enables the code to set the input MTU using the underline link
> packet types when set to 0, previously this would likely be rejected by
> the remote peer since it would be bellow the minimal of 48 for BR/EDR
> or 23 for LE, that way it shall be safe to use 0 without causing any
> side effects.
> 
> This is convenient for the likes of A2DP transport, see:
> 
> https://habr.com/en/post/456182/
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 54 ++++++++++++++++++++++++++++++++++++--
> 1 file changed, 52 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

