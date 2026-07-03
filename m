Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62EB3A0EA5
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091406; cv=pass; b=dnnie5A4INaSSpebl4/6rrD0lKRIlYEbmytHSGrQ5D8wQvHm8GC7eYsN76O7/DQZC71NDaVf3E9FnOBc2wp915dTb81p6+zvQzuiy5TsiEwBCnDq45IzOPUP3enJ9VkRPIRLSOcGDpGEFYTIdM4YwejCDj21MKDAxEIC7W0DN5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091406; c=relaxed/simple;
	bh=2/p8c/D2552T26UYbBC7ECGfdDmrD2SDV4QeuFMqiUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUxFB8h+6qe+h/8tri3tQIy6X6ewfKdJVm4aRgbtrG70O5fFCj7vSZyVTU+Nr/sXEtjQQIwWf2vvH6l2+N96Vbhaoc7rY8w4WksaIvn8nvNp96yWn6F6L0+TcZQOV6pf9nwHCwUIM1D3O/46DGAkVJCrHdV8/zLmZUsh1+uACvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlJPrDD/; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlJPrDD/"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-664b2c00e12so967633d50.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 08:10:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783091404; cv=none;
        d=google.com; s=arc-20260327;
        b=FHt4W/RQK2OUjwn+C8YDSXNc9yQV/TbLjqRF7O2XN52h5SpoLyKt3Dn4eBGAya+BuJ
         zmsQeJZHuNzBqgBHZy+3yz0xcx8BubPywXfvF28G03doRi6JVu2r/JLSfto37jdd2+dk
         BIMsawiZ3wKGQM5bOFwj2tLk3kFauEs+rlR92THxPAXsdMq98caS9ygg6GLeTwiPPqhV
         QMjQJpPkAyW1bGW9giG3qTwPcATLi62lSSPGHwxNVE7NWlJuDgI30Fb4Ai5THX4sFydQ
         UKuGMG3nNtq/bIsyCpDtp56EnHUyb3dZONkBYuNoJAfajuidsSoYb/ERjEcSLIpHGk2A
         WyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1bkt1tZa0gABx/xCLjhDv0p51hiN9XJaGklosnQclHM=;
        fh=WrZi+SSXt4P9HP7YuqP26jWbqcJqPX9XOVmM7jNRARA=;
        b=DgUnYx81dYqjtsFvl9TrNQdBf4+MA4rUQVeI/G7snDN32AZUDhYYK+w5qbr7W72kEY
         onpc/JV7k8IVChFHHZNlNyqcHq11yfzl0pj3AgPQA02USI0DPgKF5gea2tl6MTKQdfo8
         eWCz4MHEF+eJtn+6UUVtFI0X9bN0fRK6HgZovGEXypJLTFhRUav6vCR+6qYMD5nWt2KI
         F5LFqlo/qqrZjOIJxOF31yi689umMD4Bu0TZPLRLbd4Usj0WtPJcWwaG+k41Z6NGy9fn
         k4uKX+19+ibo5NeVVaDr34ZT1p7faTqI1A0VI8bw/fqcgDCG0nNgA1y6n+sx2FgMgVp8
         D9Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783091404; x=1783696204; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1bkt1tZa0gABx/xCLjhDv0p51hiN9XJaGklosnQclHM=;
        b=nlJPrDD/QBLzqN3MySFQk2hDFFTTdieVyBh3uHRUCuRTnX65FtnElyWDcw7CuF4v2U
         ei3fP12Q0/5JVg39E1RH9WHWKmTDBLZxAE3cRsnQlBvh2f8EH/1szfga3ksdN05dv1nj
         ggx3YTZHLFGPX3TEQh4V5k0KeXY+CI/xkpKQcCJlMyncTGTbcAMKX3hqwogw+D2/wxSR
         E/ADK9bFGeX8s5tJk8g7LwDxrVSadsDHSRHktRVkOF9c3VDzD8E9Eo3SZu3IIJ/tPsat
         NqecjS5xgKGSOJcCZfXEV+7IJwweTiYnfNDtnIBIMQlup6Yp8+4GT49ciVGUtR73zsNn
         VOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783091404; x=1783696204;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1bkt1tZa0gABx/xCLjhDv0p51hiN9XJaGklosnQclHM=;
        b=VQilJ4rioEjXMFk8/fmdGa0yHFlCBUY74kM90EzqtDkEVKIg89d9VaOzvhXdqTskvh
         KjDgRnRWjyhg4ybv3ssUGDkaFAQyZyJon1yj6n2BVMVv5JpWlX+gSAXuA1NZFrymB1zy
         A8y/c4MF9TjMMoyaxhaqdD40FsgjVa37I4S+dPmtGS6QMOssLGmymp2M1wpx59Sbw2t7
         PDMoZLJ5R0FAIlljUMhQOPnz82Qyk8+3ikzPPYRq+tvsyG0PPNJe88L1O9c5sYOIlouQ
         KkMXsrMRYAcai/q2PfJRlZmntl/+4Z0Euaq9GQGel1+dPwR07J6eYHnrLdnn/XbcpeKN
         wddg==
X-Forwarded-Encrypted: i=1; AHgh+RqXq7IzYMhU/Zw6ttkRl6mRtY0A6A7Mko6NO5PXnNNK/n2UN8GQzlOqFrTG+kCjFmPWASqgOOSetWm6Sh4GvHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1d6JVLQ7nuhQ3lIf11GTaIVP+ig1wFeUP7ttJRjjRqirNeCoN
	aOYSsNYvPKW5Q2M12xd2X+53cphBapctATehBjfI+6iVoZ36lgCtbbIspLDCDUlMr/gRoDG+kND
	J90ugTikSh7ZSpwxb/ba7E5lTJ5sP6tlcVZ11ePU=
X-Gm-Gg: AfdE7cn1YeYvTfB8BzgRrQDDGOw9vU3PWMoVmB1UkL3uk8qY6K8knSwsto/DHwlQfbZ
	VNj0qYqB82/5kMR4aJVPIm9fPQkVv/JiyHJ5muSRGGTdO7/ydaiRaU5CrcM9gmrBiknSmwIZhQC
	CDQCE+TblB+Jn2VmMSIC3Qa9eFpsqbw8wn9GM4isGxlks2X9lzMQarwrSySt7Bu4zP2kS/uOakS
	TERdnHhdhrpCqZp52F2u+AAl2UOmtwdn9kwSAfoQ398ArhHG0tYFxtHcZ3qLYIGSIRGcSTbupt/
	lob2FpYAwcdzFSPhEz18RIH616EEI083D7jMR1AvKqHhKeE2rJwNnyPk6vY=
X-Received: by 2002:a05:690e:4843:b0:664:f588:3e11 with SMTP id
 956f58d0204a3-66650cfc0b8mr168192d50.33.1783091403616; Fri, 03 Jul 2026
 08:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703060016.570188-1-zzzccc427@gmail.com>
In-Reply-To: <20260703060016.570188-1-zzzccc427@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 3 Jul 2026 11:09:52 -0400
X-Gm-Features: AVVi8Cc5PGtPLDq9VuyZQG2ylZfSGRZcyK8flTjT6zwXERfzdAo633PXIgd6Rsk
Message-ID: <CABBYNZ+G-=3Np-9+-LJGnzW2W4HDhQdAEJ_EJHEJR=PiP6+dZg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: MGMT: snapshot LOAD_CONN_PARAM data before
 queueing update
To: Cen Zhang <zzzccc427@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cen,

On Fri, Jul 3, 2026 at 2:00=E2=80=AFAM Cen Zhang <zzzccc427@gmail.com> wrot=
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
> The buggy scenario involves two paths, with each column showing the order
> within that path:
>
>   LOAD_CONN_PARAM update path:        LOAD_CONN_PARAM clear path:
>   1. update the existing params       1. process a later multi-param load
>   2. queue conn_update_sync(params)   2. clear disabled parameters
>   3. return while the callback        3. free the queued params object
>      is still pending
>   4. callback dereferences params

This is valid though, which means the first update shouldn't even take
place if the parameters are freed while the callback is pending.

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
> Queue a private copy of the address and connection parameter values
> instead, and free that copy from the sync-work destroy callback. The live
> hdev->le_conn_params entry can then be cleared without invalidating queue=
d
> work.
>
> Fixes: 0ece498c27d8c ("Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM upda=
te existing connection")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
>  net/bluetooth/mgmt.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 733a4b70e10c..4a38f7663445 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -7947,6 +7947,11 @@ static int conn_update_sync(struct hci_dev *hdev, =
void *data)
>         return hci_le_conn_update_sync(hdev, conn, params);
>  }
>
> +static void conn_update_sync_destroy(struct hci_dev *hdev, void *data, i=
nt err)
> +{
> +       kfree(data);
> +}
> +
>  static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *=
data,
>                            u16 len)
>  {
> @@ -8054,9 +8059,28 @@ static int load_conn_param(struct sock *sk, struct=
 hci_dev *hdev, void *data,
>                             (conn->le_conn_min_interval !=3D min ||
>                              conn->le_conn_max_interval !=3D max ||
>                              conn->le_conn_latency !=3D latency ||
> -                            conn->le_supv_timeout !=3D timeout))
> -                               hci_cmd_sync_queue(hdev, conn_update_sync=
,
> -                                                  hci_param, NULL);
> +                            conn->le_supv_timeout !=3D timeout)) {
> +                               struct hci_conn_params *update;
> +
> +                               /* Queue a private snapshot so the live p=
arams
> +                                * entry can be freed later.
> +                                */
> +                               update =3D kzalloc_obj(*update);
> +                               if (!update)
> +                                       continue;
> +
> +                               update->addr =3D hci_param->addr;
> +                               update->addr_type =3D hci_param->addr_typ=
e;
> +                               update->conn_min_interval =3D min;
> +                               update->conn_max_interval =3D max;
> +                               update->conn_latency =3D latency;
> +                               update->supervision_timeout =3D timeout;
> +
> +                               if (hci_cmd_sync_queue(hdev, conn_update_=
sync,
> +                                                      update,
> +                                                      conn_update_sync_d=
estroy) < 0)
> +                                       kfree(update);
> +                       }

So this will probably need to do a lookup to check if hci_conn_params
have been removed then don't perform any update.

>                 }
>         }
>
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
