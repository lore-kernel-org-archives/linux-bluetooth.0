Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1178834
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782340359; cv=none; b=jL+d3mFpR/9aDhB+A0dxMPlDlkdkW/9UGxpclmYZ1f7xu0C3lO96mdwJ0XrMgh4f9ndatxcn1lvhQA78y9GP7ame3rnXN1NMDNq/MHqbzcAXPDc5gJkKBoS7DKq2eGPAF4ygJS/n0Q4bvpfWHKx7AKGhEh1bu8OKfpjNTI8Xy/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782340359; c=relaxed/simple;
	bh=CATz2S2KNlRG9Tf6nJFzP9t8sfQOTMcv45Cv7eb5wMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VznuZaCcYym6gWb4fWsnu7DJK833X8qum3FgQm/UYguumQGkYFq9dwAOVTUskOYRRaJUSIdY9ygXslCUimdaNCXs6rRw2JjL/rWUsjZpIY9Ov/aGJpwBe8wnd9xmtSliTfiL0v3f65/Z4HKsSeAg5rQCAunjF/x4+h85AJgUOCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c0be5e548a4so222036466b.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 15:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782340356; x=1782945156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LWobexXHluL9TcHQuIt5uRIA5fkWkN1FHSdw4EfCUIA=;
        b=hgdmqDM38R2dYKiNcm7BP8IyATMizWZeFobyu738u1EfviuklZLKd0VWb5W3cQP9mZ
         mWWeX410aNsA2yxG2xgLllkAAYDRWPG1CRh+s6yHwi3yBlQ+fc0eszHGkobIt4jdD2A+
         /JaBriKvF7XtrFjLLKtHREwQWeCcCitWd7sfK4Nkrl/W1X3R/mrQWpM4hvDojOOttl8P
         Hl6XGLK9ABYhBaMgJV1SYdr9nOM3AD5cyLV2hvVAX2XuWmUEumrcPfiwtzvu+tqHFzMB
         lWuDRnTwK0Q54Ri9nQzkaxSRZDYRwoe8N01OUbMLMy2HSjLU70e61OPpuSQOhfgQXeWY
         xPSA==
X-Forwarded-Encrypted: i=1; AFNElJ+FVxi2k43Z9Kg95LdQcELM6mDD+0pQoCVqSVFRThjBMtrVo3o4cx5r8YDBpe96bW6i5YODy7kxEABqwScP6Do=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT+ZQmuHIWWVget1wpCKlFbNLJqilIEREOhoVhNbfAa1h/j2wt
	ih3CFAdqMDc8OYH6/OFIEUQ6SsxvFnVByouXtGgbdQjPZXqDw6l+0nYk45dgBzcK
X-Gm-Gg: AfdE7cl7yINQipKG/EMvtc8btvl0XeHtB1ZvnmBs0VPlMg5nu3esIlTZQYXDy8He8dU
	RvLZDgUA/cwptSRgjjUGtUiYMzuTcQRSDexxbsQJxvz+qBhQTSzRwxNBMZ0evoR0XVMoOdkljjQ
	m+SlWbBV6Rb5q0YzcbxzZEjF4G4+KuN+YVEnN5gnM+5WsPevl5J2xqM2Ldv7IhdBqRQ+yjC/5lv
	WHTsCMTQ9gcnSOCm/vZ1qPL13V+zCTNQazpM97B9EpugrjphMauGCwRNSvcfaEfE5gm3ZcFkc69
	QqhnM32ebDXAg5Xeysb4xADglo77kdMDPf07KHPSIL1YoXCARFnwJiAO7Hw4T0Rf5+3jD+HPVfA
	ym2rK6ZlIjMVjKq1VeL24R2hNM8JgckJZX78vw2wLnMKu2LX0dAQczx3umutzcVbPbCGazq0313
	cf7H4dZ7bCyAeQ6DXSrzdxcMMW7QdW2Ju+hmGJCwhFuJe7XHSNM1DQjcU+4FYCu+w7mfPQbzcHA
	CZU
X-Received: by 2002:a17:907:9342:b0:c11:2380:567f with SMTP id a640c23a62f3a-c119e435cc9mr296671766b.26.1782340356182;
        Wed, 24 Jun 2026 15:32:36 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe05ec7sm48503166b.40.2026.06.24.15.32.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 15:32:36 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45ef29c5561so1018722f8f.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 15:32:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro9yZyv6ShL4me7qX+HkD32ZhiEOG+ojNOq+7kjE6KOaUkEjxtm0NutyER7FaZ/4c2NqLDuyVE1tXdAkSnX3Lc=@vger.kernel.org
X-Received: by 2002:a5d:5d87:0:b0:46b:ea12:2912 with SMTP id
 ffacd0b85a97d-46c084c81acmr9043420f8f.5.1782340355775; Wed, 24 Jun 2026
 15:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624213304.1460149-2-iam@sung-woo.kim>
In-Reply-To: <20260624213304.1460149-2-iam@sung-woo.kim>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Wed, 24 Jun 2026 18:32:19 -0400
X-Gmail-Original-Message-ID: <CAJNyHpLNiQFNKmguJfzWYy8okg7u9cu20GyLUm9tHLMKwbjHpA@mail.gmail.com>
X-Gm-Features: AVVi8Ce7XWQhyb84GALLjXQv-Gvvricnj5oWRShafsFfTVey0aXDvDC1eAw9tvE
Message-ID: <CAJNyHpLNiQFNKmguJfzWYy8okg7u9cu20GyLUm9tHLMKwbjHpA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: sco: Fix a race condition in sco_sock_timeout()
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Dave Tian <daveti@purdue.edu>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 5:36=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> wrot=
e:
>
> sco_sock_timeout() runs asynchronously and lock_sock(sk). If the socket
> is closing while the timer is running, it holds the same lock
> (lock_sock(sk)) twice, leading to a deadlock.
>
> CPU 0                      CPU 1
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D       =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> sco_sock_close()
>                            sco_sock_timeout()
> lock_sock(sk) // <-- LOCK
>   __sco_sock_close()
>     sco_chan_del()
>       sco_conn_put()
>               sco_conn_free()
>                 disable_delayed_work_sync()
>                                    lock(sk) // <-- SAME LOCK
>
> Fix this by moving disable_delayed_work_sync() outside of lock_sock(sk),
> ensuring that no lock_sock(sk) is held before sco_sock_timeout().
>
> Lockdep splat:
>
> WARNING: possible circular locking dependency detected
> 6.13.0-rc4 #7 Not tainted
>
> syz-executor292/9514 is trying to acquire lock:
> ffff8881115d5070 ((work_completion)(&(&conn->timeout_work)->work)){+.+.}-=
{0:0}, at: rcu_lock_acquire sect/v6.13-rc4/./include/linux/rcupdate.h:337 [=
inline]
> ffff8881115d5070 ((work_completion)(&(&conn->timeout_work)->work)){+.+.}-=
{0:0}, at: rcu_read_lock sect/v6.13-rc4/./include/linux/rcupdate.h:849 [inl=
ine]
> ffff8881115d5070 ((work_completion)(&(&conn->timeout_work)->work)){+.+.}-=
{0:0}, at: start_flush_work sect/v6.13-rc4/kernel/workqueue.c:4137 [inline]
> ffff8881115d5070 ((work_completion)(&(&conn->timeout_work)->work)){+.+.}-=
{0:0}, at: __flush_work+0xd1/0xc40 sect/v6.13-rc4/kernel/workqueue.c:4195
>
> but task is already holding lock:
> ffff88807db3a258 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: lock=
_sock sect/v6.13-rc4/./include/net/sock.h:1623 [inline]
> ffff88807db3a258 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_=
sock_close+0x25/0x100 sect/v6.13-rc4/net/bluetooth/sco.c:524
>
> which lock already depends on the new lock.
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}:
>        lock_acquire+0x1c4/0x520 sect/v6.13-rc4/kernel/locking/lockdep.c:5=
849
>        lock_sock_nested+0x48/0x130 sect/v6.13-rc4/net/core/sock.c:3622
>        lock_sock sect/v6.13-rc4/./include/net/sock.h:1623 [inline]
>        sco_sock_timeout+0xbe/0x270 sect/v6.13-rc4/net/bluetooth/sco.c:158
>        process_one_work sect/v6.13-rc4/kernel/workqueue.c:3229 [inline]
>        process_scheduled_works+0xa99/0x18f0 sect/v6.13-rc4/kernel/workque=
ue.c:3310
>        worker_thread+0x8a9/0xd80 sect/v6.13-rc4/kernel/workqueue.c:3391
>        kthread+0x2c6/0x360 sect/v6.13-rc4/kernel/kthread.c:389
>        ret_from_fork+0x4e/0x80 sect/v6.13-rc4/arch/x86/kernel/process.c:1=
47
>        ret_from_fork_asm+0x1a/0x30 sect/v6.13-rc4/arch/x86/entry/entry_64=
.S:244
>
> -> #0 ((work_completion)(&(&conn->timeout_work)->work)){+.+.}-{0:0}:
>        check_prev_add sect/v6.13-rc4/kernel/locking/lockdep.c:3161 [inlin=
e]
>        check_prevs_add sect/v6.13-rc4/kernel/locking/lockdep.c:3280 [inli=
ne]
>        validate_chain+0x1888/0x5760 sect/v6.13-rc4/kernel/locking/lockdep=
.c:3904
>        __lock_acquire+0x13b4/0x2120 sect/v6.13-rc4/kernel/locking/lockdep=
.c:5226
>        lock_acquire+0x1c4/0x520 sect/v6.13-rc4/kernel/locking/lockdep.c:5=
849
>        touch_work_lockdep_map sect/v6.13-rc4/kernel/workqueue.c:3909 [inl=
ine]
>        start_flush_work sect/v6.13-rc4/kernel/workqueue.c:4163 [inline]
>        __flush_work+0x70f/0xc40 sect/v6.13-rc4/kernel/workqueue.c:4195
>        __cancel_work_sync sect/v6.13-rc4/kernel/workqueue.c:4351 [inline]
>        disable_delayed_work_sync+0xbb/0xf0 sect/v6.13-rc4/kernel/workqueu=
e.c:4514
>        sco_conn_free sect/v6.13-rc4/net/bluetooth/sco.c:95 [inline]
>        kref_put sect/v6.13-rc4/./include/linux/kref.h:65 [inline]
>        sco_conn_put+0x18f/0x270 sect/v6.13-rc4/net/bluetooth/sco.c:107
>        sco_chan_del+0xe2/0x210 sect/v6.13-rc4/net/bluetooth/sco.c:236
>        sco_sock_close+0x8f/0x100 sect/v6.13-rc4/net/bluetooth/sco.c:526
>        sco_sock_release+0x62/0x2d0 sect/v6.13-rc4/net/bluetooth/sco.c:130=
0
>        __sock_release+0xe1/0x2d0 sect/v6.13-rc4/net/socket.c:640
>        sock_close+0x1c/0x30 sect/v6.13-rc4/net/socket.c:1408
>        __fput+0x2bd/0xa80 sect/v6.13-rc4/fs/file_table.c:450
>        __fput_sync+0x15e/0x1c0 sect/v6.13-rc4/fs/file_table.c:535
>        __do_sys_close sect/v6.13-rc4/fs/open.c:1554 [inline]
>        __se_sys_close sect/v6.13-rc4/fs/open.c:1539 [inline]
>        __x64_sys_close+0x93/0x120 sect/v6.13-rc4/fs/open.c:1539
>        do_syscall_x64 sect/v6.13-rc4/arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xee/0x210 sect/v6.13-rc4/arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Fixes: e6720779ae61 ("Bluetooth: SCO: Use kref to track lifetime of sco_c=
onn")
> Acked-by: Dave Tian <daveti@purdue.edu>
> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> ---
>  net/bluetooth/sco.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index fcc597be5bbd..c05f79b7aa31 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -570,10 +570,23 @@ static void __sco_sock_close(struct sock *sk)
>  /* Must be called on unlocked socket. */
>  static void sco_sock_close(struct sock *sk)
>  {
> +       struct sco_conn *conn;
> +
> +       lock_sock(sk);
> +       conn =3D sco_pi(sk)->conn;
> +       if (conn)
> +               sco_conn_hold(conn);
> +       release_sock(sk);
> +
> +       if (conn)
> +               disable_delayed_work_sync(&conn->timeout_work);
> +
>         lock_sock(sk);
> -       sco_sock_clear_timer(sk);
>         __sco_sock_close(sk);
>         release_sock(sk);
> +
> +       if (conn)
> +               sco_conn_put(conn);
>  }
>
>  static void sco_sock_init(struct sock *sk, struct sock *parent)
> --
> 2.47.3
>

Although Sashiko [1] pointed out some interesting bugs in this patch,
they appear to be pre-existing.
I can send another patch for this.

[1] https://sashiko.dev/#/patchset/20260624213304.1460149-2-iam%40sung-woo.=
kim
