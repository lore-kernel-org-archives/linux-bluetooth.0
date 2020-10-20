Return-Path: <SRS0=VvJN=D3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE5AC388F7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Oct 2020 20:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0050422256
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Oct 2020 20:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GoQ+EVKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409589AbgJTUlX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Oct 2020 16:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405178AbgJTUlW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Oct 2020 16:41:22 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF0EC0613D3
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2020 13:41:21 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id s2so804723vks.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2020 13:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8oNb4bPuTPJc9IazjKYiO1BrhZxahR3FAJrD2QNpZEE=;
        b=GoQ+EVKaGML1O0xuJJyCjTyBiaV9U1ZfOBGG8NL6oeTeU5wmSLXa0hXtERape/LFcS
         qtAE7eYPxGswSe7yyoFdd27uU/nT8A6GhdRO4zLnhYDUh1mpbyNp66Mfg/QfLYOugVpR
         H07ef9O5BRyU6uQFsy3Yu6D/+/T9GWoSvHj4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8oNb4bPuTPJc9IazjKYiO1BrhZxahR3FAJrD2QNpZEE=;
        b=TwOo5Q2zvStAAICiwIGzCU0zx6FSl5aLO3zNk51FRyor6NOw5YLSkHEdxpynt2DQSd
         7Yvir2QT82atxm9QhHb999O21/FAKyvgduweCbce3IF7W8XLbpvPTuz3qQUoWqn2n2+0
         IZfG+zC07Xa1EAWPDrH07e+ByuEglwY765W2jKvJh0LTTZCxnmYrnJXusBOIoAMLQ+rA
         5sIbg1Gn+Yf93uzlmKXlzFOl7gWVdPkcn9JWE+A7IkaMnxnQ60aHxOc01AD83IcYaMXY
         2v6e5UPBI6/2VZ1y4Q8cZqYYwi6NNZzC77TwQuWIFos06BXVV44mRJetwzd/wH6W64Vy
         zJPg==
X-Gm-Message-State: AOAM530BjgVdFDvKQluHHnh7dfL02Hdorsoqt+cwFXg03MBtJ/A+JnVY
        KR4Urv24UGUt2+ncERdhLT6Hiq26m8+8pQ7axCyIqQ==
X-Google-Smtp-Source: ABdhPJzr5l3bDAXW3EOAftEuudCHyMKi5cGy1Hw3cWDeuY2TudVm6cfkI7qnQuUSnjYigue2Up2FbPDYaIBW9jh8e/k=
X-Received: by 2002:a1f:9d0e:: with SMTP id g14mr2712231vke.2.1603226480594;
 Tue, 20 Oct 2020 13:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <b74ea9cb201bb98691ecbfb3893d2a49@codeaurora.org> <CANFp7mXMfvHrAcaJhY7q2oZk3MtqOMxLGOEpNc-hnzVSyA+LZA@mail.gmail.com>
In-Reply-To: <CANFp7mXMfvHrAcaJhY7q2oZk3MtqOMxLGOEpNc-hnzVSyA+LZA@mail.gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 20 Oct 2020 13:41:09 -0700
Message-ID: <CANFp7mWTPLKx=eKxgZvXGEPi5KbphDJnSGZb12Efe_SWTKdDdg@mail.gmail.com>
Subject: Re: Update WCN3991 FW file
To:     asitshah@codeaurora.org
List-Id: <linux-firmware.lore.kernel.org>
Cc:     linux-firmware@kernel.org, jwboyer@kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, Hemantg <hemantg@codeaurora.org>,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It looks like we hadn't merged an earlier update to crnv32.bin in ChromeOS:
ad1da95 - QCA : Updated firmware files for WCN3991 (3 weeks ago) <Asit Shah>

After merging that commit, everything is working as expected.
--

Tested-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

On Mon, Oct 19, 2020 at 2:37 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Nack.
>
> This resulted in a boot loop on ChromeOS. It looks like only
> 'crbtfw32.tlv' was changed and not 'crnv32.bin'.
>
> Abhishek
>
> On Sat, Oct 17, 2020 at 8:33 AM <asitshah@codeaurora.org> wrote:
> >
> >
> > Hi Team,
> >
> > Please include updated firmware bin for WCN3991.
> >
> > Snapshot of pull request is as below, let me know if anything is
> > missing.
> >
> > >>>>>
> >
> > The following changes since commit
> > 58d41d0facca2478d3e45f6321224361519aee96:
> >
> >    ice: Add comms package file for Intel E800 series driver (2020-10-05
> > 08:09:03 -0400)
> >
> > are available in the git repository at:
> >
> >    https://github.com/shahasit/bt-linux-firmware/tree/master
> >
> > for you to fetch changes up to 8877322c1254f327f47c86ec02c46013b68b9a47:
> >
> >    QCA : Updated firmware file for WCN3991 (2020-10-17 20:53:36 +0530)
> >
> > ----------------------------------------------------------------
> > Asit Shah (1):
> >        QCA : Updated firmware file for WCN3991
> >
> >   qca/crbtfw32.tlv | Bin 126300 -> 126832 bytes
> >   1 file changed, 0 insertions(+), 0 deletions(-)
> >
> > <<<<<<
> >
> > Regards,
> > Asit
