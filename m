Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868A3386C3E
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787603084; cv=pass; b=dwobESiVfq2DnJm8Cf8D6xWIBwIUEf4yp2D8TDmT/vkKGmXA0K4U8Uia4yyU30jKkcEsXOfN+geuPtYT0KFNhcBaYyUjKgdEd9Ou+j4DQbYk01rP+bR6Fty/ycj6DwkUm0thKF4z7AO5XpruHdsbuzoE7NimZQFgq3miqitZyjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787603084; c=relaxed/simple;
	bh=MdlGQ1YGPyo6q4fQ5CsW81kcKMXd9tZzx9TSaN4B5ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOHSDnKmeSaEgsDGm0EeF/i5IafMmV7NIALLQtFn1Tt5a5zWtmbMWEtIbA5uJO3n72HTXc5rYM3zXupFfTKDKiPJIHqA+XmghrkEbXHd9FUYFs83rFJLswBvI8RWwpMg11AamGoxeePmJAA2PkBcSrgDL2ZWuDbr38eAFZouWUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUFUNoOU; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUFUNoOU"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66d07ddf077so2243848d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 13:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787603081; cv=none;
        d=google.com; s=arc-20260327;
        b=mekzto2euNzTXtmGnNSaPBX4Qg/MK8c1uOSz0m+m89jiuvLV2+2rQOGKx8FZbFbMd1
         UnUBCYihSdOrmgLtK6P172fJ0XmvFwGAXtYKa3H5JY7sqbp0fxpvKv6nww5+tTttlHIy
         H9VTQgp7QjvBGVVFlq1ZLXIyx7G8EL38qIuLvzDWigKQ5h/263E+BK9akPRg9NDnF0G5
         JYgckaest6KAwinP4NMzroeYX/WrQjqoVXCXBygUFl8odWxJ2k8gPEpvFGNHLWl0ns0p
         NJNV/uIHxjwwi02qKxCTW6+R7QgB/oIQsETt4o3RrVL2gKVp8p2zS33DcRegx3P5Ikhu
         mxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6arJFNIEtYO1N3cE88QFjylzkIER2l/NUQl8uPQTV3E=;
        fh=m92f/JBDOVykAnRzQG53HSkkPsbRSAK8OuStiYDVQcA=;
        b=A8XKqNJH0FoGF15OO651b+e1P+0P+1AR9NpuQNqMoRvCnNJjyRPYPjYV61+PbALRXf
         P4zFgH6NoZQxIK8F/p0I4281qLPCHDV7RaxoTt+DXPoboMTYYMrnRdHOD0jpxe6jsBZs
         3CCguBlDqpxvuSjjIU3NnTELiUrE8nuuDR2dMN6uVap1obIe6vK4LAIlCP2RFIG+mYDi
         YKNOeNDjVqLrdDUAHCfNLJ2XbqpamIwEAeB86a7CJ9WThHbsMin1N67yJoMcdsR+y4qj
         H2aj/MS/C7N0hswrH26Rk/TF+fo+TJZW9mTGtIyPrAhQNOhwTCtRy8ySdIGIwn/KMUkx
         gTUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787603081; x=1788207881; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6arJFNIEtYO1N3cE88QFjylzkIER2l/NUQl8uPQTV3E=;
        b=WUFUNoOUoTfpU7+O7eDe7WeUDQvJ2HlDqU9y72dK6NuEf/OmMYLfvFPfH9OKA9+w3D
         hJ0e9DyTXe/HtOhKISUgHpvRb19tyYOtmj16Wk2UNiTBdaN564rrhgs9N9QxlEg1nSxI
         V1BaCIApkbf1qjCllWq/FJ7sx5FPdu7nxsDg7HCo7hyl5x46cLT+lDTKtwj6QBzSGtsc
         MFO3gxyIpbg+pFArcTxYyvzpGRi5VmZn5XVUz/zxfakk0nfxzYBBzOYBffs1wevDRxjO
         pSJFfoSeUFHRg1R2rouHdisugLYaJWeOB4kwRQUEb0Yp1IlzY3XmrD2vZqhahvWWgF6G
         jS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787603081; x=1788207881;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6arJFNIEtYO1N3cE88QFjylzkIER2l/NUQl8uPQTV3E=;
        b=tOvGsQL9K6Rw1GMwgbjHYn40YTzJe2VkSWGlJTnHlTEPNZL0SSp9ioGVS2NOEspSPl
         CLvMVqfXOCL/fZbq7VD1r6tm1pBgtZ9mvNKZWjlgYQyQaPK3YcyvkpWq039f2lKzTApU
         GwcR/NF9UD0ergfTJRRNfBUy53WZDMc+YatTYSL4Kj6FyN+1HYwQNfVPO7i4yib7Dpgx
         jJV87S1k7JsHKDT5ocLlXwg41bFQiciSjQdTy091kSB1EM92XcY/2M4iT3D2SWRwQtap
         Y5Z06iKtz1814/RmaMzjSVNyZ4DgK9pd39T5hXZzOEElaISA22F+9W4IjQ4STj2gGo16
         kAjQ==
X-Forwarded-Encrypted: i=1; AHgh+RrPdCZPnYVgV0DpA0LcHCCT8C6cWHoxuUFZ3lcdNeOnWeiJuPYzG5p5sA9pLHjPl5FJ7p11Ji77DQVTb/OBGK4=@vger.kernel.org
X-Gm-Message-State: AFuF++nj0G72YJoP/3iUdc340l+nHrOeS6bOIgY6nYMOYSW5NGL+96u0
	MXpIUJzU8trrchum+2ZNLAtJdK830fWsBCFwVfwcyCec9P2NZCNIhhZUo6EAbm1UAo1GSSu64pu
	QO4ELbqxMxN439rc7CFwEe/Ek+8O7ex8=
X-Gm-Gg: AR+sD10PocDIkToGXvQ9MCd/Q0dmHt5MNJTMWdCEfNhv0TfgNpsDZAL9D9pVyR6z1qx
	eeaNjy3/1iFOGifAdpfR04Z3Fb96lwOMtAbVi9BSgSVhd4ORh2gm1HU8irgAHI05p8nfEu6XHn9
	uVXId+5yxgi0cpnIfJ/byWwwLy9w4JHiItJWtJD5KcWMh6C26z16H+rok6fM6BkpHhDwzFKp42b
	F6gJg4WM/nfkV1MPBo+ek02Nyo87RiStAE3QpnJENLeU8GXHWTUuYwhFjS0VmxLCOX9/yhmV6Kl
	jiVGFUxbhnRk2GdtDgkTZGGEjA57a52P+P4ys6eM23lAp6qMNpWutfvJw0xz8rTNBEWkc1FgUTH
	e/hHl3jBnr2jc1PzbrS0vBSkG9hlzmiqPSqxws+6APg==
X-Received: by 2002:a05:690e:4514:10b0:66c:c7f7:a074 with SMTP id
 956f58d0204a3-66cf21346dfmr5071579d50.1.1787603081472; Mon, 24 Aug 2026
 13:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822164341.3750491-1-nicoyip.dev@gmail.com>
 <178759021163.3014491.6954824460297136867.git-patchwork-notify@kernel.org> <5e76a95e934e451e7006db28827c2d64af5a88be.camel@iki.fi>
In-Reply-To: <5e76a95e934e451e7006db28827c2d64af5a88be.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 24 Aug 2026 16:24:30 -0400
X-Gm-Features: AcwNN1XI0fwmwELQrp0LxTgNN5-Hwkf5JRdkao3DMgkKEJh4yKK7TGLZ-xyNW8Q
Message-ID: <CABBYNZJotKc4k55jEEweD6aP6XEhYyKAgk4BamV5vfp8HHi0Tw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: RFCOMM: serialize security confirmation handling
To: Pauli Virtanen <pav@iki.fi>
Cc: patchwork-bot+bluetooth@kernel.org, Chengfeng Ye <nicoyip.dev@gmail.com>, 
	marcel@holtmann.org, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Mon, Aug 24, 2026 at 3:38=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ma, 2026-08-24 kello 16:50 +0000, patchwork-bot+bluetooth@kernel.org
> kirjoitti:
> > Hello:
> >
> > This patch was applied to bluetooth/bluetooth-next.git (master)
> > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> >
> > On Sun, 23 Aug 2026 00:43:41 +0800 you wrote:
> > > rfcomm_security_cfm() looks up a session on session_list and then wal=
ks
> > > its DLC list without holding rfcomm_mutex. Since RFCOMM session teard=
own
> > > uses rfcomm_mutex, krfcommd can close and free the same session and D=
LCs
> > > concurrently:
> > >
> > >   hci_rx_work                    krfcommd
> > >
> > > [...]
> >
> > Here is the summary with links:
> >   - Bluetooth: RFCOMM: serialize security confirmation handling
> >     https://git.kernel.org/bluetooth/bluetooth-next/c/40c621391de9
> >
> > You are awesome, thank you!
>
> I'm a bit too late now, but Sashiko report had some valid concerns
> about lock ordering in this one:
> https://sashiko.dev/#/patchset/20260822164341.3750491-1-nicoyip.dev%40gma=
il.com
>
> Running both BlueZ l2cap-tester and rfcomm-tester (so lockdep sees more
> paths) in same boot you get lockdep splat.

I didn't know about this trick, so I wonder if we should do something
about it. Testing with just rfcomm-tester should show this, or perhaps
we need to change the CI to run all tests under the same test-runner
instance so lockdep learns about all the code paths.

> Not immediately clear that a real deadlock could be triggered, but
> lockdep thinks the ordering is now inconsistent.
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 7.2.0-rc6-01463-gfe3897b4ab57 #994 Not tainted
> ------------------------------------------------------
> rfcomm-tester/364 is trying to acquire lock:
> ffff8880027d40b0 (&hdev->lock){+.+.}-{4:4}, at: l2cap_chan_connect (net/b=
luetooth/l2cap_core.c:7271)
>
> but task is already holding lock:
> ffffffff99499f58 (rfcomm_mutex){+.+.}-{4:4}, at: rfcomm_dlc_open (net/blu=
etooth/rfcomm/core.c:426)
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #2 (rfcomm_mutex){+.+.}-{4:4}:
> __mutex_lock (kernel/locking/mutex.c:646)
> rfcomm_security_cfm (net/bluetooth/rfcomm/core.c:2222)
> hci_auth_complete_evt (./include/net/bluetooth/hci_core.h:2246 net/blueto=
oth/hci_event.c:3554)
> hci_event_packet (net/bluetooth/hci_event.c:7887)
> hci_rx_work (net/bluetooth/hci_core.c:4041)
> process_scheduled_works (kernel/workqueue.c:3322)
> worker_thread (kernel/workqueue.c:3486)
> kthread (kernel/kthread.c:436)
> ret_from_fork (arch/x86/kernel/process.c:158)
> ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>
> -> #1 (hci_cb_list_lock){+.+.}-{4:4}:
> __mutex_lock (kernel/locking/mutex.c:646)
> hci_remote_ext_features_evt (./include/net/bluetooth/hci_core.h:2207 net/=
bluetooth/hci_event.c:5030)
> hci_event_packet (net/bluetooth/hci_event.c:7887)
> hci_rx_work (net/bluetooth/hci_core.c:4041)
> process_scheduled_works (kernel/workqueue.c:3322)
> worker_thread (kernel/workqueue.c:3486)
> kthread (kernel/kthread.c:436)
> ret_from_fork (arch/x86/kernel/process.c:158)
> ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>
> -> #0 (&hdev->lock){+.+.}-{4:4}:
> __lock_acquire (kernel/locking/lockdep.c:3165)
> lock_acquire (kernel/locking/lockdep.c:5868)
> __mutex_lock (kernel/locking/mutex.c:646)
> l2cap_chan_connect (net/bluetooth/l2cap_core.c:7271)
> l2cap_sock_connect (net/bluetooth/l2cap_sock.c:255)
> kernel_connect (net/socket.c:3726)

Interesting, I though the kernel_connect would actually behave as a
syscall and use it own thread so it wouldn't result into
l2cap_chan_connect, in that case it is probably useless to use it in
place of l2cap_chan_connect directly, so we may take the opportunity
and clean this up.

> rfcomm_dlc_open (net/bluetooth/rfcomm/core.c:808)
> rfcomm_sock_connect (net/bluetooth/rfcomm/sock.c:421)
> __sys_connect (net/socket.c:2135)
> __x64_sys_connect (net/socket.c:2160 net/socket.c:2157 net/socket.c:2157)
> do_syscall_64 (arch/x86/entry/syscall_64.c:63)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>
> other info that might help us debug this:
>
> Chain exists of:
> &hdev->lock --> hci_cb_list_lock --> rfcomm_mutex
>
> Possible unsafe locking scenario:
>
> CPU0                    CPU1
> ----                    ----
> lock(rfcomm_mutex);
>                         lock(hci_cb_list_lock);
>                         lock(rfcomm_mutex);
> lock(&hdev->lock);
>
> *** DEADLOCK ***
>
> 1 lock held by rfcomm-tester/364:
> #0: ffffffff99499f58 (rfcomm_mutex){+.+.}-{4:4}, at: rfcomm_dlc_open (net=
/bluetooth/rfcomm/core.c:426)
