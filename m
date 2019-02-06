Return-Path: <SRS0=OPIh=QN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F7AC169C4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 15:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC8A2175B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 15:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfBFPp7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:45:59 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:39363 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfBFPp7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Feb 2019 10:45:59 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0CE72CF2A8;
        Wed,  6 Feb 2019 16:53:48 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH BlueZ] shared/io-libevent2: Add support for libevent2
 based IO handing
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190206153045.14788-1-shawn@monadnock.ca>
Date:   Wed, 6 Feb 2019 16:45:57 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <5B669D65-754A-4DA6-8ECD-2BD0797551A8@holtmann.org>
References: <20190206153045.14788-1-shawn@monadnock.ca>
To:     Shawn Nock <shawn@monadnock.ca>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Shawn,

> ---
> src/shared/io-libevent2.c | 247 ++++++++++++++++++++++++++++++++++++++
> src/shared/io.h           |   1 +
> 2 files changed, 248 insertions(+)
> create mode 100644 src/shared/io-libevent2.c

why?

Regards

Marcel

