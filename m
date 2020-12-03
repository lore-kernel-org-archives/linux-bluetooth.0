Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D51C64E7A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 13:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBFCE24133
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 13:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbgLCN12 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 08:27:28 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:54216 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbgLCN12 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 08:27:28 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.193.87])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8FEAFCECFC;
        Thu,  3 Dec 2020 14:34:00 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH] sbc: Add sbc_reinit_msbc
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201123000157.13003-1-pali@kernel.org>
Date:   Thu, 3 Dec 2020 14:26:45 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <5289D46B-D1A7-46E6-84BF-44414B3178B8@holtmann.org>
References: <20201123000157.13003-1-pali@kernel.org>
To:     =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

> This adds a new API function sbc_reinit_msbc. Like sbc_reinit or
> sbc_reinit_a2dp but for msbc.
> ---
> Makefile.am |  6 +++---
> sbc/sbc.c   | 18 ++++++++++++++++++
> sbc/sbc.h   |  1 +
> sbc/sbc.sym |  5 +++++
> 4 files changed, 27 insertions(+), 3 deletions(-)

patch has been applied.

Regards

Marcel

