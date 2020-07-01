Return-Path: <SRS0=mBsK=AM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4480C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 10:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89EDC2073E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 10:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lo6FdJGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgGAKCX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgGAKCW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Jul 2020 06:02:22 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BFEC061755
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2020 03:02:22 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id x9so20555880ila.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2020 03:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6vcIJ8eBrpFXMulGN9ndG9kD25/Ne9bo0gCXN7FEGP0=;
        b=Lo6FdJGLEtRm3FqSKL4z4kXbpSyTOKNf1wb9Dd0kgwnFfbg7eqN84TlJnOHtvtTc8r
         5Rn8kUvzjmf+wHKHO63yy/YHAg85cy53NiP3cZDmUoA1rLyjFiKNSbW8QYgeQFA5HYJS
         ha6MB+B6SwZYgNNn3F9nOti2y8WxNXpvqd+7lwHYgO8KiB20driU4ERlwu3n6FeD5W8F
         dKd9X/DFCjMUp3jPEiHeRdXZOXP4Mq1qJC4mzaNW2UCLd5zLYre6IiniyvMhdAkRKmJ1
         3j8rMBlxHDom8OcdBeVoO546Qv91SIh25FDvIxZoOBE3RouS4rv7T8vubp/b8zbQ7/bn
         Iy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6vcIJ8eBrpFXMulGN9ndG9kD25/Ne9bo0gCXN7FEGP0=;
        b=aRyPMVKh8HiFeXEavmp5Ns0yyygEbMdwutZtGitCCmR4F+hmZqbUb7oSvXFeOvmie8
         p/MVUnK0sFpJ7grWspX8CzywQIENzYMRIHxuIl9bQOCbqFMAhQgKDC62jR8DUUb4MNQQ
         hSrhzc+COnhHKSGdax7fFTG4+BUaLLr19Lja2HF+fLUN0zzP7BGPdr/18D0MpvHR1HGJ
         4ie5M1ar9XAzFn69zpW7S/RXNsi8PRrasboxt/5HUF0r5tKUvAMZOZBZmVTfE7aYk6u/
         yxIuuJ1gDd9kGAkuU5KwDYtIf8U8PsY0GH9mpGSfX0j9LUlzSQHvWONXj3+6bTZB1s97
         vCIQ==
X-Gm-Message-State: AOAM530c5LoSyV3dBzbpAu2bBLzHm0IFXtzZrnIattI1T02JaDXBz8tE
        xBZP8xJUMJHoyYDDlnB/+aDXBNysktgDeE0W3C4=
X-Google-Smtp-Source: ABdhPJwPrua9Vx6V1J8cI3yohBfw8SBO7CISU2R/JFtCpb2Jkh9svH24n7/ehBl4mp2uDhnF2c9D2u5DiAOKNdM7Vvg=
X-Received: by 2002:a92:dd02:: with SMTP id n2mr7019658ilm.257.1593597741812;
 Wed, 01 Jul 2020 03:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200603171713.9882-1-sathish.narasimman@intel.com> <ACE20ACA-6CE3-4348-88E2-D38DF6680C7F@holtmann.org>
In-Reply-To: <ACE20ACA-6CE3-4348-88E2-D38DF6680C7F@holtmann.org>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Wed, 1 Jul 2020 15:32:10 +0530
Message-ID: <CAOVXEJKYiTAwyRAwTinZsVu2PaP-yURcSzZJY=Hrs33xifyYGw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] LL Privacy support
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Sathish Narasimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel

On Fri, Jun 19, 2020 at 1:28 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Sathish,
>
> > Based on the input the patches modified and verifed accordingly.
> >
> > Marcel Holtmann (3):
> >  Bluetooth: Translate additional address type correctly
> >  Bluetooth: Configure controller address resolution if available
> >  Bluetooth: Update resolving list when updating whitelist
> >
> > Sathish Narasimman (4):
> >  Bluetooth: Translate additional address type during le_conn
> >  Bluetooth: Let controller creates RPA during le create conn
> >  Bluetooth: Enable/Disable address resolution during le create conn
> >  Bluetooth: Enable RPA Timeout
> >
> > include/net/bluetooth/hci.h      |   8 ++-
> > include/net/bluetooth/hci_core.h |   3 +
> > net/bluetooth/hci_conn.c         |   6 +-
> > net/bluetooth/hci_core.c         |  17 +++++
> > net/bluetooth/hci_event.c        |  20 ++++++
> > net/bluetooth/hci_request.c      | 119 ++++++++++++++++++++++++++-----
> > net/bluetooth/hci_request.h      |   3 +-
> > net/bluetooth/mgmt.c             |   2 +-
> > 8 files changed, 157 insertions(+), 21 deletions(-)
>
> can you please rebase this against the latest bluetooth-next tree. With t=
he introduction of the advertising monitor, we now have a few conflicts tha=
t you need to resolve.
>
> Also as discussed, we wanted to hide this initially after an experimental=
 feature flag so it would need to be enabled first. And I think once enable=
d, we need to take the support of =E2=80=9Cadvertising=E2=80=9D aka periphe=
ral away from the controller until we can fully ensure it works for scannin=
g and advertising at the same time.

Updated the v3  rebased and the flag is introduced to enable LL
privacy from the host using mgmt set_privacy interface.

what I understood regarding removing of advertising was when we enable
LL privacy using mgmt interface. the advertisement should not work
(correct me please).

>
> Regards
>
> Marcel
>

Regards
Sathish N
