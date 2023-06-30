Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32FEEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jun 2023 22:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjF3Wb0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jun 2023 18:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjF3WbX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jun 2023 18:31:23 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5B03C29
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 15:31:11 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-307d58b3efbso2746662f8f.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 15:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688164268; x=1690756268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpUt64TUG9f/DRzzzxuqwiJUEfTRlaFEKr7xn8qUIWY=;
        b=O0efaCThDHNVytH88XvP6eK7uY/nnz7dm+BTWxdSpgQGtVbt5Pxz5SbhzAZPwV5pqY
         zVvp6Fc+tJjYOE+PxnMmniQVRsPZ6g1g+hLPQTHOlT5ujwHZ7DZLf7LgM61hFJByAWea
         FQmB/VOimdjYChbV7HW41R9vznM4q+8d1TiqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688164268; x=1690756268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpUt64TUG9f/DRzzzxuqwiJUEfTRlaFEKr7xn8qUIWY=;
        b=DjNrY1xYyAabaTEneWL2e/DgF8SknkYfy15kmQSqHEEUA+uNgaFrTfRyW8YmNYtpwG
         etaH59rm3bTiL4uqQYLvUfWLg+MTu4V0BR1MfT6QPtYF+zCNhqFtDsSH4l62PTFPCu53
         JA1J0EtnVtXz8CwegpaCNp/4LxrV1UBLyfQlVOQZ8gzy19ZeYPGhi0ciaZlARmVS7pkA
         z0s5T6hFvIy6yJr4fDFRJWXU9BGgX8SVPNtr7QFiYKwA+l4zxFtGo5l8O+P7AXsPMOw+
         SqEL8a0ShR9I7qXWZAYhBM1EXK0HfuJHJJrWjDtzgawga1yk2/Lho2bXFb9XPTFbtJUG
         8olQ==
X-Gm-Message-State: ABy/qLYqzQ0cyLukqhYS13ZYq+f5ZP9mj07U6Yr0yrhtxa+TnTrc+qiO
        eR6qgwAQ246v1KU3GfstaCGqllQJkHF7/TwFHNB54Q==
X-Google-Smtp-Source: APBJJlF51lCu7CuWMd7/ltVJFpfsKJASt05OmQZKIvK2E27IbjUdIn93XWZ39LKqaTEs4PL5D1mVMA==
X-Received: by 2002:a5d:6812:0:b0:313:e952:e500 with SMTP id w18-20020a5d6812000000b00313e952e500mr3208904wru.7.1688164268711;
        Fri, 30 Jun 2023 15:31:08 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id bu5-20020a170906a14500b0096f6a131b9fsm8523079ejb.23.2023.06.30.15.31.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 15:31:07 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-51d9372f027so3208a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 15:31:07 -0700 (PDT)
X-Received: by 2002:a50:c242:0:b0:506:90c4:b63b with SMTP id
 t2-20020a50c242000000b0050690c4b63bmr22867edf.4.1688164267585; Fri, 30 Jun
 2023 15:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230630143125.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
 <CABBYNZLtxMGQLFwZTztPo2epV2E9Z4uthFMeozxABW2KXQR1nQ@mail.gmail.com> <CAD=FV=XvSCzi1hjgcWa_AecsdG7wbe9o29n2M1cWLezqZk6Dig@mail.gmail.com>
In-Reply-To: <CAD=FV=XvSCzi1hjgcWa_AecsdG7wbe9o29n2M1cWLezqZk6Dig@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 30 Jun 2023 15:30:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VoCaDSS17pRJredtMYPTXiK8uoLOH5hEXaCdqCb9SONA@mail.gmail.com>
Message-ID: <CAD=FV=VoCaDSS17pRJredtMYPTXiK8uoLOH5hEXaCdqCb9SONA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_remove_adv_monitor()
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@google.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Jun 30, 2023 at 3:11=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> > > @@ -1980,9 +1981,10 @@ static int hci_remove_adv_monitor(struct hci_d=
ev *hdev,
> > >                 goto free_monitor;
> > >
> > >         case HCI_ADV_MONITOR_EXT_MSFT:
> > > +               handle =3D monitor->handle;
> > >                 status =3D msft_remove_monitor(hdev, monitor);
> > >                 bt_dev_dbg(hdev, "%s remove monitor %d msft status %d=
",
> > > -                          hdev->name, monitor->handle, status);
> > > +                          hdev->name, handle, status);
> >
> > Just move the call to bt_dev_dbg under msft_remove_monitor,
>
> Sure. I wasn't sure how much the order of the printout matters, but if
> it doesn't then just putting the print first makes sense. Done in v2.

So I assumed that this meant you just wanted me to switch the order,
which I did for v2. ...but then Manish pointed out that meant I wasn't
printing the right status.

Looking again, maybe you meant that I should move the debug statement
into the msft_remove_monitor(). I'm not convinced that's any cleaner.
That would mean adding an "exit" label to that function just for the
printout. It also makes the printout asymmetric with other similar
printouts.

I'm going back to v1 here. If I've misunderstood then I guess I can
always spin again. :-/

-Doug
