Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDF9C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 20:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 563D661ABA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 20:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347391AbhKOU5V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 15:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347489AbhKOTj7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 14:39:59 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71FDC06122F
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 11:35:56 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id b17so37372889uas.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 11:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=trbZXBrfkdW2jCBd7Yi11+6Z2mNHS8Rp6wG7Q3ZZVcM=;
        b=WXfCpVQPkeaNJGekcNnZt68QuzXI2Mc8pWeMmldNsZTarnpOStZ3uVy6DL45C+BeMx
         lCPHg79aPgxf5wNwXollLuvaEjxxGaXwQHIn3ZJ3YO6kog7z9leH+DlgciPs0nOy02DB
         6vSxyXw3tlrpVAfYM5ca+kdiRSu1x4qaoMaqn9zSCZsEfa/fMXKjTLeaZra9GrrkB4eP
         kCOU7QN5uWl9EvH4hAtCfBnv9c9apDzfH+u2XWf49i/QGag1VhwVCxdVk/DVasFpVZ5e
         tu0Hx0ePcEim47Req3XyjVtzJdSpRnvfSSv3MWGDfV0ov7TT+P84LARupgBjjTJL5r2q
         4XLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=trbZXBrfkdW2jCBd7Yi11+6Z2mNHS8Rp6wG7Q3ZZVcM=;
        b=MbicxNIqK6pTSKhFlB8abEdGZqqU2z3FLBeGddxT73OUWQOazKek36QXXGvzBA4Dp2
         MNo6IH32T8PL3B80bths7SwJT4TS8EfYHCM0t9IynXDrblWryUqodl4bI9tTEa36ouFB
         nV+cj0cikDRDht6NPM4smBeRXFcwtEBJgL5P0efHHay7xCzXV9+X+gY139Ao2GyahIWH
         xMvvo2FsaLr3Q2+FKO63WfBGgiavWCQ4BVKfQ+zC0Lk37kxh0bb9ZhjnAcsWvRG1YNPJ
         IslBRpxEqoinXEAH3eS7qUyE0WnqlhK9yIi4bdkO9AMtaRLhoMcH7xJXs2e/GvWG9Xrj
         7FHg==
X-Gm-Message-State: AOAM5307+OrOBMgy9ZiZNQbPTlRQKREXbxLbYfnpQePpswuEC46M5vy3
        RiHCdol4zSIfmaG2iog5Z3Oh6MS0TKVgev0i2gE=
X-Google-Smtp-Source: ABdhPJxhQZOIdsOU2F+pMQJF/XphiTC5kUsqNo65V7J/vG8FKqZsuZfzdDAwvzh0WvfYxVTVJ79svzGkPjnx3AHR140=
X-Received: by 2002:ab0:5a23:: with SMTP id l32mr1867436uad.129.1637004955841;
 Mon, 15 Nov 2021 11:35:55 -0800 (PST)
MIME-Version: 1.0
References: <20211115135114.2763223-1-alainm@chromium.org> <C44D0F6E-CF4F-44BC-BE13-43F62D083774@holtmann.org>
In-Reply-To: <C44D0F6E-CF4F-44BC-BE13-43F62D083774@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 15 Nov 2021 11:35:45 -0800
Message-ID: <CABBYNZJFZnpGWQJ5Qi=bBPRcjqot10ZODk71Ls-5+GYmgqCo-w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix adv set removal processing.
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Mon, Nov 15, 2021 at 9:07 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Alain,
>
> > When multiple advertisement sets are active and a single instance is
> > removed, the processing of hci_cc_le_set_ext_adv_enable will result in
> > considering all advertisements as disabled since the instance has
> > already been removed from the list.
> >
> > The fix is to use the command parameters to validate the intent rather
> > than making an assumption based on the validity of the adv set.
> >
> > remove_advertising() hci0
> >
> > hci_req_add_ev() hci0 opcode 0x2039 plen 6
> > hci_req_add_ev() hci0 opcode 0x203c plen 1
> >
> > hci_remove_adv_instance() hci0 removing 2MR
> > <-- This removes instance 2 from the adv_instances list
> >
> > hci_cc_le_set_ext_adv_enable() hci0 status 0x00
> > hci_sent_cmd_data() hci0 opcode 0x2039
> > hci_cc_le_set_ext_adv_enable() adv instance 0, enabled 0
> > <-- This incorrectly assumes that all instances are
> >    being disabled while only handle 2 is being disabled.
> >
> > hci_cc_le_set_ext_adv_enable() adv instance list status - before
> > hci_cc_le_set_ext_adv_enable() adv instance 3 is 1
> > hci_cc_le_set_ext_adv_enable() adv instance 1 is 1
> > hci_cc_le_set_ext_adv_enable() HCI_LE_ADV state before: 1
> > hci_cc_le_set_ext_adv_enable() adv instance list status - after
> > hci_cc_le_set_ext_adv_enable() adv instance 3 is 0
> > hci_cc_le_set_ext_adv_enable() adv instance 1 is 0
> > hci_cc_le_set_ext_adv_enable() HCI_LE_ADV state after: 0
> > <-- This is incorrect since handle 1 and 3 are still enabled
> >    in the controller
> >
> > The fix was validated by running the ChromeOS bluetooth_AdapterAdvHealt=
h
> > test suite.
> >
> > Reviewed-by: mcchou@chromium.org
>
> we need clear name and email in the tags please. And I also like to have =
Fixes: tags here as well.
>
> > Signed-off-by: Alain Michaud <alainm@chromium.org>
> >
> > ---
> >
> > net/bluetooth/hci_event.c | 8 +++++---
> > 1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index d4b75a6cfeee..52161d04136f 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -1385,14 +1385,16 @@ static void hci_cc_le_set_ext_adv_enable(struct=
 hci_dev *hdev,
> >                               if (adv->enabled)
> >                                       goto unlock;
> >                       }
> > -             } else {
> > +
> > +                     hci_dev_clear_flag(hdev, HCI_LE_ADV);
> > +             } else if (!cp->num_of_sets || !set->handle) {
> >                       /* All instances shall be considered disabled */
> >                       list_for_each_entry_safe(adv, n, &hdev->adv_insta=
nces,
> >                                                list)
> >                               adv->enabled =3D false;
> > -             }
> >
> > -             hci_dev_clear_flag(hdev, HCI_LE_ADV);
> > +                     hci_dev_clear_flag(hdev, HCI_LE_ADV);
> > +             }
> >       }
>
> Just checking if this wouldn=E2=80=99t be cleaner:
>
>                 } else {
>                         if (foo)
>                                 bar;
>
>                         hci_dev_clear_flag(hdev, HCI_LE_ADV);
>                 }

Actually this seems to already have been fixed by:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3D2128939fe2e771645dd88e1938c27fdf96bd1cd0

Perhaps the Chrome OS tree is outdated?

> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz
