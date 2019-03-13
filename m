Return-Path: <SRS0=EDUn=RQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BC3C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Mar 2019 12:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB91E214AE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Mar 2019 12:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552481846;
	bh=cylVKOxGWFd87oQE15CNxJq4VHPsZlEcdQbqSLHXFDc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=c/eRV4sjIFN9unCfR86FCu3pwKSJ1UhOj1BmDfbMoehhiahBL3emUphK3PVvO40tQ
	 0AHVbs2FxcqVobKNFQaQbWKi8AGjPgSoA4YcWDST1kOEiUinR532E1R6igPZb9/m4F
	 FjMDqAMCNqT+4UM8ExPyBmCbeqtvGTtdFyAsP8jI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbfCMM5Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Mar 2019 08:57:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfCMM5Z (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Mar 2019 08:57:25 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1146214AE
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2019 12:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552481844;
        bh=cylVKOxGWFd87oQE15CNxJq4VHPsZlEcdQbqSLHXFDc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TJVreMTf0gbOiadD59CBZq2ECkW/DFbqDV8rzrKCWv6PWDlXvcthy4wEzd/OLqh4d
         2CJuA4Z+j+yrGldCBh5EGSx0egJGenjTWdsxnhxbL9KwXh5NeEjen2fgE3izX4iwJ2
         2giNw3P7nC2hbf6ZSml3Tdy2jh+z3NmC//GkERqQ=
Received: by mail-qt1-f172.google.com with SMTP id v10so1678748qtp.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2019 05:57:24 -0700 (PDT)
X-Gm-Message-State: APjAAAVDHXvjm3+OqNNAvVTq9ZTLPHNttGwv157Gh/I1hrEzRMYZ0ZA4
        CKqGhTPK8/szPRSEUKIszk5rRuA4z+4l4JtnFF0=
X-Google-Smtp-Source: APXvYqwxzJYJxMns7uEx1yp+XUe2KI/YOFX/iYQ951S9NaUcgQteJntNPuOCFaShw4L1oJzUSycHLOuoK4w66erKPhE=
X-Received: by 2002:a0c:9dd0:: with SMTP id p16mr34834482qvf.108.1552481843844;
 Wed, 13 Mar 2019 05:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <1552471452-29683-1-git-send-email-amit.k.bag@intel.com> <1552471452-29683-3-git-send-email-amit.k.bag@intel.com>
In-Reply-To: <1552471452-29683-3-git-send-email-amit.k.bag@intel.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Wed, 13 Mar 2019 08:57:13 -0400
X-Gmail-Original-Message-ID: <CA+5PVA6B1Tj0SgTaDt7UgYgd5aENTNvhUwi6qE3pKyWdj3VRCQ@mail.gmail.com>
Message-ID: <CA+5PVA6B1Tj0SgTaDt7UgYgd5aENTNvhUwi6qE3pKyWdj3VRCQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] linux-firmware: Update firmware file for Intel
 Bluetooth 8265
To:     Amit K Bag <amit.k.bag@intel.com>
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Mar 13, 2019 at 6:08 AM Amit K Bag <amit.k.bag@intel.com> wrote:
>
> This patch updates the firmware file for Intel Bluetooth 8265
> Also it is known as Intel WindStormPeak (WsP).
>
> FW Build: REL0299
>
> Release Version: 21.0.0.4
>
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>

All 3 patches applied and pushed out.  Thanks!

josh
