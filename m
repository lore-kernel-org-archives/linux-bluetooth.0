Return-Path: <SRS0=RDM4=7Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C4FC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 19:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2494620723
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 19:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgFLTvE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:51:04 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42043 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgFLTvE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Jun 2020 15:51:04 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id C7817CED0A;
        Fri, 12 Jun 2020 22:00:53 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] mgmt:syncing configuration commands to the documentation.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200611002345.148620-1-alainm@chromium.org>
Date:   Fri, 12 Jun 2020 21:51:03 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <55B95541-2392-493B-8A76-20D40ABD536E@holtmann.org>
References: <20200611002345.148620-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This patch simply fixes the definition names (and corresponding
> implemenation) to the adopted documentation.
> 
> ---
> 
> lib/mgmt.h    | 26 +++++++++++++++++++-------
> src/adapter.c | 16 ++++++++--------
> 2 files changed, 27 insertions(+), 15 deletions(-)

patch has been applied.

Regards

Marcel

