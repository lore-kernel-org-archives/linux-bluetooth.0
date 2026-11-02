Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793640008;
	b=1Jtg5ZW2eZeM0ssspTDnVHnaESoKrCsZgxe79Vmi84oCwd73Th9IEcFujodnW6o2XEYJ
	 Zjg5d5GszYah9ulZecN5dBlmk1RXsbYM6JaO8tvyfh0X6U3f+gcRj9+EDMnKXWJXf2Udj
	 8QWs5rYRQ89rNMSzPTNNmNbJ1Wz9GrK6ehqBLc1UOnqn20V1bvw7lQq94GPfA2cI/ZuuA
	 yG7JV2N/efxTv5fxrYGwHLENseUgS+5SvVY95W/6QMHDb5XzjTCYtC4Ftbtl5bfpxhjJU
	 lPzOZ6EPfWG8weiKBV8VEqrSK6CL5k9ZZlKMFVStvXbHd8e4eU4q14mTPHLSdbwe94Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9XQPcfyOFkdJK9ts0NuvCTE8op2nAqCI6SEF7SQNcfA=;
	b=G2kyi0n39wPqNOIQ+Su3zScderyMHbgKuJciKCcStCNPtkXSCh+OhQCGrwtQBmeHc9bI
	 BzJLzVjQVmtjWr+E0VV7jGRiXzPuxYNQVkOxvjN4+UuegQDOVRl5BjIXWgkXXoJMAQ6F6
	 ykoojTwP62ikdYOrVKASuD0ksKHZBk+hdFwFl/K1JTWWMenTYmkX9ZuJcwi9rELoZN+Xw
	 IbIGbxbgUVfunfQLPTTja2Dw+9HFjR9ZY0Lu9BqdJmcJR1XoTS7pjlZJ+OAkIytwSEasq
	 Rd9l25Q0VEeAUkkG1s0W5oE8gc49KQ+aAjwfjQTDjQaxvmDsOFdQFJdA00iarDMzATQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P241Bu5Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E2C606B0FF
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 17:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65E2C606B0FF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P241Bu5Q
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b12b1ee403so18743897b3.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 09:20:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793640006; cv=none;
        d=google.com; s=arc-20260327;
        b=O7DS6J+5vHO6UwFGbmY+YuPQGlHW2NCHwP++83lqX6EjD4k/R99f7jPqWul2nkOMRl
         7be6WLDtDjZaH3k7TMc9niLIXncx7pvmbWzw7MJkalHLUSAEQEoV44IsnDityNDUcslV
         TswvNDgkYiYBFE4WDsdgzb/CTYKeypGx0aaKzSPkmx4iI2JJhXRuGEzyuCOlR/qBEIyD
         2VXRFnV7Rdek/wlK//Bs1F7Pfr0pMTwsntTKQ9qhy3xAllIvY0pTiG1hdQ7myQmlsCn3
         gZzAzDz1jhqKrUjPYlEFDKN2SZKlm8Z4FSQhruEVKM/6jh60x1fOhCHs8ZecPz/H/VmL
         eIwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9XQPcfyOFkdJK9ts0NuvCTE8op2nAqCI6SEF7SQNcfA=;
        fh=LOAiAA1YTS+5NY+N6jz0tKCfp412+rEgWXutdbptSOQ=;
        b=fpJK0aI/mg3hyxTtnCn4lWSy9OzXYl6nfr8JjWyirmZ7lazVtW2iavzexIDhCPlX0B
         X2RxBvklAEJuxd0VAq99uUNeTBgsq/Mi6BVFBdQOY/L54e03a3WL8GOiFiYYckoLnB69
         JGmkwLHK1mj4W9PIZ3JQCo7LwRoP6hXmBWeyp/ODnQ9/hZ0tWOPPa7+mvbXzviXo6ltn
         XZXmSY0AsMmeFr8CTP7TXHRUhU8OR3/YFhWnMv0ZjmXp7QYbEOoMH/V1jpt/CZBQZRIX
         GYWcD7fm0G9zsQnK+MLzGnaD7mqAw+Ld8DCyC599GitwvTF1ypjbJe//HApHKi/RB6yt
         NKdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793640006; x=1794244806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9XQPcfyOFkdJK9ts0NuvCTE8op2nAqCI6SEF7SQNcfA=;
        b=P241Bu5QSeJJOrONz7zqWzkUCPyPOf+1OJVvfqQIhmL2fQGoTY9CiiJrzzHT4NjbmJ
         U51F9UlgUyNGzVh8BwkGtEp5B8qxGw+2oHgpQajpF6OTHxkxOdHBn4vJaJEZy/Ijr+uf
         7AOAorXfTZI4boQWTrvKmLq28ofFtIYdwPGHcvCxLfl8quq/ivTaUlDQ3oIvsaj7WXuz
         23PtbxiWwaOqewynb9gNdHjyOh1bk3EUhYTL6AQIAq2xDWL0B4Mz44wmbERPEB0n/BDL
         G5TNhSsNUo71PgGtHaTHoyhMRMSySiFgLM1gGLoqP5KdjHy01gFltIs6FiKsDd1gO5u8
         pBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793640006; x=1794244806;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9XQPcfyOFkdJK9ts0NuvCTE8op2nAqCI6SEF7SQNcfA=;
        b=mV8BWxB2hgfvAeHti/s2l7WsCScB8euN9khw/oGZKhvB2NQWYFbECx1QLZPmXh5NRG
         GxjhyioAHnS47iOMfhROZEqIM0gyY+p7TQG/I8MeIDETU1AxojwIRRoKRII6IkriOedP
         ymRuOqj3zT+M4wjJW/YoHRMtUFtTxFwUaaqo8nMdYsVimaPQ3fYYtUAThr/z7G5hYcxP
         j41BG8oq3IhJoMtS2PUsYFNLjqVuUZP5GpY6qk3OqQ4Ylm3U90ll2DB62T2V0rtaBD3N
         l4OndjM776+lR/liAqqP0Uu5Fb1syZhCKjH+I8WPKN26CShw2MKtlt/dutKLZal7zUdk
         zIjA==
X-Forwarded-Encrypted: i=1; AKwUvByUkE54UCgMe59wdA/7E9GeAAQWTwEMHqR/mxbU+kRpxzQf27/CzFoIv4XuVAx4aM24vNOkiIpTYCeQ7FIkaXI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8jzSago2/AORwPaBB5xCBxLISr3fqYMIySghz3DE5CzpAxTWz
	hNo70LYJWFekXytVBUc6EbS01zXDYASOiIiZ3M3PbfCsoTlQshr6C99t2jm5gpO7olMSv2vZ5PZ
	V3A7sGixCBRtCrlUlUBdj6IgTEe1Wgu8=
X-Gm-Gg: AYBFou0wmYqJpiQIKrOs1PaQgk3MxNFHVVAmH6cMV46chBwtI0yS2AWPa1vVoi798LV
	P0UFmQA7pli4tVJx+oZOoRozYokwRfbpEQkESpuAK2mDADOcD8USbzTjSBY8EqA4huxymSTDUbI
	W6psUnjK0jiDTDgdZd+vezFF0V692PQPZkcrFgXDUQK+MMFJVcWxfRKPOROINi7ROl1hxSSQZ+w
	sieBpG0NVIJoWEzfP1tCnsWMDPZ+vcr/0PkDBkZTy6M2rJmLN680wMajGhTPRs1TKRxmpQOu5Vr
	83BkbkXt5SGOiO+OY47/SOHNRWdQaLT4MTFi28kMpczVY+dnvLxWCWORCwVI+ROMBdlRsI05y1s
	NwS5Qls3NblH2Kh7ONdS7VdwIQCmyD8ii8fUrjjhslAAqxrTHO0TdLdEnbSrE63RGMTT849cucM
	caGKkcYrg+1HmU3+vG+KgkwaMGi+uEbcNPc3/shbOxCZUohWRANxWyXiIH
X-Received: by 2002:a05:690c:5:b0:8ab:4a67:71b9 with SMTP id
 00721157ae682-8b2b675a0c4mr86678287b3.29.1793640004741; Mon, 02 Nov 2026
 09:20:04 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pm-bluetooth-objects-candidate-0245-v9-6b34bc036455ad3dd4ea-0@gmail.com>
 <pm-bluetooth-objects-candidate-0245-v9-6b34bc036455ad3dd4ea-1@gmail.com>
In-Reply-To: <pm-bluetooth-objects-candidate-0245-v9-6b34bc036455ad3dd4ea-1@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 2 Nov 2026 12:19:52 -0500
X-Gm-Features: AclHuK_RuQl60D_Huk7Lsn2Vc4PHSH3flbovEIsgSp22IjZR_ACNlMYB7eo1T_k
Message-ID: <CABBYNZLzkgTd5epQBt3rinr6kQxNFbFx7jg4gNJ3kya1=gb2kA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: hci_sync: Fix remaining advertising
 instance UAFs
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cen,

On Fri, Oct 30, 2026 at 10:27=E2=80=AFAM Cen Zhang <zzzccc427@gmail.com> wr=
ote:
>
> hci_enable_ext_advertising_sync() looks up the advertising instance
> without hdev->lock and then reads it, while HCI event processing can
> free the instance under the lock:
>
>   Request work                    HCI event work
>   hci_enable_ext_advertising_sync()
>     adv =3D hci_find_adv_instance()
>                                   hci_cc_le_clear_adv_sets()
>                                     hci_dev_lock(hdev)
>                                     hci_remove_adv_instance()
>                                       kfree(adv)
>                                     hci_dev_unlock(hdev)
>     reads adv->enabled
>
> Since the conversion to hci_sync, the advertising request paths run
> without hdev->lock, and the periodic advertising, advertising timeout
> and mesh code added later does the same, while management commands and
> HCI event processing still add and free instances under the lock. The
> same unlocked use exists in:
>
>  - hci_set_adv_data_sync(), hci_disable_ext_adv_instance_sync(),
>    hci_remove_ext_adv_instance_sync(), the periodic advertising enable
>    and disable helpers, hci_schedule_adv_instance_sync(),
>    adv_expire_sync() and set_advertising_complete()
>  - hci_enable_advertising_sync() and hci_start_per_adv_sync(), which
>    keep the instance across HCI commands
>  - hci_remove_advertising_sync() and hci_clear_adv_instance_sync(),
>    which keep the next instance as a pointer
>  - mesh_send_sync(), which adds the mesh instance
>  - the walks of hdev->adv_instances in hci_dev_open_sync(),
>    hci_dev_close_sync(), hci_resume_advertising_sync() and
>    hci_powered_update_adv_sync()
>
> Fix them as commit cdc36db204ff ("Bluetooth: hci_sync: Fix advertising
> data UAFs") does for the extended advertising data paths: look the
> instance up under hdev->lock, copy what is needed, and release the lock
> before a command is sent, since command completion handlers take it.
> Keep the next instance as an instance number. Walks that send no
> command hold the lock, as hci_clear_adv_sync() does. The resume and
> power on walks send a command per instance and cannot hold it, so they
> copy the instance numbers under the lock first, as commit cac164b6246f
> ("Bluetooth: hci_sync: Copy the LE accept list under hdev->lock") does
> for the accept list.
>
> KASAN report as below:
>
>     BUG: KASAN: slab-use-after-free in
>      hci_enable_ext_advertising_sync+0x2fd/0x330
>     Read of size 1 at addr ffff88811673b810 by task kworker/u17:0/492
>
>     Workqueue: hci0 hci_cmd_sync_work
>     Call Trace:
>      hci_enable_ext_advertising_sync+0x2fd/0x330
>      add_ext_adv_data_sync+0x1f8/0x250
>      hci_cmd_sync_work+0x1b3/0x450
>
>     Allocated by task 490:
>      hci_add_adv_instance+0x627/0x960
>      add_ext_adv_params+0x4d4/0xaf0
>      hci_sock_sendmsg+0x128b/0x22e0
>
>     Freed by task 495:
>      kfree+0x307/0x580
>      hci_remove_adv_instance+0x226/0x4f0
>      hci_cc_le_clear_adv_sets+0x2a5/0x400
>      hci_cmd_complete_evt+0x373/0xab0
>      hci_event_packet+0x4e8/0xc70
>      hci_rx_work+0x367/0xf00
>
>     The buggy address belongs to the object at ffff88811673b800
>      which belongs to the cache kmalloc-1k of size 1024
>     The buggy address is located 16 bytes inside of
>      freed 1024-byte region [ffff88811673b800, ffff88811673bc00)
>
> Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue=
 set 2")
> Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connec=
tions")
> Fixes: c249ea9b4309 ("Bluetooth: Move Adv Instance timer to hci_sync")
> Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
> Assisted-by: LLM
>
>  net/bluetooth/hci_sync.c | 296 +++++++++++++++++++++++++++++----------
>  net/bluetooth/mgmt.c     |  34 ++++-
>  2 files changed, 252 insertions(+), 78 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 9d71ce96bd8ec..72533236ee819 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -489,7 +489,8 @@ static void cancel_adv_timeout(struct hci_dev *hdev)
>  int hci_clear_adv_instance_sync(struct hci_dev *hdev, struct sock *sk,
>                                 u8 instance, bool force)
>  {
> -       struct adv_info *adv_instance, *n, *next_instance =3D NULL;
> +       struct adv_info *adv_instance, *n;
> +       u8 next_instance =3D 0;
>         int err;
>         u8 rem_inst;
>
> @@ -497,12 +498,20 @@ int hci_clear_adv_instance_sync(struct hci_dev *hde=
v, struct sock *sk,
>         if (!instance || hdev->cur_adv_instance =3D=3D instance)
>                 cancel_adv_timeout(hdev);
>
> +       /* This is safe as long as there is no command send while the
> +        * lock is held.
> +        */
> +       hci_dev_lock(hdev);
> +
>         /* Get the next instance to advertise BEFORE we remove
>          * the current one. This can be the same instance again
>          * if there is only one instance.
>          */
> -       if (instance && hdev->cur_adv_instance =3D=3D instance)
> -               next_instance =3D hci_get_next_instance(hdev, instance);
> +       if (instance && hdev->cur_adv_instance =3D=3D instance) {
> +               adv_instance =3D hci_get_next_instance(hdev, instance);
> +               if (adv_instance)
> +                       next_instance =3D adv_instance->instance;
> +       }
>
>         if (instance =3D=3D 0x00) {
>                 list_for_each_entry_safe(adv_instance, n, &hdev->adv_inst=
ances,
> @@ -521,9 +530,8 @@ int hci_clear_adv_instance_sync(struct hci_dev *hdev,=
 struct sock *sk,
>                 if (force || (adv_instance && adv_instance->timeout &&
>                               !adv_instance->remaining_time)) {
>                         /* Don't advertise a removed instance. */
> -                       if (next_instance &&
> -                           next_instance->instance =3D=3D instance)
> -                               next_instance =3D NULL;
> +                       if (next_instance =3D=3D instance)
> +                               next_instance =3D 0;
>
>                         err =3D hci_remove_adv_instance(hdev, instance);
>                         if (!err)
> @@ -531,12 +539,13 @@ int hci_clear_adv_instance_sync(struct hci_dev *hde=
v, struct sock *sk,
>                 }
>         }
>
> +       hci_dev_unlock(hdev);
> +
>         if (!hdev_is_powered(hdev) || hci_dev_test_flag(hdev, HCI_ADVERTI=
SING))
>                 return 0;
>
>         if (next_instance && !ext_adv_capable(hdev))
> -               return hci_schedule_adv_instance_sync(hdev,
> -                                                     next_instance->inst=
ance,
> +               return hci_schedule_adv_instance_sync(hdev, next_instance=
,
>                                                       false);
>
>         return 0;
> @@ -1214,16 +1223,26 @@ static int hci_disable_ext_adv_instance_sync(stru=
ct hci_dev *hdev, u8 instance)
>         struct hci_cp_ext_adv_set *set;
>         u8 data[sizeof(*cp) + sizeof(*set) * 1];
>         u8 size;
> -       struct adv_info *adv =3D NULL;
> +       u8 handle =3D instance;
>
>         /* If request specifies an instance that doesn't exist, fail */
>         if (instance > 0) {
> +               struct adv_info *adv;
> +               bool enabled;
> +
> +               hci_dev_lock(hdev);
>                 adv =3D hci_find_adv_instance(hdev, instance);
> -               if (!adv)
> +               if (!adv) {
> +                       hci_dev_unlock(hdev);
>                         return -EINVAL;
> +               }
> +
> +               enabled =3D adv->enabled;
> +               handle =3D adv->handle;
> +               hci_dev_unlock(hdev);
>
>                 /* If not enabled there is nothing to do */
> -               if (!adv->enabled)
> +               if (!enabled)
>                         return 0;
>         }
>
> @@ -1236,7 +1255,7 @@ static int hci_disable_ext_adv_instance_sync(struct=
 hci_dev *hdev, u8 instance)
>         cp->num_of_sets =3D !!instance;
>         cp->enable =3D 0x00;
>
> -       set->handle =3D adv ? adv->handle : instance;
> +       set->handle =3D handle;
>
>         size =3D sizeof(*cp) + sizeof(*set) * cp->num_of_sets;
>
> @@ -1374,14 +1393,21 @@ static int hci_set_ext_adv_data_sync(struct hci_d=
ev *hdev, u8 instance)
>  }
>
>  static int hci_set_adv_data_sync(struct hci_dev *hdev, u8 instance)
> +       __context_unsafe(/* conditional locking */)
>  {
>         struct hci_cp_le_set_adv_data cp;
>         u8 len;
>
>         memset(&cp, 0, sizeof(cp));
>
> +       if (instance)
> +               hci_dev_lock(hdev);
> +
>         len =3D eir_create_adv_data(hdev, instance, cp.data, sizeof(cp.da=
ta));
>
> +       if (instance)
> +               hci_dev_unlock(hdev);
> +
>         /* There's nothing to do if the data hasn't changed */
>         if (hdev->adv_data_len =3D=3D len &&
>             memcmp(cp.data, hdev->adv_data, len) =3D=3D 0)
> @@ -1670,17 +1696,33 @@ int hci_enable_ext_advertising_sync(struct hci_de=
v *hdev, u8 instance)
>         struct hci_cp_le_set_ext_adv_enable *cp;
>         struct hci_cp_ext_adv_set *set;
>         u8 data[sizeof(*cp) + sizeof(*set) * 1];
> -       struct adv_info *adv;
> +       u8 handle =3D instance;
> +       u16 duration =3D 0;
>
>         if (instance > 0) {
> +               struct adv_info *adv;
> +
> +               hci_dev_lock(hdev);
>                 adv =3D hci_find_adv_instance(hdev, instance);
> -               if (!adv)
> +               if (!adv) {
> +                       hci_dev_unlock(hdev);
>                         return -EINVAL;
> +               }
>                 /* If already enabled there is nothing to do */
> -               if (adv->enabled)
> +               if (adv->enabled) {
> +                       hci_dev_unlock(hdev);
>                         return 0;
> -       } else {
> -               adv =3D NULL;
> +               }
> +
> +               handle =3D adv->handle;
> +
> +               /* Set duration per instance since controller is
> +                * responsible for scheduling it.
> +                */
> +               if (adv->timeout)
> +                       duration =3D adv->mesh ? adv->timeout :
> +                                              adv->timeout * MSEC_PER_SE=
C;
> +               hci_dev_unlock(hdev);
>         }
>
>         cp =3D (void *)data;
> @@ -1693,18 +1735,10 @@ int hci_enable_ext_advertising_sync(struct hci_de=
v *hdev, u8 instance)
>
>         memset(set, 0, sizeof(*set));
>
> -       set->handle =3D adv ? adv->handle : instance;
> -
> -       /* Set duration per instance since controller is responsible for
> -        * scheduling it.
> -        */
> -       if (adv && adv->timeout) {
> -               u16 duration =3D adv->mesh ? adv->timeout :
> -                                          adv->timeout * MSEC_PER_SEC;
> +       set->handle =3D handle;
>
> -               /* Time =3D N * 10 ms */
> -               set->duration =3D cpu_to_le16(duration / 10);
> -       }
> +       /* Time =3D N * 10 ms */
> +       set->duration =3D cpu_to_le16(duration / 10);
>
>         /* Track which instance owns the advertising set since the handle
>          * alone is ambiguous when instances share handle 0x00, see
> @@ -1736,11 +1770,15 @@ int hci_start_ext_adv_sync(struct hci_dev *hdev, =
u8 instance)
>  int hci_disable_per_advertising_sync(struct hci_dev *hdev, u8 instance)
>  {
>         struct hci_cp_le_set_per_adv_enable cp;
> -       struct adv_info *adv =3D NULL;
> +       struct adv_info *adv;
> +       bool enabled;
>
>         /* If periodic advertising already disabled there is nothing to d=
o. */
> +       hci_dev_lock(hdev);
>         adv =3D hci_find_adv_instance(hdev, instance);
> -       if (!adv || !adv->periodic_enabled)
> +       enabled =3D adv && adv->periodic_enabled;
> +       hci_dev_unlock(hdev);
> +       if (!enabled)
>                 return 0;
>
>         memset(&cp, 0, sizeof(cp));
> @@ -1809,11 +1847,15 @@ static int hci_set_per_adv_data_sync(struct hci_d=
ev *hdev, u8 instance)
>  static int hci_enable_per_advertising_sync(struct hci_dev *hdev, u8 inst=
ance)
>  {
>         struct hci_cp_le_set_per_adv_enable cp;
> -       struct adv_info *adv =3D NULL;
> +       struct adv_info *adv;
> +       bool enabled;
>
>         /* If periodic advertising already enabled there is nothing to do=
. */
> +       hci_dev_lock(hdev);
>         adv =3D hci_find_adv_instance(hdev, instance);
> -       if (adv && adv->periodic_enabled)
> +       enabled =3D adv && adv->periodic_enabled;
> +       hci_dev_unlock(hdev);
> +       if (enabled)
>                 return 0;
>
>         memset(&cp, 0, sizeof(cp));
> @@ -1828,25 +1870,36 @@ static int hci_enable_per_advertising_sync(struct=
 hci_dev *hdev, u8 instance)
>  /* Checks if periodic advertising data contains a Basic Announcement and=
 if it
>   * does generates a Broadcast ID and add Broadcast Announcement.
>   */
> -static int hci_adv_bcast_annoucement(struct hci_dev *hdev, struct adv_in=
fo *adv)
> +static int hci_adv_bcast_annoucement(struct hci_dev *hdev, u8 instance)
>  {
> +       struct adv_info *adv;
>         u8 bid[3];
>         u8 ad[HCI_MAX_EXT_AD_LENGTH];
>         u8 len;
> +       int err =3D 0;
>
> -       /* Skip if NULL adv as instance 0x00 is used for general purpose
> +       /* Skip if instance 0x00 as it is used for general purpose
>          * advertising so it cannot used for the likes of Broadcast Annou=
ncement
>          * as it can be overwritten at any point.
>          */
> -       if (!adv)
> +       if (!instance)
>                 return 0;
>
> +       hci_dev_lock(hdev);
> +
> +       /* The instance may have been removed while waiting for the
> +        * controller, in which case there is nothing to announce.
> +        */
> +       adv =3D hci_find_adv_instance(hdev, instance);
> +       if (!adv)
> +               goto unlock;
> +
>         /* Check if PA data doesn't contains a Basic Audio Announcement t=
hen
>          * there is nothing to do.
>          */
>         if (!eir_get_service_data(adv->per_adv_data, adv->per_adv_data_le=
n,
>                                   0x1851, NULL))
> -               return 0;
> +               goto unlock;
>
>         /* Check if advertising data already has a Broadcast Announcement=
 since
>          * the process may want to control the Broadcast ID directly and =
in that
> @@ -1854,34 +1907,44 @@ static int hci_adv_bcast_annoucement(struct hci_d=
ev *hdev, struct adv_info *adv)
>          */
>         if (eir_get_service_data(adv->adv_data, adv->adv_data_len, 0x1852=
,
>                                  NULL))
> -               return 0;
> +               goto unlock;
>
>         /* Generate Broadcast ID */
>         get_random_bytes(bid, sizeof(bid));
>         len =3D eir_append_service_data(ad, 0, 0x1852, bid, sizeof(bid));
>         if (adv->adv_data_len > sizeof(ad) - len) {
>                 bt_dev_err(hdev, "No room for Broadcast Announcement");
> -               return -EINVAL;
> +               err =3D -EINVAL;
> +               goto unlock;
>         }
>
>         memcpy(ad + len, adv->adv_data, adv->adv_data_len);
> -       hci_set_adv_instance_data(hdev, adv->instance, len + adv->adv_dat=
a_len,
> +       hci_set_adv_instance_data(hdev, instance, len + adv->adv_data_len=
,
>                                   ad, 0, NULL);
>
> -       return hci_update_adv_data_sync(hdev, adv->instance);
> +       hci_dev_unlock(hdev);
> +
> +       return hci_update_adv_data_sync(hdev, instance);
> +
> +unlock:
> +       hci_dev_unlock(hdev);
> +       return err;
>  }
>
>  int hci_start_per_adv_sync(struct hci_dev *hdev, u8 instance, u8 sid,
>                            u8 data_len, u8 *data, u32 flags, u16 min_inte=
rval,
>                            u16 max_interval, u16 sync_interval)
>  {
> -       struct adv_info *adv =3D NULL;
> +       struct adv_info *adv;
> +       u8 bcast_instance =3D 0;
>         int err;
>         bool added =3D false;
>
>         hci_disable_per_advertising_sync(hdev, instance);
>
>         if (instance) {
> +               hci_dev_lock(hdev);
> +
>                 adv =3D hci_find_adv_instance(hdev, instance);
>                 if (adv) {
>                         if (sid !=3D HCI_SID_INVALID && adv->sid !=3D sid=
) {
> @@ -1890,6 +1953,7 @@ int hci_start_per_adv_sync(struct hci_dev *hdev, u8=
 instance, u8 sid,
>                                  */
>                                 adv =3D hci_find_adv_sid(hdev, sid);
>                                 if (!adv) {
> +                                       hci_dev_unlock(hdev);
>                                         bt_dev_err(hdev,
>                                                    "Unable to find adv_in=
fo");
>                                         return -EINVAL;
> @@ -1908,11 +1972,17 @@ int hci_start_per_adv_sync(struct hci_dev *hdev, =
u8 instance, u8 sid,
>                                                    data_len, data,
>                                                    sync_interval,
>                                                    sync_interval);
> -                       if (IS_ERR(adv))
> +                       if (IS_ERR(adv)) {
> +                               hci_dev_unlock(hdev);
>                                 return PTR_ERR(adv);
> +                       }
>                         adv->pending =3D false;
>                         added =3D true;
>                 }
> +
> +               bcast_instance =3D adv->instance;
> +
> +               hci_dev_unlock(hdev);
>         }
>
>         /* Start advertising */
> @@ -1920,7 +1990,7 @@ int hci_start_per_adv_sync(struct hci_dev *hdev, u8=
 instance, u8 sid,
>         if (err < 0)
>                 goto fail;
>
> -       err =3D hci_adv_bcast_annoucement(hdev, adv);
> +       err =3D hci_adv_bcast_annoucement(hdev, bcast_instance);
>         if (err < 0)
>                 goto fail;
>
> @@ -1940,8 +2010,11 @@ int hci_start_per_adv_sync(struct hci_dev *hdev, u=
8 instance, u8 sid,
>         return 0;
>
>  fail:
> -       if (added)
> +       if (added) {
> +               hci_dev_lock(hdev);
>                 hci_remove_adv_instance(hdev, instance);
> +               hci_dev_unlock(hdev);
> +       }
>
>         return err;
>  }
> @@ -1971,6 +2044,7 @@ int hci_enable_advertising_sync(struct hci_dev *hde=
v)
>         u8 own_addr_type, enable =3D 0x01;
>         bool connectable;
>         u16 adv_min_interval, adv_max_interval;
> +       bool scannable;
>         u32 flags;
>         u8 status;
>
> @@ -1978,8 +2052,25 @@ int hci_enable_advertising_sync(struct hci_dev *hd=
ev)
>                 return hci_enable_ext_advertising_sync(hdev,
>                                                        hdev->cur_adv_inst=
ance);
>
> +       /* Snapshot the instance under hdev->lock since it may be removed
> +        * while waiting for the commands below to complete.
> +        */
> +       hci_dev_lock(hdev);
> +
>         flags =3D hci_adv_instance_flags(hdev, hdev->cur_adv_instance);
> +       scannable =3D hci_adv_instance_is_scannable(hdev,
> +                                                 hdev->cur_adv_instance)=
;
> +
>         adv_instance =3D hci_find_adv_instance(hdev, hdev->cur_adv_instan=
ce);
> +       if (adv_instance) {
> +               adv_min_interval =3D adv_instance->min_interval;
> +               adv_max_interval =3D adv_instance->max_interval;
> +       } else {
> +               adv_min_interval =3D hdev->le_adv_min_interval;
> +               adv_max_interval =3D hdev->le_adv_max_interval;
> +       }
> +
> +       hci_dev_unlock(hdev);
>
>         /* If the "connectable" instance flag was not set, then choose be=
tween
>          * ADV_IND and ADV_NONCONN_IND based on the global connectable se=
tting.
> @@ -2013,18 +2104,10 @@ int hci_enable_advertising_sync(struct hci_dev *h=
dev)
>
>         memset(&cp, 0, sizeof(cp));
>
> -       if (adv_instance) {
> -               adv_min_interval =3D adv_instance->min_interval;
> -               adv_max_interval =3D adv_instance->max_interval;
> -       } else {
> -               adv_min_interval =3D hdev->le_adv_min_interval;
> -               adv_max_interval =3D hdev->le_adv_max_interval;
> -       }
> -
>         if (connectable) {
>                 cp.type =3D LE_ADV_IND;
>         } else {
> -               if (hci_adv_instance_is_scannable(hdev, hdev->cur_adv_ins=
tance))
> +               if (scannable)
>                         cp.type =3D LE_ADV_SCAN_IND;
>                 else
>                         cp.type =3D LE_ADV_NONCONN_IND;
> @@ -2077,8 +2160,16 @@ int hci_remove_ext_adv_instance_sync(struct hci_de=
v *hdev, u8 instance,
>                 return err;
>
>         /* If request specifies an instance that doesn't exist, fail */
> -       if (instance > 0 && !hci_find_adv_instance(hdev, instance))
> -               return -EINVAL;
> +       if (instance > 0) {
> +               bool exists;
> +
> +               hci_dev_lock(hdev);
> +               exists =3D !!hci_find_adv_instance(hdev, instance);
> +               hci_dev_unlock(hdev);
> +
> +               if (!exists)
> +                       return -EINVAL;
> +       }
>
>         return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_REMOVE_ADV_SET,
>                                         sizeof(instance), &instance, 0,
> @@ -2109,9 +2200,13 @@ int hci_schedule_adv_instance_sync(struct hci_dev =
*hdev, u8 instance,
>         if (hdev->adv_instance_timeout)
>                 return -EBUSY;
>
> +       hci_dev_lock(hdev);
> +
>         adv =3D hci_find_adv_instance(hdev, instance);
> -       if (!adv)
> +       if (!adv) {
> +               hci_dev_unlock(hdev);
>                 return -ENOENT;
> +       }
>
>         /* A zero timeout means unlimited advertising. As long as there i=
s
>          * only one instance, duration should be ignored. We still set a =
timeout
> @@ -2141,6 +2236,8 @@ int hci_schedule_adv_instance_sync(struct hci_dev *=
hdev, u8 instance,
>                                                secs_to_jiffies(timeout));
>         }
>
> +       hci_dev_unlock(hdev);
> +
>         /* If we're just re-scheduling the same instance again then do no=
t
>          * execute any HCI commands. This happens when a single instance =
is
>          * being advertised.
> @@ -2238,7 +2335,7 @@ static int hci_remove_adv_sync(struct hci_dev *hdev=
, u8 instance,
>  int hci_remove_advertising_sync(struct hci_dev *hdev, struct sock *sk,
>                                 u8 instance, bool force)
>  {
> -       struct adv_info *next =3D NULL;
> +       u8 next_instance =3D 0;
>         int err;
>
>         /* Cancel any timeout concerning the removed instance(s). */
> @@ -2249,20 +2346,34 @@ int hci_remove_advertising_sync(struct hci_dev *h=
dev, struct sock *sk,
>          * the current one. This can be the same instance again
>          * if there is only one instance.
>          */
> -       if (hdev->cur_adv_instance =3D=3D instance)
> +       if (hdev->cur_adv_instance =3D=3D instance) {
> +               struct adv_info *next;
> +
> +               hci_dev_lock(hdev);
>                 next =3D hci_get_next_instance(hdev, instance);
> +               if (next)
> +                       next_instance =3D next->instance;
> +               hci_dev_unlock(hdev);
> +       }
>
>         if (!instance) {
>                 err =3D hci_clear_adv_sync(hdev, sk, force);
>                 if (err)
>                         return err;
>         } else {
> -               struct adv_info *adv =3D hci_find_adv_instance(hdev, inst=
ance);
> +               struct adv_info *adv;
> +               bool remove;
> +
> +               hci_dev_lock(hdev);
> +               adv =3D hci_find_adv_instance(hdev, instance);
> +               remove =3D force ||
> +                        (adv && adv->timeout && !adv->remaining_time);
> +               hci_dev_unlock(hdev);
>
> -               if (force || (adv && adv->timeout && !adv->remaining_time=
)) {
> +               if (remove) {
>                         /* Don't advertise a removed instance. */
> -                       if (next && next->instance =3D=3D instance)
> -                               next =3D NULL;
> +                       if (next_instance =3D=3D instance)
> +                               next_instance =3D 0;
>
>                         err =3D hci_remove_adv_sync(hdev, instance, sk);
>                         if (err)
> @@ -2273,8 +2384,8 @@ int hci_remove_advertising_sync(struct hci_dev *hde=
v, struct sock *sk,
>         if (!hdev_is_powered(hdev) || hci_dev_test_flag(hdev, HCI_ADVERTI=
SING))
>                 return 0;
>
> -       if (next && !ext_adv_capable(hdev))
> -               hci_schedule_adv_instance_sync(hdev, next->instance, fals=
e);
> +       if (next_instance && !ext_adv_capable(hdev))
> +               hci_schedule_adv_instance_sync(hdev, next_instance, false=
);
>
>         return 0;
>  }
> @@ -2732,10 +2843,33 @@ static int hci_pause_advertising_sync(struct hci_=
dev *hdev)
>         return 0;
>  }
>
> +/* Copy the instance identifiers under hdev->lock, in list order, so tha=
t
> + * the caller can walk them while waiting for HCI commands to complete.
> + */
> +static u8 *adv_instance_list_copy(struct hci_dev *hdev, size_t *n)
> +{
> +       struct adv_info *adv;
> +       size_t i =3D 0;
> +       u8 *ids;
> +
> +       hci_dev_lock(hdev);
> +
> +       *n =3D list_count_nodes(&hdev->adv_instances);
> +       ids =3D kvzalloc_objs(u8, *n);
> +       if (!ids)
> +               goto unlock;
> +
> +       list_for_each_entry(adv, &hdev->adv_instances, list)
> +               ids[i++] =3D adv->instance;
> +
> +unlock:
> +       hci_dev_unlock(hdev);
> +       return ids;
> +}
> +
>  /* This function enables all user advertising instances */
>  static int hci_resume_advertising_sync(struct hci_dev *hdev)
>  {
> -       struct adv_info *adv, *tmp;
>         int err =3D 0;
>
>         /* If advertising has not been paused there is nothing  to do. */
> @@ -2752,18 +2886,27 @@ static int hci_resume_advertising_sync(struct hci=
_dev *hdev)
>         bt_dev_dbg(hdev, "Resuming advertising instances");
>
>         if (ext_adv_capable(hdev)) {
> +               size_t i, n;
> +               u8 *ids;
> +
> +               ids =3D adv_instance_list_copy(hdev, &n);
> +               if (!ids)
> +                       return -ENOMEM;
> +
>                 /* Call for each tracked instance to be re-enabled */
> -               list_for_each_entry_safe(adv, tmp, &hdev->adv_instances, =
list) {
> +               for (i =3D 0; i < n; i++) {
>                         err =3D hci_enable_ext_advertising_sync(hdev,
> -                                                             adv->instan=
ce);
> +                                                             ids[i]);
>                         if (!err)
>                                 continue;
>
>                         /* If the instance cannot be resumed remove it */
> -                       hci_remove_ext_adv_instance_sync(hdev, adv->insta=
nce,
> +                       hci_remove_ext_adv_instance_sync(hdev, ids[i],
>                                                          NULL);
>                 }
>
> +               kvfree(ids);
> +
>                 /* If current advertising instance is set to instance 0x0=
0
>                  * then we need to re-enable it.
>                  */
> @@ -3585,7 +3728,8 @@ int hci_write_le_host_supported_sync(struct hci_dev=
 *hdev, u8 le, u8 simul)
>
>  static int hci_powered_update_adv_sync(struct hci_dev *hdev)
>  {
> -       struct adv_info *adv, *tmp;
> +       size_t i, n;
> +       u8 *ids;
>         int err;
>
>         if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
> @@ -3621,9 +3765,15 @@ static int hci_powered_update_adv_sync(struct hci_=
dev *hdev)
>                         hci_enable_advertising_sync(hdev);
>         }
>
> +       ids =3D adv_instance_list_copy(hdev, &n);
> +       if (!ids)
> +               return -ENOMEM;
> +
>         /* Call for each tracked instance to be scheduled */
> -       list_for_each_entry_safe(adv, tmp, &hdev->adv_instances, list)
> -               hci_schedule_adv_instance_sync(hdev, adv->instance, true)=
;
> +       for (i =3D 0; i < n; i++)
> +               hci_schedule_adv_instance_sync(hdev, ids[i], true);
> +
> +       kvfree(ids);
>
>         return 0;
>  }
> @@ -5597,7 +5747,9 @@ int hci_dev_open_sync(struct hci_dev *hdev)
>         if (!ret) {
>                 hci_dev_hold(hdev);
>                 hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
> +               hci_dev_lock(hdev);
>                 hci_adv_instances_set_rpa_expired(hdev, true);
> +               hci_dev_unlock(hdev);
>                 set_bit(HCI_UP, &hdev->flags);
>                 hci_sock_dev_event(hdev, HCI_DEV_UP);
>                 hci_leds_update_powered(hdev, true);
> @@ -5740,8 +5892,10 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>
>                 cancel_delayed_work_sync(&hdev->rpa_expired);
>
> +               hci_dev_lock(hdev);
>                 list_for_each_entry(adv_instance, &hdev->adv_instances, l=
ist)
>                         cancel_delayed_work_sync(&adv_instance->rpa_expir=
ed_cb);
> +               hci_dev_unlock(hdev);
>         }
>
>         /* Avoid potential lockdep warnings from the *_flush() calls by
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 3cb4f9ece83cb..d8b1b9b241eb7 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2341,6 +2341,9 @@ static int mesh_send_sync(struct hci_dev *hdev, voi=
d *data)
>
>         timeout =3D 1000;
>         duration =3D send->cnt * INTERVAL_TO_MS(hdev->le_adv_max_interval=
);
> +
> +       hci_dev_lock(hdev);
> +
>         adv =3D hci_add_adv_instance(hdev, instance, 0,
>                                    send->adv_data_len, send->adv_data,
>                                    0, NULL,
> @@ -2375,6 +2378,8 @@ static int mesh_send_sync(struct hci_dev *hdev, voi=
d *data)
>                 instance =3D 0;
>         }
>
> +       hci_dev_unlock(hdev);
> +
>         if (instance)
>                 return hci_schedule_adv_instance_sync(hdev, instance, tru=
e);
>
> @@ -4013,22 +4018,34 @@ static int user_passkey_neg_reply(struct sock *sk=
, struct hci_dev *hdev,
>  static int adv_expire_sync(struct hci_dev *hdev, u32 flags)
>  {
>         struct adv_info *adv_instance;
> +       u8 instance;
> +
> +       hci_dev_lock(hdev);
>
>         adv_instance =3D hci_find_adv_instance(hdev, hdev->cur_adv_instan=
ce);
>         if (!adv_instance)
> -               return 0;
> +               goto unlock;
>
>         /* stop if current instance doesn't need to be changed */
>         if (!(adv_instance->flags & flags))
> -               return 0;
> +               goto unlock;
>
>         cancel_adv_timeout(hdev);
>
>         adv_instance =3D hci_get_next_instance(hdev, adv_instance->instan=
ce);
>         if (!adv_instance)
> -               return 0;
> +               goto unlock;
> +
> +       instance =3D adv_instance->instance;
> +
> +       hci_dev_unlock(hdev);
>
> -       hci_schedule_adv_instance_sync(hdev, adv_instance->instance, true=
);
> +       hci_schedule_adv_instance_sync(hdev, instance, true);
> +
> +       return 0;
> +
> +unlock:
> +       hci_dev_unlock(hdev);
>
>         return 0;
>  }
> @@ -6610,12 +6627,15 @@ static void set_advertising_complete(struct hci_d=
ev *hdev, void *data, int err)
>
>         instance =3D hdev->cur_adv_instance;
>         if (!instance) {
> +               hci_dev_lock(hdev);
>                 adv_instance =3D list_first_entry_or_null(&hdev->adv_inst=
ances,
>                                                         struct adv_info, =
list);
> -               if (!adv_instance)
> -                       return;
> +               if (adv_instance)
> +                       instance =3D adv_instance->instance;
> +               hci_dev_unlock(hdev);
>
> -               instance =3D adv_instance->instance;
> +               if (!instance)
> +                       return;
>         }
>
>         err =3D hci_schedule_adv_instance_sync(hdev, instance, true);

netdev sashiko instance found a problem:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/pm-bluetooth-objects-ca=
ndidate-0245-v9-6b34bc036455ad3dd4ea-0%40gmail.com
and I sort of agree that if we could avoid doing an allocation using
the stack that probably would have been better.

--=20
Luiz Augusto von Dentz
