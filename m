Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71EDC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 22:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D82E61057
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 22:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbhIBWjG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 18:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347699AbhIBWjF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 18:39:05 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D69C061575
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Sep 2021 15:38:06 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id 75so1747112uav.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Sep 2021 15:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cpn2zUGF/0/bW7qtiXPiQUWwrr/6v41QzLbXEm+YhW4=;
        b=juG+7WeRQwVssh7gqet7vITrj6G6AaHmPGIjcbBCS1kj03XkCtSCPi3UKXvECDFhJj
         NKDUDeQR4smGXjDBMQ2BM6PTgIUEX3vi9xX+Tv5XMj9n4FAtrfbOximVU41HR0/iv4LK
         hRcw8MxGDEsBp4qeGuoIB/kkDd8va5vA/lr61wzO5tol05VNQ+lYdn9KAGdQOWhFrbDS
         m2ncpnyz3SQ4FajroZv5xIh/OaHZnmVpyKTqNuiICe9/ZJ3xgQlkxWU3ExXwPNebQtmJ
         IauWNKwiEpXui4mGbuBbLUhoLhHLt/0m05rRYs4wNgl/8GAUgjE/f/u3Bnz0cLVTPTP4
         v8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cpn2zUGF/0/bW7qtiXPiQUWwrr/6v41QzLbXEm+YhW4=;
        b=UmwxN6CVzOqAtYn0Pl4HyTOSOFIjFOvWa8mR0scU0SQKchVYcQTDOSUDPNBqSjBQP6
         kVjrFLSQDUM9htMwKQJgqkTuk1eJgno+hyFv+eIXWQDUeJbbCItXoCmR51/XQl6zY+mF
         dDGOIeL6/ngOD9fQDV1qOrJ5+CbykBCt2xbX2pYLpe6Ixfprji2pWLFCMf9H6wSjBgp3
         uUMxhvAMkYBUfNFiI51ZzWjr99gBWBmCKID1Lztu/D1v+U7AxZdqC8SDjdxRgb1dGPRy
         KECteuJW27PaFyhorgYR4Rzsf4oiPyEDR4uW/2Z7rkj+rASDEF0qNz2D4/VZp+2FpEut
         vP/A==
X-Gm-Message-State: AOAM533FpezkhXt+6cHhCiJ/c41Fxr8+kGhNDlTV7ZEHXvgmkWNy3kUU
        IDOpXAZWVimHskU5BXxjyQDXPTYKxsXdAApJMdQ=
X-Google-Smtp-Source: ABdhPJw15hrNOLjuMNXAizByt5qmknxqaC1iktFmLvToAXq7LejM0WroEle+i3wdLZFVtb8+5KeNLvKINFioRQJmtg0=
X-Received: by 2002:ab0:3757:: with SMTP id i23mr446813uat.72.1630622285855;
 Thu, 02 Sep 2021 15:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210831115637.6713-1-kiran.k@intel.com> <20210831115637.6713-12-kiran.k@intel.com>
 <CABBYNZL3=z6CWj9EAiGnOkcaEmgs1Mq7kc5-fT4Mjk2HCUPsFA@mail.gmail.com> <135FFE98-549B-4C02-9AC3-AD7F18EC0564@holtmann.org>
In-Reply-To: <135FFE98-549B-4C02-9AC3-AD7F18EC0564@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 2 Sep 2021 15:37:54 -0700
Message-ID: <CABBYNZJGF+VzeouaJXf7_T1smtgEqwyUimsxV8ajUZURMGBxfg@mail.gmail.com>
Subject: Re: [PATCH v13 12/12] Bluetooth: Allow usb to auto-suspend when SCO
 use non-HCI transport
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Kiran K <kiran.k@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, Sep 2, 2021 at 2:37 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> >> Currently usb tranport is not allowed to suspend when SCO over
> >> HCI tranport is active.
> >>
> >> This patch shall enable the usb tranport to suspend when SCO
> >> link use non-HCI transport
> >>
> >> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> >> Signed-off-by: Kiran K <kiran.k@intel.com>
> >> ---
> >>
> >> Notes:
> >>    changes in v13:
> >>    - suspend usb in HFP offload use case
> >>
> >> drivers/bluetooth/btintel.c       |  2 +-
> >> include/net/bluetooth/bluetooth.h |  4 ++++
> >> net/bluetooth/hci_event.c         | 20 +++++++++++---------
> >> net/bluetooth/sco.c               |  2 +-
> >> 4 files changed, 17 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> >> index 6091b691ddc2..2d64e289cf6e 100644
> >> --- a/drivers/bluetooth/btintel.c
> >> +++ b/drivers/bluetooth/btintel.c
> >> @@ -2215,7 +2215,7 @@ static int btintel_get_codec_config_data(struct =
hci_dev *hdev,
> >> static int btintel_get_data_path_id(struct hci_dev *hdev, __u8 *data_p=
ath_id)
> >> {
> >>        /* Intel uses 1 as data path id for all the usecases */
> >> -       *data_path_id =3D 1;
> >> +       *data_path_id =3D BT_SCO_PCM_PATH;
> >>        return 0;
> >> }
> >>
> >> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth=
/bluetooth.h
> >> index c1fa90fb7502..9e2745863b33 100644
> >> --- a/include/net/bluetooth/bluetooth.h
> >> +++ b/include/net/bluetooth/bluetooth.h
> >> @@ -177,6 +177,10 @@ struct bt_codecs {
> >> #define CODING_FORMAT_TRANSPARENT      0x03
> >> #define CODING_FORMAT_MSBC             0x05
> >>
> >> +/* Audio data transport path used for SCO */
> >> +#define BT_SCO_HCI_PATH 0x00
> >> +#define BT_SCO_PCM_PATH 0x01
> >
> > If this is in fact vendor specific perhaps you should be declared in
> > btintel.h not here.
> >
> >> +
> >> __printf(1, 2)
> >> void bt_info(const char *fmt, ...);
> >> __printf(1, 2)
> >> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> >> index b48e24629fa4..7ff11cba89cf 100644
> >> --- a/net/bluetooth/hci_event.c
> >> +++ b/net/bluetooth/hci_event.c
> >> @@ -4516,15 +4516,17 @@ static void hci_sync_conn_complete_evt(struct =
hci_dev *hdev,
> >>
> >>        bt_dev_dbg(hdev, "SCO connected with air mode: %02x", ev->air_m=
ode);
> >>
> >> -       switch (ev->air_mode) {
> >> -       case 0x02:
> >> -               if (hdev->notify)
> >> -                       hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_CVSD)=
;
> >> -               break;
> >> -       case 0x03:
> >> -               if (hdev->notify)
> >> -                       hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_TRANS=
P);
> >> -               break;
> >> +       if (conn->codec.data_path =3D=3D BT_SCO_HCI_PATH) {
> >> +               switch (ev->air_mode) {
> >> +               case 0x02:
> >> +                       if (hdev->notify)
> >> +                               hdev->notify(hdev, HCI_NOTIFY_ENABLE_S=
CO_CVSD);
> >> +                       break;
> >> +               case 0x03:
> >> +                       if (hdev->notify)
> >> +                               hdev->notify(hdev, HCI_NOTIFY_ENABLE_S=
CO_TRANSP);
> >> +                       break;
> >> +               }
> >
> > Hmm I think we might need to notify the driver to enable PCM routing
> > so the likes of btusb can call
> > usb_disable_endpoint/usb_enable_endpoint for example since in theory
> > userspace may choose to switch from software to hardware offload and
> > vice-versa, note without calling usb_disable_endpoint there might not
> > be much power saving after all since the endpoint will remain active
> > or do we actually have a good explanation why it shall not be called
> > when using PCM routing? Note that usb_set_interface will call
> > usb_enable_interface that will then call usb_enable_endpoint so
> > perhaps we need to call usb_disable_interface, either way we can't
> > assume the platform will be restricted to only use one or the other.
>
> actually for the Intel hardware we shouldn=E2=80=99t do this at all. We s=
hould switch to vendor specific SCO over bulk endpoints and not claim the I=
SOC endpoints at all.

Yep, but I guess that requires switching to SCO over bulk then which
perhaps needs more changes, not sure if we should pursue that or go
with all the way with H4 mode like we did in Zephyr, anyway for the
purpose of offload I would be fine skipping the SCO over bulk since we
are already at v13 of these.

> Regards
>
> Marcel

>


--
Luiz Augusto von Dentz
