Return-Path: <SRS0=wTsk=PW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7667DC43387
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jan 2019 17:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5B52086D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jan 2019 17:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547486604;
	bh=/R5P5JI5LxOZr++VFkk+FPiBVO/kGLCBeHT1D5s7gao=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=F4KNOL7tCR/nP7sakMBamOKf3AjNPIHs3dLuaElMGmPuLIxOdnAhftkbNYdyMBhOF
	 oMItkWS8UG6mYvzcyBeOKF6h4ZLCzh5LkUx8qIE5anq82ESBzuThPz/+j8CjvaegsK
	 S6mFOknTtF/1oeMfMeAMffhcNksgyyPzA8r0NQMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfANRXX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:23:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:50356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfANRXX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Jan 2019 12:23:23 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 106E720873
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jan 2019 17:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547486603;
        bh=/R5P5JI5LxOZr++VFkk+FPiBVO/kGLCBeHT1D5s7gao=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bswwTkh38YKAc0rdeDuZWM6B11PtnjSV23zIBKeTAyqjC4VX23wnHxDmMJeeLZgi7
         Z/ZmpNFzyEGA4TQyqJt6ACC/E0s4cvfD6VFNIpgcUD/AbQteYOpB9Q3pWh0/zkSZKv
         PR71vAVmxRGQE+70s3D/Ggm/d47nJhm4qDj8N0mg=
Received: by mail-qk1-f176.google.com with SMTP id q8so11015428qke.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jan 2019 09:23:23 -0800 (PST)
X-Gm-Message-State: AJcUukfpO1e8enKU3tUuWuTXhO8kbM7kx6iVHoOEouBCno2u8K0FTaBc
        6OvNmhAPm2mnH2j+I6POPn+tkRXsX7+6lHBeaDU=
X-Google-Smtp-Source: ALg8bN7gZ4r8ZH/ir3qedfyWGbYAebnVbCdSheS62ygIdaewMTDWhhaHrGtK80cwkhFSNREuzhuyHTEQDLvxu99xc9Q=
X-Received: by 2002:a05:620a:151a:: with SMTP id i26mr23067335qkk.281.1547486602282;
 Mon, 14 Jan 2019 09:23:22 -0800 (PST)
MIME-Version: 1.0
References: <1545389940-9170-1-git-send-email-amit.k.bag@intel.com>
In-Reply-To: <1545389940-9170-1-git-send-email-amit.k.bag@intel.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Mon, 14 Jan 2019 12:23:07 -0500
X-Gmail-Original-Message-ID: <CA+5PVA7YcEhEdPj6DOYR=kHOxzMZkbeP6-QHq62Jx9qk3=j4hg@mail.gmail.com>
Message-ID: <CA+5PVA7YcEhEdPj6DOYR=kHOxzMZkbeP6-QHq62Jx9qk3=j4hg@mail.gmail.com>
Subject: Re: [PATCH 1/4] linux-firmware: Update firmware file for Intel Bluetooth,9560
To:     Amit K Bag <amit.k.bag@intel.com>
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        chethan.tumkur.narayan@intel.com, ravishankar.srivatsa@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Dec 21, 2018 at 6:02 AM Amit K Bag <amit.k.bag@intel.com> wrote:
>
> This patch updates the firmware file for Intel Bluetooth 9560
> Also it is known as Intel JeffersonPeak (JfP).
>
> FW Build: REL0386
>
> Release Version: 20.100.0.3
>
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> ---
>  WHENCE                |   8 ++++----
>  intel/ibt-17-16-1.sfi | Bin 640328 -> 641280 bytes
>  intel/ibt-17-2.sfi    | Bin 640328 -> 641280 bytes
>  3 files changed, 4 insertions(+), 4 deletions(-)

All 4 patches applied and pushed out.

josh
