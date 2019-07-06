Return-Path: <SRS0=OJUr=VD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FB5C0650E
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 13:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B3820989
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 13:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfGFN4y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Jul 2019 09:56:54 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:45730 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfGFN4y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Jul 2019 09:56:54 -0400
Received: from [192.168.0.171] (188.146.228.97.nat.umts.dynamic.t-mobile.pl [188.146.228.97])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6CE01CF12E;
        Sat,  6 Jul 2019 16:05:24 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC] tools: Fix build after y2038 changes in glibc
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190607075133.11255-1-hadess@hadess.net>
Date:   Sat, 6 Jul 2019 15:56:51 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <850B9D99-7BE6-4FF1-9405-FA87AB572CEC@holtmann.org>
References: <20190607075133.11255-1-hadess@hadess.net>
To:     Bastien Nocera <hadess@hadess.net>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

> The 32-bit SIOCGSTAMP has been deprecated. Use the deprecated name
> to fix the build.
> ---
> tools/l2test.c | 6 +++++-
> tools/rctest.c | 6 +++++-
> 2 files changed, 10 insertions(+), 2 deletions(-)

patch has been applied.

Regards

Marcel

