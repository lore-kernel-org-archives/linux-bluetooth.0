Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C69DC77B7A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Jun 2023 23:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240221AbjFFXPC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Jun 2023 19:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240228AbjFFXOl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Jun 2023 19:14:41 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FE510CE
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jun 2023 16:14:40 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b1fe3a1a73so3694591fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jun 2023 16:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686093278; x=1688685278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AJRf76VOMGQ7elOeldYPxpvpVH6Pm4XRW46qmUu/oM=;
        b=lItvUvVBAYpZeooXG6HNgeRs30i2TrwvIu27A8ea4VNLvOn5GZUbhkRRjfE+8BnJPD
         iWoPk9SaMotjzf0hamGJEo552jQEtuhk+HMN4/5s3rq7gLNHQpL0UGuglY04NNiWcfco
         TWHWZZPC05QL7A2JMdqhbiUf3hazwSglgm/SnVECVeWkBZHT+U8FixaXS7H8x4TWbsCa
         QYSiswuhBm33+mMDJuxP1s9FyEMJCj72+VkA7juzUhLBMbnol2K1t9iIq4/i5JTkKhfk
         fv4dL43BdhNwiLSOpq2iJCM4BTXPfjErd82pUnjijma2IHPdgA4a198ISaembg5HQ6UJ
         5zgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686093278; x=1688685278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AJRf76VOMGQ7elOeldYPxpvpVH6Pm4XRW46qmUu/oM=;
        b=AZh79DfynrImrx2C+h5WZdUXm7Is4ZIFxLp97eww+N9Wye5LPE3h9eb/im/cyMfwQh
         9tASn3bERu0gH5RRyjXqjFWdI0rtRgH/cIVubskIVOTsCjKc0g3lLjXapk+0yFqTHX4/
         TBidkOQW0HoM98L+LJ3ebdiTaYJBPyFX7WSuHTpi9sfjjmtqVx5QSPl69JjfXaev8RiM
         ZqgcoBy5tYUIfDAMjiTmr1qLODKMoIXHw+qUBmEZ3fiAR1O3Zaf3Fa0iY7RaU+q4Nvjj
         qlx+/4S13OKHbW3qctffb+p0EoNLdJw7r45sjOH/5sNQeEQg+TIkeYprF9O5AdDXi1S8
         Dc1Q==
X-Gm-Message-State: AC+VfDwcqHDPTabbVze50m/++z9L0oksSvWi0bR/RDVOar5jAwFiE6M+
        Rvayi1ov9NHfxoyucAWVj9wVsU08puWg3J6XC9o5twEe
X-Google-Smtp-Source: ACHHUZ5eczZF6/1jRVAbAKyxRBxesPwse7vbYUqKITBPDODgGdhbAmOWzaXDAsyo42wOzVZM83jeTAFMVOeznnC9+ZE=
X-Received: by 2002:a2e:3313:0:b0:2ac:819f:f73f with SMTP id
 d19-20020a2e3313000000b002ac819ff73fmr1889619ljc.20.1686093277958; Tue, 06
 Jun 2023 16:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230606120824.4705-1-nitin.jadhav@nxp.com>
In-Reply-To: <20230606120824.4705-1-nitin.jadhav@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 6 Jun 2023 16:14:25 -0700
Message-ID: <CABBYNZJZJTSpm4MNpBq-Q2gUozLz2S9c4p-Zya6CwnWWv=QfxA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 0/2] Code handling for VOCS service
To:     NJNXP <nitin.jadhav@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, devyani.godbole@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Nitin,

On Tue, Jun 6, 2023 at 5:09=E2=80=AFAM NJNXP <nitin.jadhav@nxp.com> wrote:
>
> Hello Maintainers
>
> This patch series handles code implementation for mandatory features of
> Volume Offset Control Service.
>
> Implementation of following features have been handled in this patch
> series
> - Volume Offset Control Service
> - Volume Offset State Characteristic (Read, Notify)
> - Audio Location Characteristic (Read)
> - Volume Offset Control Point Characteristic (Write)
> - Audio Output Description Characteristic (Read)
> - Set Volume Offset
>
> All the code implementation has been tested using PTS testing the
> verdict is PASS for all mandatory test cases.

Great, though at this stage I think it would be even more important to
have a unit tester for the bt_vcp instance, just as we do have for
bt_bap and bt_bass in unit/test-bap.c and unit/test-bass.c
respectively, this would help us making sure there are no memory
issues and avoid introducing regressions going forward.

> Thank you in advance for your review.
>
> Warm Regards
> Nitin Jadhav
>
> NJNXP (2):
>   Added initial code for handling VOCS
>   Fixed the following issue observed during PTS testing for mandatory
>     test cases - Specified Upper and Lower Limit for Volume offset -
>     Corrected the number of handles for VOCS - VOCS is made as included
>     service of VCS because VOCS is secondary service and VSC is primary
>     service
>
>  lib/uuid.h       |   5 +
>  src/shared/vcp.c | 547 ++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 550 insertions(+), 2 deletions(-)
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
