Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691E2C432BE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 17:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43F9460F5C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 17:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbhH3RfH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Aug 2021 13:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbhH3RfG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Aug 2021 13:35:06 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B071AC061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 10:34:12 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id s10so7932922lfr.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 10:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P+Kn5C3hZ/a5LYQzUjSn1gRnoxYieHukCUMSNJAxpd8=;
        b=nNWuohS7dRnWDv1QcLnsLhoXb2lJjSdxiOHQCl1tfIfbi58Roy5R7lulRRBlIu+sNs
         smD7oiOKTX4d9gFxHunsw0qx+TtNJxZICaqwd4EEG/nCaY+x/E4TXgVrPVRb+U1HB/3i
         Bd2hThwESypnM6MSRnQRV+qqAJacaDdfMbtW8I0z9qSa8LaivgkAwMPtYwpJE1xOEGkS
         IV9STAK2GpoOM+CVbDyNormmDpNy28gBNWlPfguMEdbeHgldXKNzi42c8x4cJx7R7h1T
         TkwhWAEZ3s2vV4D7vuHD3BlS9uk6zJCw9vNSh92Ckzd0/RcUO/DSCT+mRoCBSPwW5rFW
         yXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P+Kn5C3hZ/a5LYQzUjSn1gRnoxYieHukCUMSNJAxpd8=;
        b=bJMLixXROE0fOJndjCgXIopD3bTRPFrksHf7zMFKe6rALdu/ypgD0/53sL8nzt0YGl
         kL1wyHv/FSC9LCwoq2SbOtKzBgnJ+b74ax3jQ3lPB8vq2mYhQJQaBXSamyQzPdoqOWUh
         mGsjdWcBlfBOropHGqHOf+JiRCQSVCr5s8JTLu3Cn7HYAvnEeU7YFbpF+fXl5ZCib7ox
         5oW3ePXas7OFv0bpXVdPZXKPqIrC04ZT4vcETkTAzNPz/XudSrvsa9MQOSc9scVP/Tpp
         IxoTX0Ll/wooGkphi84diuD4/Ngui1KV0AEtB+WD5xpFOTsKRgzM3Fg1FOXXsAXnJV42
         C6/A==
X-Gm-Message-State: AOAM530Dw3ZutffEk1AFf0gOrikR2AQKDRVyBTFSmf0Ac7n8fhwPIfe1
        fx2SbMTAc5qMrSqSM4p6XjmYJ73l1Vn2a0lr/hIacwF1
X-Google-Smtp-Source: ABdhPJxgWPzCl3FkCp6ark64DRzIVGZRJCNpTKZlLRULBSUY0GcwCu6uJoSE992e8qdgWTt/Si33l+tnwtXaGYdPXZI=
X-Received: by 2002:a05:6512:2356:: with SMTP id p22mr11556191lfu.67.1630344851001;
 Mon, 30 Aug 2021 10:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <5CCD9480-1D51-4744-8F27-CAE06E6A3285@holtmann.org>
In-Reply-To: <5CCD9480-1D51-4744-8F27-CAE06E6A3285@holtmann.org>
From:   Raul Piper <raulpblooper@gmail.com>
Date:   Mon, 30 Aug 2021 23:03:59 +0530
Message-ID: <CAEwN+MAcyx-pBDsN6823ETw7=QA5FDONOA_=+qqtX4_3qtHDhg@mail.gmail.com>
Subject: Re: Anybody still using BlueZ for Android support?
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

sorry if not BlueZ then what in Android. Isn't Android using BlueZ already?
Regards,

On Mon, Aug 30, 2021 at 8:46 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi,
>
> the BlueZ for Android support hasn=E2=80=99t been updated in a long time =
and recent Android version are unlikely to be supported. So my plan is to r=
emove the code to ease the burden on maintaining BlueZ userspace.
>
> Regards
>
> Marcel
>
