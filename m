Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527C0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Sep 2021 18:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AC2661165
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Sep 2021 18:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhIUSEl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Sep 2021 14:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbhIUSEl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Sep 2021 14:04:41 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A6FC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Sep 2021 11:03:12 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id x207so48356vke.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Sep 2021 11:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uMcWwlD4KkbttN5sdgIl8rxcI62woAI1Zfppujj7Nks=;
        b=moV1ZlJ4irt298fsSyFVPDyhmJHcjTYx72SVaeQIoJyESn4wMIpnsyYfaIoeTLouMp
         S06SX2FeOsynWnAhmJ01IEm5uagYTtIkdtlbcUDKl6L01jqVRsS0skg1rdg1pVVkcnyR
         ZEPP6bdcB7lg2PQ5I2RAozIcO15BmAdhX7VJ2cNmt8mfCblmHDKTR3RSpF36K62rubB0
         iMeKoMxM1tAehcfPWumTEG7db1ok6ITUkEthhkxve0eCaKQy2ZNBAdMWg0uQaPDQI68T
         y2JJ+YeB3rendNyMW8d7BB6t+QySQApOAeDDQxExYX903X6k6ZDa8fCQj9+Mu3epen/e
         Nprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMcWwlD4KkbttN5sdgIl8rxcI62woAI1Zfppujj7Nks=;
        b=4aTumWL+YXkTyh7bTvWP91L7fT+KGb1+VDCwl5r6DzuFl3HlhkqYzOYrhZ42ien6GU
         LJWawv3lUJml1IEft0SLwuMWgg9W98Sq4dfM3KYfOi2UzsB/CGM18CGsi7Zrnmj8bhrp
         irtRG58S1+OQ53TtNKxNF3cjL8IRnS0PzIYC8NhGWAClEf7zBVeqaogkxXQBLILDfr7z
         9UfWMflSxyc30dXjGRH1speVCBtuo4fxMSxfrODkQjyL9KT643XH+qwjUnIBW/dEPzef
         7lDjErdhkcthmUmIm3nuH1+6xuyDNlhZOcMwqYOW25kVVGNaw2whjntSp9FScovh5ofJ
         l2mA==
X-Gm-Message-State: AOAM533cqOMr7tnE20NunrwX1F+vWXyIENBuHYNZTy76wdHFDp9rBEH5
        SVX6Bqb8EoTAUlg/3HWVM2vyhnbpznMoBfC4lzJ1YAzHhY0=
X-Google-Smtp-Source: ABdhPJzESio86DWxUKsEl+jeqUjmel2DIm4TNKr9WVcj69EDdBVIuv3tlc9LPWBCcRvafZ4F/8Ahec/C4DeR6BKYJhI=
X-Received: by 2002:a1f:1c04:: with SMTP id c4mr19910475vkc.6.1632247391664;
 Tue, 21 Sep 2021 11:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210916201049.114392-1-luiz.dentz@gmail.com> <1F53E938-77D3-4520-B119-11F81C991D44@holtmann.org>
In-Reply-To: <1F53E938-77D3-4520-B119-11F81C991D44@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 21 Sep 2021 11:03:00 -0700
Message-ID: <CABBYNZJhaJGvbuvydtdBa7mHK7kM1Rt+KxKQ9PyNGPM4thwFuA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] Bluetooth: hci_sock: Add support for BT_{SND,RCV}BUF
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Sep 21, 2021 at 1:46 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This adds support for BT_{SND,RCV}BUF so userspace can set MTU based on
> > the channel usage.
> >
> > Fixes: https://github.com/bluez/bluez/issues/201
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > net/bluetooth/hci_sock.c | 102 ++++++++++++++++++++++++++++++++++-----
> > 1 file changed, 91 insertions(+), 11 deletions(-)
>
> so I applied patches 1, 3 and 4 to bluetooth-next tree.
>
> The patch 2 needs a more details review when I have time since I remember there were cases where the SKB copy was really needed.

Is that something not covered by CI testing? Note we still have a copy
done internally with create_monitor_ctrl_command.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
