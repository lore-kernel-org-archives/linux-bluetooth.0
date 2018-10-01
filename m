Return-Path: <SRS0=AfC+=MN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4462C43143
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Oct 2018 14:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6047208D9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Oct 2018 14:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Udf504mq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6047208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbeJAUrq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:47:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728979AbeJAUrq (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Oct 2018 16:47:46 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2096C208D9
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Oct 2018 14:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538402987;
        bh=ucMKuR2oC+n3fb1R9Tc+Z/7ptSsQt1j/kj/Maovk4bg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Udf504mqwPaBHxGH/KeQKhWuULaKd5MmxgUmuD+AFx33a6VxU8Ns2izlvitecpDF3
         TlCZQywmO2jTOAe00x526oDtWUF4UNc/IBoPtWKtBrRMMyuLR40BZGWwchmNsibAzk
         6NYdwQOZomrJRDa7lmt0+cBTa4lDn7de4wYUYh1w=
Received: by mail-qt1-f178.google.com with SMTP id q40-v6so1144171qte.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Oct 2018 07:09:47 -0700 (PDT)
X-Gm-Message-State: ABuFfois0t2T0sC5/efgxtFSzCn2YpByAQyXc4CAR56OBVHQ+woLfjh9
        kmG+mSmKishGEOw7g6WHfAKa+0e6HwERZAmAsEs=
X-Google-Smtp-Source: ACcGV63/IHbrcDha+oh7SvLP9+uhSwGbz5XLrwbJHFTghqwjHVP8G3wvs4DQp0XEuAMquRR5O7oeEuw2Y6o/n5adL38=
X-Received: by 2002:a05:6214:1091:: with SMTP id o17mr4604017qvr.97.1538402986370;
 Mon, 01 Oct 2018 07:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180913014518.19180-1-david@lechnology.com>
In-Reply-To: <20180913014518.19180-1-david@lechnology.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Mon, 1 Oct 2018 10:09:35 -0400
X-Gmail-Original-Message-ID: <CA+5PVA4oEz7qc56KrOdV=CES-L0Yw2hzXxahfaMLRk=Hhf=1AQ@mail.gmail.com>
Message-ID: <CA+5PVA4oEz7qc56KrOdV=CES-L0Yw2hzXxahfaMLRk=Hhf=1AQ@mail.gmail.com>
Subject: Re: [RESEND] ti-connectivity: add firmware for CC2560(A) Bluetooth
To:     david@lechnology.com
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Sep 12, 2018 at 9:45 PM David Lechner <david@lechnology.com> wrote:
>
> This adds TIInit_6.2.31.bts and TIInit_6.6.15.bts for TI CC2560 and
> CC2560A Bluetooth chips. These are found in LEGO MINDSTORMS EV3, which
> has mainline kernel support now.
>
> The versions listed are the ones given on the TI wiki[1] where the files
> were obtained. The version in parentheses are the ones found in the
> files themselves.
>
> These files are redistributable under the same LICENCE.ti-connectivity that
> is used by other TI firmwares.
>
> [1]: http://processors.wiki.ti.com/index.php/CC256x_Downloads
>
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  WHENCE                            |   4 ++++
>  ti-connectivity/TIInit_6.2.31.bts | Bin 0 -> 50699 bytes
>  ti-connectivity/TIInit_6.6.15.bts | Bin 0 -> 15614 bytes
>  3 files changed, 4 insertions(+)
>  create mode 100644 ti-connectivity/TIInit_6.2.31.bts
>  create mode 100644 ti-connectivity/TIInit_6.6.15.bts

Applied and pushed out.

josh
