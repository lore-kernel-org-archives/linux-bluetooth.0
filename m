Return-Path: <SRS0=uRtI=WR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB94C3A59E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Aug 2019 11:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A625922CF7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Aug 2019 11:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566388409;
	bh=BItdNVXzFbA0HH1Zuvl0AW2u5PxuknfNJOxIayWho0k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tu3Fwpl6pEARTIPQnKPMSuYpI+TXBNPOAjFX+caj5sCJ+bUBKTAmZZ6siT+r4URzf
	 idUbODRALA4+pCR4DOG6KJAQfZxdm0p7DaDI7wRKybJP06A8AwycdWEek9vssoN5hx
	 Tu7uMR2QgA7/3I8YZLddDJTFAovILsoUsXEY5m/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfHULx3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Aug 2019 07:53:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfHULx3 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Aug 2019 07:53:29 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC45C22CF7
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2019 11:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566388408;
        bh=BItdNVXzFbA0HH1Zuvl0AW2u5PxuknfNJOxIayWho0k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wdBOM3H0u9xTMhj2ToBMdJBd+lYHGmxnHsrGp4M947GL4qxyyi46Zkb+4O7Vr00gm
         2vW5BEHW2nBlD2PMkukiB6kN9EB3mFaDu8sslTKLxjjUCgSAoxPJTnfPbxesFXhaBy
         Dq9GznwJiIKUzocLyHGl04Fe4CjiHl91UY0FdZf4=
Received: by mail-qt1-f176.google.com with SMTP id j15so2569299qtl.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2019 04:53:27 -0700 (PDT)
X-Gm-Message-State: APjAAAWgb8XMPuj8kxVuSK9k94Vg6baLkGWCMY24tHuNlbDQ3yoJjWDP
        K0rrthEAl6+mslVOvr+wmlT/v1iiBhPttl6FrCE=
X-Google-Smtp-Source: APXvYqxOX+eOR27Ll7R1C914q85b/gz7SDXEY6gXENR7uLvPDX3MsbNln+EklWwwp6257oNiSsco4ii/EZu7PmO5Pd4=
X-Received: by 2002:ac8:549:: with SMTP id c9mr30862887qth.223.1566388407193;
 Wed, 21 Aug 2019 04:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <1566294301-8854-1-git-send-email-amit.k.bag@intel.com> <1566294301-8854-4-git-send-email-amit.k.bag@intel.com>
In-Reply-To: <1566294301-8854-4-git-send-email-amit.k.bag@intel.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Wed, 21 Aug 2019 07:53:16 -0400
X-Gmail-Original-Message-ID: <CA+5PVA4ogWyvviLe9Hy0YkoxftZ+4QKFF_Nv38zLHLnsuXz=_A@mail.gmail.com>
Message-ID: <CA+5PVA4ogWyvviLe9Hy0YkoxftZ+4QKFF_Nv38zLHLnsuXz=_A@mail.gmail.com>
Subject: Re: [PATCH 4/4] linux-firmware: Update firmware file for Intel
 Bluetooth AX200
To:     Amit K Bag <amit.k.bag@intel.com>
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        chethan.tumkur.narayan@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Aug 20, 2019 at 5:51 PM Amit K Bag <amit.k.bag@intel.com> wrote:
> This patch updates new firmware file for Intel Bluetooth AX200
> Also it is known as Intel CyclonePeak (CcP).
>
> FW Build: REL0318
>
> Release Version: 21.40.0.1
>
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> ---
> WHENCE               |  12 ++++++------
> intel/ibt-20-0-3.sfi | Bin 722072 -> 722132 bytes
> intel/ibt-20-1-3.sfi | Bin 722072 -> 722132 bytes
> intel/ibt-20-1-4.sfi | Bin 722072 -> 722132 bytes
> 4 files changed, 6 insertions(+), 6 deletions(-)

All 4 patches applied and pushed out.

josh
