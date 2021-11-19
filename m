Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54AAC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 19:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9496B61283
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 19:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbhKSTmi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 14:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbhKSTmg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 14:42:36 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75299C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Nov 2021 11:39:34 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id t13so23368181uad.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Nov 2021 11:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MkztbDI+eaM9k0H1MIWK3V0FbajuuEYTQpE8Ux23bPU=;
        b=CF3Dxgn8b5sz2wfFxsqaUH6Ey22ii3jDt7DT/gLzFTZNRmupsduqFlu65OLzp+Srqa
         oGp5Z/NDX47BqCJCSLMncW3fnJrlTg49tnLs4f6yotRPhvWPf2SlEVWhoh34jtavYH2X
         v32v0Tgm5wo7pXOZhIj+kjeClhsp6Ih+ynIBaLxF9djvmZgZYscKGjhOycGQhjSBGfy2
         VRmbHt/WGSfSfwtVO7dsyxMMiCepbTlFtN26sOHXz0NtQGGQwgAdoHh6V7Ujy046qEjS
         WTU/f84hYl/O2YZu7IpYs+zjijAqr9STq9yX5jEz8NK4KhQ9PoZxzA5ZLBi2GsbK7Ak8
         GcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MkztbDI+eaM9k0H1MIWK3V0FbajuuEYTQpE8Ux23bPU=;
        b=YYC4Eslhk3LB++RKVnaUDn5jazwTSi5NfkaNORgaYeI4h9oSRYMpldjqYcbk/NTUrU
         krYEKluOhxZ7nFhxoYXpvtCEH53T5GAV3sSqmJejP6jK4YunPvOmSM9QPv0xiReCjIDU
         HwMoyvQW93waSAhchuP1VxvxZIHblddTazfX8DJabw7RQp9GLXOFdG+ilXxLpHOwUE6N
         NsEncYGuFa8H5j4A1y31zncm9OZj93j79gpNO5fgl12+pw4I3bx1vy99654F4LE4aG1o
         icdFtcHMbUrcuPotAsRUcyjUCNwhN1Lr+VmzJyosUhIr+sdYw8dfwhfLXi6ADb1DJAHQ
         M89A==
X-Gm-Message-State: AOAM530LldQ4Dks0SzpWJQm+miGpco8YwACtWcsOG4jlFAklYgXCqORm
        dSBk5edexOB/5bRvhp5TGWKRxxvapdWzBxK2OdiAupvf
X-Google-Smtp-Source: ABdhPJz4KFB34avJsBZ27lGmVNVTL9o+oZggmz5oqvyUezfI9BtGXZXMCfKsiOKLPP8W5lLMvK1vOK3ral557T+vzwA=
X-Received: by 2002:ab0:4465:: with SMTP id m92mr52552759uam.47.1637350773345;
 Fri, 19 Nov 2021 11:39:33 -0800 (PST)
MIME-Version: 1.0
References: <20211118231302.1000168-1-luiz.dentz@gmail.com> <BA3F20E5-3D85-4513-ADB2-B2F03163A1C6@holtmann.org>
In-Reply-To: <BA3F20E5-3D85-4513-ADB2-B2F03163A1C6@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 19 Nov 2021 11:39:22 -0800
Message-ID: <CABBYNZ+vfSYHHddLCS2+tUKYHju4cf_NrFo7Ue8TJO1JBU7R1g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: Introduce HCI_CONN_FLAG_DEVICE_PRIVACY
 device flag
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, Nov 19, 2021 at 2:01 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Luiz,
>
> > This introduces HCI_CONN_FLAG_DEVICE_PRIVACY which can be used by
> > userspace to indicate to the controller to use Device Privacy Mode to a
> > specific device.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > v2: Fix supported flags not actually checking if the hdev really
> > supports the flags.
> >
> > include/net/bluetooth/hci_core.h |  4 ++++
> > net/bluetooth/mgmt.c             | 30 ++++++++++++++++++++++++++----
> > 2 files changed, 30 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index 2560cfe80db8..42ba40df6e20 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -160,6 +160,7 @@ struct bdaddr_list_with_flags {
> >
> > enum hci_conn_flags {
> >       HCI_CONN_FLAG_REMOTE_WAKEUP,
> > +     HCI_CONN_FLAG_DEVICE_PRIVACY,
> >       HCI_CONN_FLAG_MAX
> > };
> >
> > @@ -1465,6 +1466,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
> > #define use_ll_privacy(dev) (ll_privacy_capable(dev) && \
> >                            hci_dev_test_flag(dev, HCI_ENABLE_LL_PRIVACY=
))
> >
> > +#define privacy_mode_capable(dev) (use_ll_privacy(dev) && \
> > +                                (hdev->commands[39] & 0x04))
> > +
> > /* Use enhanced synchronous connection if command is supported */
> > #define enhanced_sco_capable(dev) ((dev)->commands[29] & 0x08)
> >
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index f8f74d344297..d82d1a62754a 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -4349,7 +4349,22 @@ static int set_exp_feature(struct sock *sk, stru=
ct hci_dev *hdev,
> >                              MGMT_STATUS_NOT_SUPPORTED);
> > }
> >
> > -#define SUPPORTED_DEVICE_FLAGS() ((1U << HCI_CONN_FLAG_MAX) - 1)
> > +static u32 supported_device_flags(struct hci_dev *hdev)
> > +{
> > +     u32 flags =3D 0;
> > +
> > +     /* Check if adapter can wakeup the system */
> > +     if (hdev->wakeup && hdev->wakeup(hdev))
> > +             flags |=3D BIT(HCI_CONN_FLAG_REMOTE_WAKEUP);
>
> I would do this change as a separate patch since it has nothing to do wit=
h the device privacy setting.

Will do.

> Do we have to call hdev->wakeup() as well here? Isn=E2=80=99t the existen=
ce of the callback enough indication.

Hmm, right I guess we want to know if the driver is capable of waking
up, not that it is actually enabled at that point since we are
evaluating if it is supported. I will change that.

> That also said, doesn=E2=80=99t it make sense to store the supported_flag=
s in the device params struct. It would make it certainly easy to return. P=
otentially we have a few calls to Get Device Flags and its notifications th=
at have to rebuild this flags field over and over again.

But we only perform a lookup, so in case there are no hci_conn_params
we would have to store it somewhere else, perhaps in hci_dev?

> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz
