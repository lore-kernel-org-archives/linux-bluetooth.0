Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD4C3DDDAA
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783356355; cv=pass; b=HRRd3BYs56sAlS1ROaT86cGEpFPrJV/YCROZhY2JBYbFpPb7w5sG2ZGNfJtrdvCsLVv8lW0b/ZRCn1Y+V/eZ0+4XSeT7Qzmv9HTjgqjXUtcrzgmgXjpmjLeE6dHGw6mZLbQ9VSiQf5xzmNV//GRAXWgeOKaR8QwSHZzmBvMwKfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783356355; c=relaxed/simple;
	bh=hixIVnvv0cgNNll0oqLDKnhgXfS/1DZ8a1gjGHVvbQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iqpaOEBi5LY3/rbGA4MJcOEIRR3lbudqEc5eObCgA/3vIb9uW5evt3/2ZRu9trKRnWuI7x2ThATjQksn8TZbCuTFdm5cpEI3rdWjeh14if9WjCmAO6AvejpR+p/rUbI1/iZ8mxs2c7FXOrb4AlMSNzhCTyTiOAy48EPDd679qxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9F9R+P6; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9F9R+P6"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-664b3831a20so4610845d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 09:45:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783356353; cv=none;
        d=google.com; s=arc-20260327;
        b=FkYgSezYCwClj9j9mVVqUwKUSLINXziuOE1iKImaN+1GgdOMrDD+ZSlKp/25gjJPl6
         dJURBPlstQvkcNPzCWnrIJoElrWujv6MEFXTbPWtzpmdO99WL0P7eaKY0Bb1pik6BjmW
         2murmg5Go91DfWCZBvjodnojqDugenkuBcyZUbejLQl/SA9FnduWMqCB4xQX5OF3buBv
         6c3CL9uAIm9Bhf5AL6WYeBxYRyA9M0tCZiUR8MokLSF1PdXEXn9bPohAaeoSPKI3OEre
         sLZ1je0tnzvLuKQHE2miXXkZKDs1lD8oCuSESHyHONtm70W0S9788skBpuUpUw/LFA3r
         7KBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C6bozURA9av93LzDhVs/uoTEEbg26KUjdRTgWoERGm0=;
        fh=RArUK58xUEpZv1NCSVucrRZcjy7P0O1pDkIgcejuIBs=;
        b=iYNH4O+tF6nGDKZ/Cq/QPbnDspNJQXGCHYK//DXpnmgso2MHo8gC+s5HJljQs7KHHj
         p1ULXvLtrdRsYDMpdwY692I6DbtX/MnJ2cG9m6/bjZArNob0YXfIk3eBPZw8NHqGLPJn
         RftZ2ggypK2HZl3nTh06F7cHA7GypeOHp2d+3xK1sXqcwzgCi+Q4Y/QQ811Fajn4wcaa
         4zKgBM7wvVfQtYjRpkGFXyt3xB2FvgWExk0i/W5sjBPbxg6lKPLwekCp5qQGcLQV3qIO
         mGE9apojH4NUNjnkqsp+MfqxMoSnnPMgKu17MP58AP64VJWrlzddUWPcwsCtbutpz6mD
         pfUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783356353; x=1783961153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6bozURA9av93LzDhVs/uoTEEbg26KUjdRTgWoERGm0=;
        b=P9F9R+P6yPSkdCIv4hFaHsBJZhIkvgLmmsQTP5tq8sijisVVsAR1aLumJdWxMy94/p
         CXG9AGtmdtNwCTpqI1K27UIfdZDQzj0YQpATHLDX52CFYoDACXpIKXSm43dEs3h7Sd0L
         +V3R14rzFX8ZyttQ+wSPad/mWRDg3ud6PldRv8glvbL2HwVqj4ecqxNx1rjUKikQZ8Hs
         JOvT2RJyHP1u0rxQjuY/eFCGmCLNE4H7q+WWEEeMYBpqmZkCLy+Jao5ibNuh9uMtXvhR
         PqYNwJHXorau/wZM0k2Fxl1isVLpW77ruFIpDFzepBIhFvMfMPf334+0GcRTqaGYu8Ic
         WeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783356353; x=1783961153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C6bozURA9av93LzDhVs/uoTEEbg26KUjdRTgWoERGm0=;
        b=hnHMMDJffYAWQoB+N6iqWdaW1aFRwJueewDrWFpbN2dWeKnGL0C3Os3oIJ7YZ27jvv
         39q9QKmy2xXk/CYjkrLdkBrEJcxvEg14F8cLpOkDdHeTfQ6MuQt2YVdtWS3lM/SBFMDt
         1e2t9esNZjJ0qJegtwSmGi8Ohvz0f2jhTYpfpb8WZ8SmLrTJSDxDkErNFLtlNZZdUmZ6
         MrpQ3gf8XcNUFfZ+ZqrvIKSljuCjbFj7Kr/IHs9GknU+NMvVxVH25kcpVmV9MbWgquud
         I3Iqav/dfPkhx5lcb2UAyTXA0gzhoMMbOxy/HhofHymVToDA9pzRyqpasY/a1gI53ZNX
         jSeA==
X-Forwarded-Encrypted: i=1; AHgh+RqMbeuEF25c2AOhcDaweajBs1Mrahr9tmXJvZp3M8IW7aFtTHOQ2ayzpW/dhzccDSS8J698BIN7GPE/BuGfPC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8vvq42jF5N644jybnJ7kqCRh/oVX2t89tqzjDi1QkcAnjEU1e
	fcZ5u+4ewcAaaDifjUQTaVR+lr50X4wnreV7M90fmev/aZLV8PZp5wkCa7KyG2VScZ/2fykciHO
	CQ2n9+poqsHMKJncDtCBPEZn9l0mVKhbNlKFKXkfr5A==
X-Gm-Gg: AfdE7ckGioei90H/54pkea9PCvraBPptwql9FF9p8NlbTcJYiMNpmnRYDX4oyVZc2Vd
	pZo35HSXQDTRSdUq6aH42zEHDps/nmj5gYGS7Q2ABSfQMdWYUDBi3zGWPL/boRLkc5Rn9CG5iEV
	Zds1Bt9BM3GgAbkF+i9rxrOHQ7WfP28KVRkqwpv9OXr1TzUaErb97v0U5khE2FHnD1V6NZ7hjet
	uf41UG7nZC4wCpGh3l2vFyWabiF2HLeFtTl7v9Xr8/ah16fq5HiGVU9Xy9251qCKc+toVf9nvKF
	ZuWuULFsr29y0XqPXoYzqR4ePhc9CPDDPr17SAEtb7deX/yJh1bxnDDf
X-Received: by 2002:a05:690e:1349:b0:660:54e4:5db5 with SMTP id
 956f58d0204a3-6677fc47961mr1088950d50.56.1783356352717; Mon, 06 Jul 2026
 09:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703172455.2363611-1-zzzccc427@gmail.com>
In-Reply-To: <20260703172455.2363611-1-zzzccc427@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 6 Jul 2026 12:45:41 -0400
X-Gm-Features: AVVi8CdkvwpD9RVdyd5RIIRb6ODSGjaa-0Hpg7ddPiyvlMLlQ3Hgh-hnHMyWkoU
Message-ID: <CABBYNZJjpt7cQFnevKo=wYbo3h0Z1=8iHUqjuDSZYWWU5jeLkQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: MGMT: validate LOAD_CONN_PARAM entry before update
To: Cen Zhang <zzzccc427@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cen,

On Fri, Jul 3, 2026 at 1:25=E2=80=AFPM Cen Zhang <zzzccc427@gmail.com> wrot=
e:
>
> MGMT_OP_LOAD_CONN_PARAM queues conn_update_sync() when a single parameter
> update changes an existing LE central connection. The queued work current=
ly
> stores the hci_conn_params object from hdev->le_conn_params. A later
> LOAD_CONN_PARAM request can clear disabled parameters and free that objec=
t
> before hci_cmd_sync_work() runs the queued callback.
>
> Do not keep that borrowed pointer in the queued work. Queue only the
> address key. conn_update_sync() can then look up the current params entry
> while holding hdev->lock. If userspace removed that entry while the work
> was pending, cancel the queued update.
>
> If the entry is still present, copy the current params and connection
> handle under the lock. Then issue LE Connection Update after dropping the
> lock.
>
> Validation reproduced this kernel report:
> BUG: KASAN: slab-use-after-free in conn_update_sync+0x2a/0xf0 [bluetooth]
> Read of size 1 at addr ffff88810c697126 by task kworker/u17:0/377
> Workqueue: hci0 hci_cmd_sync_work [bluetooth]
>
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x66/0xa0
>  print_report+0xce/0x5f0
>  ? conn_update_sync+0x2a/0xf0 [bluetooth]
>  ? __virt_addr_valid+0x19f/0x330
>  ? conn_update_sync+0x2a/0xf0 [bluetooth]
>  kasan_report+0xe0/0x110
>  ? conn_update_sync+0x2a/0xf0 [bluetooth]
>  ? __pfx_conn_update_sync+0x10/0x10 [bluetooth]
>  conn_update_sync+0x2a/0xf0 [bluetooth]
>  hci_cmd_sync_work+0x187/0x210 [bluetooth]
>  process_one_work+0x4fd/0xbc0
>  worker_thread+0x2d8/0x570
>  kthread+0x1ad/0x1f0
>  ret_from_fork+0x3c9/0x540
>  ret_from_fork_asm+0x1a/0x30
>
> Allocated by task 466:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x17/0x60
>  __kasan_kmalloc+0xaa/0xb0
>  hci_conn_params_add+0xa6/0x240 [bluetooth]
>  load_conn_param+0x4e1/0x850 [bluetooth]
>  hci_sock_sendmsg+0x96b/0xf80 [bluetooth]
>  sock_write_iter+0x28e/0x2a0
>  vfs_write+0x6e4/0x810
>  ksys_write+0x147/0x170
>  do_syscall_64+0x115/0x6a0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 474:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x17/0x60
>  kasan_save_free_info+0x3b/0x60
>  __kasan_slab_free+0x5f/0x80
>  kfree+0x313/0x590
>  hci_conn_params_clear_disabled+0x9b/0xc0 [bluetooth]
>  load_conn_param+0x4bf/0x850 [bluetooth]
>  hci_sock_sendmsg+0x96b/0xf80 [bluetooth]
>  sock_write_iter+0x28e/0x2a0
>  vfs_write+0x6e4/0x810
>  ksys_write+0x147/0x170
>  do_syscall_64+0x115/0x6a0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Fixes: 0ece498c27d8c ("Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM upda=
te existing connection")
> Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
> v2:
> - Re-check hci_conn_params in conn_update_sync() and skip the queued
>   update if the entry was removed while the work was pending, as
>   suggested by Luiz.
> - Queue only the address key and copy the current params and connection
>   handle under hdev->lock before issuing the HCI command.
>
>  net/bluetooth/mgmt.c | 62 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 54 insertions(+), 8 deletions(-)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 733a4b70e10c..6fbabf437786 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -7935,16 +7935,50 @@ static int remove_device(struct sock *sk, struct =
hci_dev *hdev,
>         return err;
>  }
>
> +struct conn_update_sync_data {
> +       bdaddr_t addr;
> +       u8 addr_type;
> +};
> +
>  static int conn_update_sync(struct hci_dev *hdev, void *data)
>  {
> -       struct hci_conn_params *params =3D data;
> +       struct conn_update_sync_data *update =3D data;
> +       struct hci_conn_params *params;
> +       struct hci_cp_le_conn_update cp;
>         struct hci_conn *conn;
>
> -       conn =3D hci_conn_hash_lookup_le(hdev, &params->addr, params->add=
r_type);
> -       if (!conn)
> -               return -ECANCELED;
> +       hci_dev_lock(hdev);
> +
> +       params =3D hci_conn_params_lookup(hdev, &update->addr, update->ad=
dr_type);
> +       if (!params)
> +               goto cancel;
> +
> +       conn =3D hci_conn_hash_lookup_le(hdev, &update->addr, update->add=
r_type);
> +       if (!conn || conn->role !=3D HCI_ROLE_MASTER)
> +               goto cancel;
> +
> +       memset(&cp, 0, sizeof(cp));
> +       cp.handle               =3D cpu_to_le16(conn->handle);
> +       cp.conn_interval_min    =3D cpu_to_le16(params->conn_min_interval=
);
> +       cp.conn_interval_max    =3D cpu_to_le16(params->conn_max_interval=
);
> +       cp.conn_latency         =3D cpu_to_le16(params->conn_latency);
> +       cp.supervision_timeout  =3D cpu_to_le16(params->supervision_timeo=
ut);
> +       cp.min_ce_len           =3D cpu_to_le16(0x0000);
> +       cp.max_ce_len           =3D cpu_to_le16(0x0000);

Don't really like where this is going, we shouldn't need to open code
hci_le_conn_update_sync, perhaps we should use the likes RCU to
prevent removing concurrently otherwise this sounds more like a
workaround and there might be other user of hci_conn_params_lookup
that are not protected from concurrent deletion.

> -       return hci_le_conn_update_sync(hdev, conn, params);
> +       hci_dev_unlock(hdev);
> +
> +       return __hci_cmd_sync_status(hdev, HCI_OP_LE_CONN_UPDATE,
> +                                    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> +
> +cancel:
> +       hci_dev_unlock(hdev);
> +       return -ECANCELED;
> +}
> +
> +static void conn_update_sync_destroy(struct hci_dev *hdev, void *data, i=
nt err)
> +{
> +       kfree(data);
>  }
>
>  static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *=
data,
> @@ -8054,9 +8088,21 @@ static int load_conn_param(struct sock *sk, struct=
 hci_dev *hdev, void *data,
>                             (conn->le_conn_min_interval !=3D min ||
>                              conn->le_conn_max_interval !=3D max ||
>                              conn->le_conn_latency !=3D latency ||
> -                            conn->le_supv_timeout !=3D timeout))
> -                               hci_cmd_sync_queue(hdev, conn_update_sync=
,
> -                                                  hci_param, NULL);
> +                            conn->le_supv_timeout !=3D timeout)) {
> +                               struct conn_update_sync_data *update;
> +
> +                               update =3D kzalloc_obj(*update);
> +                               if (!update)
> +                                       continue;
> +
> +                               bacpy(&update->addr, &hci_param->addr);
> +                               update->addr_type =3D hci_param->addr_typ=
e;
> +
> +                               if (hci_cmd_sync_queue(hdev, conn_update_=
sync,
> +                                                      update,
> +                                                      conn_update_sync_d=
estroy) < 0)
> +                                       kfree(update);

It would probably be a lot simpler to just pass the connection here
rather than allocating another object just to carry the address and
address type.

> +                       }
>                 }
>         }
>
> --
> 2.43.0



--=20
Luiz Augusto von Dentz
