Return-Path: <SRS0=nALV=6T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D21DC47254
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 May 2020 20:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 205FA20721
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 May 2020 20:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbgEEU6V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 May 2020 16:58:21 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46993 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbgEEU6V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 May 2020 16:58:21 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 20616CECFA;
        Tue,  5 May 2020 23:08:01 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [BlueZ PATCH v2] Fixing opcode definition order
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200504153626.231603-1-alainm@chromium.org>
Date:   Tue, 5 May 2020 22:58:19 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <CF51AB19-BF71-445B-A8E6-5901341E82B3@holtmann.org>
References: <20200504153626.231603-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> Fixing what looks like a bad merge in the opcode order.
> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> ---
> 
> lib/mgmt.h | 16 ++++++++--------
> 1 file changed, 8 insertions(+), 8 deletions(-)

patch has been applied.

Regards

Marcel

