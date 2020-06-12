Return-Path: <SRS0=RDM4=7Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52107C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 19:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A36820792
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 19:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t8LI1Cxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgFLTvv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgFLTvv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Jun 2020 15:51:51 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5184DC03E96F
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2020 12:51:51 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id t9so11494638ioj.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2020 12:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uPGfWs3VpbCyAhpCNKMcXlSM3DOGieyxzbbqbJA1IIU=;
        b=t8LI1CxwUokizneQs+HcsRuLqHbZ2wg+YWjs8mQg6yJajWaUZgkPQj/WS01P61Jdhp
         wvOAqBjktubTe0EQlhCi2aNcP3Nrr1Q/px6oabhZtdWmTqQllXIbsCBNEWvLR/rhOelS
         iYMNFyuRTh8tMCYifXnTysUVJnr5H07IBlYjGNzF3HVF5hb7i0r52i5kkXMwJ9hfucV7
         EY/2RB/r/h3KJxWNll1qp1bpo3UHWd038roUUerxbHq65fiziaum8QjxsWIxDKmugkr9
         Y03s6Ds/eNg6nSZjen6Ftwi9PETcRSKy0JFJFXyy51ZVSSOwMB4ARMGpWOlcoOHFvOh3
         5/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uPGfWs3VpbCyAhpCNKMcXlSM3DOGieyxzbbqbJA1IIU=;
        b=nFFzWjaU3/Yc/27TxSyuVHM8T1Z7KHi2Q8jOkojHyuMy9rb3mtXKU/C7EmE4qDR21n
         JbdcylmIjjncg0m3CZEl4nb6VjTbVaSBmhnKLLZYTO394kyJbnbh5BnFvRYJIpO9utFN
         cObaGfumytoVqFc2dqeksVvISXA04ccFFIIHZg468H2YYVnopLe1Ay3fWidYU/BT+qU1
         fXr5Y6aV/mgZIEzsrHRMq2vEMdyJ+k3FSTYxnoiK/dMtMLbsoLuNmbu1eQJHOP7AZW/x
         hMXUAgV083x4zeSH/49nSXYOdybQXo5W84VFlxNnCAuByHiF7TSMz0MnLO9rNqsNyrOV
         59fw==
X-Gm-Message-State: AOAM532caXAX+5yRaw9x4GvKjB/PKHzPKBEskVloO0Z3S5X25TXlQdZY
        5AV332l/JZxfel/j/SM2tzGd23ggLngQMoAXyG02bA==
X-Google-Smtp-Source: ABdhPJx8JM+ocQC3J0rxN3W1AbtwKHPRvsDsXzApMQ0CsxndW47/UXGXhi6tRCs9aOtPdU9KxvviluBCU9heiOms/HU=
X-Received: by 2002:a05:6602:2431:: with SMTP id g17mr15630656iob.3.1591991510128;
 Fri, 12 Jun 2020 12:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200612193358.203186-1-alainm@chromium.org> <FCDEE47E-B787-4B64-A57B-00EB213AE0CD@holtmann.org>
In-Reply-To: <FCDEE47E-B787-4B64-A57B-00EB213AE0CD@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Fri, 12 Jun 2020 15:51:38 -0400
Message-ID: <CALWDO_X0YS5zsheDcpkB+ZYTT3td820gPusXMC99An9aVMmmBQ@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: Fix op_code size entry from the previous patch
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

OK, thanks!

On Fri, Jun 12, 2020 at 3:42 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> > The previous applied patch introduced an error that was not present in
> > the submitted patch here: https://patchwork.kernel.org/patch/11599123/
> >
> > In particular MGMT_SET_DEF_SYSTEM_CONFIG_SIZE was introduced but
> > MGMT_SET_DEF_SYSTEM_CONFIG was used.
> >
> > Signed-off-by: Alain Michaud <alainm@chromium.org>
> > ---
> >
> > net/bluetooth/mgmt.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 2e0f976e7e04..99fbfd467d04 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -7303,7 +7303,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
> >                                               HCI_MGMT_HDEV_OPTIONAL },
> >       { read_def_system_config,  MGMT_READ_DEF_SYSTEM_CONFIG_SIZE,
> >                                               HCI_MGMT_UNTRUSTED },
> > -     { set_def_system_config,   MGMT_SET_DEF_SYSTEM_CONFIG,
> > +     { set_def_system_config,   MGMT_SET_DEF_SYSTEM_CONFIG_SIZE,
> >                                               HCI_MGMT_VAR_LEN },
>
> This was me being stupid. I had this fixed up in my tree, but forgot to amend the commit. I force pushed a correct commit to bluetooth-next now.
>
> Regards
>
> Marcel
>
