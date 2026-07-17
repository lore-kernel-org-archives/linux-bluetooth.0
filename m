Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95DA2D949F
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303237; cv=pass; b=tn0ywr6jWLdnbSIK5J2KzsF2maITL5boC/m6OhLjwQfXIg2ZpKhSCrzk5aCBD+v5uh1imVALP2D0vdpnMUGrMo6KxcHTupOZIqkuZN1LV8sm6ztko2f7jT38npb8zHPrgWeqzj9/lgHnL/9zZbTRAd6K37MmNp8ylWb71FbXxQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303237; c=relaxed/simple;
	bh=ssqp+pzBwVqjC/OZREmWoHUkfjQpzqQQ5FKvwxi7qKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMlHDWQ/+15xs622tvTMJKkSkBCeX1sZvba2HzoXp5KR5BcT5oezjS6i72Gtg723FG67jbgw4MLvXegNl5I3G0G/A0DLdxTVwvxaHfktZQqv3Ud28+8bGVrQui1XAyuxWtwjeqS7xktw/LIFYjlAGWrQIb+yjz04Jo39Pjs9ppc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLLmNWrg; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLLmNWrg"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81ee6b2da98so19741937b3.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 08:47:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784303235; cv=none;
        d=google.com; s=arc-20260327;
        b=khimso+peAtIDkFo1MdoVqo+FPYq8Yp1Ix9PI4H8u+CoIWp53SEKoaskBrz9eJT9Ol
         KH+JqlQmztA0yMR8u3nLW8U+OonJ4p5PhOtdORqfSs5DpRNx49PGxrgyqN877VvLpLPE
         jX8MK005nno8I61RwNAxPC7dFoa5Hn+S0c39SJuaV+NAExgCnGutm67U7P1YyeZ5Wiwl
         PPPk8QOsf4aEUajN5M2gAPdWrwbTsJH1EE+3yGDEpNPo20iFjExeC8eNR04Gmj07EHze
         bRmOdgA9YRBGrRrtVZF67OHrLx8Q30QxFY8Ip9j4e1PGhPj2p3xHuvUlLzcTTirRxEnm
         5zuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wmTfKgqKmzDAIxeAA7OFX0iX+1srJ/QXaWKlhJfulns=;
        fh=SPVv+hyDtCYw/w4JWDVLs++kFTWEVgRFrw593GpkOsc=;
        b=FdhoDQVw2weerc8dBFmLteBPYKbTqYIKHcnF8Odeu8BT3m5dXK4INxgkj/cIq0eZYf
         e+/MBvmINObie5Nnkbq6WmgHNShsq/yXdloOBb1nJzAVKVppft8i0fjMz8lMpjPcK0F3
         4LuzvEP9pmskzMlfiJvBcyR8NU7WXUj1CbBTq6bwYt42xO93t7fZ9jqdL11OhNq9q7gK
         bdFnCWJAF8zT3Yg3jFfRIaM2HANj84Lpi9t/+bsb6CJhl67h9pIYmK5Xzw+rj/gZ3JRv
         LGdgPcXnpSk19FiYVEIM/d2q82RXmhFVnt4/EjrdcK8gVa2eDOJBsof72oyvYp95YMRu
         CFSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784303235; x=1784908035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wmTfKgqKmzDAIxeAA7OFX0iX+1srJ/QXaWKlhJfulns=;
        b=SLLmNWrgG4MYGFQbXwFrUEQWRrRpy3/l94ubOB+xGeZ31/WA8BXtx2DMpaGw61qQRc
         4Jpy1AbJtqmkdOmcNsQTe+bYXb5AY2wVHoLEguiWi7fzaLvM/Fdm/qm3GK8mG6wbY8i8
         i3yaASaetuccSDcMJweScwjocZvjQh8/d3fWewJvBmf73uRcwG5VjB7Tab6EEDoPr1Tk
         4UjaQDpw2UgEJCPoezj91ArMaJ3WCHS/SIUH5ZpWas0LF6SdMTo3AhCblqOUsy2mZmn3
         eCKkdinoMuhh0aL3xfIM+l1AyqZ1WrODtAxIWUDKB2jLZLkooSUBqHBkxsP9NcFmu1l1
         MuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784303235; x=1784908035;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wmTfKgqKmzDAIxeAA7OFX0iX+1srJ/QXaWKlhJfulns=;
        b=DYrbHl+ny44qEgKn/1T+OyBnO+/LcpbwBw6y+HoD2uYh2QxWiOqeLsOnYEQO3HNES6
         5JfiKt3KhwW0p0UcIhPYc4e0K3LsSJT44CGJi3CuAq1PcRX1ppnHkiJNgHPDcI/lKiuc
         cWfZRBS+hmJwOM15KPE1aQH6PLyf7njAUmjpGWBis927VKejc3oTjRTXpMq44RVubgR+
         AYfDQeW1qtFuBBjZlpO/EvHm4ypMT2QBWAiVl6+FNzzH05A8+k/6U5RpxSPj1gI3tmR+
         JaKeiSOripAsvCo3n90MVpbx/P2Eqzj5k563LsTI+PUOwOfkWfvtxks0feVMmLwSc7WO
         t8Iw==
X-Gm-Message-State: AOJu0YwptCBHkvGmUltid5x6P9VB4gZH8esoPJcbau/FwjAOhLAxOKxX
	QwaG5rgg25oHrNxBUEDBtCcYlk2xP4609LdRCkiUDFrZXjIXzFe80htIx5lsze4OC1xTdm0lu7L
	sqz/K73ddvjQjiaqN2SwmlgDfeSA9pXA=
X-Gm-Gg: AfdE7cn2KFxF7YUurxzRzHE8GIhApB8KjWWKsPcHcTHrTOK9md+AWGFtrf/dwvTdhHW
	cWTBEwZk6ggrdqQw/rvUB2ZFgCsgvBoY5Bl54vZ4o7z1HXnbp+U67C2LrWHOvN+0xYpdNpSN7MG
	SnVpbQ4DXy/Bl8r+ma4mvAprCgmIerPztnrWC569BQFlGuGcyeyB6Nkv8cooyh/eMqH6UX6U2Sb
	OubXXapQqv4qB102LIEyMwIsVjsLDYIbsJHanL4nwxwv1p0TJzkE+XdpCnF1xnh
X-Received: by 2002:a05:690c:6e11:b0:80d:78bd:7a37 with SMTP id
 00721157ae682-81ef260c8d6mr10314317b3.49.1784303234609; Fri, 17 Jul 2026
 08:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703060033.570932-1-zzzccc427@gmail.com>
In-Reply-To: <20260703060033.570932-1-zzzccc427@gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Fri, 17 Jul 2026 23:47:03 +0800
X-Gm-Features: AUfX_mxy29SvkHLt4PeDHkvEGWE66oHRXZLvA2ORRg3PIlulreENUyLB5f_ZwUU
Message-ID: <CAFRLqsW3Rjz_oyLiVihooJfCp7AawzdaeXr26o_EFMaYN2kJzw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: MGMT: Fix ADD_EXT_ADV_DATA rollback of
 committed instances
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marcel, Luiz,

Gentle ping on this patch.

Could you please take a look when you have a chance?

Thanks!

Best regards,
Cen Zhang

Cen Zhang <zzzccc427@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=883=E6=97=A5=
=E5=91=A8=E4=BA=94 14:00=E5=86=99=E9=81=93=EF=BC=9A
>
> add_ext_adv_data() uses clear_new_instance to roll back failures after
> preparing advertising data. That path is valid for a newly created pendin=
g
> instance, but a malformed ADD_EXT_ADV_DATA request can also reach it for
> an already committed advertising instance. In that case clear_new_instanc=
e
> frees the live adv_info while hci_cmd_sync_work() may still be using it.
>
> The buggy scenario involves two paths, with each column showing the order
> within that path:
>
>   advertising enable path:           ADD_EXT_ADV_DATA error path:
>   1. look up the committed adv_info  1. accept an update for that instanc=
e
>   2. wait for the controller         2. hit clear_new_instance on failure
>      response                        3. remove and free the live adv_info
>   3. resume and access adv_info
>
> Validation reproduced this kernel report:
> BUG: KASAN: slab-use-after-free in hci_enable_ext_advertising_sync+0x99/0=
x190 [bluetooth]
> Read of size 1 at addr ffff888104e3f010 by task kworker/u17:1/2502
> Workqueue: hci0 hci_cmd_sync_work [bluetooth]
>
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x66/0xa0
>  print_report+0xce/0x5f0
>  ? hci_enable_ext_advertising_sync+0x99/0x190 [bluetooth]
>  ? __virt_addr_valid+0x19f/0x330
>  ? hci_enable_ext_advertising_sync+0x99/0x190 [bluetooth]
>  kasan_report+0xe0/0x110
>  ? hci_enable_ext_advertising_sync+0x99/0x190 [bluetooth]
>  ? __pfx_add_ext_adv_data_sync+0x10/0x10 [bluetooth]
>  hci_enable_ext_advertising_sync+0x99/0x190 [bluetooth]
>  ? __pfx_hci_enable_ext_advertising_sync+0x10/0x10 [bluetooth]
>  hci_cmd_sync_work+0x187/0x210 [bluetooth]
>  process_one_work+0x4fd/0xbc0
>  worker_thread+0x2d8/0x570
>  kthread+0x1ad/0x1f0
>  ret_from_fork+0x3c9/0x540
>  ret_from_fork_asm+0x1a/0x30
>
> Allocated by task 2515:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x17/0x60
>  __kasan_kmalloc+0xaa/0xb0
>  hci_add_adv_instance+0x35d/0x440 [bluetooth]
>  add_ext_adv_params+0x291/0x510 [bluetooth]
>  hci_sock_sendmsg+0x96b/0xf80 [bluetooth]
>  __sys_sendto+0x2bc/0x2d0
>  __x64_sys_sendto+0x76/0x90
>  do_syscall_64+0x115/0x6a0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 2515:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x17/0x60
>  kasan_save_free_info+0x3b/0x60
>  __kasan_slab_free+0x5f/0x80
>  kfree+0x313/0x590
>  hci_remove_adv_instance+0x130/0x1b0 [bluetooth]
>  add_ext_adv_data+0x263/0x640 [bluetooth]
>  hci_sock_sendmsg+0x96b/0xf80 [bluetooth]
>  __sys_sendto+0x2bc/0x2d0
>  __x64_sys_sendto+0x76/0x90
>  do_syscall_64+0x115/0x6a0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Only pending instances should be rolled back from ADD_EXT_ADV_DATA
> failures. Leave committed instances in place so queued controller work
> cannot retain a freed adv_info pointer.
>
> Fixes: 12410572833a2 ("Bluetooth: Break add adv into two mgmt commands")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
>  net/bluetooth/mgmt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 733a4b70e10c..a4126d616efa 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -9220,7 +9220,8 @@ static int add_ext_adv_data(struct sock *sk, struct=
 hci_dev *hdev, void *data,
>         goto unlock;
>
>  clear_new_instance:
> -       hci_remove_adv_instance(hdev, cp->instance);
> +       if (adv_instance->pending)
> +               hci_remove_adv_instance(hdev, cp->instance);
>
>  unlock:
>         hci_dev_unlock(hdev);
> --
> 2.43.0
>
