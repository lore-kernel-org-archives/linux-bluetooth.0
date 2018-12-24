Return-Path: <SRS0=i2N+=PB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6DEC64E75
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Dec 2018 21:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72CC21850
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Dec 2018 21:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbeLXVMJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Dec 2018 16:12:09 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:33986 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXVMJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Dec 2018 16:12:09 -0500
Received: from [192.168.0.117] (188.146.78.210.nat.umts.dynamic.t-mobile.pl [188.146.78.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id E07F9CF2A8;
        Mon, 24 Dec 2018 22:19:47 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH BlueZ v5 30/30] mesh: Enable building Mesh Daemon
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181219042016.25538-31-brian.gix@intel.com>
Date:   Mon, 24 Dec 2018 22:12:06 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        inga.stotland@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <6B9879DB-546D-4B2A-B98C-371E8B2B43D6@holtmann.org>
References: <20181219042016.25538-1-brian.gix@intel.com>
 <20181219042016.25538-31-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

> ---
> Makefile.am | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/Makefile.am b/Makefile.am
> index 7e92977b7..f84a1faba 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -303,6 +303,7 @@ unit_tests =
> include Makefile.tools
> include Makefile.obexd
> include android/Makefile.am
> +include Makefile.mesh

this is so lazy to stay bisectable. At the end of the day, you could do a massive re-write in a single patch and it would be cleaner.

Regards

Marcel

