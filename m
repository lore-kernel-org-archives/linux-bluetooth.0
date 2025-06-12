Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4794123D280;
	Thu, 12 Jun 2025 13:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749733970; cv=none; b=UXIDQILFYyxtawqSa0HJBul5qoEYORxRlK5c/+mhdQBtEo7vG0164GAjD3XRng4g/g+6fBTxmzI0Bg9H+jVELd1kNTX9UU52VSNGeqwwOnZRZUI5IqMO0++m+ZrCncR5iA1DkXDGUpTwIi3VAB64wcYsB1ye/1FDzZnfbrjL8CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749733970; c=relaxed/simple;
	bh=7UPdY64JJ72+l5O3IsGp4X0va/EyqoWVab2O6wj1VUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Caa6w4WCXow7jcXEIcFpSAzcLvUmIo9a1AFLclsnVBLg7TzpURzHVUl+ucarF7J0dVHtUux5NE6pZzz5MOIMpFILgiWCmaMbT73ETj5Aay7vkyeAPDZ76WK/zGxAvZvHoUQx5UD7YL/tf2x/iCk9rYaMt+OwY4DkHM+Lzotr1to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdRPwH/O; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdRPwH/O"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32ade3723adso9948661fa.0;
        Thu, 12 Jun 2025 06:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749733966; x=1750338766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVnHHKEy1VyvVoQknUk2ch5LzvEGfZ30fQTnWrhXBr4=;
        b=NdRPwH/OtDMt7luJiLanTXh/ZtyEnjD89TMaTsKgYq5X4zCMgGL1EvVyUCrk+aY3HM
         KKw8MkntmjTD//21SSEI+HoX/z15RfjuImxs737xe+ss/hGyci1erj5xIsg5cBVyhikD
         bigYrYCi+3tIy6gtpYmneH31n8d5zq2GBxs+sn90O5X3dSQMPEl7LzwJCLC1y3ouTcHw
         d5glsYixPgkP5Gr4789OgAY8LiGOCK8FpC1ZN6C3ZSixV8phMWGSlDFedJQJ3HSrHCKR
         n0aTH9icTU9aWEY/O/Qnrc6Z0al/ZT4V1O9I8e9mUTaXPnkHcJ7qokcP1jLPZDIwhoBA
         un6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749733966; x=1750338766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVnHHKEy1VyvVoQknUk2ch5LzvEGfZ30fQTnWrhXBr4=;
        b=JHAYeSVhT/Ftg+5rewKWXoQIbBEi2XqbthKmhUnbT2hIiL4MbiFEwUIS60BY2qqZNj
         xdORke9F2RBE4KwdbjlNqV3BLlxjvXHPvH2XDAkt2uWqWFzMRhgLVmoUNCZz5uJ5b0bD
         1bNaWS5PI+NA42f5WHyUiGxOi77Vf/Jfxf4CSjZnPgUZhOxfBRhBeTkpddjai5ffsQXG
         kj/VXUekkRlJmLvJQfG/LV1jGOqAWcb3U8YB983BmpEb4xwgeEFaBCAwPIJPZoo9hjVB
         06oxFvaI2BmwSU8dCJ9T1U0tz7voxB3sdDvp6NJH/m+uaAI/ZBwzg5ueAVE/KFt4ep9L
         u67A==
X-Forwarded-Encrypted: i=1; AJvYcCX/1moh6PFmw+pEPGeO9E+YXwBf/t41jyMg/6dDoCIsIyIqcQ4jpQ0nULrn4mCINrDiF9vRI1OdbFfTh13K@vger.kernel.org, AJvYcCXGYCHQMti9D2zN3b5cKtXE0IBHzzsoGVKYrajdcOxLvdyCotxTKbyFYoSO3FvMoOAv51ttn7AvbZRF9QE//ug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5j5N5MGQlp+WUs8ptYzKw4o7OAffyQBWSEjKT782Gnfuf5MAV
	rwrbiF137YLLIMLrOFCNTouzuwtOJ5g7YqbUS9Go6zZpYLsx33fSZnraPb9ILF4rCqiXAHjCzd+
	JNHNC8HQe2i0E0giVk8HLTfmJqUmA5Zc=
X-Gm-Gg: ASbGncvAi3YyzqqOMWoDzdKIPpmfuI1By6qwF3XawjuMiiCox/Q7/JHGAa8HPoliAQ0
	pDPPsaU/wSJQdztWOik1AHHF7vkssTsXHIazlVo8lo/ZHxXqdX2Jz6ByPxET5NmWP/djbPa72ex
	69lDAiZKwEP+jywkB1SMnyo8tRwBXs+3/bmNXd/VHqLuD/9FB/h6bX
X-Google-Smtp-Source: AGHT+IEH0CkXP4YrxtGc8WhKCJlTw/IBE6kuWlSDpVjQh43CjGs0xlQ7U17g3NKFfkHTcM8zVIQ3QV+CEytevymHcLM=
X-Received: by 2002:a2e:be03:0:b0:32b:3879:ce7f with SMTP id
 38308e7fff4ca-32b3879f2fbmr6342511fa.0.1749733965944; Thu, 12 Jun 2025
 06:12:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4e1578fb-c81d-fe9c-1aa1-26b6016866eb@salutedevices.com>
In-Reply-To: <4e1578fb-c81d-fe9c-1aa1-26b6016866eb@salutedevices.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 12 Jun 2025 09:12:33 -0400
X-Gm-Features: AX0GCFtoF8kmEfxIWY2iK9V3IKYBfPHHYIWyXIo9X4fM-6SffgStTpz0HPSfNJ8
Message-ID: <CABBYNZJPuZKifTNe5DMEaro6-4j+_7ExvKU5C6JgRZEwcbZBDw@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_sync: fix double free in 'hci_discovery_filter_clear()'
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, oxffffaa@gmail.com, kernel@salutedevices.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arseniy,

On Wed, Jun 11, 2025 at 12:31=E2=80=AFPM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> Function 'hci_discovery_filter_clear()' frees 'uuids' array and then
> sets it to NULL. There is a tiny chance of the following race:
>
> 'hci_cmd_sync_work()'
>
>  'update_passive_scan_sync()'
>
>    'hci_update_passive_scan_sync()'
>
>      'hci_discovery_filter_clear()'
>        kfree(uuids);
>
>        <-------------------------preempted-------------------------------=
->
>                                            'start_service_discovery()'
>
>                                              'hci_discovery_filter_clear(=
)'
>                                                kfree(uuids); // DOUBLE FR=
EE
>
>        <-------------------------preempted-------------------------------=
->
>
>       uuids =3D NULL;
>
> To fix it let's add locking around call  'hci_update_passive_scan_sync()'=
 in
> 'update_passive_scan_sync()'. Otherwise the following backtrace fires:
>
> [ ] ------------[ cut here ]------------
> [ ] kernel BUG at mm/slub.c:547!
> [ ] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> [ ] CPU: 3 UID: 0 PID: 246 Comm: bluetoothd Tainted: G O 6.12.19-sdkernel=
 #1
> [ ] Tainted: [O]=3DOOT_MODULE
> [ ] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> [ ] pc : __slab_free+0xf8/0x348
> [ ] lr : __slab_free+0x48/0x348
> ...
> [ ] Call trace:
> [ ]  __slab_free+0xf8/0x348
> [ ]  kfree+0x164/0x27c
> [ ]  start_service_discovery+0x1d0/0x2c0
> [ ]  hci_sock_sendmsg+0x518/0x924
> [ ]  __sock_sendmsg+0x54/0x60
> [ ]  sock_write_iter+0x98/0xf8
> [ ]  do_iter_readv_writev+0xe4/0x1c8
> [ ]  vfs_writev+0x128/0x2b0
> [ ]  do_writev+0xfc/0x118
> [ ]  __arm64_sys_writev+0x20/0x2c
> [ ]  invoke_syscall+0x68/0xf0
> [ ]  el0_svc_common.constprop.0+0x40/0xe0
> [ ]  do_el0_svc+0x1c/0x28
> [ ]  el0_svc+0x30/0xd0
> [ ]  el0t_64_sync_handler+0x100/0x12c
> [ ]  el0t_64_sync+0x194/0x198
> [ ] Code: 8b0002e6 eb17031f 54fffbe1 d503201f (d4210000)
> [ ] ---[ end trace 0000000000000000 ]---
>
> Cc: stable@vger.kernel.org
> Fixes: ad383c2c65a5 ("Bluetooth: hci_sync: Enable advertising when LL pri=
vacy is enabled")
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  net/bluetooth/hci_sync.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index e56b1cbedab90..61a9922eb820d 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3167,7 +3167,15 @@ int hci_update_scan(struct hci_dev *hdev)
>
>  static int update_passive_scan_sync(struct hci_dev *hdev, void *data)
>  {
> -       return hci_update_passive_scan_sync(hdev);
> +       int ret;
> +
> +       hci_dev_lock(hdev);
> +
> +       ret =3D hci_update_passive_scan_sync(hdev);
> +
> +       hci_dev_unlock(hdev);
> +
> +       return ret;

This deadlocks since it is a callback on hci_cmd_sync_work which shall
never use hci_dev_lock while waiting for events processed by
hci_event_packet which will attempt to do:

    hci_dev_lock(hdev);
    kfree_skb(hdev->recv_event);
    hdev->recv_event =3D skb_clone(skb, GFP_KERNEL);
    hci_dev_unlock(hdev);

This is why there are no test results because all tests seem to be failing =
now:

https://github.com/BluezTestBot/bluetooth-next/pull/2884

>  }
>
>  int hci_update_passive_scan(struct hci_dev *hdev)
> --
> 2.30.1
>


--=20
Luiz Augusto von Dentz
