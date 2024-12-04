Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B7720C499
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Dec 2024 16:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331455; cv=none; b=O8l9IRL0OfcunElolN+9OEyFM/UHOEE4jRIqV25ATMjQvgQAH1uTlw9tv1isjHdrtbdYs6D8hSisQq3P7a0Skg6efjlvuSxHlHekATPtjTBSu7SEy6T6/zVF89ESPMqcopgocJmMcfv+DtTHC/lCX9Gl54CtucTdvwvvdeYkNrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331455; c=relaxed/simple;
	bh=DjjepKme7mOge0ADMzRzzXgkjmhxfnAvXP++eWditDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUIjHKW2BsciewU5V2MGN25V6cv07ZYTf8GphmRl4Q+oNchVtPX6/qqFoqVPWeStr96yLVMYJVgStHyFLqqTgpfN4sF6ZkQX1dKELblI7UzNdVTBzKBDBDbsToM5qMGoAr5b/96YDXHMOq+T0Gw+tuE1iiJBGQGXIjcejxj2mi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9+obe8e; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9+obe8e"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ffdd9fc913so74217901fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Dec 2024 08:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733331452; x=1733936252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DUIHIjvl7rDCyWCZZvu3wuj7QItvqEmrh86iS0aJ84=;
        b=g9+obe8eXG+BBQWf1ggFqbPUo00QxAnoPva3MvaRNEeehPFR8pW9la3JgHCzi5YsCQ
         tZhqR+uVMVcQoiJ15kdhW1W1fLMEGnv4LRH15wGB01EecLOi+4/RRTiw4HY9jpmdGRJb
         5BPlVvT/hau+7wS7z0wS7Jjo/bulCmIY7+BwXE1WG2zf9VGWizIOnjp+kRd0Z6ctHlQ8
         FVccA5R4TJGDTcmMG9pDIouGcuG25i0NtJk0gRN/f0Z6o0bSLxUWa4MfBw26zWXKfmVZ
         9z+/E0BNVSJXo34hjPEw5cxVlNMNb66mRFT5bUIxSv9g1ujpnKfu3juiDkGLmGePqAm0
         y7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733331452; x=1733936252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DUIHIjvl7rDCyWCZZvu3wuj7QItvqEmrh86iS0aJ84=;
        b=O0UmMRMqwOTQzNUCgofIGCZKoCEX9fbi9MPf8XOCwOj2RB5KwidoBPc+4fP+06pNbH
         eYvT6IJ0Cznv3mrT9ExqoL3jtL1op0N7ijS0Usn/KTnapOFPc/xlnNPOh71RUEvPTl4d
         2RSAdCk4M8qrzxXlwpR4ue0snsl9EGPACMPBUgFYRkcm/Il/ymXSFUwqd1KFN+YqFnxs
         6GCDVjks8cd9t/7Dowz0CMepgEIJTc8qkJ2YyEqQrmkuu2KlgvvD5uEpR7YLxxNevNvc
         zQymq62pdHGg3XZ/fnv0+rA0i+qRKJnijuM0KHTiB2AVZd9zdVaZWKzKnw863EyHREdf
         KbAw==
X-Gm-Message-State: AOJu0YxLjDVz89Oob9rhwBfI5VSnFdmUKnkWycuvWxE56JK0vl/jh8Xa
	OtQFXfdsMxGOj3JWkf8Uc+6j6vTYIAqoRZaicCusISmEgcxAdeNqI+yLrUs96mVFw/jUbn6mkdM
	qCGzaZ1Ubu2NmHLgEfudxHbt/T0e2KA==
X-Gm-Gg: ASbGncu46a9TxytbWOR6cLoiRSVUmNyHMEgDaSwylXpDe7halGSZSecrUa/1Zo3TPNW
	/n0/0D9HxP6TUH1bDEIxx2mFHMgwdU8p3
X-Google-Smtp-Source: AGHT+IEZwGW3wvDQa6mWeELelAkmZoPTm4uKAOKN9nSZaAb8txf0zXOythfw4X7hyI9aLN9ntOco90Ehs3qWpTVjMFs=
X-Received: by 2002:a2e:80c7:0:b0:300:1889:633a with SMTP id
 38308e7fff4ca-300188965ffmr11707941fa.4.1733331451678; Wed, 04 Dec 2024
 08:57:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204164840.14037-1-iulia.tanasescu@nxp.com> <20241204164840.14037-2-iulia.tanasescu@nxp.com>
In-Reply-To: <20241204164840.14037-2-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 4 Dec 2024 11:57:19 -0500
Message-ID: <CABBYNZKKRjO8aWyuaMoWtziq12M7eOEgSHPPa3Jy0TqVrn6J+w@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: hci_event: Fix use after free error
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iulia,

On Wed, Dec 4, 2024 at 11:48=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> This removes the hci_conn_del call while the conn_hash list is iterated
> through, fixing the use after free error below:
>
> [   82.961619] BUG: KASAN: slab-use-after-free in
>                hci_le_create_big_complete_evt+0x900/0x9e0 [bluetooth]
> [   82.961688] Read of size 8 at addr ffff88811fc0c000 by task
>                kworker/u81:2/2806
>
> [   82.961697] CPU: 10 UID: 0 PID: 2806 Comm: kworker/u81:2
> [   82.961704] Tainted: [W]=3DWARN
> [   82.961707] Hardware name: Dell Inc. Precision 3571/07K1M2,
>                BIOS 1.11.0 12/12/2022
> [   82.961711] Workqueue: hci0 hci_rx_work [bluetooth]
> [   82.961780] Call Trace:
> [   82.961783]  <TASK>
> [   82.961787]  dump_stack_lvl+0x91/0xf0
> [   82.961796]  print_report+0xd1/0x670
> [   82.961803]  ? __virt_addr_valid+0x23a/0x440
> [   82.961810]  ? kasan_complete_mode_report_info+0x6a/0x200
> [   82.961816]  kasan_report+0xed/0x130
> [   82.961821]  ? hci_le_create_big_complete_evt+0x900/0x9e0 [bluetooth]
> [   82.961900]  ? hci_le_create_big_complete_evt+0x900/0x9e0 [bluetooth]
> [   82.961963]  ? hci_le_create_big_complete_evt+0x427/0x9e0 [bluetooth]
> [   82.962009]  __asan_report_load8_noabort+0x14/0x30
> [   82.962012]  hci_le_create_big_complete_evt+0x900/0x9e0 [bluetooth]
> [   82.962080]  ? __pfx_hci_le_create_big_complete_evt+0x10/0x10
>                 [bluetooth]
> [   82.962130]  hci_le_meta_evt+0x26c/0x660 [bluetooth]
> [   82.962194]  ? __pfx_hci_le_create_big_complete_evt+0x10/0x10
>                 [bluetooth]
> [   82.962245]  hci_event_packet+0x55e/0x10c0 [bluetooth]
> [   82.962291]  ? __pfx_hci_le_meta_evt+0x10/0x10 [bluetooth]
> [   82.962337]  ? __pfx_hci_event_packet+0x10/0x10 [bluetooth]
> [   82.962389]  ? __kasan_check_read+0x11/0x20
> [   82.962395]  hci_rx_work+0x365/0x1310 [bluetooth]
> [   82.962471]  ? lock_acquire+0x7c/0xc0
> [   82.962476]  process_one_work+0x859/0x1a10
> [   82.962481]  ? __pfx_process_one_work+0x10/0x10
> [   82.962483]  ? do_raw_spin_lock+0x137/0x290
> [   82.962488]  ? assign_work+0x16f/0x280
> [   82.962492]  ? lock_is_held_type+0xa3/0x130
> [   82.962496]  worker_thread+0x6eb/0x11e0
> [   82.962501]  ? __pfx_worker_thread+0x10/0x10
> [   82.962503]  kthread+0x2f0/0x3e0
> [   82.962506]  ? __pfx_kthread+0x10/0x10
> [   82.962509]  ret_from_fork+0x44/0x90
> [   82.962513]  ? __pfx_kthread+0x10/0x10
> [   82.962516]  ret_from_fork_asm+0x1a/0x30
> [   82.962525]  </TASK>
>
> [   82.962531] Allocated by task 3161:
> [   82.962535]  kasan_save_stack+0x39/0x70
> [   82.962540]  kasan_save_track+0x14/0x40
> [   82.962544]  kasan_save_alloc_info+0x37/0x60
> [   82.962548]  __kasan_kmalloc+0xc3/0xd0
> [   82.962552]  __kmalloc_cache_noprof+0x196/0x3e0
> [   82.962557]  __hci_conn_add+0x163/0x18c0 [bluetooth]
> [   82.962634]  hci_conn_add_unset+0x53/0xe0 [bluetooth]
> [   82.962708]  hci_bind_bis+0x9b2/0x1a40 [bluetooth]
> [   82.962783]  iso_sock_connect+0x7a9/0xd10 [bluetooth]
> [   82.962853]  __sys_connect_file+0x145/0x1b0
> [   82.962859]  __sys_connect+0x113/0x140
> [   82.962864]  __x64_sys_connect+0x72/0xc0
> [   82.962868]  x64_sys_call+0x21c0/0x25f0
> [   82.962873]  do_syscall_64+0x87/0x150
> [   82.962878]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> [   82.962886] Freed by task 2806:
> [   82.962889]  kasan_save_stack+0x39/0x70
> [   82.962893]  kasan_save_track+0x14/0x40
> [   82.962898]  kasan_save_free_info+0x3b/0x60
> [   82.962901]  __kasan_slab_free+0x52/0x80
> [   82.962906]  kfree+0x148/0x480
> [   82.962910]  bt_link_release+0x15/0x20 [bluetooth]
> [   82.962983]  device_release+0x9d/0x220
> [   82.962988]  kobject_put+0x18a/0x470
> [   82.962992]  put_device+0x13/0x30
> [   82.962996]  hci_conn_del_sysfs+0x114/0x150 [bluetooth]
> [   82.963072]  hci_conn_del+0x366/0xc00 [bluetooth]
> [   82.963145]  hci_le_create_big_complete_evt+0x43c/0x9e0 [bluetooth]
> [   82.963217]  hci_le_meta_evt+0x26c/0x660 [bluetooth]
> [   82.963290]  hci_event_packet+0x55e/0x10c0 [bluetooth]
> [   82.963345]  hci_rx_work+0x365/0x1310 [bluetooth]
> [   82.963389]  process_one_work+0x859/0x1a10
> [   82.963391]  worker_thread+0x6eb/0x11e0
> [   82.963394]  kthread+0x2f0/0x3e0
> [   82.963396]  ret_from_fork+0x44/0x90
> [   82.963399]  ret_from_fork_asm+0x1a/0x30
>
> [   82.963403] Last potentially related work creation:
> [   82.963405]  kasan_save_stack+0x39/0x70
> [   82.963408]  __kasan_record_aux_stack+0xae/0xd0
> [   82.963410]  kasan_record_aux_stack_noalloc+0xb/0x20
> [   82.963413]  __queue_work+0x318/0x1100
> [   82.963415]  __queue_delayed_work+0x1cf/0x2d0
> [   82.963417]  queue_delayed_work_on+0x8c/0xd0
> [   82.963419]  iso_conn_put+0x256/0x460 [bluetooth]
> [   82.963460]  iso_chan_del+0x9a/0x240 [bluetooth]
> [   82.963499]  iso_conn_del+0x149/0x280 [bluetooth]
> [   82.963538]  iso_connect_cfm+0x374/0x1430 [bluetooth]
> [   82.963577]  hci_le_create_big_complete_evt+0x39b/0x9e0 [bluetooth]
> [   82.963622]  hci_le_meta_evt+0x26c/0x660 [bluetooth]
> [   82.963667]  hci_event_packet+0x55e/0x10c0 [bluetooth]
> [   82.963713]  hci_rx_work+0x365/0x1310 [bluetooth]
> [   82.963756]  process_one_work+0x859/0x1a10
> [   82.963758]  worker_thread+0x6eb/0x11e0
> [   82.963760]  kthread+0x2f0/0x3e0
> [   82.963762]  ret_from_fork+0x44/0x90
> [   82.963765]  ret_from_fork_asm+0x1a/0x30
>
> Fixes: a0bfde167b50 ("Bluetooth: ISO: Add support for connecting multiple=
 BISes")
> Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> ---
>  net/bluetooth/hci_event.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index aca121408369..8735264ccd8b 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -6872,6 +6872,15 @@ static void hci_le_create_big_complete_evt(struct =
hci_dev *hdev, void *data,
>                 return;
>
>         hci_dev_lock(hdev);
> +
> +       if (ev->status) {
> +               while ((conn =3D hci_conn_hash_lookup_big_state(hdev,
> +                                                             ev->handle,
> +                                                             BT_BOUND)))
> +                       hci_conn_failed(conn, ev->status);
> +               goto unlock;
> +       }
> +

Oh, Im working on a very similar fix actually, but Im taking away the
entire block of rcu_read_lock, will send it shortly.

>         rcu_read_lock();
>
>         /* Connect all BISes that are bound to the BIG */
> @@ -6885,26 +6894,18 @@ static void hci_le_create_big_complete_evt(struct=
 hci_dev *hdev, void *data,
>                                         __le16_to_cpu(ev->bis_handle[i++]=
)))
>                         continue;
>
> -               if (!ev->status) {
> -                       conn->state =3D BT_CONNECTED;
> -                       set_bit(HCI_CONN_BIG_CREATED, &conn->flags);
> -                       rcu_read_unlock();
> -                       hci_debugfs_create_conn(conn);
> -                       hci_conn_add_sysfs(conn);
> -                       hci_iso_setup_path(conn);
> -                       rcu_read_lock();
> -                       continue;
> -               }
> -
> -               hci_connect_cfm(conn, ev->status);
> +               conn->state =3D BT_CONNECTED;
> +               set_bit(HCI_CONN_BIG_CREATED, &conn->flags);
>                 rcu_read_unlock();
> -               hci_conn_del(conn);
> +               hci_debugfs_create_conn(conn);
> +               hci_conn_add_sysfs(conn);
> +               hci_iso_setup_path(conn);
>                 rcu_read_lock();
>         }
>
>         rcu_read_unlock();
>
> -       if (!ev->status && !i)
> +       if (!i)
>                 /* If no BISes have been connected for the BIG,
>                  * terminate. This is in case all bound connections
>                  * have been closed before the BIG creation
> @@ -6913,6 +6914,7 @@ static void hci_le_create_big_complete_evt(struct h=
ci_dev *hdev, void *data,
>                 hci_cmd_sync_queue(hdev, hci_iso_term_big_sync,
>                                    UINT_PTR(ev->handle), NULL);
>
> +unlock:
>         hci_dev_unlock(hdev);
>  }
>
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
