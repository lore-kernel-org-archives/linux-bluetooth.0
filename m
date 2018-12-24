Return-Path: <SRS0=i2N+=PB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD2EC64E79
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Dec 2018 20:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A08D2184A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Dec 2018 20:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbeLXU4J convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Dec 2018 15:56:09 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:41228 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXU4J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Dec 2018 15:56:09 -0500
Received: from [192.168.0.117] (188.146.78.210.nat.umts.dynamic.t-mobile.pl [188.146.78.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0395ACF2A7;
        Mon, 24 Dec 2018 22:03:47 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH BlueZ v5 01/30] mesh: Staging for Mesh DBus API rewrite
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181219042016.25538-2-brian.gix@intel.com>
Date:   Mon, 24 Dec 2018 21:56:05 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        inga.stotland@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <7E58E152-A3BD-465F-9DFF-C2EFBEA2D88E@holtmann.org>
References: <20181219042016.25538-1-brian.gix@intel.com>
 <20181219042016.25538-2-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

totally unclear commit subject and missing commit message explaining what this does.

> 
> ---
> Makefile.am | 1 -
> 1 file changed, 1 deletion(-)
> 
> diff --git a/Makefile.am b/Makefile.am
> index f84a1faba..7e92977b7 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -303,7 +303,6 @@ unit_tests =
> include Makefile.tools
> include Makefile.obexd
> include android/Makefile.am
> -include Makefile.mesh

Please re-read this patch and think about if you want to start a 30 patch series like this.

Regards

Marcel

