Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A05CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 17:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A6082070B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 17:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JX0IbVHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgFJRbx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgFJRbw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 13:31:52 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE66C03E96B
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 10:31:52 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id i1so780938vkp.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 10:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ndxJ2dUG7tcQpwf9b8QyaY0jspcb89QKZoq+HINk/ZA=;
        b=JX0IbVHCvLJ/Prz30N/rwWhjOFgrM9ss4p3zsT7TInCT41bUgTmRfrf+UeTpU6QLID
         xrDoCDSG7Qa19K9diMRXXwq1AvlBnT/Llb2dlRL/5WTNXOKOX3C0Anqr3kh2puq7UA1G
         UKWgSjr42Gz7x9Zph2SK4EeIzjSwRDE1NMC9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ndxJ2dUG7tcQpwf9b8QyaY0jspcb89QKZoq+HINk/ZA=;
        b=Ckrka5wTGsOmql+bMhZiTxd2V6wxwMU9B/loj7heixeNwP+USYiuUrbtt2m3yLH2DD
         g6cPKMdoLL6Mz5fNBNnxAiTnkEIx7yRI7TwidVWzbWv/I7XERJTyoDQSja2/j9GefDWY
         vkMlT4i3OVFjXVY71ntOzJokpOzo+Q1LPa0uAZrsaDDhgQqe+eTk5cpAcV91xLs6KcCs
         HZILAvpO3kEEzq/Hl2XxCkpbZR/S1dwO6cY1iz775O5aKS/WuSWSTNPV6Wr9XxOit/0M
         +aE2+xbimoP+ZIQYgxNuxTDmVSIdLBwvotXec/fexn8aJjNLHhoMDWWUjwyLD/EyHF10
         VGeg==
X-Gm-Message-State: AOAM531U2rabHxDzehaFKgi2MAwyugHSu0dWH8yO0PbrSATwPYXwllhl
        P7zjsyfZ/ai0YdsYj3msKQ6dNuLrdyIfrNDpdV0nQLIsiTE=
X-Google-Smtp-Source: ABdhPJwK8OxBYFQPkUHilEIHtFjKVn6ubgd1Nzz15NZ1pygZ/xqQLUBRDekuLrquuGxWlhbPiJtM5Q+fDyq+qCK4ulk=
X-Received: by 2002:a1f:9946:: with SMTP id b67mr2509353vke.100.1591810311173;
 Wed, 10 Jun 2020 10:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200406180331.891822-1-marcel@holtmann.org> <CANFp7mXe3QtkKL8+TgTp=jwvpydABhDkiXks=3h4+op20rWhGQ@mail.gmail.com>
 <AC887BAA-95ED-456B-84D2-2D1EF6A8339F@holtmann.org> <CANFp7mU2+Z3f1ZqR8RCsOUu6Crc_xng12gcgn0YCwjzfH9Y-nQ@mail.gmail.com>
 <8FE42946-ED27-4F9F-8F30-2744D0AC2AB0@holtmann.org>
In-Reply-To: <8FE42946-ED27-4F9F-8F30-2744D0AC2AB0@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Wed, 10 Jun 2020 10:31:39 -0700
Message-ID: <CANFp7mUdL2eB8pWf1sfL_zC0zqTvc7QQuv8xR-pBSDds-Mg5Qw@mail.gmail.com>
Subject: Re: [PATCH] doc: Add commands and event for handling device flags
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks Marcel.

Do you want to handle the implementation in the kernel or shall I send
up a patch?

Abhishek

On Wed, Jun 10, 2020 at 10:23 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Abhishek,
>
> > Coming back to this device flags idea, I think I would prefer the
> > original design over adding new management commands for each flag.
> > Bluez will just have to maintain the current flags and pending flags
> > (i.e. mgmt call) to decide when to emit property changed events for
> > the device WakeAllowed property.
> >
> > 0x0049 and 0x004A are now taken for experimental features but you have
> > my reviewed-by for the next available values for the original patch.
>
> I updated the patch and applied it.
>
> Regards
>
> Marcel
>
