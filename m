Return-Path: <SRS0=YM4v=Q4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD213C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Feb 2019 12:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECED2147A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Feb 2019 12:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550751300;
	bh=olCnI40NNedUTzaRsRnT3YFSc6AGJ5vx7/i+0kihzdE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2ulOeyM/e5LyiAY7d9ZK3jknzOujqwd4VwHb3IErcIALzgpQM1kQL+YEajenOwcKQ
	 SF8JzZh8gKukQoCCWtjsvYLcp8pZniXAQMqKe0y8tY45M+jKkKHOtXvt1AmkMq5NIW
	 QOlYlU0iCX1+5vjQH41zvtVVir4EfYABciB/7eEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbfBUMPA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:15:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:47218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfBUMO7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Feb 2019 07:14:59 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C8652086C
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Feb 2019 12:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550751299;
        bh=olCnI40NNedUTzaRsRnT3YFSc6AGJ5vx7/i+0kihzdE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=syP5iTK0pS4Zww27d/MkCNfwoQBgo8WLklXRefxN1g/MFEA/tBkVRud4Moad1NfNP
         L5xfqDbor0a9SJhzjqoCi0QJ3kTUx9GM8G8LQd3o2+59kp1QaH5AZ2eIkooIN7qIse
         t93LckiGpZHH721hnqYzYRHk6sGjdKa19Jmszumo=
Received: by mail-qt1-f171.google.com with SMTP id z25so9416535qti.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Feb 2019 04:14:59 -0800 (PST)
X-Gm-Message-State: AHQUAub661V7jxEYCaxELe5Zuh4/LCZrbvDmthBZ0FXHpSkT4UBzly1P
        iA7edgj2RIsEkpNJwbG6WZ6JFXqW31fNF/5ZTbA=
X-Google-Smtp-Source: AHgI3IYkEe6ZvBS7Gslzp4gzJr9ppc8/HPEHj2WdpDxgJZFNibZHsgMU0maAM04zrClA5wGzeQZqUv/qWozNExPe2Jg=
X-Received: by 2002:ac8:1811:: with SMTP id q17mr21245083qtj.166.1550751298478;
 Thu, 21 Feb 2019 04:14:58 -0800 (PST)
MIME-Version: 1.0
References: <1550636558-16694-1-git-send-email-amit.k.bag@intel.com> <1550636558-16694-2-git-send-email-amit.k.bag@intel.com>
In-Reply-To: <1550636558-16694-2-git-send-email-amit.k.bag@intel.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Thu, 21 Feb 2019 07:14:45 -0500
X-Gmail-Original-Message-ID: <CA+5PVA4SK5bip=xQHsqwkQ4rUrB4X17LMOxJ2SNHbg9TUNLymw@mail.gmail.com>
Message-ID: <CA+5PVA4SK5bip=xQHsqwkQ4rUrB4X17LMOxJ2SNHbg9TUNLymw@mail.gmail.com>
Subject: Re: [PATCH 2/2] linux-firmware: Update firmware file for Intel Bluetooth,9560
To:     Amit K Bag <amit.k.bag@intel.com>
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Feb 19, 2019 at 11:26 PM Amit K Bag <amit.k.bag@intel.com> wrote:
>
> This patch updates the firmware file for Intel Bluetooth 9560
> Also it is known as Intel JeffersonPeak (JfP).
>
> FW Build: REL0395
>
> Release Version: 20.110.0.3
>
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> ---
>  WHENCE                |   8 ++++----
>  intel/ibt-17-16-1.sfi | Bin 641280 -> 642664 bytes
>  intel/ibt-17-2.sfi    | Bin 641280 -> 642664 bytes
>  3 files changed, 4 insertions(+), 4 deletions(-)

Both patches applied and pushed out.  Thanks.

josh
