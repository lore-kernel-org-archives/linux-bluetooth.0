Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148EC393DF5
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518687; cv=pass; b=dwMTFzt5vy5ksWuIm1wwE/42KH6qO87xUs6APOihr6nPlX/rqvofUC2ZNLk9nI7OGz6cmwamvmsEBBK5lJxbrQclqcSoDgfZ/QcK1+Dg3e5t7flbkDZScjHaWbVw96xBDaA7Rdll9/jMEh3nxSi97ggCdXGCBj3jfikIZ+LWXpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518687; c=relaxed/simple;
	bh=JEw8HwFuQl+tAwqyru3dgnqdruNr5r2f0R67dLeVx6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdadUP22QHWtQAat/cyRw9A8OdltsLswpzmHx8XeV/DYQ+B7Zk03BiyuH8UMVtems5nDw0PPN48Sbyz4ydri9ZyO7vXcMmY/o/6GII2jCmxJmIoSkBaXVa8QqZFpQxHgmNf0DSYs2WkjV33Kmy3miq+j+xDr2OZsomlxzNFAz04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOcVW4n8; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOcVW4n8"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-667b0ced2d3so297064d50.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 06:51:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783518674; cv=none;
        d=google.com; s=arc-20260327;
        b=H2CNNObRVK+ECCH18GPrBzYuOrKI9poWMxjo8Wpfsy84C4OGj64A0g9b1IeDLl+1FT
         rygTdi+WX6YtlXalAJ0TOH4jAd/WjnN9Uend2SLO7IiS2fEaVIopb2uOklHtfN1FEkzO
         +LqRKV2FioayBQlOKLanS5K6IMVqxBJCd2m5esZIhQCuf4nyp0DipzOQ0aKGTKqX2Vre
         49Pc8pxMstiQtEfosRUamX5Fhni0DPcwKNzF7XqOYPBPklJ2v40CdQvnIVAk4p/KdZNb
         YrhBQs2BAh05CRNE5CFydMLVU9wfX8rMfdTdHxOAs3j5w3LAx/z4DFOSUmHwDUpmi8qe
         B2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZV3C4UpUpSJJxBdiVf23ZW56xvpWwW6MMX7CrWEfTZA=;
        fh=s2X4nHVHbl3UT8dCE6qXcF9REzH7uKX3ePhmwy9Bxi0=;
        b=O2iVMEz+hGcMDZJkUn1KjGDS5Fwq3JGwGPxks4DygjS9YnuK6s6kHLkv1H5Jx6pldf
         gEXuvS+OOUdHw5xJMG/ZFyIu2ObErKQIHg4uPb/rQvFyZ0y06SvQ97+js7DxAdDjShhI
         zRFhQiyaiI7KJOPjVM0MHnQw+8YmUdjPbW4owtSkhpJr3859BEBkE+gMWiSeu+eGUrje
         7ymWCqF0wKCbbRSxoFGSe/M3LN7LcvD6/73AIGx6ZawpwuPqagjwkimjv5NFJMC3Tcmw
         ELwLZM18+ST4ktzapjXOuayjthC8K5i3JxbpXBYt9A34Yn+1te4bmbEGKgh/vcU7CgXH
         X0OQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783518674; x=1784123474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZV3C4UpUpSJJxBdiVf23ZW56xvpWwW6MMX7CrWEfTZA=;
        b=JOcVW4n8UerNhfWvNml/+fRPG4+3lkFIJdyUG0fWTMVeBlOfm9OOcRoH31tA/39Eqa
         R2awZjRVC8UVswq74M2P8360aU9HsQZXRn5LN5vYmDxPQkfQugQRwfc15mGOBtJqoVyg
         S8DhrABqwX4NnVEdbh2AdWKkwg1MJ7hmO+D27gtlIAjipGgMxqJjyQuBd1sB8zKU5US1
         tyXPO/IQ00DsAuLPvdD9SSXwtf1ZkoIcWfwT2zqIi4awDIgyhS/JQhABUHfbiqRSmzT5
         YNPOmSZCjMhS6dKEWGPoHXq8j1KpBbtEFkpIpCVaSr+4kMfOYvgj7He14AhFX9YaeILp
         6A8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783518674; x=1784123474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZV3C4UpUpSJJxBdiVf23ZW56xvpWwW6MMX7CrWEfTZA=;
        b=XiNfS93ZmPuDuxIVJPPyhDRSqVitMvxgjLjjeo4WawqNsIdmehZpDd9frHithRQxv1
         8/2Z+fSDcdn9LG6sl8RX7b5fxALMMU2/fD7bFg3OadB9zDkfu7lPtBJy+pYmIo9JaOjg
         hvJcqYAdWH1a93SEIKKoo5Jx6I3G8T2kuWbedA9BnD3Ka/H+IM8CZrkxv9/N2U80/mGu
         PAlUFU8leOHH6X7r6FtnDmiUBbdSp0ebSjkYu5fyRUXnOptWVs6ZscplNTyTc2ty/Ov7
         wF6D23b4zwemepETL5wee0rAioKt9dgZWXzkd6eddObZurJ9K8sCQa9E2kINUTvImgp8
         6WkQ==
X-Forwarded-Encrypted: i=1; AHgh+RryeXABLW2NP3fpCt6KHulk8st/IjRFqixLOPrjv1c5gBNCTx3R959H19Rb8n5ToSDpFqwfDUQdRScsCkXwptM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOy2868Y6BG50CCyUtB5hEE/Yr2JZXKdr50Ldw8uGObIIrIfc5
	sL8LqWEl98jMcBHE5OrHqZSvfy2ERANysi0Mz8MPmRTsM3URu7Y52M+M/fvVoy1t+0iM0AfNkkG
	nXVNwAcqb2G9JKmHevoZExSSiqIMJrtw=
X-Gm-Gg: AfdE7ck/eufeISBzIkvGlr2W75P+4/aDw1Sj4wknJTCK+Hx3JAdAqbwBV+m8wdARtvp
	CcKmv0UUFSS/YLO1HrCS1MKyjpM3MwqK0M81dy4KcqHZ6QQFDJWxQZOFzhxcnAlauYojQ3ysb78
	Gdk/yYXVKBjoL/90UdGiq9g2ENTg6WjCdgSI2GjcRgyRUsZYyIz3JxYBKQqvOBYPff+ewAWsBqI
	22/qe/AqINU6taYUqWa9bkxU7ehiYAKZN05WxkXzwNaWR77bFm+hqJSOxdk0GjSnw7IXbmFVXv3
	WevIiVuHKYBhGu2FAXTEA4yQ5CjD7lEIxZMuMoUfwtpicpTqmxIjWZhxbuo=
X-Received: by 2002:a05:690e:4841:b0:667:6c44:ba95 with SMTP id
 956f58d0204a3-6679f153120mr1460876d50.62.1783518674078; Wed, 08 Jul 2026
 06:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708093822.3495633-1-xiuzhuo.shang@oss.qualcomm.com>
In-Reply-To: <20260708093822.3495633-1-xiuzhuo.shang@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 8 Jul 2026 09:51:02 -0400
X-Gm-Features: AVVi8CfaHmxTvZvtG2K6Ng3GQP2_U34HrbzGAz_wFxb8w03AATbevrrfs9zcCE4
Message-ID: <CABBYNZJ+Kw0RGE3sW4AWUTzHeAH0Z1UhBQwdkhtpQg5FKOUtCw@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: MGMT: Fix discovery state race against
 cmd_sync worker
To: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com, 
	wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com, 
	mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xiuzhuo,

On Wed, Jul 8, 2026 at 5:38=E2=80=AFAM Xiuzhuo Shang
<xiuzhuo.shang@oss.qualcomm.com> wrote:
>
> start_discovery_internal(), start_service_discovery() and stop_discovery(=
)
> queue a cmd_sync work item and only then move the discovery state machine
> into its transient value (DISCOVERY_STARTING / DISCOVERY_STOPPING):
>
>   err =3D hci_cmd_sync_queue(hdev, ..._sync, cmd, ..._complete);
>   if (err < 0) { ... }
>   hci_discovery_set_state(hdev, DISCOVERY_STARTING /* or STOPPING */);
>
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
>
> Fix it in three parts:
>
>   1. In all three call sites move hci_discovery_set_state(STARTING /
>      STOPPING) to before hci_cmd_sync_queue(). The transient state is
>      therefore always published before any worker can run the
>      completion. On queue-submit failure, roll back to
>      DISCOVERY_STOPPED.
>
>   2. In start_discovery_complete() and stop_discovery_complete(), wrap
>      the terminal hci_discovery_set_state() call with
>      hci_dev_lock() / hci_dev_unlock(). These callbacks run without
>      hdev->lock; serialising the state write matches the pattern used
>      by mgmt_set_powered_complete() and removes any residual ordering
>      hazard against a concurrent mgmt path holding hdev->lock.
>
>   3. Generalise the "ignore -ECANCELED" early return in both completion
>      callbacks to "on any non-zero err, also reset the transient state
>      to STOPPED". With (1) in place the state observed at completion
>      time is always known.
>
>      For the stop path this also fixes a pre-existing wedge: when any
>      sub-command issued from hci_stop_discovery_sync() returns an
>      error, stop_discovery_complete() is invoked with err !=3D 0. The
>      existing "if (!err) set_state(STOPPED)" tail then skips the reset
>      and the state machine sits in DISCOVERY_STOPPING forever.
>
> Fixes: abfeea476c68 ("Bluetooth: hci_sync: Convert MGMT_OP_START_DISCOVER=
Y")
> Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
> ---
> Changes in v3:
>  - Replace inline patch title with lore.kernel.org URL in v2 link
>    reference to fix GitLint B1 line-length check.
>  - Link to v2:
>    https://lore.kernel.org/all/20260708062009.3047447-1-xiuzhuo.shang@oss=
.qualcomm.com/
>
> Changes in v2:
>  - Fix if (err < 0) to if (err) in both start_discovery_complete() and
>    stop_discovery_complete() to also catch positive HCI status codes,
>    flagged by Sashiko.
>  - Add Fixes: tag for commit abfeea476c68 as requested.
>  - Update commit message wording from "err < 0" to "non-zero err" to
>    match the code change.
>  - Link to v1:
>    https://lore.kernel.org/all/20260707093426.372897-1-xiuzhuo.shang@oss.=
qualcomm.com/
>
>  net/bluetooth/mgmt.c | 86 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 74 insertions(+), 12 deletions(-)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 733a4b70e10c..81c09c24a14b 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -5975,15 +5975,38 @@ static void start_discovery_complete(struct hci_d=
ev *hdev, void *data, int err)
>
>         bt_dev_dbg(hdev, "err %d", err);
>
> -       if (err =3D=3D -ECANCELED || !mgmt_pending_valid(hdev, cmd))
> +       if (err) {
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

I guess I will need to repeat myself, now that the callbacks do
acquire hdev lock the comments above are invalid, the callback will
attempt to hdev->lock making it wait the hci_dev_unlock bellow past
setting DISCOVERY_STARTING, so the change above is no longer needed.

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
> +
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
> +       if (err) {
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
> +
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
