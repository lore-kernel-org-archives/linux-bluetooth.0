Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF80C7EE22
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 May 2023 02:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjEPC3l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 May 2023 22:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEPC3l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 May 2023 22:29:41 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7675B80
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 May 2023 19:29:39 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f13d8f74abso15581927e87.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 May 2023 19:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684204178; x=1686796178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0NdoRRVsaTM/7abFkjeoSMBtrgqFDGWfwBOlfQ/pK0=;
        b=rEwYrAAgNj70zMMI4UJmuDmDauECYOmtwYCEGaKe37rXZnwrKN4sAxvhSrz1fB1HbC
         I0auXJLHj4mLsAy5t+DRqmdWWKwDi35XhzUoBOQdcp4lHLw4JRAJc7uWjnWZLzW5jdQN
         uUGi1IdCXPp2iCpl6OUB1fjPUjUZKTo7RYgeoEjMI7gHYtu+CR27kJ03uwSvDT9W4GtD
         NLMOHbmsQ/3ulcUo0/UjdtVR1CTNNOF8UFAIfLp0zHPpL53G8cfEvJ3Vx/51YBYjpXIx
         iSs4ENuStJkgZm6jLDigfaY2lJhW1hjfMawoxunc/mgQSM1FXH1/Crh5Enw1/7yni4Vz
         TJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684204178; x=1686796178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0NdoRRVsaTM/7abFkjeoSMBtrgqFDGWfwBOlfQ/pK0=;
        b=Lt6JOvlVXsgnRAMftrlpFcIFFedCXMkZf7IDt1H69Hamq1EMfwbHK1zl2tBbmzpcxW
         xC0pwMzt+vUDlZY78BXXZIvRrwABq+Q/ECw71EjEDFIideJoKnNNancrmOw9ZO7ukCUG
         iPzrEEdYigyr2+m8GMqSt8HDOjGrbPLYrNzv9JukdVqqiEhDDfKLEtjZMmewI05p9K2O
         h1QUwXalUWJDCMLWdgQgG+5+X7L6OpNj3EJh2GwVSP8SiLbqv7fBPtfo7aubWT7eya79
         wl9hrqKQcHWFrhV0sfK9AcT6BVMyRDLyxzwIAPLu5FgH2HIVv+LKmR/fVskj19j3zurr
         /QNA==
X-Gm-Message-State: AC+VfDyCYqlF/toV7MD4N/8SoRMCq1o3mmzqHBtHZ5A/qAzwwEIz0yVE
        1Zy64U3OWxUib0eIa1UKmqCqjTawZ8rvuKbrWT0=
X-Google-Smtp-Source: ACHHUZ59cVULm+j39FRGhOcz1W0o5BqmdNetW/5H5Qa/VH/JSClTrWJVvnu4xQIQSEW5qpF/qTMi5lCIe7wz4Ltl6bY=
X-Received: by 2002:ac2:446b:0:b0:4ef:b18c:89b2 with SMTP id
 y11-20020ac2446b000000b004efb18c89b2mr8299252lfl.56.1684204177714; Mon, 15
 May 2023 19:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230510134557.11486-1-claudia.rosu@nxp.com> <168417961964.11671.9854954504887799038.git-patchwork-notify@kernel.org>
In-Reply-To: <168417961964.11671.9854954504887799038.git-patchwork-notify@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 15 May 2023 19:29:25 -0700
Message-ID: <CABBYNZKnzvHn4y424Z4T+fres+ySJFNkJ9+k00qi8j7RKZS1xg@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] Bluetooth: Check for ISO support in controller
To:     patchwork-bot+bluetooth@kernel.org
Cc:     Claudia Draghicescu <claudia.rosu@nxp.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Claudia,

On Mon, May 15, 2023 at 12:56=E2=80=AFPM <patchwork-bot+bluetooth@kernel.or=
g> wrote:
>
> Hello:
>
> This patch was applied to bluetooth/bluetooth-next.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Wed, 10 May 2023 16:45:56 +0300 you wrote:
> > This patch checks for ISO_BROADCASTER and ISO_SYNC_RECEIVER in controll=
er.
> >
> > Claudia Draghicescu (1):
> >   Check for ISO_BROADCASTER and ISO_SYNC_RECEIVER bits in adapter's
> >     supported features
> >
> >  include/net/bluetooth/hci.h      | 1 +
> >  include/net/bluetooth/hci_core.h | 1 +
> >  include/net/bluetooth/mgmt.h     | 2 ++
> >  net/bluetooth/mgmt.c             | 6 ++++++
> >  4 files changed, 10 insertions(+)
>
> Here is the summary with links:
>   - [v2,1/1] Bluetooth: Check for ISO support in controller
>     https://git.kernel.org/bluetooth/bluetooth-next/c/fd4fbf8cd81f
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html

Btw, we need to update the documentation:

https://github.com/bluez/bluez/blob/master/doc/mgmt-api.txt#L336

And decoding support:

https://github.com/bluez/bluez/blob/master/monitor/packet.c#L12656

>


--=20
Luiz Augusto von Dentz
