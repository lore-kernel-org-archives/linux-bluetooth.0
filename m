Return-Path: <SRS0=OJUr=VD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374DFC468AD
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 10:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A892214AF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 10:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfGFKwU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Jul 2019 06:52:20 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48167 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfGFKwU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Jul 2019 06:52:20 -0400
Received: from [192.168.0.113] (CMPC-089-239-107-172.CNet.Gawex.PL [89.239.107.172])
        by mail.holtmann.org (Postfix) with ESMTPSA id 50269CF163;
        Sat,  6 Jul 2019 13:00:50 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] 6lowpan: no need to check return value of debugfs_create
 functions
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190614071423.GA18533@kroah.com>
Date:   Sat, 6 Jul 2019 12:52:18 +0200
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <1D496433-35A6-478A-8B9D-FEEE557A2CA9@holtmann.org>
References: <20190614071423.GA18533@kroah.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Greg,

> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Because we don't care if debugfs works or not, this trickles back a bit
> so we can clean things up by making some functions return void instead
> of an error value that is never going to fail.
> 
> Cc: Alexander Aring <alex.aring@gmail.com>
> Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: linux-wpan@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> net/6lowpan/6lowpan_i.h | 16 ++-----
> net/6lowpan/core.c      |  8 +---
> net/6lowpan/debugfs.c   | 97 +++++++++++------------------------------
> 3 files changed, 32 insertions(+), 89 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

