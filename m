Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C053C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 19:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCTTlV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 15:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjCTTkp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 15:40:45 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760DE3B86C
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 12:36:02 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-17ab3a48158so14160783fac.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 12:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679340954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D73YoFna1jLNmCj1NnxO84erI2ipjzc0PecpNXmPnAo=;
        b=chtfnFWB7whGTKRPXnGfKl/O9Bfa6gcy7UlQeHmHif1SR34CAwmRhkS4gF9CacWRWR
         Va2kFxFnZ5DbcPaOY9HMxTSz6Zu3+UZDkSjgeEIcSPGrYBoCAWJ9oyMdAd6DKQJdZ1Nf
         nSCw3fI1W7+MV277Vk1Xz0kunJgKYihBMcgdmVN/Z7xAfYNe2l6mNHq9ejhFOWLHZUkn
         5GV7my4CxhWDiKrIf0Gk5eb5ZMLIEzKegPFbEn41p0Gnt25j39gHJW2eJZ97dxIOkrHs
         3HYwncaJLJnBRP+/TTtC6/NLGmrMOpfy5J/ApNEXKDzAV8VuvwVULQEvCTkLyXb/+Fk0
         fjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679340954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D73YoFna1jLNmCj1NnxO84erI2ipjzc0PecpNXmPnAo=;
        b=AEud8LW7bkwGCTpOxfFnv9jRk2BCrm+V59fWSYampHegfFMhEdD94Zq9par2HR300R
         iByR6Bfc/sgxbT1BnD+VxJ4uDP64PRWzlo+HEKRf82BYuN4mj4onnOiRa+mh5AjlfPxd
         bS75q25PnWs4Wlg7qqV3dc0DtNUbrIdojEzXQSKgmI7ViqEdtkbMvq8KQJ8OnkiAYRXo
         O/6rPhtoAU7d0f0WECoRhOPnibAXJ3j8LSb7xiEMD00pGKysqh0UdI99IZAsSQmU6eox
         +Xgiqy+Ew0MZuvPZ5U/w0wMDUzM/L5a3faY4Ow1gYLLLfWjy9sbm3VI+vbtJksDAd5WW
         DWMQ==
X-Gm-Message-State: AO0yUKUapx1mbnGfB8uv+PrHUTvShJhGYRsOUgY1TwXrJlaUOBxKepr2
        y4KTT6wychZ92P8sdgJhvKiVGmUm3b8EcSL3GI8zMOrL0cupxg==
X-Google-Smtp-Source: AK7set+4RShuKSCGebfwy8tAUnDtPJhz4zap4QS+DxG4GoHJq6x3dYX+keC5wnRvrNfy2szEBCtzMEdxyNIOpE0JsfA=
X-Received: by 2002:a05:6871:2515:b0:17e:24a2:36a0 with SMTP id
 yx21-20020a056871251500b0017e24a236a0mr2042640oab.10.1679340954349; Mon, 20
 Mar 2023 12:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230317204620.2809181-1-raul.cheleguini@gmail.com> <CABBYNZ+tW=w74V8bOYtjcwG=RUUKxSBKGkpe+w8A4gohCWbXZg@mail.gmail.com>
In-Reply-To: <CABBYNZ+tW=w74V8bOYtjcwG=RUUKxSBKGkpe+w8A4gohCWbXZg@mail.gmail.com>
From:   =?UTF-8?Q?Raul_Jos=C3=A9_Cheleguini?= <raul.cheleguini@gmail.com>
Date:   Mon, 20 Mar 2023 16:35:18 -0300
Message-ID: <CACk7upw80H_xjGFLx=QLfO-iOoLMsGBon1R2-SYe-3+5W-Mk4g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Partial support for Actions Semi ATS2851 based devices
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Mar 17, 2023 at 5:54=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Raul,
>
> On Fri, Mar 17, 2023 at 1:46=E2=80=AFPM Raul Cheleguini
> <raul.cheleguini@gmail.com> wrote:
> >
> > This change enables support to device initialization and to scan
> > process, by adding two new quirks for the following advertised but
> > unsupported commands: "Set Random Private Address Timeout" and
> > "Extended Create Connection".
> >
> > It offers partial device support: controller initialization and scan.
> > The pairing process still needs work.
> >
> > At the moment there is little to none available documentation about the
> > ATS2851 and its based USB dongles. It is known that it works in other
> > systems via generic drivers, and this is one step towards have it worki=
ng
> > in Linux.
> >
> > Signed-off-by: Raul Cheleguini <raul.cheleguini@gmail.com>
> > ---
> >  drivers/bluetooth/btusb.c   |  2 ++
> >  include/net/bluetooth/hci.h | 14 ++++++++++++++
> >  net/bluetooth/hci_sync.c    | 13 +++++++++++--
> >  3 files changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 7382b021f3df..7bba19061277 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -4106,6 +4106,8 @@ static int btusb_probe(struct usb_interface *intf=
,
> >                 set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->qui=
rks);
> >                 set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->qu=
irks);
> >                 set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
> > +               set_bit(HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT, &hdev->quirks=
);
> > +               set_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, &hdev->quirks=
);
> >         }
> >
> >         if (!reset)
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 997107bfc0b1..3ff1681fd2b8 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -301,6 +301,20 @@ enum {
> >          * don't actually support features declared there.
> >          */
> >         HCI_QUIRK_BROKEN_LOCAL_EXT_FEATURES_PAGE_2,
> > +
> > +       /*
> > +        * When this quirk is set, the HCI_OP_LE_SET_RPA_TIMEOUT comman=
d is
> > +        * disabled. This is required for the Actions Semiconductor ATS=
2851
> > +        * controller, which erroneously claim to support it.
> > +        */
> > +       HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT,
> > +
> > +       /*
> > +        * When this quirk is set, the HCI_OP_LE_EXT_CREATE_CONN comman=
d is
> > +        * disabled. This is required for the Actions Semiconductor ATS=
2851
> > +        * controller, which erroneously claim to support it.
> > +        */
> > +       HCI_QUIRK_BROKEN_EXT_CREATE_CONN,
> >  };
> >
> >  /* HCI device flags */
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 8e5fe73873a8..9b2a0d6d6c1a 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -4090,9 +4090,11 @@ static int hci_le_set_rpa_timeout_sync(struct hc=
i_dev *hdev)
> >  {
> >         __le16 timeout =3D cpu_to_le16(hdev->rpa_timeout);
> >
> > -       if (!(hdev->commands[35] & 0x04))
> > +       if (!(hdev->commands[35] & 0x04) ||
> > +           test_bit(HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT, &hdev->quirks))
> >                 return 0;
>
> This one Im not so sure, if we can't set a timeout then we shouldn't
> use the controller to rotate the RPA, although it seems we are already
> doing it when the command bit is not set.

Hi Luiz, this propose is based on two observations:

- Another USB dongle I own here (fake CSR) initializes and works without
  the command.
- The ATS2851 dongle initializes and works in other systems (as a generic
  device) without the command.

I noticed there is a default timeout (HCI_DEFAULT_RPA_TIMEOUT) which
is set during the hci device allocation. I presume this is used when we
are unable to set the timeout.

> >
> > +
> >         return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_RPA_TIMEOUT,
> >                                      sizeof(timeout), &timeout,
> >                                      HCI_CMD_TIMEOUT);
> > @@ -4530,6 +4532,12 @@ static const struct {
> >                          "HCI Set Event Filter command not supported.")=
,
> >         HCI_QUIRK_BROKEN(ENHANCED_SETUP_SYNC_CONN,
> >                          "HCI Enhanced Setup Synchronous Connection com=
mand is "
> > +                         "advertised, but not supported."),
> > +       HCI_QUIRK_BROKEN(SET_RPA_TIMEOUT,
> > +                        "HCI LE Set Random Private Address Timeout com=
mand is "
> > +                        "advertised, but not supported."),
> > +       HCI_QUIRK_BROKEN(EXT_CREATE_CONN,
> > +                        "HCI LE Extended Create Connection command is =
"
> >                          "advertised, but not supported.")
> >  };
> >
> > @@ -6067,7 +6075,8 @@ int hci_le_create_conn_sync(struct hci_dev *hdev,=
 struct hci_conn *conn)
> >         if (err)
> >                 goto done;
> >
> > -       if (use_ext_conn(hdev)) {
> > +       if (use_ext_conn(hdev) &&
> > +           !test_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, &hdev->quirks))=
 {
> >                 err =3D hci_le_ext_create_conn_sync(hdev, conn, own_add=
r_type);
> >                 goto done;
> >         }
>
> I guess we can incorporate the new quirk check inside use_ext_conn.

Thanks Luiz, I will resend it with this suggestion.

> > --
> > 2.39.2
> >
>
>
> --
> Luiz Augusto von Dentz
