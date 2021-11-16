Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01490C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 20:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3DD563215
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 20:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhKPUxO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Nov 2021 15:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhKPUxN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Nov 2021 15:53:13 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF3DC061570
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Nov 2021 12:50:16 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id l8so509908ilv.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Nov 2021 12:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=efqFHOeANayC0baa4+ILoJW70HiGRxSCs5RfDwIXPis=;
        b=NuRY3L7Akac8I9t/0ACCZTF9c/xmNs/MMOU3PlcMDH/AYY3OWWgxQSLEyqNveJyo/4
         7Aw9ks9oQFkwzc156afAA8E/eYVtNEsxaauyywJHGssLqFtc536lrADDHH3Fw/sGNevS
         BuxAV8fe9FVjsOG4DMTdU+yUpIulFrAuqcQbyawW5/sFnglG84EayWNCTlb1nTL9yDmK
         8u36AQrl5PCcblByYt0lsfJvZDrDMup0OSTQDA0ZzdCs7fossZ+nuBTyAG5BB+dU4jUz
         fsrXC+lYlXNY+OuNHKet5F/+ZoC1R9GidTJzHS8W0lzs2xB33X/BsabFJW6kIquiYykU
         5/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=efqFHOeANayC0baa4+ILoJW70HiGRxSCs5RfDwIXPis=;
        b=f2H2SjDXTnLJKWTyn26SvUcfy9qgy/cwUZBqGuMpO+yyT/DVD9YJmpudu/3qw/IDqN
         Xjd7CVYhhOCResH7cs0/aYGSsX6l0XRE6Dtp81MVUPIQlW80+grr40e5vloleppMC3GL
         D+17OAVVVUgm5g7QphjUNoregbD6TpbHAxfKXt1dhOy+IS5nYNdB220GSb1H9jCmBYR6
         nqbUov9NRenhoA4i3VAmmbg/RPZ90hsINVkIeEAKLWelmVGQsuR4cHFOedco5DmUzk9M
         DATILPTCloi4YLg+rWefHIqu7WLaF1kLdu8g6m8nFUAOr13ul16wLieI3Zj3RbjdZB+G
         vsqQ==
X-Gm-Message-State: AOAM532z1YU1v82naTo17idkwHkMufy7+ek+mffuTwmc8WfA7Aezovbs
        BPUX1QNYKwGbUP9rQsae6/vDR0A93VJ+hC47pCmQ+g==
X-Google-Smtp-Source: ABdhPJwX+ls5ym4u7u5B/c8jfLkoZzv5JbR59xfADRFlVRh7Q37GlLSOu/E90WGG0TZNs/iv06IKsucAbOietxF6Dn4=
X-Received: by 2002:a92:6f0c:: with SMTP id k12mr6386747ilc.240.1637095815401;
 Tue, 16 Nov 2021 12:50:15 -0800 (PST)
MIME-Version: 1.0
References: <20211115135114.2763223-1-alainm@chromium.org> <C44D0F6E-CF4F-44BC-BE13-43F62D083774@holtmann.org>
 <CABBYNZJFZnpGWQJ5Qi=bBPRcjqot10ZODk71Ls-5+GYmgqCo-w@mail.gmail.com>
In-Reply-To: <CABBYNZJFZnpGWQJ5Qi=bBPRcjqot10ZODk71Ls-5+GYmgqCo-w@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 16 Nov 2021 15:49:58 -0500
Message-ID: <CALWDO_U2kW51P4zbK86yXYTfyX_jsp2F6DBKTJB5qLwein6x4A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix adv set removal processing.
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

HI Luiz,



On Mon, Nov 15, 2021 at 2:35 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Alain,
>
> On Mon, Nov 15, 2021 at 9:07 AM Marcel Holtmann <marcel@holtmann.org> wro=
te:
> >
> > Hi Alain,
> >
> > > When multiple advertisement sets are active and a single instance is
> > > removed, the processing of hci_cc_le_set_ext_adv_enable will result i=
n
> > > considering all advertisements as disabled since the instance has
> > > already been removed from the list.
> > >
> > > The fix is to use the command parameters to validate the intent rathe=
r
> > > than making an assumption based on the validity of the adv set.
> > >
> > > remove_advertising() hci0
> > >
> > > hci_req_add_ev() hci0 opcode 0x2039 plen 6
> > > hci_req_add_ev() hci0 opcode 0x203c plen 1
> > >
> > > hci_remove_adv_instance() hci0 removing 2MR
> > > <-- This removes instance 2 from the adv_instances list
> > >
> > > hci_cc_le_set_ext_adv_enable() hci0 status 0x00
> > > hci_sent_cmd_data() hci0 opcode 0x2039
> > > hci_cc_le_set_ext_adv_enable() adv instance 0, enabled 0
> > > <-- This incorrectly assumes that all instances are
> > >    being disabled while only handle 2 is being disabled.
> > >
> > > hci_cc_le_set_ext_adv_enable() adv instance list status - before
> > > hci_cc_le_set_ext_adv_enable() adv instance 3 is 1
> > > hci_cc_le_set_ext_adv_enable() adv instance 1 is 1
> > > hci_cc_le_set_ext_adv_enable() HCI_LE_ADV state before: 1
> > > hci_cc_le_set_ext_adv_enable() adv instance list status - after
> > > hci_cc_le_set_ext_adv_enable() adv instance 3 is 0
> > > hci_cc_le_set_ext_adv_enable() adv instance 1 is 0
> > > hci_cc_le_set_ext_adv_enable() HCI_LE_ADV state after: 0
> > > <-- This is incorrect since handle 1 and 3 are still enabled
> > >    in the controller
> > >
> > > The fix was validated by running the ChromeOS bluetooth_AdapterAdvHea=
lth
> > > test suite.
> > >
> > > Reviewed-by: mcchou@chromium.org
> >
> > we need clear name and email in the tags please. And I also like to hav=
e Fixes: tags here as well.
> >
> > > Signed-off-by: Alain Michaud <alainm@chromium.org>
> > >
> > > ---
> > >
> > > net/bluetooth/hci_event.c | 8 +++++---
> > > 1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > index d4b75a6cfeee..52161d04136f 100644
> > > --- a/net/bluetooth/hci_event.c
> > > +++ b/net/bluetooth/hci_event.c
> > > @@ -1385,14 +1385,16 @@ static void hci_cc_le_set_ext_adv_enable(stru=
ct hci_dev *hdev,
> > >                               if (adv->enabled)
> > >                                       goto unlock;
> > >                       }
> > > -             } else {
> > > +
> > > +                     hci_dev_clear_flag(hdev, HCI_LE_ADV);
> > > +             } else if (!cp->num_of_sets || !set->handle) {
> > >                       /* All instances shall be considered disabled *=
/
> > >                       list_for_each_entry_safe(adv, n, &hdev->adv_ins=
tances,
> > >                                                list)
> > >                               adv->enabled =3D false;
> > > -             }
> > >
> > > -             hci_dev_clear_flag(hdev, HCI_LE_ADV);
> > > +                     hci_dev_clear_flag(hdev, HCI_LE_ADV);
> > > +             }
> > >       }
> >
> > Just checking if this wouldn=E2=80=99t be cleaner:
> >
> >                 } else {
> >                         if (foo)
> >                                 bar;
> >
> >                         hci_dev_clear_flag(hdev, HCI_LE_ADV);
> >                 }
>
> Actually this seems to already have been fixed by:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.=
git/commit/?id=3D2128939fe2e771645dd88e1938c27fdf96bd1cd0
>
> Perhaps the Chrome OS tree is outdated?
You are right, looks like this would fix it and it was indeed not
merged to the chromium tree.  Please ignore this patch.
>
> > Regards
> >
> > Marcel
> >
>
>
> --
> Luiz Augusto von Dentz
