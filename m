Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E54C77B71
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Apr 2023 09:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjDRJKa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Apr 2023 05:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjDRJK2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Apr 2023 05:10:28 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C904C1A7
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Apr 2023 02:10:26 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-54ee0b73e08so451600787b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Apr 2023 02:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681809026; x=1684401026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sIdLuh0YsEXFhwNIbAtHDqpsY5fap9VloDpWQIFGF4U=;
        b=HosxURX3ChbwZKNn4YKQtISwq82SPHNlHvU8+KQZ1TEkHlYSdwkEaq5scPHbCl4xfi
         Bn9K+Aq8rHGOFtRfFAX/W/jNlA4OEbM3RcKWpfeQg49Tz04TjDhfAAagcTbiN+7QbE12
         axNbUDmR2CwEh2pfVHCZQOC5/sIrtY5ksZBXHQR6EXNAdOAE2jENQNQs2Nfg4u/QCLBf
         DV3HRBDBozCNC6QdYCLkYPYNkIm23y7gtAivT3NTsN50XOwrR+dWwGY9guId5dwq7gWx
         M75rPtPkAmpBcGdTABTXYhOzWmb3V/ic1+DCAo0lrFzBgv3XDlIqoLHtxpL9C6jIImma
         izPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681809026; x=1684401026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sIdLuh0YsEXFhwNIbAtHDqpsY5fap9VloDpWQIFGF4U=;
        b=RirT8mYUQONxlOaPW5P07dONVKcsx/85HgvwUk+C5YsjSy5O/2IYcrCbzm0PQqDhGD
         /lq8QFG5MW0HqNfDKVuGNojTA2YP/HJ86NA+tThJi11MbqRf9bXLIips2IGJDqOgwaUv
         fyxlQPcGxMaSqYxr4Gm88vk2nciEeuG13qgQ3j5fImUhUWzHSa+5jOPiU5PgjaVd8aau
         6/X0nvPLsta8GKkhC0YgLM0lhSMJzUDdPuXTn/nNnnaPFpTzgNTnHtwUCVkwOGZMTAWx
         vOu7OP6NDV8OWcXp0cQ60UZCFhVcDbJ8JfU2QASSCjglvTwunP3BRsi01Zxb9xC1NyFw
         0wJA==
X-Gm-Message-State: AAQBX9dknzV1I/lkDieuoIIf7xi31KpQa+p4eYIJEYfO1m4UPr6QWaUO
        5+HGY2sVJIdKUL5j5giKAB9Hjw0NA4UQuNBWvRenZg==
X-Google-Smtp-Source: AKy350baYiQUbT4k6ozDbpWs1GqPpRg4luYmX8oNyF2aGUcFzmagNtslM3QDJSesiOtxgceK3fvS/HN1TDH2ygSBaB8=
X-Received: by 2002:a81:4f09:0:b0:541:66e8:d4da with SMTP id
 d9-20020a814f09000000b0054166e8d4damr16184276ywb.29.1681809026050; Tue, 18
 Apr 2023 02:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230413064344.18714-1-quic_tjiang@quicinc.com>
 <CAA8EJpoc4nn+Wr131-o=YQoDeL0t7aj9hC=8NNnJa3SeHwgJ-w@mail.gmail.com>
 <934c32ef9427464a9d0b898b843df6ab@quicinc.com> <CAA8EJpqz9o9CtAnXRE86kw-cfL=_d-c5BDAXwQLSJAyZRy_fEg@mail.gmail.com>
 <a908e04e9b7d4b97bc6b5ee3c713e71f@quicinc.com>
In-Reply-To: <a908e04e9b7d4b97bc6b5ee3c713e71f@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 18 Apr 2023 12:10:15 +0300
Message-ID: <CAA8EJprztGdP0yqV=O6P2tn4i0+iQ4rfBVY2x-3_93o3C0c-Nw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Add WCN6855 devcoredump support
To:     "Tim Jiang (QUIC)" <quic_tjiang@quicinc.com>
Cc:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>,
        "mka@chromium.org" <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 18 Apr 2023 at 12:07, Tim Jiang (QUIC) <quic_tjiang@quicinc.com> wrote:
>
> Hi Dmitry:
>
> -----Original Message-----
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Sent: Tuesday, April 18, 2023 5:03 PM
> To: Tim Jiang (QUIC) <quic_tjiang@quicinc.com>
> Cc: marcel@holtmann.org; linux-kernel@vger.kernel.org; linux-bluetooth@vger.kernel.org; linux-arm-msm@vger.kernel.org; Balakrishna Godavarthi (QUIC) <quic_bgodavar@quicinc.com>; Hemant Gupta (QUIC) <quic_hemantg@quicinc.com>; mka@chromium.org
> Subject: Re: [PATCH v2] Bluetooth: btusb: Add WCN6855 devcoredump support
>
> On Tue, 18 Apr 2023 at 04:02, Tim Jiang (QUIC) <quic_tjiang@quicinc.com> wrote:
> >
> > Hi Dmitry:
> >
> > -----Original Message-----
> > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Sent: Saturday, April 15, 2023 5:03 AM
> > To: Tim Jiang (QUIC) <quic_tjiang@quicinc.com>
> > Cc: marcel@holtmann.org; linux-kernel@vger.kernel.org;
> > linux-bluetooth@vger.kernel.org; linux-arm-msm@vger.kernel.org;
> > Balakrishna Godavarthi (QUIC) <quic_bgodavar@quicinc.com>; Hemant
> > Gupta (QUIC) <quic_hemantg@quicinc.com>; mka@chromium.org
> > Subject: Re: [PATCH v2] Bluetooth: btusb: Add WCN6855 devcoredump
> > support
> >
> > On Thu, 13 Apr 2023 at 09:44, Tim Jiang <quic_tjiang@quicinc.com> wrote:
> > >
> > > WCN6855 will report memdump via ACL data or HCI event when it get
> > > crashed, so we collect memdump to debug firmware.
> >
> > Is it applicable only to wcn6855 or to some of earlier chips too?
> >  [Tim]  Also applicable to earlier chips , but currently google only
> > require us to support wcn6855
>
> Since upstream is not a google kernel, please enable this feature for all relevant chipsets.
> [Tim] agreed , but the title of this gerrit unchanged,  I raise a new gerrit for other relevant chipsets , is OK?

There is no gerrit here.

Also, is there any chance you can fix your email client to stop
putting old headers at the top of the email?

>
> >
> > >
> > > Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
> > > ---
> > >  drivers/bluetooth/btusb.c | 222
> > > ++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 222 insertions(+)
>
>
>
>
> --
> With best wishes
> Dmitry



-- 
With best wishes
Dmitry
