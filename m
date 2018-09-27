Return-Path: <SRS0=a08L=MJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651C8C43382
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 10:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEAD21571
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 10:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BEAD21571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbeI0RF7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:05:59 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38611 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeI0RF7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Sep 2018 13:05:59 -0400
Received: from marcel-macbook.fritz.box (p4FEFC9BB.dip0.t-ipconnect.de [79.239.201.187])
        by mail.holtmann.org (Postfix) with ESMTPSA id CE7FDCF16A;
        Thu, 27 Sep 2018 12:55:33 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH] ath3k: add warning when switch pid is not working
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180907233549.GE3379@giustizia.org>
Date:   Thu, 27 Sep 2018 12:48:17 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <BE213F03-E020-4046-BF60-8723902BCD71@holtmann.org>
References: <20180907233549.GE3379@giustizia.org>
To:     Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This patch adds a warning message in the ath3k driver when
> ath3k_switch_pid() returns error.
> 
> This event happens in a specific laptop, with an adapter which
> identifies itself as 0cf3:0036. Surprisingly, the adapter works even
> after this event - hence a warning is chosen instead of an error.
> 
> The current version of ath3k doesn't check the return value of
> ath3k_switch_pid() and so this event may remain undetected in the
> original version.

if works anyway, why bother with a warning? I have no idea what benefit this has.

Regards

Marcel

