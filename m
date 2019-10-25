Return-Path: <SRS0=fFFM=YS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651BCCA9EBC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Oct 2019 12:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3257C21D7B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Oct 2019 12:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572006820;
	bh=YAd7gggJFVVKLtfZpqLAZriUJ89Cy1FMjTZ4+kVb+rg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EFvITENeEtez6PAxP+yb1jdt9aWJtGfpGOk9Zb/YYtzzR6daqztsRsNPpkin5m1Qc
	 tNrzJPhnZ7cjidX3DFc+S6W+BUF/eT2P9SZvGdiomehIbKkON4ihxfKu6QhJEirB9r
	 Pwy2/ojXElUZSuoEwDGpQmhusuTz6SVpZroeTQWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504488AbfJYMdj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:33:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfJYMdj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Oct 2019 08:33:39 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D437B21D71
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2019 12:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572006819;
        bh=YAd7gggJFVVKLtfZpqLAZriUJ89Cy1FMjTZ4+kVb+rg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OaoroZuoXAJ/qx26iB/1kd8BAKY0Kh3WfRlsDT775bG8to04eGoUYvfySkFWlziqB
         g3Zm0vb3mGC1qfNsXSvT3yK7OnPLPJXDBjLW8q6RZ9irAMZw/c8k3HpeqafvcGmMO3
         /AY97E4L+uXJJq5TigSwKppxqzfcbd2afMXR/Sv0=
Received: by mail-qt1-f171.google.com with SMTP id w14so2921045qto.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2019 05:33:38 -0700 (PDT)
X-Gm-Message-State: APjAAAVQ2IiNrv8gl84klHkpGSI58CzjU2S7U7TXIfBAOp4ywsSbTH1k
        1o1/gdsI0B79544fzcVF2tYsi8RnCRyuVvri6bU=
X-Google-Smtp-Source: APXvYqxx0aftXtZVj6A4YdxeVpZQMZ2Mv3oHoRV8MyHTezZoBpE5lsRK5izKC4o9mPTfZrqWOacZfx9EE1NpavocJf8=
X-Received: by 2002:ad4:57ae:: with SMTP id g14mr602200qvx.95.1572006818030;
 Fri, 25 Oct 2019 05:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <1571823498-13834-1-git-send-email-amit.k.bag@intel.com>
In-Reply-To: <1571823498-13834-1-git-send-email-amit.k.bag@intel.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Fri, 25 Oct 2019 08:33:26 -0400
X-Gmail-Original-Message-ID: <CA+5PVA7BuAJ66LiadBa+-5+6Ep6JOTHOuHXuGMOc3Wc+T_Kgcw@mail.gmail.com>
Message-ID: <CA+5PVA7BuAJ66LiadBa+-5+6Ep6JOTHOuHXuGMOc3Wc+T_Kgcw@mail.gmail.com>
Subject: Re: [PATCH] linux-firmware: Add firmware file for Intel Bluetooth AX201
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

On Wed, Oct 23, 2019 at 5:44 AM Amit K Bag <amit.k.bag@intel.com> wrote:
>
> This patch adds new firmware file for Intel Bluetooth AX201
> Also it is known as Intel HarrisonPeak (HrP).
>
> FW Build: REL0333
>
> Release Version: 21.50.0.1
>
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> ---
>  WHENCE                 |   8 ++++++++
>  intel/ibt-19-240-1.ddc | Bin 0 -> 70 bytes
>  intel/ibt-19-240-1.sfi | Bin 0 -> 722536 bytes
>  intel/ibt-19-240-4.ddc | Bin 0 -> 70 bytes
>  intel/ibt-19-240-4.sfi | Bin 0 -> 722536 bytes
>  5 files changed, 8 insertions(+)
>  create mode 100644 intel/ibt-19-240-1.ddc
>  create mode 100644 intel/ibt-19-240-1.sfi
>  create mode 100644 intel/ibt-19-240-4.ddc
>  create mode 100644 intel/ibt-19-240-4.sfi

Applied and pushed out.

josh
