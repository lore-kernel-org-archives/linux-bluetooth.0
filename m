Return-Path: <SRS0=Q26+=O3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC7CC43387
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 23:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBD12184C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 23:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeLRXPm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:15:42 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:40800 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeLRXPm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 18:15:42 -0500
Received: from marcel-macpro.fritz.box (p4FF9F1DE.dip0.t-ipconnect.de [79.249.241.222])
        by mail.holtmann.org (Postfix) with ESMTPSA id AE648CEE81;
        Wed, 19 Dec 2018 00:23:19 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH BlueZ v4 25/30] mesh: Add default location for Mesh Node
 storage
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181218223139.8041-26-brian.gix@intel.com>
Date:   Wed, 19 Dec 2018 00:15:40 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        inga.stotland@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <29B57DE0-38C2-4EAE-8851-0598E97BDA8E@holtmann.org>
References: <20181218223139.8041-1-brian.gix@intel.com>
 <20181218223139.8041-26-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

> 
> ---
> configure.ac | 5 +++++
> 1 file changed, 5 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index 1a095a352..901d51e0f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -364,6 +364,11 @@ AC_DEFINE_UNQUOTED(CONFIGDIR, "${configdir}",
> 			[Directory for the configuration files])
> AC_SUBST(CONFIGDIR, "${configdir}")
> 
> +if (test "${enable_mesh}" = "yes"); then
> +	AC_DEFINE_UNQUOTED(MESH_STORAGEDIR, "${storagedir}/mesh",
> +			[Directory for the storage files])
> +fi
> +

why are we bothering with the check around it. We don’t do that for ANDROID_STORAGEDIR either. If there is a reason for it, then that one needs to be fixed first. Also can we please have proper text: "Directory for the mesh daemon storage files"

Regards

Marcel

