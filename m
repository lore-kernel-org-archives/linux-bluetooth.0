Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CEAEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jun 2023 18:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjFOS2T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Jun 2023 14:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjFOS2S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Jun 2023 14:28:18 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DF7268B
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jun 2023 11:28:17 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b3424edd5fso33048051fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jun 2023 11:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686853695; x=1689445695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuEo+qN9UsmOC5gS6dz6Bus0OXg/D1nOA7fnGrCQFxU=;
        b=e2AEkMFU5EMeu0PWF5LA4/JaA7BHaGXeH0g8jxR80RmRqD/z/Emzd8QlNEgMuoG2t+
         RRmvO8buQNK07+GwqATRcJ92DiD6PMdCNryfdyLIDKDP4egffgHpKGMqrR7qtnL7FFhG
         Nb3MwXdQHkHfXJUlNELTEfgmdI2fbALPCDg3PByJwxfHQob6TML0OcMKinE/Dx8CiT39
         iIf+ZUL0ie7g1e9JXOFFLYZSKHOOPV5qXMjTc25VlqDsgtge/1X4W2AYyij5cDs9xbOF
         GeN9t2NGZkaagTO4JBQj7oUVFBncOpX6Aw4bAYn26ivsZQThzPPNtoxjB7Cd8I0Pz77i
         kM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686853695; x=1689445695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuEo+qN9UsmOC5gS6dz6Bus0OXg/D1nOA7fnGrCQFxU=;
        b=ShiO0iPqbgpch/4C8DuRc92nAFkobqMLncarupTR4IGop94q/i5rm8y0CadI/ZAvB/
         0ofdth4DOc4PNEmYaOoLzSnW5ioEgdQtx2I6ehvR0Beq/RTsFBgbBgMSXTMARCyXc8xi
         R78OXNVvdNkRBaBGnR1RUdG/tplNVqNWw96jd0sSzPp2GgSL/htTR4Mk4qOSp9FaJXSQ
         OgnpBUioW2L5/vA1WRuomC+4gjKAeIYL1bfI8IRtRLTpkeKWagi8ihWJ/t2a8E6wzHr1
         nj0vwCWeG1rHEEMI9UqQi1my64P2n2Klb7Hwgu7z8djxSP6XadXO83ol7Z/skMRisceb
         pYbQ==
X-Gm-Message-State: AC+VfDzwiG3hBpoQ5ki4CRIdEQjxlGKJmYLqNS/fAUDpC5/lo713Ux7m
        dZbw5SjSMG5jpYthL6eHpEexpIEruGdlvkWtngo=
X-Google-Smtp-Source: ACHHUZ6WIPwbohXw73rLDIib8t/IhYKMwXswMHLd0CbzOA1qi8zWI5W3mwWVALXFUQd1Bn0evzGqGjHydyaWbeFTqmQ=
X-Received: by 2002:a2e:980a:0:b0:2b1:c111:6c29 with SMTP id
 a10-20020a2e980a000000b002b1c1116c29mr168284ljj.32.1686853694922; Thu, 15 Jun
 2023 11:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220727135834.294184-1-brian.gix@intel.com> <20220727135834.294184-3-brian.gix@intel.com>
 <578e6d7afd676129decafba846a933f5@agner.ch> <CABBYNZJGKfwTQM8WAdUGXueTPnFyus1a65UO5mg2g4PXVuCnpA@mail.gmail.com>
In-Reply-To: <CABBYNZJGKfwTQM8WAdUGXueTPnFyus1a65UO5mg2g4PXVuCnpA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 15 Jun 2023 11:28:02 -0700
Message-ID: <CABBYNZLgG+zTsk-6ceqzLXXyVRnN6p-m8sFq9Ss7mveD0f9BsQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] Bluetooth: Rework le_scan_restart for hci_sync
To:     Stefan Agner <stefan@agner.ch>, Brian Gix <brian.gix@gmail.com>
Cc:     Brian Gix <brian.gix@intel.com>, linux-bluetooth@vger.kernel.org,
        marcel@holtmann.org, Regressions <regressions@lists.linux.dev>,
        =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

+Brian Gix

On Thu, Jun 15, 2023 at 10:27=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Stefan,
>
> On Thu, Jun 15, 2023 at 5:06=E2=80=AFAM Stefan Agner <stefan@agner.ch> wr=
ote:
> >
> > Hi Brian, hi all,
> >
> > We experienced quite some Bluetooth issues after moving from Linux 5.15
> > to 6.1 on Home Assistant OS, especially on Intel NUC type systems (whic=
h
> > is a popular choice in our community, so it might just be that). When
> > continuously scanning/listening for BLE packets, the packet flow
> > suddenly ends. Depending on which and how many devices (possibly also
> > other factors) within minutes or hours.
> >
> > Jan (in cc) was able to bisect the issue, and was able to pinpoint the
> > problem to this change.
> >
> > Meanwhile I was able to confirm, that reverting this single commit on
> > the latest 6.1.34 seems to resolve the issue.
> >
> > I've reviewed the change and surrounding code, and one thing I've
> > noticed is that the if statement to set cp.filter_dup in
> > hci_le_set_ext_scan_enable_sync and hci_le_set_scan_enable_sync are
> > different. Not sure if that needs to be the way it is, but my outside
> > gut feeling says hci_le_set_ext_scan_enable_sync should use "if (val &&
> > hci_dev_test_flag(hdev, HCI_MESH))" as well.
> >
> > However, that did not fix the problem (but maybe it is wrong
> > nonetheless?).
> >
> > Anyone has an idea what could be the problem here?
>
> Are there any logs of the problem? Does any HCI command fails or
> anything so that we can track down what could be wrong?

@Brian Gix perhaps you have a better idea what is going wrong here?

> > --
> > Stefan
> >
> > On 2022-07-27 15:58, Brian Gix wrote:
> > > le_scan_restart delayed work queue was running as a deprecated
> > > hci_request instead of on the newer thread-safe hci_sync mechanism.
> > >
> > > Signed-off-by: Brian Gix <brian.gix@intel.com>
> > > ---
> > >  net/bluetooth/hci_request.c | 89 -----------------------------------=
--
> > >  net/bluetooth/hci_sync.c    | 75 +++++++++++++++++++++++++++++++
> > >  2 files changed, 75 insertions(+), 89 deletions(-)
> > >
> > > diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.=
c
> > > index 32fefaa0d3ca..114af7350363 100644
> > > --- a/net/bluetooth/hci_request.c
> > > +++ b/net/bluetooth/hci_request.c
> > > @@ -1975,92 +1975,6 @@ int hci_abort_conn(struct hci_conn *conn, u8 r=
eason)
> > >       return 0;
> > >  }
> > >
> > > -static int le_scan_restart(struct hci_request *req, unsigned long op=
t)
> > > -{
> > > -     struct hci_dev *hdev =3D req->hdev;
> > > -
> > > -     /* If controller is not scanning we are done. */
> > > -     if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
> > > -             return 0;
> > > -
> > > -     if (hdev->scanning_paused) {
> > > -             bt_dev_dbg(hdev, "Scanning is paused for suspend");
> > > -             return 0;
> > > -     }
> > > -
> > > -     hci_req_add_le_scan_disable(req, false);
> > > -
> > > -     if (use_ext_scan(hdev)) {
> > > -             struct hci_cp_le_set_ext_scan_enable ext_enable_cp;
> > > -
> > > -             memset(&ext_enable_cp, 0, sizeof(ext_enable_cp));
> > > -             ext_enable_cp.enable =3D LE_SCAN_ENABLE;
> > > -             ext_enable_cp.filter_dup =3D LE_SCAN_FILTER_DUP_ENABLE;
> > > -
> > > -             hci_req_add(req, HCI_OP_LE_SET_EXT_SCAN_ENABLE,
> > > -                         sizeof(ext_enable_cp), &ext_enable_cp);
> > > -     } else {
> > > -             struct hci_cp_le_set_scan_enable cp;
> > > -
> > > -             memset(&cp, 0, sizeof(cp));
> > > -             cp.enable =3D LE_SCAN_ENABLE;
> > > -             cp.filter_dup =3D LE_SCAN_FILTER_DUP_ENABLE;
> > > -             hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp),=
 &cp);
> > > -     }
> > > -
> > > -     return 0;
> > > -}
> > > -
> > > -static void le_scan_restart_work(struct work_struct *work)
> > > -{
> > > -     struct hci_dev *hdev =3D container_of(work, struct hci_dev,
> > > -                                         le_scan_restart.work);
> > > -     unsigned long timeout, duration, scan_start, now;
> > > -     u8 status;
> > > -
> > > -     bt_dev_dbg(hdev, "");
> > > -
> > > -     hci_req_sync(hdev, le_scan_restart, 0, HCI_CMD_TIMEOUT, &status=
);
> > > -     if (status) {
> > > -             bt_dev_err(hdev, "failed to restart LE scan: status %d"=
,
> > > -                        status);
> > > -             return;
> > > -     }
> > > -
> > > -     hci_dev_lock(hdev);
> > > -
> > > -     if (!test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks)=
 ||
> > > -         !hdev->discovery.scan_start)
> > > -             goto unlock;
> > > -
> > > -     /* When the scan was started, hdev->le_scan_disable has been qu=
eued
> > > -      * after duration from scan_start. During scan restart this job
> > > -      * has been canceled, and we need to queue it again after prope=
r
> > > -      * timeout, to make sure that scan does not run indefinitely.
> > > -      */
> > > -     duration =3D hdev->discovery.scan_duration;
> > > -     scan_start =3D hdev->discovery.scan_start;
> > > -     now =3D jiffies;
> > > -     if (now - scan_start <=3D duration) {
> > > -             int elapsed;
> > > -
> > > -             if (now >=3D scan_start)
> > > -                     elapsed =3D now - scan_start;
> > > -             else
> > > -                     elapsed =3D ULONG_MAX - scan_start + now;
> > > -
> > > -             timeout =3D duration - elapsed;
> > > -     } else {
> > > -             timeout =3D 0;
> > > -     }
> > > -
> > > -     queue_delayed_work(hdev->req_workqueue,
> > > -                        &hdev->le_scan_disable, timeout);
> > > -
> > > -unlock:
> > > -     hci_dev_unlock(hdev);
> > > -}
> > > -
> > >  bool hci_req_stop_discovery(struct hci_request *req)
> > >  {
> > >       struct hci_dev *hdev =3D req->hdev;
> > > @@ -2158,7 +2072,6 @@ int hci_req_configure_datapath(struct hci_dev
> > > *hdev, struct bt_codec *codec)
> > >
> > >  void hci_request_setup(struct hci_dev *hdev)
> > >  {
> > > -     INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work)=
;
> > >       INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expir=
e);
> > >       INIT_DELAYED_WORK(&hdev->interleave_scan, interleave_scan_work)=
;
> > >  }
> > > @@ -2167,8 +2080,6 @@ void hci_request_cancel_all(struct hci_dev *hde=
v)
> > >  {
> > >       __hci_cmd_sync_cancel(hdev, ENODEV);
> > >
> > > -     cancel_delayed_work_sync(&hdev->le_scan_restart);
> > > -
> > >       if (hdev->adv_instance_timeout) {
> > >               cancel_delayed_work_sync(&hdev->adv_instance_expire);
> > >               hdev->adv_instance_timeout =3D 0;
> > > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > > index 7dae2ee1bb82..19d57ec0feb8 100644
> > > --- a/net/bluetooth/hci_sync.c
> > > +++ b/net/bluetooth/hci_sync.c
> > > @@ -392,6 +392,79 @@ static void le_scan_disable(struct work_struct *=
work)
> > >       hci_dev_unlock(hdev);
> > >  }
> > >
> > > +static int hci_le_set_scan_enable_sync(struct hci_dev *hdev, u8 val,
> > > +                                    u8 filter_dup);
> > > +static int hci_le_scan_restart_sync(struct hci_dev *hdev)
> > > +{
> > > +     /* If controller is not scanning we are done. */
> > > +     if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
> > > +             return 0;
> > > +
> > > +     if (hdev->scanning_paused) {
> > > +             bt_dev_dbg(hdev, "Scanning is paused for suspend");
> > > +             return 0;
> > > +     }
> > > +
> > > +     hci_le_set_scan_enable_sync(hdev, LE_SCAN_DISABLE, 0x00);
> > > +     return hci_le_set_scan_enable_sync(hdev, LE_SCAN_ENABLE,
> > > +                                        LE_SCAN_FILTER_DUP_ENABLE);
> > > +}
> > > +
> > > +static int le_scan_restart_sync(struct hci_dev *hdev, void *data)
> > > +{
> > > +     return hci_le_scan_restart_sync(hdev);
> > > +}
> > > +
> > > +static void le_scan_restart(struct work_struct *work)
> > > +{
> > > +     struct hci_dev *hdev =3D container_of(work, struct hci_dev,
> > > +                                         le_scan_restart.work);
> > > +     unsigned long timeout, duration, scan_start, now;
> > > +     int status;
> > > +
> > > +     bt_dev_dbg(hdev, "");
> > > +
> > > +     hci_dev_lock(hdev);
> > > +
> > > +     status =3D hci_cmd_sync_queue(hdev, le_scan_restart_sync, NULL,=
 NULL);
> > > +     if (status) {
> > > +             bt_dev_err(hdev, "failed to restart LE scan: status %d"=
,
> > > +                        status);
> > > +             goto unlock;
> > > +     }
> > > +
> > > +     if (!test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks)=
 ||
> > > +         !hdev->discovery.scan_start)
> > > +             goto unlock;
> > > +
> > > +     /* When the scan was started, hdev->le_scan_disable has been qu=
eued
> > > +      * after duration from scan_start. During scan restart this job
> > > +      * has been canceled, and we need to queue it again after prope=
r
> > > +      * timeout, to make sure that scan does not run indefinitely.
> > > +      */
> > > +     duration =3D hdev->discovery.scan_duration;
> > > +     scan_start =3D hdev->discovery.scan_start;
> > > +     now =3D jiffies;
> > > +     if (now - scan_start <=3D duration) {
> > > +             int elapsed;
> > > +
> > > +             if (now >=3D scan_start)
> > > +                     elapsed =3D now - scan_start;
> > > +             else
> > > +                     elapsed =3D ULONG_MAX - scan_start + now;
> > > +
> > > +             timeout =3D duration - elapsed;
> > > +     } else {
> > > +             timeout =3D 0;
> > > +     }
> > > +
> > > +     queue_delayed_work(hdev->req_workqueue,
> > > +                        &hdev->le_scan_disable, timeout);
> > > +
> > > +unlock:
> > > +     hci_dev_unlock(hdev);
> > > +}
> > > +
> > >  void hci_cmd_sync_init(struct hci_dev *hdev)
> > >  {
> > >       INIT_WORK(&hdev->cmd_sync_work, hci_cmd_sync_work);
> > > @@ -400,6 +473,7 @@ void hci_cmd_sync_init(struct hci_dev *hdev)
> > >
> > >       INIT_WORK(&hdev->cmd_sync_cancel_work, hci_cmd_sync_cancel_work=
);
> > >       INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable);
> > > +     INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart);
> > >  }
> > >
> > >  void hci_cmd_sync_clear(struct hci_dev *hdev)
> > > @@ -4488,6 +4562,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
> > >       cancel_delayed_work(&hdev->power_off);
> > >       cancel_delayed_work(&hdev->ncmd_timer);
> > >       cancel_delayed_work(&hdev->le_scan_disable);
> > > +     cancel_delayed_work(&hdev->le_scan_restart);
> > >
> > >       hci_request_cancel_all(hdev);
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
