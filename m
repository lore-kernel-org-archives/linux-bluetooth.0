Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D525C05027
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Feb 2023 01:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbjBOBUP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Feb 2023 20:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjBOBUO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Feb 2023 20:20:14 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F06BB96
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Feb 2023 17:20:08 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id bj22so14563877oib.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Feb 2023 17:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuJvfV0OAzz9kxw25r+GX6HaPf7wKgi9opbAeK1ezjs=;
        b=OT47T5A4cgo6pIV/swYDUH1TOozT6chtdyI1BKOt73Ouiij1RvY0C5uevdzFoPmcU0
         IIOTB4JsMPGWgJHR5M5JIJd0/CLgFXDBjTzx0pai4XNNQc3cAG6Wv+vvFHQqATsBwopk
         C/zTsJc4aYaCB+SlwnM/mYV1VPO+wI/4i2SvUJ7FSpPxTDG26Z4es8jIv61G3/P7Bq7s
         DOFBYnWsEwwGHd/BFyQqalWc1Wth1Px5AmSCtjp3dtkVDCqaYdsGoHKeSKiY74ZmuqUh
         fU8RzEO5dIUCOIHM2Tkyr+Q2bRDBt/G2MAuDQQ14uwlZwibZusmIcB1T50keuOL0UDej
         X5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuJvfV0OAzz9kxw25r+GX6HaPf7wKgi9opbAeK1ezjs=;
        b=nOUmESMzdB9a7Vt6DEe04umhhNckoQGT5Xl4aNdzK1lZ2HwSEEtcissKmHm4dPaGtn
         tmZmuhzRx67x5pli1g2tnEhLyAWvpKJfmWFlsVmmK4aI3Mkb/CT1AaOuoLtMn9RujQWu
         U/Al/TnMWKqJT5zxNeO2MS3bGCA7q4ul20WX5XOQfGhpnZhcrg4kCHhpzrB1zIdN7OF7
         nVmkvd/rnos2pq+uFPbe+NJQPQEtlzT4A/0pDvZ3UeM9DsmYctZDbFrdZRT2sxzvsDdA
         lUpQoZ4nA3V/UxNUpk8PFt5eHTbTprMXSnrN7yBobhLilDwwA4lyLS0YPifM5TYBo1PC
         n1JA==
X-Gm-Message-State: AO0yUKU5xcLN+cgYI5b6EF/zxwN8tVUAFJpB7WvqZQbg31g8OAxv0jpQ
        OEF/xbuXJgjt8QtoGMpWs+mrXLWksCQ2LQjhVKeWIU/Jmex5GnShoQXHUg==
X-Google-Smtp-Source: AK7set/+8T/i6UqkGBhXs11DcqcY7XFEtJAL2eYwmATv/4zvzpzj+utuRMxrEMt6zEgk6SHj850fBSxdFijn+WCRy+k=
X-Received: by 2002:aca:3d56:0:b0:378:5f47:6cbf with SMTP id
 k83-20020aca3d56000000b003785f476cbfmr130149oia.44.1676424006866; Tue, 14 Feb
 2023 17:20:06 -0800 (PST)
MIME-Version: 1.0
References: <20230214145609.kernel.v1.1.Ibe4d3a42683381c1e78b8c3aa67b53fc74437ae9@changeid>
 <CABBYNZKVVo4T_pbEdozhNvgiykC7NiLQKEnJi3q5gZpHunGrbA@mail.gmail.com>
 <CAB4PzUo+EuapOr+O7eWZH2xiVVAUd98m_DmEK-337=CvfUDeoA@mail.gmail.com> <CABBYNZJJhNTrH85VuqvAQbk6JyNhQ5atXzxb+rV7JcrhkgFWpQ@mail.gmail.com>
In-Reply-To: <CABBYNZJJhNTrH85VuqvAQbk6JyNhQ5atXzxb+rV7JcrhkgFWpQ@mail.gmail.com>
From:   Zhengping Jiang <jiangzp@google.com>
Date:   Tue, 14 Feb 2023 17:19:54 -0800
Message-ID: <CAB4PzUoj2=QNH0SqrSe8LbT74Z7DZr-K6Qw=b71k20a=1aLuSg@mail.gmail.com>
Subject: Re: [kernel PATCH v1] Bluetooth: hci_sync: Resume adv with no RPA
 when active scan
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> Where is that mentioned?
It is just below the command on "7.8.44 LE Set Address Resolution
Enable command".

On "4.7 RESOLVING LIST", there is another note:
> Note: The Controller may generate Resolvable Private Addresses even when =
address resolution is disabled.

If this is the case, then the comment in the kernel
(hci_active_scan_sync) is not accurate.
> /* Pause advertising since active scanning disables address resolution
> * which advertising depend on in order to generate its RPAs.
> */

> I think it may be related to the fact that it only affects the addr
> resolution of remote devices, that said if you are active scanning
> that probably means the user wants to setup a new device thus why we
> don't enable any filtering like accept list, etc, so it is not really
> useful to keep address resolution active either way.
That makes sense. When the local privacy is enabled, I assume the host
RPA will change
when advertising. I haven't tested that scenario, but if RPA
generation is not related to disable/enable
address resolution, why should the advertising be paused when active scan?

Thanks,
Zhengping

>
> > Thanks,
> > Zhengping
> >
> > On Tue, Feb 14, 2023 at 4:09 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Zhengping,
> > >
> > > On Tue, Feb 14, 2023 at 2:56 PM Zhengping Jiang <jiangzp@google.com> =
wrote:
> > > >
> > > > The address resolution should be disabled during the active scan,
> > > > so all the advertisements can reach the host. The advertising
> > > > has to be paused before disabling the address resolution,
> > > > because the advertising will prevent any changes to the resolving
> > > > list and the address resolution status. Skipping this will cause
> > > > the hci error and the discovery failure.
> > >
> > > It is probably a good idea to quote the spec saying:
> > >
> > > 7.8.44 LE Set Address Resolution Enable command
> > >
> > > This command shall not be used when:
> > > =E2=80=A2 Advertising (other than periodic advertising) is enabled,
> > >
> > > > If the host is using RPA, the controller needs to generate RPA for
> > > > the advertising, so the advertising must remain paused during the
> > > > active scan.
> > > >
> > > > If the host is not using RPA, the advertising can be resumed after
> > > > disabling the address resolution.
> > > >
> > > > Fixes: 9afc675edeeb ("Bluetooth: hci_sync: allow advertise when sca=
n without RPA")
> > > > Signed-off-by: Zhengping Jiang <jiangzp@google.com>
> > > > ---
> > > >
> > > > Changes in v1:
> > > > - Always pause advertising when active scan, but resume the adverti=
sing if the host is not using RPA
> > > >
> > > >  net/bluetooth/hci_sync.c | 8 ++++++--
> > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > > > index 117eedb6f709..edbf9faf7fa1 100644
> > > > --- a/net/bluetooth/hci_sync.c
> > > > +++ b/net/bluetooth/hci_sync.c
> > > > @@ -2402,7 +2402,7 @@ static u8 hci_update_accept_list_sync(struct =
hci_dev *hdev)
> > > >         u8 filter_policy;
> > > >         int err;
> > > >
> > > > -       /* Pause advertising if resolving list can be used as contr=
ollers are
> > > > +       /* Pause advertising if resolving list can be used as contr=
ollers
> > > >          * cannot accept resolving list modifications while adverti=
sing.
> > > >          */
> > > >         if (use_ll_privacy(hdev)) {
> > > > @@ -5397,7 +5397,7 @@ static int hci_active_scan_sync(struct hci_de=
v *hdev, uint16_t interval)
> > > >         /* Pause advertising since active scanning disables address=
 resolution
> > > >          * which advertising depend on in order to generate its RPA=
s.
> > > >          */
> > > > -       if (use_ll_privacy(hdev) && hci_dev_test_flag(hdev, HCI_PRI=
VACY)) {
> > > > +       if (use_ll_privacy(hdev)) {
> > > >                 err =3D hci_pause_advertising_sync(hdev);
> > > >                 if (err) {
> > > >                         bt_dev_err(hdev, "pause advertising failed:=
 %d", err);
> > > > @@ -5416,6 +5416,10 @@ static int hci_active_scan_sync(struct hci_d=
ev *hdev, uint16_t interval)
> > > >                 goto failed;
> > > >         }
> > > >
> > > > +       // Resume paused advertising if the host is not using RPA
> > > > +       if (use_ll_privacy(hdev) && !hci_dev_test_flag(hdev, HCI_PR=
IVACY))
> > > > +               hci_resume_advertising_sync(hdev);
> > > > +
> > > >         /* All active scans will be done with either a resolvable p=
rivate
> > > >          * address (when privacy feature has been enabled) or non-r=
esolvable
> > > >          * private address.
> > > > --
> > > > 2.39.1.581.gbfd45094c4-goog
> > >
> > > I think it is better that we add something like
> > > hci_pause_addr_resolution so we can make it check all the conditions,
> > > such as pausing advertising and resuming if needed. Btw, we do seem t=
o
> > > have proper checks for these conditions on the emulator:
> > >
> > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/emulator/btde=
v.c#n4090
> > >
> > > But perhaps there is no test which attempts to enable LL Privacy
> > > without enabling Local Privacy, so it would be great if you could
> > > update mgmt-tester adding a test that emulates such behavior.
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
