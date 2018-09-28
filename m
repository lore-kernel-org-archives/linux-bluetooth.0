Return-Path: <SRS0=5peh=MK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447A4C43382
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Sep 2018 17:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E9320676
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Sep 2018 17:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E9320676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbeI1Xxm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:53:42 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:33353 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbeI1Xxm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Sep 2018 19:53:42 -0400
Received: from marcel-macbook.fritz.box (p4FEFC9BB.dip0.t-ipconnect.de [79.239.201.187])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3C441CF2A1;
        Fri, 28 Sep 2018 19:36:11 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH] ath3k: add more information to error message
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180927201926.GB19318@giustizia.org>
Date:   Fri, 28 Sep 2018 19:28:54 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <BAD00739-D3ED-48C2-9070-E96B74F5DA3A@holtmann.org>
References: <20180927201926.GB19318@giustizia.org>
To:     Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> When there is an error in either ath3k_load_firmware() or
> ath3k_load_fwfile(), the inlined function ath3k_log_failed_loading() is
> called receiving the error returned and both the block size requested to
> load and the size actually loaded. These values are printed in an error
> message using the macro BT_ERR.
> 
> This patch changes that function in order to print the variable "count"
> as well, to show more information when a failing firmware loading
> operation happens. The calls to the older function were changed to the
> new one.
> 
> This event is being monitored in a laptop with an adapter which
> identifies itself as 0cf3:0036, where sometimes there are errors in the
> firmware loading process.
> 
> Signed-off-by: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
> ---
> drivers/bluetooth/ath3k.c | 12 +++++++-----
> 1 file changed, 7 insertions(+), 5 deletions(-)

patch has been applied (with minor style modifications) to bluetooth-next tree.

Regards

Marcel

