Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84DDC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Nov 2021 09:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D22B1610A2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Nov 2021 09:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhKJJxF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Nov 2021 04:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhKJJxD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Nov 2021 04:53:03 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FCBC061767
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Nov 2021 01:50:15 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id b12so2947709wrh.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Nov 2021 01:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5UMuJsaXJlRIVYo602teN6Llh/BVk34gSLYOyb29zxk=;
        b=eOEZJPywhVvmUpTHvqbF3DoAFb9DK7kkSLyz6CO+GNOMZvBY59Boj9LUhkhDhxYKmd
         SZwFlFsvJbEN7sLuw53ojB9lY+LWMGg/z98W2a7mr0VJ4NMT7ou5kD2clhc3OWeIj1E9
         nlheyadTrsahoPOMG0coqN2p7PNzf0eGtVY49y8ZXNf/8J8/Y/e3vSp1e1PKjOj+xO0U
         MW7ZI7qaSEPH25GGenrFGrNjdmWfP8yCoyi+5kMvzo30Uknub8086u+nBz7BFvBa0SZK
         ALeEJQ+zKtw7awreQQ+0XK2384MqO7y2EqSdqiEl6bHVUjH/JcrHTQJ2ImeZkb+wbC2r
         ds2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5UMuJsaXJlRIVYo602teN6Llh/BVk34gSLYOyb29zxk=;
        b=WhcF71YIxoUKGuD2X6gyGBBVZxpzKKvrn58egeg4hvaN/8N6b3M2hNMQeYdE/kyi2d
         KpUGpidEvuWg3xwKWZl63tPjDQnHS8b1JLjh/9tfRpENONhrzQP8kjZkwqJsolQmI+Wc
         CNtWVenca2Ln9zt/k94rBSelNK5CQeg2qfRHHWteCg03Ss43CPrTXi1hBm94HYBqqisM
         Fsg9vLdeVZpsGZXop2CYRLG56buoBwJgQZ/GonWCVWoJDZ355jYMPJ2PX4rSDhg8N1Cb
         BWqgjZdGf7y6VjwHH8ZpWko58GQ6UjazSff6Wi5QD9Hd0Xzu3XTUOCdgv9virKlwh1Rc
         hf5w==
X-Gm-Message-State: AOAM530IiNZFZTaaPI7dFPGQWcI/LNxp8XdTbvAu0Xbzt23yX7R6CnBK
        /QS4T0/G+xQAEkMMQFOFSCtSY3W5yu7U09WqsGmEzfi/0Lw=
X-Google-Smtp-Source: ABdhPJw3+QyOwTuj4o0Xt8Y/0172otjk3L79f0H9EZxjWftWA4w0LxN+PKwpCXd9vL4DCDq1U4icg/Ct/cyc5+tzugY=
X-Received: by 2002:a05:6000:1acd:: with SMTP id i13mr18316739wry.398.1636537814086;
 Wed, 10 Nov 2021 01:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20211103133225.v2.1.I3ba1a76d72da5a813cf6e6f219838c9ef28c5eaa@changeid>
 <CAJQfnxEXnoz3q750ZPN=32bS-fDg8pRRp2RqL3txMks-1DLsoQ@mail.gmail.com> <CC006C8F-26D7-44DB-BDAE-93960C474472@holtmann.org>
In-Reply-To: <CC006C8F-26D7-44DB-BDAE-93960C474472@holtmann.org>
From:   Archie Pusaka <apusaka@google.com>
Date:   Wed, 10 Nov 2021 17:50:03 +0800
Message-ID: <CAJQfnxEVmutp6+8oX+=8tE+Hc3SxJvXxnJ3rG3fVy26fTVWYXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: Ignore HCI_ERROR_CANCELLED_BY_HOST on
 adv set terminated event
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Thanks for your prompt reply.


On Wed, 10 Nov 2021 at 17:48, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Archie,
>
> > Could you take a look at this patch?
> >
>
> patch is fine, I am just waiting for the resolution of our pull request before applying new patches.
>
> Regards
>
> Marcel
>
