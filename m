Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5673E9C2B
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437486; cv=pass; b=MV88AUvl1oMPD7BGmBgIOBMcmVWofocTCemryT7yPzaIe/bM+gvvZe2AwEMH20qyA4BQIK/2OwHz5MjGwzxOp8OmR95XZbwa2MiXCPd4dWvyiduzN2kBQqlMwVKcm3UKEODmmVS+MRNolxjInSLkTgQTJbGQA8gJn0CCvpNqMFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437486; c=relaxed/simple;
	bh=JrLe0+91RvH+iwQVMtiHQWSAzagGN6ayCbcuR3ZTX4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k52TSHlrDdITU+mZSAaOPcRSqQgrTUH1dEJfx245yOiBcc5n44GL2HzWDRLgjQtD4haIo9mhDsSCc2gqpOIvI097n0hql+XEWUlcCzmtHQ2a+kZO2iG7p5hEEeUTcr6ZUQ+afiXFL4G0Jfspmty9hgK/eLQ0GeZcgtkx7ycZLrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJqcL8bI; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJqcL8bI"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-664e3ed58bcso971698d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 08:18:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783437483; cv=none;
        d=google.com; s=arc-20260327;
        b=QuAoP4xfSog18BgLit+ZOSvI/K/xku4nu1vxjwYGUEk1hAvLOr1df2+tUVbs9GoSlt
         Fh4I4HLtCHg0dy3MV6vLvWM3aurQWgJ4+kImaudwQy5UvszmrVDlptgAKeqlgYUnqs/b
         bNpxUzBSWgb+1kl7auoyETG3BQE4o4nk+IK4mjJAZ3ZuNPSVGrZOPaGq4ePC+ow0mwpt
         fluZIsJSWBpzwt8fAgZiUpJLDBO/vYtHWNWKHPG17xvgSzSJrUDXYbb49ujPbA9jYpdo
         p1jEEB80y6OfY6+VzLQDMuZPE3XyLETOckFpDeL26rg4Qf9qHK1F6EwlyqMb8mb+wUjw
         voJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2ZaCl6zujV03WJXHYNWe6umkNXdAYNDCuyNyxaJxU8w=;
        fh=oeaDEGUaJfiYC1PwstpOqLEJQtWTd8wVE9fGssqe/Yg=;
        b=gniPe/muPzYfxLiLxqwdMU78iRi6Hj1E9d1xiRzcClmWeN5BTB0KyrgdUfQUXj2x4j
         5uMX43wi64aXYPUE+vFdbTafE5t4kzz6QO8ERz7xcUmWpX/lniE/mTwp2yyo0MAR/XIv
         UG/v+lipduYDD43YrK0w519NIoLONOzWrqpjPEVrelHlkCf9XJFOrI+mrzkWXcqiy5nK
         Fsd/xmgW2jkY7WQyZCsW6ocoSR8VwtLPxI0YELBV3dvkj6GMVA3V36nZ8QXjb/UrPlWG
         HgQi5D7nz0ec6ksUXzbW9Jj/Fjq2OFSdXvtWKPfGnM7c+D4HKksPvcCywoi0RRpkSvD/
         8dyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783437483; x=1784042283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZaCl6zujV03WJXHYNWe6umkNXdAYNDCuyNyxaJxU8w=;
        b=nJqcL8bIJ0M7vh+oqWEITYKKm9tnzIoUsMhUEkAoPiMeL11tw4heCm20hAt0GfN51O
         tcP3nA6RQxTQCay70HhZveUB/NSAmjaKBYqaWZE71B42641YmETFNNzao7P0QycXTFfl
         NpyhG9gwMGyK3MOK63hUA5dsc8RMsWEzzD37CnCHx88aKWNGKbq+j913y7iL3c8B/1fR
         H7Ge++wQRD89PWl2gHiDW9jKeaLJt/xndA+M3YuS47Js1eit9JY2AlaY9PlcQEJxgkpO
         23QhkW+rUe5aKZeVfEDcvKEd+giCKkaJX4XaAmGPbDLINWjLm8p5Ug+XUZjyVFK2smzL
         iyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783437483; x=1784042283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2ZaCl6zujV03WJXHYNWe6umkNXdAYNDCuyNyxaJxU8w=;
        b=N3iwD7pOEwOgsNEWNBvhfIHikzqsEkgYKq4bkDElFLseLzoemK7vtKysXvgSoCPma1
         qb7EA6H9TD6DoR/LzvXvYPdgAzTGvogRghbnl4/EB6tnbf4bMSZBFtDx/QkeL5NK8eKc
         BbMu145btUtfFW/7AXHYic/TwnUHv8AXGOyIVpN5+Bk5O5PKO+79NlbL5lxtAey+xT7o
         fwzb4CFiEEWylYbUyjeleYxcYM59PKkjsGgtJm6xc+gxWcFP2VzSGEedqJQNxxy5YaFX
         Yi0/aJBkXgH0HUfVrFO46c5kmKHxGCNHRD18C0pqiCz1CK1fT/3FZr7GmZ23ds9J3tjn
         sL9A==
X-Forwarded-Encrypted: i=1; AHgh+Rq/Tu1t0mAZMR4oE17IkkPYLO+qrZonqgS01iSnAcAGyZ9zGBsV0q3YS7IMaFrYjSiD8agmRiAgVIRf230M2RY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRKFfi6/hcL4zSwrblJL2Y65ZpyAGq+/w/mm4wcXzHlMczPNWl
	DBarcD35fhaZ/gJ4+CmeCOO3JkWh+49pkRuZaXvLW9xeGresk32N9vKlrP6xrBbx89pgrUUqBOl
	b0eawDfQBEym55Q+2e8wU/Dy+Dowf8SU=
X-Gm-Gg: AfdE7ckPky41GMR7ndwsX4YAq3ApkC21H2FXzMPLkb6Du5K20WzNqBz11YO1DjM4x8x
	smjYpxhS7BreVx7K4L/VO23pDw75vfTFG2vtB40O9ys7s7koHa7/HOhn+ORJ9NonqED3JjKNmyM
	TWKqOOMAg06IKXyHPxHFM6DTV09GmE4XYAwUyPIV/FnDvexIcoc9JiGCTelEFN2Vh3YRJJlKjkJ
	Y9ypoDiLUZBJc30yEk/A5SG5EkOYfA8sX+1PdccZiLpXZ4ETu37upNhWHNDOwj+/uGUotiN+3qJ
	kabVgV5/Fv7Mlk/uGMvw3szvSAVpCYb2ORYQWRahKNoqn6F0FygquMHyoHE=
X-Received: by 2002:a05:690e:1656:b0:664:b335:ed44 with SMTP id
 956f58d0204a3-66788de159dmr1968703d50.18.1783437482930; Tue, 07 Jul 2026
 08:18:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707093426.372897-1-xiuzhuo.shang@oss.qualcomm.com> <CABBYNZ+X-+ZJYz-V-_QSP5kCJpJJaBiyO=wMHD+Ut+b=639t2Q@mail.gmail.com>
In-Reply-To: <CABBYNZ+X-+ZJYz-V-_QSP5kCJpJJaBiyO=wMHD+Ut+b=639t2Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 7 Jul 2026 11:17:51 -0400
X-Gm-Features: AVVi8Cc5pPMYKvZIKRc8IN7tJ5gFRaYxX6Ggp4Pn3O5zGAdkHnGgjzgDwEvFzQ4
Message-ID: <CABBYNZLXZaY7KiUneNMg7PrsTJjPF99hPY3sq5a2pL0RC9Z4tg@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: MGMT: Fix discovery state race against
 cmd_sync worker
To: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com, 
	wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com, 
	mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xiuzhuo,

On Tue, Jul 7, 2026 at 10:09=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Xiuzhuo,
>
> On Tue, Jul 7, 2026 at 5:34=E2=80=AFAM Xiuzhuo Shang
> <xiuzhuo.shang@oss.qualcomm.com> wrote:
> >
> > start_discovery_internal(), start_service_discovery() and stop_discover=
y()
> > queue a cmd_sync work item and only then move the discovery state machi=
ne
> > into its transient value (DISCOVERY_STARTING / DISCOVERY_STOPPING):
> >   err =3D hci_cmd_sync_queue(hdev, ..._sync, cmd, ..._complete);
> >   if (err < 0) { ... }
> >   hci_discovery_set_state(hdev, DISCOVERY_STARTING /* or STOPPING */);
> > The matching completion callbacks run on hdev->req_workqueue serialised
> > by hci_req_sync_lock, which is independent of hdev->lock. So once the
> > work has been queued, the worker can be scheduled, run the sync functio=
n
> > and invoke the completion before the caller has executed the trailing
> > hci_discovery_set_state(). The completion's success path writes the
> > terminal state (DISCOVERY_STOPPED for stop, DISCOVERY_FINDING for start=
);
> > the caller then overwrites it with the transient value, and the state
> > machine is wedged: every subsequent Start (Service) Discovery is
> > rejected by the DISCOVERY_STOPPED gate with MGMT_STATUS_BUSY (0x0a),
> > with no HCI traffic generated, until bluetoothd or the adapter is
> > restarted.
> > Fix it in three parts:
> >   1. In all three call sites move hci_discovery_set_state(STARTING /
> >      STOPPING) to before hci_cmd_sync_queue(). The transient state is
> >      therefore always published before any worker can run the
> >      completion. On queue-submit failure, roll back to
> >      DISCOVERY_STOPPED.
> >   2. In start_discovery_complete() and stop_discovery_complete(), wrap
> >      the terminal hci_discovery_set_state() call with
> >      hci_dev_lock() / hci_dev_unlock(). These callbacks run without
> >      hdev->lock; serialising the state write matches the pattern used
> >      by mgmt_set_powered_complete() and removes any residual ordering
> >      hazard against a concurrent mgmt path holding hdev->lock.
> >   3. Generalise the "ignore -ECANCELED" early return in both completion
> >      callbacks to "on any err < 0, also reset the transient state to
> >      STOPPED". With (1) in place the state observed at completion time
> >      is always known.
> >      For the stop path this also fixes a pre-existing wedge: when any
> >      sub-command issued from hci_stop_discovery_sync() returns an
> >      error, stop_discovery_complete() is invoked with err < 0. The
> >      existing "if (!err) set_state(STOPPED)" tail then skips the reset
> >      and the state machine sits in DISCOVERY_STOPPING forever.
>
> Needs the Fixes tag since we might want to backport.
>
> > Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
> > ---
> >  net/bluetooth/mgmt.c | 86 +++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 74 insertions(+), 12 deletions(-)
> >
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 733a4b70e10c..25ad9c10740d 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -5975,15 +5975,38 @@ static void start_discovery_complete(struct hci=
_dev *hdev, void *data, int err)
> >
> >         bt_dev_dbg(hdev, "err %d", err);
> >
> > -       if (err =3D=3D -ECANCELED || !mgmt_pending_valid(hdev, cmd))
> > +       if (err < 0) {

Sashiko flags the above check as an issue because it tests only for
negative errors, not HCI (positive) errors:

https://sashiko.dev/#/patchset/20260707093426.372897-1-xiuzhuo.shang%40oss.=
qualcomm.com

> > +               /* The queued start-discovery work failed before the no=
rmal
> > +                * completion path could advance the state machine. The
> > +                * caller already moved the state to DISCOVERY_STARTING
> > +                * (under hdev->lock, before queueing). Reset it here s=
o the
> > +                * gate in start_discovery_internal()/start_service_dis=
covery()
> > +                * does not wedge in STARTING and reject every future S=
tart
> > +                * (Service) Discovery with MGMT_STATUS_BUSY.
> > +                */
> > +               hci_dev_lock(hdev);
> > +               if (hdev->discovery.state =3D=3D DISCOVERY_STARTING)
> > +                       hci_discovery_set_state(hdev, DISCOVERY_STOPPED=
);
> > +               hci_dev_unlock(hdev);
> > +
> > +               if (err =3D=3D -ECANCELED)
> > +                       return;
> > +       }
> > +
> > +       if (!mgmt_pending_valid(hdev, cmd))
> >                 return;
> >
> >         mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_sta=
tus(err),
> >                           cmd->param, 1);
> >         mgmt_pending_free(cmd);
> >
> > -       hci_discovery_set_state(hdev, err ? DISCOVERY_STOPPED:
> > +       /* Serialise discovery.state writes against any concurrent mgmt=
 path
> > +        * holding hdev->lock; this callback runs on req_workqueue with=
out it.
> > +        */
> > +       hci_dev_lock(hdev);
> > +       hci_discovery_set_state(hdev, err ? DISCOVERY_STOPPED :
> >                                 DISCOVERY_FINDING);
> > +       hci_dev_unlock(hdev);
> >  }
> >
> >  static int start_discovery_sync(struct hci_dev *hdev, void *data)
> > @@ -6051,15 +6074,23 @@ static int start_discovery_internal(struct sock=
 *sk, struct hci_dev *hdev,
> >                 goto failed;
> >         }
> >
> > +       /* Publish the transient state BEFORE queueing the work. The
> > +        * completion callback runs on hdev->req_workqueue serialised b=
y
> > +        * hci_req_sync_lock, which is independent of hdev->lock; setti=
ng
> > +        * the state after the queue allowed the worker to win the race
> > +        * and have its terminal STOPPED/FINDING write overwritten by t=
his
> > +        * trailing STARTING write, wedging discovery in STARTING.
> > +        */
> > +       hci_discovery_set_state(hdev, DISCOVERY_STARTING);
>
> Hmm, do we really need to do this if hdev lock is taken at
> start_discovery_sync? Because that should then synchronize the
> callback won't be able to change the state before it is set to
> DISCOVERY_STARTING.
>
> >         err =3D hci_cmd_sync_queue(hdev, start_discovery_sync, cmd,
> >                                  start_discovery_complete);
> >         if (err < 0) {
> > +               hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> >                 mgmt_pending_remove(cmd);
> >                 goto failed;
> >         }
> >
> > -       hci_discovery_set_state(hdev, DISCOVERY_STARTING);
> > -
> >  failed:
> >         hci_dev_unlock(hdev);
> >         return err;
> > @@ -6178,15 +6209,19 @@ static int start_service_discovery(struct sock =
*sk, struct hci_dev *hdev,
> >                 }
> >         }
> >
> > +       /* Publish the transient state BEFORE queueing; see the comment=
 in
> > +        * start_discovery_internal() for the race details.
> > +        */
> > +       hci_discovery_set_state(hdev, DISCOVERY_STARTING);
>
> Ditto.
>
> >         err =3D hci_cmd_sync_queue(hdev, start_discovery_sync, cmd,
> >                                  start_discovery_complete);
> >         if (err < 0) {
> > +               hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> >                 mgmt_pending_remove(cmd);
> >                 goto failed;
> >         }
> >
> > -       hci_discovery_set_state(hdev, DISCOVERY_STARTING);
> > -
> >  failed:
> >         hci_dev_unlock(hdev);
> >         return err;
> > @@ -6196,17 +6231,40 @@ static void stop_discovery_complete(struct hci_=
dev *hdev, void *data, int err)
> >  {
> >         struct mgmt_pending_cmd *cmd =3D data;
> >
> > -       if (err =3D=3D -ECANCELED || !mgmt_pending_valid(hdev, cmd))
> > -               return;
> > -
> >         bt_dev_dbg(hdev, "err %d", err);
> >
> > +       if (err < 0) {
> > +               /* The queued stop-discovery work failed before the nor=
mal
> > +                * completion path could advance the state machine. The
> > +                * caller already moved the state to DISCOVERY_STOPPING
> > +                * (under hdev->lock, before queueing). Reset it here s=
o
> > +                * the gate does not wedge in STOPPING.
> > +                */
> > +               hci_dev_lock(hdev);
> > +               if (hdev->discovery.state =3D=3D DISCOVERY_STOPPING)
> > +                       hci_discovery_set_state(hdev, DISCOVERY_STOPPED=
);
> > +               hci_dev_unlock(hdev);
> > +
> > +               if (err =3D=3D -ECANCELED)
> > +                       return;
> > +       }
> > +
> > +       if (!mgmt_pending_valid(hdev, cmd))
> > +               return;
> > +
> >         mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_sta=
tus(err),
> >                           cmd->param, 1);
> >         mgmt_pending_free(cmd);
> >
> > -       if (!err)
> > +       if (!err) {
> > +               /* Serialise discovery.state writes against any concurr=
ent
> > +                * mgmt path holding hdev->lock; this callback runs on
> > +                * req_workqueue without it.
> > +                */
> > +               hci_dev_lock(hdev);
> >                 hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> > +               hci_dev_unlock(hdev);
> > +       }
> >  }
> >
> >  static int stop_discovery_sync(struct hci_dev *hdev, void *data)
> > @@ -6248,15 +6306,19 @@ static int stop_discovery(struct sock *sk, stru=
ct hci_dev *hdev, void *data,
> >                 goto unlock;
> >         }
> >
> > +       /* Publish the transient state BEFORE queueing; see the comment=
 in
> > +        * start_discovery_internal() for the race details.
> > +        */
> > +       hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
>
> Ditto.
>
> >         err =3D hci_cmd_sync_queue(hdev, stop_discovery_sync, cmd,
> >                                  stop_discovery_complete);
> >         if (err < 0) {
> > +               hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> >                 mgmt_pending_remove(cmd);
> >                 goto unlock;
> >         }
> >
> > -       hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
> > -
> >  unlock:
> >         hci_dev_unlock(hdev);
> >         return err;
> > --
> > 2.43.0
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
