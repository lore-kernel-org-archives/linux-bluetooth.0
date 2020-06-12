Return-Path: <SRS0=RDM4=7Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064B6C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 22:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA78120791
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 22:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CsOw4Dpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgFLWTV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Jun 2020 18:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgFLWTR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Jun 2020 18:19:17 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6971BC08C5C1
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2020 15:19:15 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z9so12771666ljh.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2020 15:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S69gyMNLaOGAiFr7qCBHHiwdlIohIgL0MhzrMbPUZUQ=;
        b=CsOw4DppoW/KZukLdxx5XANt+gyx3ZCgkZNHwyXtURrAp1lCqlx15V5lmbjBu0H78U
         mFwCZ6jbT5V1e1DaMb1cgDFnGJnW0gYnTAMGZXkrCOZybuHa10hRdXKqksVsf8hPtzTn
         LEbL3zFL9ORq9OljOdAg2cp0L3kv14fiCKzjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S69gyMNLaOGAiFr7qCBHHiwdlIohIgL0MhzrMbPUZUQ=;
        b=FKCL51bjGBW3r9p+irSDugaevlMQIz+Q8ldC0usqkqz3B93V/6mX9LvPnMZMukoNxL
         fq1CHNYxIVU4l7qYr6M8efpOJl2g8enOkCxxyQqpRF3mWtSGKm07PvFh7+4dmpTMyuK0
         ssZ70DDRytBmHgKetDI58MH1l+sDwalLlxITJ/lUk80lHsS6jDs4l+02LLBgRv69BYMM
         Z07Y44jVKgI2lfg12X9p52FZj2r4IJdoM4uqreIQEq8JvWwt2/r24SK9j+MSpgLEAkd/
         DB8e9zx8wQ6VNcWOb5srHuTd73vn23z3As+nfecwEZ6/DEd/TmIyVAUtrxLgLtOvKHVP
         9E8w==
X-Gm-Message-State: AOAM533KkDc7eEtttNfYpB6leYmpmaqhbyr8GvMJjvqzjSE+nehpebsi
        0UEr4+F7UQ38Xy+gNL8HDb0Te5CQG80/g4gJvLuGTQ==
X-Google-Smtp-Source: ABdhPJxos6YOXBcGtM2nVczNOEJuzWaHmxynVDeqAdFrSLAp8j+4lf4tWG0biGINRGjJZGeiHM/Yp2M/OmdbiTYDPIc=
X-Received: by 2002:a2e:2202:: with SMTP id i2mr8031631lji.199.1592000352134;
 Fri, 12 Jun 2020 15:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200603160058.v2.1.I636f906bf8122855dfd2ba636352bbdcb50c35ed@changeid>
 <2097432F-C4FA-4166-A221-DAE82B4A0C31@holtmann.org> <CABmPvSHKfS3fCfLzKCLAmf2p_JUYSkRrSfdkePVaHXSrLrXpbA@mail.gmail.com>
 <550BD45A-FE50-48C1-91CB-470D157A728B@holtmann.org>
In-Reply-To: <550BD45A-FE50-48C1-91CB-470D157A728B@holtmann.org>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Fri, 12 Jun 2020 15:19:01 -0700
Message-ID: <CABmPvSE=eX_MqAWvgvOo9B6D+5Y0SzedAbRxrKmopvV+DTo5MQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] Bluetooth: Add definitions for advertisement
 monitor features
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Manish Mandlik <mmandlik@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Yoni Shavit <yshavit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

The name in the mgmt-api.txt doc is "Add Advertisement Patterns
Monitor Command", and Luiz changed the name from
MGMT_OP_ADD_ADV_PATTERNS_MONITOR to MGMT_OP_ADD_ADV_MONITOR before
applied. So we either change the doc or change the header file to
match. Based on the outcome I may need to change the name in mgmt.h in
the kernel patch.

Regards,
Miao

On Fri, Jun 12, 2020 at 6:21 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Miao-chen,
>
> > Thanks for reviewing. Please see v3 for the update.
> > I am trying to settle down the name of Add Advertisement Pattern
> > Monitor command with Luiz on the other thread. I will post the update
> > here once it is sorted out.
>
> I thought the name was just fine. Especially in the discussed context tha=
t we might add another =E2=80=9CAdd=E2=80=9D command for future vendors, bu=
t keep a single =E2=80=9CRemove=E2=80=9D command.
>
> Regards
>
> Marcel
>
