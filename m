Return-Path: <SRS0=e/tT=4Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B315CC3F2CF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 08:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896A1246A3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 08:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgB1IJU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:09:20 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:50713 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgB1IJU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Feb 2020 03:09:20 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2E9BFCECF6;
        Fri, 28 Feb 2020 09:18:45 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [BlueZ PATCH] Adding missing Phy Configuration bit description.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200227191919.119429-1-alainm@chromium.org>
Date:   Fri, 28 Feb 2020 09:09:18 +0100
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <E1A04114-CFF5-48A3-A061-4F338B79D1DB@holtmann.org>
References: <20200227191919.119429-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This change simply adds the missing Phy Configuration settings bit
> description to the Read Controller Information Command documentation.
> 
> ---
> 
> doc/mgmt-api.txt | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied.

Regards

Marcel

