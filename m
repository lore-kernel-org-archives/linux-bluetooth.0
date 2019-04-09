Return-Path: <SRS0=4NR/=SL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32F6C10F0E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Apr 2019 10:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33CB20818
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Apr 2019 10:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554806309;
	bh=gjSnGaNQiLiUs2Kcnh+kGZDLOHY2hKJ/Q8tLfBznbyg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZM5vqXDDvnlUexxKsQU0c2PHlIzXxFC8kO85ej5+5UMtUyo+LexwzwxmVo3reV851
	 q4kx0DJCYZ8aJ7dlQscY5uMX4EWRToDRu/BGFHnAVzwjajDBRtxCPV+aoiteDliMAr
	 nnIB8SJAj50YCEbMFt0p/pM+uQG8EejeBZEUxSeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfDIKi3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:38:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfDIKi3 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Apr 2019 06:38:29 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22B2720818
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2019 10:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554806308;
        bh=gjSnGaNQiLiUs2Kcnh+kGZDLOHY2hKJ/Q8tLfBznbyg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=we8tXrbnHuUK+sv+2MR/PCEiZscQRJpxC4VFajkUWkxhuIYrFTxc+GqhJLE2m7/7D
         BVo3mh0Pa4kt4EHADwvHYZA46ygc33RVZKfYVVvwJ8g/inaQyZGaNDtocXiB4etAUN
         vP4jIMDom2nM7q59MQHJ63X2bOvKHhgUacn5dNIU=
Received: by mail-qt1-f177.google.com with SMTP id s15so10717890qtn.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Apr 2019 03:38:28 -0700 (PDT)
X-Gm-Message-State: APjAAAXI0ASjqMf2MXOpb045neu3UTGuXlxf9AK5/jGUGbukOJtPG/9i
        GV2wwR4U1MTy86b5wkllc+AAjgPNg8bYYsD1Pdk=
X-Google-Smtp-Source: APXvYqxTds6gIOSqKm0mYCus9SGt07JD612v2bx1W14odFRETJiII7XEZmBhYNKcsoZOEFI7IZgf1jFE/e1KYnojmE4=
X-Received: by 2002:aed:3b9c:: with SMTP id r28mr28730202qte.22.1554806307435;
 Tue, 09 Apr 2019 03:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <1554352527-7316-1-git-send-email-amit.k.bag@intel.com>
In-Reply-To: <1554352527-7316-1-git-send-email-amit.k.bag@intel.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Tue, 9 Apr 2019 06:38:14 -0400
X-Gmail-Original-Message-ID: <CA+5PVA7MhUYFp+aHf89PDB79_W96p+AJ3O31oDuDV4han+4p5g@mail.gmail.com>
Message-ID: <CA+5PVA7MhUYFp+aHf89PDB79_W96p+AJ3O31oDuDV4han+4p5g@mail.gmail.com>
Subject: Re: [PATCH] linux-firmware: Add firmware file for Intel Bluetooth 22161
To:     Amit K Bag <amit.k.bag@intel.com>
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Apr 4, 2019 at 12:39 AM Amit K Bag <amit.k.bag@intel.com> wrote:
>
> This patch adds new firmware file for Intel Bluetooth 22161
> Also it is known as Intel CyclonePeak (CcP).
>
> FW Build: REL0246
>
> Release Version: 21.0.0.4
>
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> ---
>  WHENCE               |   9 +++++++++
>  intel/ibt-20-0-3.ddc | Bin 0 -> 70 bytes
>  intel/ibt-20-0-3.sfi | Bin 0 -> 755276 bytes
>  intel/ibt-20-1-3.ddc | Bin 0 -> 70 bytes
>  intel/ibt-20-1-3.sfi | Bin 0 -> 755276 bytes
>  5 files changed, 9 insertions(+)
>  create mode 100644 intel/ibt-20-0-3.ddc
>  create mode 100644 intel/ibt-20-0-3.sfi
>  create mode 100644 intel/ibt-20-1-3.ddc
>  create mode 100644 intel/ibt-20-1-3.sfi

Applied and pushed out.

josh
