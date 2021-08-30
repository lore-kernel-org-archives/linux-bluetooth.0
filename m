Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CEEC432BE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 15:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75EBB60C3F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 15:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbhH3PQY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Aug 2021 11:16:24 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:39755 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237528AbhH3PQX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Aug 2021 11:16:23 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id ABEEACEC82
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 17:15:28 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Anybody still using BlueZ for Android support?
Message-Id: <5CCD9480-1D51-4744-8F27-CAE06E6A3285@holtmann.org>
Date:   Mon, 30 Aug 2021 17:15:28 +0200
To:     "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

the BlueZ for Android support hasn’t been updated in a long time and recent Android version are unlikely to be supported. So my plan is to remove the code to ease the burden on maintaining BlueZ userspace.

Regards

Marcel

