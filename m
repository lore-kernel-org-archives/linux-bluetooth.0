Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3171EC2BA12
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 13:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2BF206E9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 13:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390938AbgDCNx1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:53:27 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51486 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390930AbgDCNx1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 09:53:27 -0400
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id B74C8CECFF;
        Fri,  3 Apr 2020 16:02:59 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] tools/hciattach_ath3k: Load BT board data based on
 country code
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200331003355.14614-1-sonnysasaka@chromium.org>
Date:   Fri, 3 Apr 2020 15:53:25 +0200
Cc:     linux-bluetooth@vger.kernel.org, yixiang@google.com,
        caiz@google.com
Content-Transfer-Encoding: 8BIT
Message-Id: <7CA6DAE1-09E7-4CEC-BA78-E8C4E104D92E@holtmann.org>
References: <20200331003355.14614-1-sonnysasaka@chromium.org>
To:     Sonny Sasaka <sonnysasaka@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

> BT board data file PS_ASIC-<country-code>.pst is loaded based
> on country code. If not exist, default BT board data file
> PS_ASIC.pst would be loaded.
> 
> This patch doesn't define how to get the country code at the moment, but
> future patches can supply the country code in the region parameter of
> get_ps_file_name.
> ---
> tools/hciattach_ath3k.c | 32 +++++++++++++++++++++++---------
> 1 file changed, 23 insertions(+), 9 deletions(-)

while we can fix parts of hciattach, but I rather remove that tool at some point.

Do you still require it with serdev kernel support? I mean all UART based Bluetooth controllers should be handled via serdev.

Regards

Marcel

