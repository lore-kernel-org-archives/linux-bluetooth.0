Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F071C0015E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jun 2023 17:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjFOR11 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Jun 2023 13:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239312AbjFOR1V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Jun 2023 13:27:21 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AF6271E
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jun 2023 10:27:19 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b1afe57bdfso33025481fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jun 2023 10:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686850038; x=1689442038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+avTCV6NrJInGw+RAS8r8EI9G1Hf3tcg+dqnaNehIeQ=;
        b=kZnETjsfzYF4Ckkc0ao5Rw5aSXu/tIbNComFQi2KhMy0oScv2MLTMNnu+fKL78Jv7i
         z4stQd8VNa1cRsRqNCr+ogT34FJPbdJqHv4eRydLqNfRvYpFcW2miQNsFyf5YT4AysW/
         fCMqds3U12ESLh4TEndf+fjrLYIUZrKUJGiIx6YCNfn3re73mTHyKpJVP32inM6L1P8H
         Edi9+cu1FbeLv83HG7/8JackFs2NRYoA3v3b1TRjYThXTAVPlduRJS29FjGd1dHGCjg9
         Sm9+1OfoTt3oB8FgYzM54nhKE8Z1lfJea0kf8atOSNQRH5hPh059aTCoFGZQR+BsFHi0
         q6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686850038; x=1689442038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+avTCV6NrJInGw+RAS8r8EI9G1Hf3tcg+dqnaNehIeQ=;
        b=c7A556b/2fsZAPxLlL39AbEpj8kDmKXSS4V0UP33VwSX9yNr+8xV37WU7cp5wEia1D
         GprkteIQuNj6BIR2Pe923t9NVxuTtfJ0OhrleEFr9mYwqyIzvXYMZLpb+yxXmsaNHrh8
         rzHRuJcJ/ciQUR3EE10/phuvYSejAfSdGT4w00enx/Nsx7P5gsXdonpPIRJiwATPIAud
         iIwQwJanULyM5Rx1aeFrFGsNk8SqnNL0h4pHeqIjOJAnCoFxL6SgldYt+Eb3brfTzRjA
         M72dKdMS5r8daxwxtEmHS6iLRtl8kQf/i8xVNrAWHOX0RP4WcRJ8R42iaIAlZycgocP4
         pvGw==
X-Gm-Message-State: AC+VfDwsg5iR68t3AQz8zV6dS2P5PCrJXQoi1NjwInlvsqXE23oJS+hz
        HKtMCug9E9kJ0dU8hw0/7K/4TRc+L3u0CW4WmcJfcrtS4IHkdg==
X-Google-Smtp-Source: ACHHUZ5RXWArE0r9/G9IEVd390+5OvCawDqUmBExB0D6IwAYIBNmsnq05B0PLiOCf7LYXsByrawM7uR33TL0lk/nlCM=
X-Received: by 2002:a05:651c:104:b0:2b4:466d:deb5 with SMTP id
 a4-20020a05651c010400b002b4466ddeb5mr61097ljb.43.1686850037505; Thu, 15 Jun
 2023 10:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220727135834.294184-1-brian.gix@intel.com> <20220727135834.294184-3-brian.gix@intel.com>
 <578e6d7afd676129decafba846a933f5@agner.ch>
In-Reply-To: <578e6d7afd676129decafba846a933f5@agner.ch>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 15 Jun 2023 10:27:04 -0700
Message-ID: <CABBYNZJGKfwTQM8WAdUGXueTPnFyus1a65UO5mg2g4PXVuCnpA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] Bluetooth: Rework le_scan_restart for hci_sync
To:     Stefan Agner <stefan@agner.ch>
Cc:     Brian Gix <brian.gix@intel.com>, linux-bluetooth@vger.kernel.org,
        marcel@holtmann.org, Regressions <regressions@lists.linux.dev>,
        =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Stefan,

On Thu, Jun 15, 2023 at 5:06=E2=80=AFAM Stefan Agner <stefan@agner.ch> wrot=
e:
>
> Hi Brian, hi all,
>
> We experienced quite some Bluetooth issues after moving from Linux 5.15
> to 6.1 on Home Assistant OS, especially on Intel NUC type systems (which
> is a popular choice in our community, so it might just be that). When
> continuously scanning/listening for BLE packets, the packet flow
> suddenly ends. Depending on which and how many devices (possibly also
> other factors) within minutes or hours.
>
> Jan (in cc) was able to bisect the issue, and was able to pinpoint the
> problem to this change.
>
> Meanwhile I was able to confirm, that reverting this single commit on
> the latest 6.1.34 seems to resolve the issue.
>
> I've reviewed the change and surrounding code, and one thing I've
> noticed is that the if statement to set cp.filter_dup in
> hci_le_set_ext_scan_enable_sync and hci_le_set_scan_enable_sync are
> different. Not sure if that needs to be the way it is, but my outside
> gut feeling says hci_le_set_ext_scan_enable_sync should use "if (val &&
> hci_dev_test_flag(hdev, HCI_MESH))" as well.
>
> However, that did not fix the problem (but maybe it is wrong
> nonetheless?).
>
> Anyone has an idea what could be the problem here?

Are there any logs of the problem? Does any HCI command fails or
anything so that we can track down what could be wrong?

> --
> Stefan
>
> On 2022-07-27 15:58, Brian Gix wrote:
> > le_scan_restart delayed work queue was running as a deprecated
> > hci_request instead of on the newer thread-safe hci_sync mechanism.
> >
> > Signed-off-by: Brian Gix <brian.gix@intel.com>
> > ---
> >  net/bluetooth/hci_request.c | 89 -------------------------------------
> >  net/bluetooth/hci_sync.c    | 75 +++++++++++++++++++++++++++++++
> >  2 files changed, 75 insertions(+), 89 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> > index 32fefaa0d3ca..114af7350363 100644
> > --- a/net/bluetooth/hci_request.c
> > +++ b/net/bluetooth/hci_request.c
> > @@ -1975,92 +1975,6 @@ int hci_abort_conn(struct hci_conn *conn, u8 rea=
son)
> >       return 0;
> >  }
> >
> > -static int le_scan_restart(struct hci_request *req, unsigned long opt)
> > -{
> > -     struct hci_dev *hdev =3D req->hdev;
> > -
> > -     /* If controller is not scanning we are done. */
> > -     if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
> > -             return 0;
> > -
> > -     if (hdev->scanning_paused) {
> > -             bt_dev_dbg(hdev, "Scanning is paused for suspend");
> > -             return 0;
> > -     }
> > -
> > -     hci_req_add_le_scan_disable(req, false);
> > -
> > -     if (use_ext_scan(hdev)) {
> > -             struct hci_cp_le_set_ext_scan_enable ext_enable_cp;
> > -
> > -             memset(&ext_enable_cp, 0, sizeof(ext_enable_cp));
> > -             ext_enable_cp.enable =3D LE_SCAN_ENABLE;
> > -             ext_enable_cp.filter_dup =3D LE_SCAN_FILTER_DUP_ENABLE;
> > -
> > -             hci_req_add(req, HCI_OP_LE_SET_EXT_SCAN_ENABLE,
> > -                         sizeof(ext_enable_cp), &ext_enable_cp);
> > -     } else {
> > -             struct hci_cp_le_set_scan_enable cp;
> > -
> > -             memset(&cp, 0, sizeof(cp));
> > -             cp.enable =3D LE_SCAN_ENABLE;
> > -             cp.filter_dup =3D LE_SCAN_FILTER_DUP_ENABLE;
> > -             hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &=
cp);
> > -     }
> > -
> > -     return 0;
> > -}
> > -
> > -static void le_scan_restart_work(struct work_struct *work)
> > -{
> > -     struct hci_dev *hdev =3D container_of(work, struct hci_dev,
> > -                                         le_scan_restart.work);
> > -     unsigned long timeout, duration, scan_start, now;
> > -     u8 status;
> > -
> > -     bt_dev_dbg(hdev, "");
> > -
> > -     hci_req_sync(hdev, le_scan_restart, 0, HCI_CMD_TIMEOUT, &status);
> > -     if (status) {
> > -             bt_dev_err(hdev, "failed to restart LE scan: status %d",
> > -                        status);
> > -             return;
> > -     }
> > -
> > -     hci_dev_lock(hdev);
> > -
> > -     if (!test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks) |=
|
> > -         !hdev->discovery.scan_start)
> > -             goto unlock;
> > -
> > -     /* When the scan was started, hdev->le_scan_disable has been queu=
ed
> > -      * after duration from scan_start. During scan restart this job
> > -      * has been canceled, and we need to queue it again after proper
> > -      * timeout, to make sure that scan does not run indefinitely.
> > -      */
> > -     duration =3D hdev->discovery.scan_duration;
> > -     scan_start =3D hdev->discovery.scan_start;
> > -     now =3D jiffies;
> > -     if (now - scan_start <=3D duration) {
> > -             int elapsed;
> > -
> > -             if (now >=3D scan_start)
> > -                     elapsed =3D now - scan_start;
> > -             else
> > -                     elapsed =3D ULONG_MAX - scan_start + now;
> > -
> > -             timeout =3D duration - elapsed;
> > -     } else {
> > -             timeout =3D 0;
> > -     }
> > -
> > -     queue_delayed_work(hdev->req_workqueue,
> > -                        &hdev->le_scan_disable, timeout);
> > -
> > -unlock:
> > -     hci_dev_unlock(hdev);
> > -}
> > -
> >  bool hci_req_stop_discovery(struct hci_request *req)
> >  {
> >       struct hci_dev *hdev =3D req->hdev;
> > @@ -2158,7 +2072,6 @@ int hci_req_configure_datapath(struct hci_dev
> > *hdev, struct bt_codec *codec)
> >
> >  void hci_request_setup(struct hci_dev *hdev)
> >  {
> > -     INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
> >       INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expire)=
;
> >       INIT_DELAYED_WORK(&hdev->interleave_scan, interleave_scan_work);
> >  }
> > @@ -2167,8 +2080,6 @@ void hci_request_cancel_all(struct hci_dev *hdev)
> >  {
> >       __hci_cmd_sync_cancel(hdev, ENODEV);
> >
> > -     cancel_delayed_work_sync(&hdev->le_scan_restart);
> > -
> >       if (hdev->adv_instance_timeout) {
> >               cancel_delayed_work_sync(&hdev->adv_instance_expire);
> >               hdev->adv_instance_timeout =3D 0;
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 7dae2ee1bb82..19d57ec0feb8 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -392,6 +392,79 @@ static void le_scan_disable(struct work_struct *wo=
rk)
> >       hci_dev_unlock(hdev);
> >  }
> >
> > +static int hci_le_set_scan_enable_sync(struct hci_dev *hdev, u8 val,
> > +                                    u8 filter_dup);
> > +static int hci_le_scan_restart_sync(struct hci_dev *hdev)
> > +{
> > +     /* If controller is not scanning we are done. */
> > +     if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
> > +             return 0;
> > +
> > +     if (hdev->scanning_paused) {
> > +             bt_dev_dbg(hdev, "Scanning is paused for suspend");
> > +             return 0;
> > +     }
> > +
> > +     hci_le_set_scan_enable_sync(hdev, LE_SCAN_DISABLE, 0x00);
> > +     return hci_le_set_scan_enable_sync(hdev, LE_SCAN_ENABLE,
> > +                                        LE_SCAN_FILTER_DUP_ENABLE);
> > +}
> > +
> > +static int le_scan_restart_sync(struct hci_dev *hdev, void *data)
> > +{
> > +     return hci_le_scan_restart_sync(hdev);
> > +}
> > +
> > +static void le_scan_restart(struct work_struct *work)
> > +{
> > +     struct hci_dev *hdev =3D container_of(work, struct hci_dev,
> > +                                         le_scan_restart.work);
> > +     unsigned long timeout, duration, scan_start, now;
> > +     int status;
> > +
> > +     bt_dev_dbg(hdev, "");
> > +
> > +     hci_dev_lock(hdev);
> > +
> > +     status =3D hci_cmd_sync_queue(hdev, le_scan_restart_sync, NULL, N=
ULL);
> > +     if (status) {
> > +             bt_dev_err(hdev, "failed to restart LE scan: status %d",
> > +                        status);
> > +             goto unlock;
> > +     }
> > +
> > +     if (!test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks) |=
|
> > +         !hdev->discovery.scan_start)
> > +             goto unlock;
> > +
> > +     /* When the scan was started, hdev->le_scan_disable has been queu=
ed
> > +      * after duration from scan_start. During scan restart this job
> > +      * has been canceled, and we need to queue it again after proper
> > +      * timeout, to make sure that scan does not run indefinitely.
> > +      */
> > +     duration =3D hdev->discovery.scan_duration;
> > +     scan_start =3D hdev->discovery.scan_start;
> > +     now =3D jiffies;
> > +     if (now - scan_start <=3D duration) {
> > +             int elapsed;
> > +
> > +             if (now >=3D scan_start)
> > +                     elapsed =3D now - scan_start;
> > +             else
> > +                     elapsed =3D ULONG_MAX - scan_start + now;
> > +
> > +             timeout =3D duration - elapsed;
> > +     } else {
> > +             timeout =3D 0;
> > +     }
> > +
> > +     queue_delayed_work(hdev->req_workqueue,
> > +                        &hdev->le_scan_disable, timeout);
> > +
> > +unlock:
> > +     hci_dev_unlock(hdev);
> > +}
> > +
> >  void hci_cmd_sync_init(struct hci_dev *hdev)
> >  {
> >       INIT_WORK(&hdev->cmd_sync_work, hci_cmd_sync_work);
> > @@ -400,6 +473,7 @@ void hci_cmd_sync_init(struct hci_dev *hdev)
> >
> >       INIT_WORK(&hdev->cmd_sync_cancel_work, hci_cmd_sync_cancel_work);
> >       INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable);
> > +     INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart);
> >  }
> >
> >  void hci_cmd_sync_clear(struct hci_dev *hdev)
> > @@ -4488,6 +4562,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
> >       cancel_delayed_work(&hdev->power_off);
> >       cancel_delayed_work(&hdev->ncmd_timer);
> >       cancel_delayed_work(&hdev->le_scan_disable);
> > +     cancel_delayed_work(&hdev->le_scan_restart);
> >
> >       hci_request_cancel_all(hdev);



--=20
Luiz Augusto von Dentz
