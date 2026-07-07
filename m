Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D7F313E2B
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433363; cv=pass; b=m1zto0JilPSLhFYUa4qlw1xG2QwV2ogAdy1+ZE3gfjNOmTmhSZ4h/5+Kx7SBelbFlSKMt+rX154wIbz3zKONNIb2FI3E1VsF2Ke94kF28r5YbhUiaeBCcZlq95nTFPmzNSG/IN947g/ihJ4WlfOjOMjqW/3qBKvX2oo9LC6Grk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433363; c=relaxed/simple;
	bh=4Gk/T7gcb9Frs7VwcGVHH2iC1ABibfBUNLCg4sA29Ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oPUY9PAhTqGjOGSI7EF99FGrlPvjtY0GH510Me/YI+eeoVTPjt1iKOliTzHRuKbQn/XMys6FplGMrssWyZ/tidOJY2Ewvf+nxrlhwNUMwQX8wHb2hUODK9jxoJO5m+nU3zx1cgqItYhBOY+QW1m6FqACdFbtWNUAu7HVgq16sTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igV8La/b; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igV8La/b"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6651bc57458so2747500d50.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 07:09:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783433360; cv=none;
        d=google.com; s=arc-20260327;
        b=QpqkL63UlV6mpkjjElJnnQUZrgFC8DU0x3reKuPN/eRFn6UKDLpNWOQoYtj2HFiTh5
         WugrabfwpraWleQlG7JIQGaBMyZWjUusHgSBTPiF25q1H/nZ8kpp1XhGbipQ8ZN5iSvQ
         vJXx+fhRgf4DjK5FSq81C6OphqpPKQaLIrPwm0UIWGZH9K1FqzBTlfOLgGKXn6svzrzV
         HwxgdZ0h9J5IPldHpXhJ/eLBYZVAgQNu0t8YLpZvvY/Lvm4fefYf8jfbr2gM2ovEO8St
         V7C65HM+wF21xuhGmAeMsivsQB4PtMZOypSgb8MOuL3RKeA+udNcCNiiIQKgAtJTQrq+
         uC9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AdoCQ4ZX5BtlQtLCqarU4DocdJVuupPvE5g+WnHkPbY=;
        fh=/vklIAWVaRe11ziRV8KwNh4FssYL/JFMBACc+LsDRx8=;
        b=aP9ihuwbUxIzlKJCrh0y9/AKYno66dETVqr3E6wb4FfO4RihJRQYm0qp7BmbJs+qti
         zlH1rs58TMvChCOwtBKE/GB+w6CngQHL+H6qw46QS6YED4Van9AKnivaVmOKKzacY/cJ
         IlJXjQJxaHJDX6mBg52GOf+x8et9IkWl11kAcm2OLSdeavg81IajEscFD7jTDLaL5s+n
         iyAuH02rN8YbX7+hMWxeKibPSGArc/ePa3RA07v63a8Zt0IxjFGJzZas7/LNwnAYqqEm
         sl8lbc+0KHdb9y/psmnB8wGcIEiihruhI9yXgwcx8Q9mSnHECVCftynm8t5kZWbG/zva
         44yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783433360; x=1784038160; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AdoCQ4ZX5BtlQtLCqarU4DocdJVuupPvE5g+WnHkPbY=;
        b=igV8La/bD7l0S3iQ8CEZJyztpRYbJ8r69cKY2/4pp+PjZeuN6BII0gPCZMBTlMmW+8
         s2R03uC3fiNd2DLLh/QPhA1kxWhyMqnpe/GpXmv+ZLwGQnLKVTk50yXr5NXKFNsX9Ayj
         lrKlpt+pVhHSd54FDMYlJxg4UNlqZqrJTRm9Vl/UYXAvaIchRrmMtWfQvBUYBqBLBSHG
         IVzBnAqo8Dv1eFNoTgzUhSYd28M292oCcD56GEx90tr1WokrXJuxav1H6kNO0BweQH7m
         sIJqyVuoy427zWAjlSs0n54QPqMMYRj4yX1v2Webr6SVFX+/qgEVNxWtOOOsATvZ1xPS
         8vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783433360; x=1784038160;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AdoCQ4ZX5BtlQtLCqarU4DocdJVuupPvE5g+WnHkPbY=;
        b=cfenhy1PfZpGmKAVQArWlPXj3Zul+eOhNxrv8+Rf/ECfgoH6SglhhsXCDGnGlO2zqk
         yo1DyatiDAmm9dwAu2jMI9ZPnXEbqcFnn/ShQ543MqSSD/Xa6cUT45te2in1uXD/ZHf7
         t8+Zq+5I3XwSLb/4ZaSZ2q61Ii9spFQIaQX3cqPIURUUeIhiNjl4cqHyt16k+l5LQzxi
         T1LdebBvyc0LH2wgewR8cryasUhQ6xVoJw4NmexnDWVu9WJfqgnOWkFcNTVPnPCSn2F8
         A4IOOOQUrDHdKLTWdUbZBVWmGEtSa5EQxvyut2xQFmKySvfEpSJQmAkuZW4gx1djZMFZ
         nj5A==
X-Forwarded-Encrypted: i=1; AHgh+RpO01RcPYNvG2dz2Bzc5myE0cTR4IlKZnhblxjVLIisP6YAlQnRvAg0merOWiEi7EfUcsEFghUkgb91NK6I6pM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCUQCkH42RQU8yugRQjxd1sCl6b5jL4OsQVPLYhMXmaARPeQGL
	BaICDYjlUVRAqUjqJ9Q8IDXvWkkgl2j1+/UIxUcE6brFO4P6MKQasvMzd5zRJYUQHu4Lh0GJC+N
	dN8lHfEz3x84XPWhgaXiWjR4AaQvGgBA=
X-Gm-Gg: AfdE7cmjNUheXcNSFE5GabncbpGttkeqJVluJDN7/N95rGfgNoZWwdU9WTrdDCSeQEt
	0W/ChDkMCfcl/oAs4zrZw6afwWuuaw5sHz6MzuOTCqo113zIz9alHFpFU/w8Rrp/4w7vNcehAQn
	DdrEhy+Z0MvlkvuxH0s0cTeimo28YCqzbK/ynZ3LIrVyhpqeG7QXNIoExpm8pVJ4WPwF3R3j/DZ
	6sMxJDjES3B+LQV2jg0wvKI5c15rWY6NmUYf+ymzNBRgu/QEwO6NTxg1ntwA8qYBX8Xe3YSWBJH
	O6WJ6/9AmYLvJPW6j0XblQ9ogEbHG7mPO3XJ5OxFc1WzJyqfROuVuPJoPZU=
X-Received: by 2002:a05:690e:1c08:b0:667:7750:14cb with SMTP id
 956f58d0204a3-6677f7ec627mr3586743d50.0.1783433359929; Tue, 07 Jul 2026
 07:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707093426.372897-1-xiuzhuo.shang@oss.qualcomm.com>
In-Reply-To: <20260707093426.372897-1-xiuzhuo.shang@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 7 Jul 2026 10:09:07 -0400
X-Gm-Features: AVVi8CdhspMrbH2pvJNN8ASf_Zebyq0dNRZdvHpxPbku9FW2X3yUDminqy4JhvU
Message-ID: <CABBYNZ+X-+ZJYz-V-_QSP5kCJpJJaBiyO=wMHD+Ut+b=639t2Q@mail.gmail.com>
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

On Tue, Jul 7, 2026 at 5:34=E2=80=AFAM Xiuzhuo Shang
<xiuzhuo.shang@oss.qualcomm.com> wrote:
>
> start_discovery_internal(), start_service_discovery() and stop_discovery(=
)
> queue a cmd_sync work item and only then move the discovery state machine
> into its transient value (DISCOVERY_STARTING / DISCOVERY_STOPPING):
>   err =3D hci_cmd_sync_queue(hdev, ..._sync, cmd, ..._complete);
>   if (err < 0) { ... }
>   hci_discovery_set_state(hdev, DISCOVERY_STARTING /* or STOPPING */);
> The matching completion callbacks run on hdev->req_workqueue serialised
> by hci_req_sync_lock, which is independent of hdev->lock. So once the
> work has been queued, the worker can be scheduled, run the sync function
> and invoke the completion before the caller has executed the trailing
> hci_discovery_set_state(). The completion's success path writes the
> terminal state (DISCOVERY_STOPPED for stop, DISCOVERY_FINDING for start);
> the caller then overwrites it with the transient value, and the state
> machine is wedged: every subsequent Start (Service) Discovery is
> rejected by the DISCOVERY_STOPPED gate with MGMT_STATUS_BUSY (0x0a),
> with no HCI traffic generated, until bluetoothd or the adapter is
> restarted.
> Fix it in three parts:
>   1. In all three call sites move hci_discovery_set_state(STARTING /
>      STOPPING) to before hci_cmd_sync_queue(). The transient state is
>      therefore always published before any worker can run the
>      completion. On queue-submit failure, roll back to
>      DISCOVERY_STOPPED.
>   2. In start_discovery_complete() and stop_discovery_complete(), wrap
>      the terminal hci_discovery_set_state() call with
>      hci_dev_lock() / hci_dev_unlock(). These callbacks run without
>      hdev->lock; serialising the state write matches the pattern used
>      by mgmt_set_powered_complete() and removes any residual ordering
>      hazard against a concurrent mgmt path holding hdev->lock.
>   3. Generalise the "ignore -ECANCELED" early return in both completion
>      callbacks to "on any err < 0, also reset the transient state to
>      STOPPED". With (1) in place the state observed at completion time
>      is always known.
>      For the stop path this also fixes a pre-existing wedge: when any
>      sub-command issued from hci_stop_discovery_sync() returns an
>      error, stop_discovery_complete() is invoked with err < 0. The
>      existing "if (!err) set_state(STOPPED)" tail then skips the reset
>      and the state machine sits in DISCOVERY_STOPPING forever.

Needs the Fixes tag since we might want to backport.

> Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
> ---
>  net/bluetooth/mgmt.c | 86 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 74 insertions(+), 12 deletions(-)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 733a4b70e10c..25ad9c10740d 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -5975,15 +5975,38 @@ static void start_discovery_complete(struct hci_d=
ev *hdev, void *data, int err)
>
>         bt_dev_dbg(hdev, "err %d", err);
>
> -       if (err =3D=3D -ECANCELED || !mgmt_pending_valid(hdev, cmd))
> +       if (err < 0) {
> +               /* The queued start-discovery work failed before the norm=
al
> +                * completion path could advance the state machine. The
> +                * caller already moved the state to DISCOVERY_STARTING
> +                * (under hdev->lock, before queueing). Reset it here so =
the
> +                * gate in start_discovery_internal()/start_service_disco=
very()
> +                * does not wedge in STARTING and reject every future Sta=
rt
> +                * (Service) Discovery with MGMT_STATUS_BUSY.
> +                */
> +               hci_dev_lock(hdev);
> +               if (hdev->discovery.state =3D=3D DISCOVERY_STARTING)
> +                       hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> +               hci_dev_unlock(hdev);
> +
> +               if (err =3D=3D -ECANCELED)
> +                       return;
> +       }
> +
> +       if (!mgmt_pending_valid(hdev, cmd))
>                 return;
>
>         mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_statu=
s(err),
>                           cmd->param, 1);
>         mgmt_pending_free(cmd);
>
> -       hci_discovery_set_state(hdev, err ? DISCOVERY_STOPPED:
> +       /* Serialise discovery.state writes against any concurrent mgmt p=
ath
> +        * holding hdev->lock; this callback runs on req_workqueue withou=
t it.
> +        */
> +       hci_dev_lock(hdev);
> +       hci_discovery_set_state(hdev, err ? DISCOVERY_STOPPED :
>                                 DISCOVERY_FINDING);
> +       hci_dev_unlock(hdev);
>  }
>
>  static int start_discovery_sync(struct hci_dev *hdev, void *data)
> @@ -6051,15 +6074,23 @@ static int start_discovery_internal(struct sock *=
sk, struct hci_dev *hdev,
>                 goto failed;
>         }
>
> +       /* Publish the transient state BEFORE queueing the work. The
> +        * completion callback runs on hdev->req_workqueue serialised by
> +        * hci_req_sync_lock, which is independent of hdev->lock; setting
> +        * the state after the queue allowed the worker to win the race
> +        * and have its terminal STOPPED/FINDING write overwritten by thi=
s
> +        * trailing STARTING write, wedging discovery in STARTING.
> +        */
> +       hci_discovery_set_state(hdev, DISCOVERY_STARTING);

Hmm, do we really need to do this if hdev lock is taken at
start_discovery_sync? Because that should then synchronize the
callback won't be able to change the state before it is set to
DISCOVERY_STARTING.

>         err =3D hci_cmd_sync_queue(hdev, start_discovery_sync, cmd,
>                                  start_discovery_complete);
>         if (err < 0) {
> +               hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
>                 mgmt_pending_remove(cmd);
>                 goto failed;
>         }
>
> -       hci_discovery_set_state(hdev, DISCOVERY_STARTING);
> -
>  failed:
>         hci_dev_unlock(hdev);
>         return err;
> @@ -6178,15 +6209,19 @@ static int start_service_discovery(struct sock *s=
k, struct hci_dev *hdev,
>                 }
>         }
>
> +       /* Publish the transient state BEFORE queueing; see the comment i=
n
> +        * start_discovery_internal() for the race details.
> +        */
> +       hci_discovery_set_state(hdev, DISCOVERY_STARTING);

Ditto.

>         err =3D hci_cmd_sync_queue(hdev, start_discovery_sync, cmd,
>                                  start_discovery_complete);
>         if (err < 0) {
> +               hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
>                 mgmt_pending_remove(cmd);
>                 goto failed;
>         }
>
> -       hci_discovery_set_state(hdev, DISCOVERY_STARTING);
> -
>  failed:
>         hci_dev_unlock(hdev);
>         return err;
> @@ -6196,17 +6231,40 @@ static void stop_discovery_complete(struct hci_de=
v *hdev, void *data, int err)
>  {
>         struct mgmt_pending_cmd *cmd =3D data;
>
> -       if (err =3D=3D -ECANCELED || !mgmt_pending_valid(hdev, cmd))
> -               return;
> -
>         bt_dev_dbg(hdev, "err %d", err);
>
> +       if (err < 0) {
> +               /* The queued stop-discovery work failed before the norma=
l
> +                * completion path could advance the state machine. The
> +                * caller already moved the state to DISCOVERY_STOPPING
> +                * (under hdev->lock, before queueing). Reset it here so
> +                * the gate does not wedge in STOPPING.
> +                */
> +               hci_dev_lock(hdev);
> +               if (hdev->discovery.state =3D=3D DISCOVERY_STOPPING)
> +                       hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> +               hci_dev_unlock(hdev);
> +
> +               if (err =3D=3D -ECANCELED)
> +                       return;
> +       }
> +
> +       if (!mgmt_pending_valid(hdev, cmd))
> +               return;
> +
>         mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_statu=
s(err),
>                           cmd->param, 1);
>         mgmt_pending_free(cmd);
>
> -       if (!err)
> +       if (!err) {
> +               /* Serialise discovery.state writes against any concurren=
t
> +                * mgmt path holding hdev->lock; this callback runs on
> +                * req_workqueue without it.
> +                */
> +               hci_dev_lock(hdev);
>                 hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> +               hci_dev_unlock(hdev);
> +       }
>  }
>
>  static int stop_discovery_sync(struct hci_dev *hdev, void *data)
> @@ -6248,15 +6306,19 @@ static int stop_discovery(struct sock *sk, struct=
 hci_dev *hdev, void *data,
>                 goto unlock;
>         }
>
> +       /* Publish the transient state BEFORE queueing; see the comment i=
n
> +        * start_discovery_internal() for the race details.
> +        */
> +       hci_discovery_set_state(hdev, DISCOVERY_STOPPING);

Ditto.

>         err =3D hci_cmd_sync_queue(hdev, stop_discovery_sync, cmd,
>                                  stop_discovery_complete);
>         if (err < 0) {
> +               hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
>                 mgmt_pending_remove(cmd);
>                 goto unlock;
>         }
>
> -       hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
> -
>  unlock:
>         hci_dev_unlock(hdev);
>         return err;
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
