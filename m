Return-Path: <SRS0=YCPJ=M6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8121BC5ACCC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Oct 2018 15:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A15821476
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Oct 2018 15:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqvd/avf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A15821476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbeJRXPT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeJRXPT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Oct 2018 19:15:19 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6117020869
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Oct 2018 15:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539875631;
        bh=KMqZBsIeHhkhU9EVQR3Xr0BiB3oGdtGUovxkvmMR9zA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oqvd/avfIdeTF3AoiyPbciDS1637X3kndUfJIlBB2uHE0Sa2onaGyqKjEvV0pYn9c
         wfdmFusCT83uGtkaF1hBzZD4tZQJqV6Mxvv2S8f9tgKSdUlHIC285iN5ZE7pt2yUih
         PvcjPItbj+TAeUDNRd2HzIWPUuHoOY7FELBjHFYs=
Received: by mail-qt1-f171.google.com with SMTP id q41-v6so34611381qtq.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Oct 2018 08:13:51 -0700 (PDT)
X-Gm-Message-State: ABuFfohvfMTC0lG45/adwBTP2TZrkA/58yxxMS+HmD55mFDts3jXdGW5
        Q6248+6EjtG32DjerfiO1S/pGTQaItrRERSGd6Y=
X-Google-Smtp-Source: ACcGV605ardLfIKTirYX0XTC3vRDOT5mEKgzxyiJfD7PQqllB2g6lXdjsATs8Ih/l4Gp4FKZ5ZX00+jfvu3GA9GNFOg=
X-Received: by 2002:a0c:9aea:: with SMTP id k42-v6mr30489642qvf.200.1539875630596;
 Thu, 18 Oct 2018 08:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <1539768048-18665-1-git-send-email-amit.k.bag@intel.com> <1539768048-18665-4-git-send-email-amit.k.bag@intel.com>
In-Reply-To: <1539768048-18665-4-git-send-email-amit.k.bag@intel.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Thu, 18 Oct 2018 11:13:39 -0400
X-Gmail-Original-Message-ID: <CA+5PVA46OeGqSdbpx8OMaBgFT2GtPBAPpRzqTmefh9T1_zCSGw@mail.gmail.com>
Message-ID: <CA+5PVA46OeGqSdbpx8OMaBgFT2GtPBAPpRzqTmefh9T1_zCSGw@mail.gmail.com>
Subject: Re: [PATCH 4/4] linux-firmware: Update firmware file for Intel Bluetooth,8265
To:     "Bag, Amit K" <amit.k.bag@intel.com>
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        ravishankar.srivatsa@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Oct 17, 2018 at 6:15 AM Amit K Bag <amit.k.bag@intel.com> wrote:
>
> This patch updates the firmware file for Intel Bluetooth 8265
> Also it is known as Intel WindStormPeak (WsP).
>
> FW Build: REL0285
>
> Release Version: 20.90.0.3
>
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> ---
>  WHENCE              |   4 ++--
>  intel/ibt-12-16.sfi | Bin 592464 -> 592656 bytes
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied all 4 patches and pushed them out.

josh
