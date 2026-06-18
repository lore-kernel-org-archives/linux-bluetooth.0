Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFBC22689C
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797575; cv=pass; b=FV3imhwK1NUjSqvXpRSMmzNnPnhR5KJ9GCGvWjy6RMzeV35TNUkck9u21V1oo7f+xcAJv88ARDni4eWjrpHHoQEdOfvduNecFfLouVtqnut1ZAqcWwvrKcxZmMQ9bsIngbgQYu0QemK56e+aXuPoKc1lqRaP3vsx62DAOKTACaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797575; c=relaxed/simple;
	bh=E3MUAO3a4GEc2gEEkp72KV45QR3SXMSWmW3V3wggpEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMhOi1BrYhudYEKMIoVJx3xmSHD35k+y35dfN0sG1M18UWuNvcBVRTC9fUAQnOoTP3/dv9rSbwBeZC6pZ+PP4hhJ8zcXnDiazZIOBZ2HikNO2bSZxkVricuaLed5Byt2Xg5xUF0wgLiOtyEJDQnFJHeak7TcwBsvQegfOk/mP1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UehJ83IZ; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UehJ83IZ"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66043ecf6b3so1088359d50.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 08:46:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781797573; cv=none;
        d=google.com; s=arc-20240605;
        b=Eyp7gzk6nYvfzdfEX7SYlK+pbrFklrFfwv8aeF+YIyQO8Ty43jcyE4Ek9BPWgYxxfH
         LeAG4+MIgP0/AvWzSk6wSKEmtjpkCRyjJwOK0g1QlzS/nJ5dSc66HWcduZ9jp2GladV6
         daYokTuTErOMuR14Dt0fzGdna6QmfAmeDrQ3u1j5o4jvjt+IxGpjM9iFbrMCFfvXC8tC
         hVPpBodvYP2Zk4ZUWgDPzQ3OLw+IcqvjprSdqMuAcoKp+202UmOJO9HgqH99UrkQol14
         Wgwi6FnKBJj4r6D4q+MCq3p7a0X8P2mzrTzSie3tmNmw6NYW3ZSdX9DWnlkDxBHI0Y/4
         V3mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bRIJbkJxxj319rB/3HQ6FBts4aqQHzhuAaWll0V3LsM=;
        fh=fG4rWNAYOqa3eAAkgPjTo3EQs20QbCItr88AE34oa+I=;
        b=hMoAmk8jG7wg2scwF3cdwB+LCb2omgkDoeOH0LnWAtHDNWruRFQFU1+JNNQu3a0alJ
         PBxAQCMMk5Xu2+vYWN2OonHmSB6AO/QgWu7XtVG7XDQFWZQK0NmehhAVjYlLvDXX/vfn
         ia+sJ2rQIkmjQAEDZkBWTcKBXlXz1cG5zzUr94z5+vthG9BPjs8cZvlhEVu3G/TfbgGb
         1obIY6TbN8rEPePgDw7r7L8PW1ZD+uLkrFdOsquM8DJZ9dk+Eue2QmDOCxNYPjgrr0YK
         tlRBNknpCw5XxF3oK679cEOA8khdEdKt7af+6p9aS/TGvwAMWnehRGTN3ZMudwDeOmPX
         8fnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781797573; x=1782402373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRIJbkJxxj319rB/3HQ6FBts4aqQHzhuAaWll0V3LsM=;
        b=UehJ83IZ0aFEEuEuOSeLFYYxr1z5US2hS5FHIj7eNHzShDlYGuD7e1rX+CfSHTFY1a
         eyACh8lxCK1cMchojZ7Q9qQhBy5hoGp1XpCO8O/ja3/uQe4MuxcYOtjDQT3eb1k8ax/Y
         GX1DV9QA67fsZB7LjeITXSs6bXoVlnoCO5y914eC8GqN6qmU4xzxw7uI2RsdDxSLL1iF
         gb3SO91NPb7520St8fr3VabOnQ55Lazzssi77j51LpDUUMVhr7Y0jCoX+Uby8rWkH/It
         nH7fzc49H67JcTojCyi2Xnx83COPYO+ucr1cpTfRRFsY6a4C49DVG+BMc4QTUa1x526A
         Dm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781797573; x=1782402373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bRIJbkJxxj319rB/3HQ6FBts4aqQHzhuAaWll0V3LsM=;
        b=XUuOmyiFNx6z48NjB6rQtlakLVuKCRWDU2IJ98a8TQJDCDBKvCQexFZfaFkysDkZIb
         80VWBgikICkF60CXPnno/P5icVo2uLPatggVtFf3aqZx55IUrY3oBLs/In4CMMeCGm6p
         qNAeRDSX4gs4GOuAdA/z7X4GcgVfIWsDL0+CI5ljhiCwI5rCM/ohd0brz9t54msDM97O
         2Yu8Bx+YgSMgyYS20ZSbU7w7je/ewJdYTu6wVEnZ8YQUtyO/CgdCjpB2FoJRpgOHhMUK
         M+zKwttxxMx62vyQ7IZJ8MOqnwxRhTUFPJol4Aj7q6KSwiUabPKLvA/6SMgzrxeIH6Pd
         L7ww==
X-Forwarded-Encrypted: i=1; AFNElJ+dqPBgHo+4gFa1tUCIoPhsub1mpROl/poE/KJ8QNByDcf0QuQ5hgQ9UOpAgvMgathVFD5Q6Ul8ZYk+9d5vmYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgSzzM+i4//POXX60hUMdnVC6em/vNHwuLEEs7Y5KBUxzT0ILd
	hOIT7PwVRTc8XIiyRteXg/w2E5jBZ8UkQ1LADW2u2pAVTBAVHEc1pPel5nXVjKVgiYMLgiqSsmZ
	NZud1dit/bOxsYMoYZ0zUCTF6ggznUPc=
X-Gm-Gg: AfdE7cmQz8+bmVDeNMo3iBBkl9Shjc2IUgPKUd6GVQl1hNUOAbvLWgYGh+YHoS1I9NC
	1AT49oFNU/KVQ7xIk3Hiv2l3KSKFujiYr34FAXDpmdSi5yFfKnJsk7hqbJAVc81F/NV2FDgGeBa
	rkiOIF2+jBanUm+rvr92b/P6MLUObTdS108gDHtxuLH59GbpJzWeJvAhO3p9QvWfhtyhcyAHk9c
	9vybC0SptzOSeM/h25u71m2ZOTBpdh2rci10zumEPRi5mtoqyZ2yZL8z9metTq37n80boFT1i88
	kw4ai2K5AfbxLwQ/e/z3ngLlE2KztPsY0WbNusGXyGyaEB1F6gz76p6waQA=
X-Received: by 2002:a05:690e:243:b0:64e:e896:a86 with SMTP id
 956f58d0204a3-662fca5f9c0mr107144d50.36.1781797572647; Thu, 18 Jun 2026
 08:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618102134.3339999-1-zzzccc427@gmail.com>
In-Reply-To: <20260618102134.3339999-1-zzzccc427@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 18 Jun 2026 11:46:01 -0400
X-Gm-Features: AVVi8Cfn5xDakvXwNPqBFD0e3ESJ__gs94xzDzUr5odkNiaPMPl_fwpN3Ce9qC8
Message-ID: <CABBYNZJVx7NphF8FmTGYLwCGVnrhyq=4sdHtwvAvPoktidGh2g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: mgmt: copy pending command data under the list lock
To: Cen Zhang <zzzccc427@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cen,

On Thu, Jun 18, 2026 at 6:21=E2=80=AFAM Cen Zhang <zzzccc427@gmail.com> wro=
te:
>
> mgmt_pending_find() only protects the pending list lookup. Once it
> returns, a caller that dereferences the returned command has no lifetime
> guarantee unless another lock or ownership transfer keeps the command fro=
m
> being removed and freed.
>
> mgmt_powering_down() only needs the requested SET_POWERED mode, but it
> currently keeps the raw pending command pointer after the list lock has
> been dropped and then reads cmd->param and cp->val.
>
> The buggy scenario involves two paths, with each column showing the order
> within that path:
>
> hci_suspend_dev()/hci_resume_dev():     SET_POWERED completion:
>   1. mgmt_powering_down() calls           1. mgmt_set_powered_complete()
>      pending_find()
>   2. pending_find() drops                 2. mgmt_pending_valid() delists
>      mgmt_pending_lock                       the command
>                                           3. mgmt_pending_free() frees th=
e
>                                              command and parameter buffer
>   3. mgmt_powering_down() reads
>      cmd->param
>   4. mgmt_powering_down() reads
>      cp->val
>
> Add a helper that copies a requested pending-command parameter slice whil=
e
> mgmt_pending_lock is still held. Use it for the mgmt_mode readers in
> mgmt.c so they take a snapshot of the pending request instead of keeping =
an
> unlocked raw command pointer just to inspect the requested mode.
>
> Validation reproduced this kernel report:
> BUG: KASAN: slab-use-after-free in mgmt_powering_down+0xa0/0xf0
>
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x66/0xa0
>  print_report+0xce/0x5f0
>  ? mgmt_powering_down+0xa0/0xf0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __virt_addr_valid+0x19f/0x330
>  ? mgmt_powering_down+0xa0/0xf0
>  kasan_report+0xe0/0x110
>  ? mgmt_powering_down+0xa0/0xf0
>  mgmt_powering_down+0xa0/0xf0
>  hci_suspend_dev+0xc0/0x2d0
>  ? vhci_suspend_work+0x31/0x50
>  process_one_work+0x4fd/0xbc0
>  ? __pfx_process_one_work+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __list_add_valid_or_report+0x37/0xf0
>  ? __pfx_vhci_suspend_work+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  worker_thread+0x2d8/0x570
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0x1ad/0x1f0
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x3c9/0x540
>  ? __pfx_ret_from_fork+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __switch_to+0x2e9/0x730
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
>
> Allocated by task 336 on cpu 2 at 98.764916s:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x17/0x60
>  __kasan_kmalloc+0xaa/0xb0
>  mgmt_pending_new+0x44/0x130
>  mgmt_pending_add+0x22/0x110
>  set_powered+0x1ad/0x310
>  hci_sock_sendmsg+0x96b/0xf80
>  sock_write_iter+0x28e/0x2a0
>  do_iter_readv_writev+0x211/0x390
>  vfs_writev+0x266/0x7b0
>  do_writev+0x191/0x1d0
>  do_syscall_64+0x115/0x6a0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 314 on cpu 0 at 101.816391s:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x17/0x60
>  kasan_save_free_info+0x3b/0x60
>  __kasan_slab_free+0x5f/0x80
>  kfree+0x313/0x590
>  mgmt_pending_foreach+0x144/0x190
>  __mgmt_power_off+0xca/0x250
>  hci_dev_close_sync+0x8ba/0xb00
>  hci_set_powered_sync+0x384/0x480
>  hci_cmd_sync_work+0x187/0x210
>  process_one_work+0x4fd/0xbc0
>  worker_thread+0x2d8/0x570
>  kthread+0x1ad/0x1f0
>  ret_from_fork+0x3c9/0x540
>  ret_from_fork_asm+0x1a/0x30
>
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
>  net/bluetooth/mgmt.c      | 37 ++++++++++++++++++-------------------
>  net/bluetooth/mgmt_util.c | 27 +++++++++++++++++++++++++++
>  net/bluetooth/mgmt_util.h |  2 ++
>  3 files changed, 47 insertions(+), 19 deletions(-)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index d23ca1dd0893..91272640864a 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -960,19 +960,25 @@ static struct mgmt_pending_cmd *pending_find(u16 op=
code, struct hci_dev *hdev)
>         return mgmt_pending_find(HCI_CHANNEL_CONTROL, opcode, hdev);
>  }
>
> +static bool pending_find_copy(u16 opcode, struct hci_dev *hdev, void *da=
ta,
> +                             size_t len)
> +{
> +       return mgmt_pending_find_copy(HCI_CHANNEL_CONTROL, opcode, hdev,
> +                                     data, len);
> +}
> +
>  u8 mgmt_get_adv_discov_flags(struct hci_dev *hdev)
>  {
> -       struct mgmt_pending_cmd *cmd;
> +       struct mgmt_mode cp;
>
>         /* If there's a pending mgmt command the flags will not yet have
>          * their final values, so check for this first.
>          */
> -       cmd =3D pending_find(MGMT_OP_SET_DISCOVERABLE, hdev);
> -       if (cmd) {
> -               struct mgmt_mode *cp =3D cmd->param;
> -               if (cp->val =3D=3D 0x01)
> +       if (pending_find_copy(MGMT_OP_SET_DISCOVERABLE, hdev, &cp,
> +                             sizeof(cp))) {
> +               if (cp.val =3D=3D 0x01)
>                         return LE_AD_GENERAL;
> -               else if (cp->val =3D=3D 0x02)
> +               else if (cp.val =3D=3D 0x02)
>                         return LE_AD_LIMITED;
>         } else {
>                 if (hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE))
> @@ -986,17 +992,13 @@ u8 mgmt_get_adv_discov_flags(struct hci_dev *hdev)
>
>  bool mgmt_get_connectable(struct hci_dev *hdev)
>  {
> -       struct mgmt_pending_cmd *cmd;
> +       struct mgmt_mode cp;
>
>         /* If there's a pending mgmt command the flag will not yet have
>          * it's final value, so check for this first.
>          */
> -       cmd =3D pending_find(MGMT_OP_SET_CONNECTABLE, hdev);
> -       if (cmd) {
> -               struct mgmt_mode *cp =3D cmd->param;
> -
> -               return cp->val;
> -       }
> +       if (pending_find_copy(MGMT_OP_SET_CONNECTABLE, hdev, &cp, sizeof(=
cp)))
> +               return cp.val;
>
>         return hci_dev_test_flag(hdev, HCI_CONNECTABLE);
>  }
> @@ -9826,18 +9828,15 @@ static void unpair_device_rsp(struct mgmt_pending=
_cmd *cmd, void *data)
>
>  bool mgmt_powering_down(struct hci_dev *hdev)
>  {
> -       struct mgmt_pending_cmd *cmd;
> -       struct mgmt_mode *cp;
> +       struct mgmt_mode cp;
>
>         if (hci_dev_test_flag(hdev, HCI_POWERING_DOWN))
>                 return true;
>
> -       cmd =3D pending_find(MGMT_OP_SET_POWERED, hdev);
> -       if (!cmd)
> +       if (!pending_find_copy(MGMT_OP_SET_POWERED, hdev, &cp, sizeof(cp)=
))
>                 return false;
>
> -       cp =3D cmd->param;
> -       if (!cp->val)
> +       if (!cp.val)
>                 return true;
>
>         return false;
> diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
> index 6ea107c0e054..5d6d13ccadd2 100644
> --- a/net/bluetooth/mgmt_util.c
> +++ b/net/bluetooth/mgmt_util.c
> @@ -233,6 +233,33 @@ struct mgmt_pending_cmd *mgmt_pending_find(unsigned =
short channel, u16 opcode,
>         return NULL;
>  }
>
> +bool mgmt_pending_find_copy(unsigned short channel, u16 opcode,
> +                           struct hci_dev *hdev, void *data, size_t len)
> +{
> +       struct mgmt_pending_cmd *cmd, *tmp;
> +       bool found =3D false;
> +
> +       mutex_lock(&hdev->mgmt_pending_lock);
> +
> +       list_for_each_entry_safe(cmd, tmp, &hdev->mgmt_pending, list) {
> +               if (hci_sock_get_channel(cmd->sk) !=3D channel)
> +                       continue;
> +
> +               if (cmd->opcode !=3D opcode)
> +                       continue;
> +
> +               if (cmd->param_len >=3D len) {
> +                       memcpy(data, cmd->param, len);
> +                       found =3D true;
> +               }
> +               break;
> +       }
> +
> +       mutex_unlock(&hdev->mgmt_pending_lock);
> +
> +       return found;
> +}

Or we could just add a kref to mgmt_pending_cmd so mgmt_pending_find
can return a reference which is then unref'd when finished accessing
it.

>  void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev, bool remove,
>                           void (*cb)(struct mgmt_pending_cmd *cmd, void *=
data),
>                           void *data)
> diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
> index 20810cf06e81..4cccb71c8a1f 100644
> --- a/net/bluetooth/mgmt_util.h
> +++ b/net/bluetooth/mgmt_util.h
> @@ -51,6 +51,8 @@ int mgmt_cmd_complete(struct sock *sk, u16 index, u16 c=
md, u8 status,
>
>  struct mgmt_pending_cmd *mgmt_pending_find(unsigned short channel, u16 o=
pcode,
>                                            struct hci_dev *hdev);
> +bool mgmt_pending_find_copy(unsigned short channel, u16 opcode,
> +                           struct hci_dev *hdev, void *data, size_t len)=
;
>  void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev, bool remove,
>                           void (*cb)(struct mgmt_pending_cmd *cmd, void *=
data),
>                           void *data);
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
