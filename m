Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AFEEB64DC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jun 2023 22:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjF3WL5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jun 2023 18:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjF3WL4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jun 2023 18:11:56 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95033C22
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 15:11:53 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-992ace062f3so262785566b.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 15:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688163111; x=1690755111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Is887M0LY3foTKHy3QXuE4U0rfFRSbnNfTDJd8nB704=;
        b=BYqQLQjGrLsKQOwv3KAJ37MJ2f3adtFs03MAjLvRr06QMVaBjmxnt1uw71WICoXTop
         SdegnhkChD+CXntjx460Oy+bLM0LmpihJBTdrGU9cRuAgP15DXyJTRGorFtmnC4jn+R7
         iRdQkeESDa83pKEDVHgTsww14XbWg9FnO4sMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688163111; x=1690755111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Is887M0LY3foTKHy3QXuE4U0rfFRSbnNfTDJd8nB704=;
        b=OidYJMjD0+fpzn+XtO0DCcygJU9odWyJyo22C/xOZIiaiqwdSQYWw9CCQc3xHgffFB
         knr+BHPCr6P0R0gpDoY61wv3mTnaKi0rqAs3vWgpr0LZczjLoo+uKz56HJMpgCdNTat0
         HZtwfg+kzzY41LDnHoQE2Xfz33a+F2SaP+0Ppc+VgEMzQtZQDMtPhhza4R1pYPq0CizG
         smGoOPghqlWPDe8X5AyYOl7zrxiRtQuEV9RCIceMJVDu7vLZ8HOuIVWh5vK3rsJ4o185
         S2r1dEmqIqUZI7T9ip6BOZ/h3zIEDRY6l6VxOtnz/jolWW1BHP9U4woHN5gDJR5Rh/FU
         Z7JA==
X-Gm-Message-State: ABy/qLY4oxxbWlDtxitj2SJJlDjIyK+SS6fJAF0u6SsVE08I0wlC4JGP
        TVQZE1+UdlZb0bzV3tHo8e0AaDWXTXLLYWo8EnSE4Q==
X-Google-Smtp-Source: APBJJlEkCc601HJaB8jeeLXBFF3lxivTNajVrXhHudGIoD5/m5qTdZIf63FIB+jUqGisP/bnpqqNIw==
X-Received: by 2002:a17:906:519:b0:98d:fc51:b3dd with SMTP id j25-20020a170906051900b0098dfc51b3ddmr2673482eja.41.1688163111016;
        Fri, 30 Jun 2023 15:11:51 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id d14-20020a170906370e00b00992e265a22dsm1220179ejc.136.2023.06.30.15.11.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 15:11:50 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51ddbf83ff9so3299a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 15:11:50 -0700 (PDT)
X-Received: by 2002:a50:d544:0:b0:50b:c48c:8a25 with SMTP id
 f4-20020a50d544000000b0050bc48c8a25mr28955edj.6.1688163109691; Fri, 30 Jun
 2023 15:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230630143125.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
 <CABBYNZLtxMGQLFwZTztPo2epV2E9Z4uthFMeozxABW2KXQR1nQ@mail.gmail.com>
In-Reply-To: <CABBYNZLtxMGQLFwZTztPo2epV2E9Z4uthFMeozxABW2KXQR1nQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 30 Jun 2023 15:11:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XvSCzi1hjgcWa_AecsdG7wbe9o29n2M1cWLezqZk6Dig@mail.gmail.com>
Message-ID: <CAD=FV=XvSCzi1hjgcWa_AecsdG7wbe9o29n2M1cWLezqZk6Dig@mail.gmail.com>
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

On Fri, Jun 30, 2023 at 2:55=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Douglas,
>
> On Fri, Jun 30, 2023 at 2:40=E2=80=AFPM Douglas Anderson <dianders@chromi=
um.org> wrote:
> >
> > KASAN reports that there's a use-after-free in
> > hci_remove_adv_monitor(). Trawling through the disassembly, you can
> > see that the complaint is from the access in bt_dev_dbg() under the
> > HCI_ADV_MONITOR_EXT_MSFT case. The problem case happens because
> > msft_remove_monitor() can end up freeing the monitor
> > structure. Specifically:
> >   hci_remove_adv_monitor() ->
> >   msft_remove_monitor() ->
> >   msft_remove_monitor_sync() ->
> >   msft_le_cancel_monitor_advertisement_cb() ->
> >   hci_free_adv_monitor()
> >
> > Let's fix the problem by just stashing the relevant data when it's
> > still valid.
> >
> > Fixes: 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv Monitor"=
)
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  net/bluetooth/hci_core.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 48917c68358d..dbb2043a9112 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -1972,6 +1972,7 @@ static int hci_remove_adv_monitor(struct hci_dev =
*hdev,
> >                                   struct adv_monitor *monitor)
> >  {
> >         int status =3D 0;
> > +       int handle;
> >
> >         switch (hci_get_adv_monitor_offload_ext(hdev)) {
> >         case HCI_ADV_MONITOR_EXT_NONE: /* also goes here when powered o=
ff */
> > @@ -1980,9 +1981,10 @@ static int hci_remove_adv_monitor(struct hci_dev=
 *hdev,
> >                 goto free_monitor;
> >
> >         case HCI_ADV_MONITOR_EXT_MSFT:
> > +               handle =3D monitor->handle;
> >                 status =3D msft_remove_monitor(hdev, monitor);
> >                 bt_dev_dbg(hdev, "%s remove monitor %d msft status %d",
> > -                          hdev->name, monitor->handle, status);
> > +                          hdev->name, handle, status);
>
> Just move the call to bt_dev_dbg under msft_remove_monitor,

Sure. I wasn't sure how much the order of the printout matters, but if
it doesn't then just putting the print first makes sense. Done in v2.

> also there
> is no reason to print hdev->name since bt_dev_dbg already does that so
> while at it we can probably fix this as well.

I made that a separate patch just to keep it cleaner. I also fixed the
"add" function which has the same issue.

-Doug
