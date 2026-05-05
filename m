Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F357339B952
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993613; cv=pass; b=H2sfwriHeIocd+jD2LdfKULbBfNN8HrLlePjt/cADSj6DlyU7/HadSVtSBeT2m3Jgj42rmQVsWIDf8VSo4TfRw7lafj/zyVDdNDIKpEeuQMtXWj2EqKggtvawrV91YXDtomgckbUvv0EwHFjZFjTcR638/C7OdxhfJ5xv5ZzZFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993613; c=relaxed/simple;
	bh=UgdKY8d8Awk7EzEPYnWw+mH/FjQ5RVCE8hCcibnZ9lU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYV+RmsA0fn/0iMk+GMCW05QkdvSPTU3n6iWiSp6F8pFdWmCRdCigy5HSOrdMQLQ/ABp41Ivf+1ub812S+UmBIxVWssfQ4v/fa9GgdZ0lZW0LNSpCPDwV1yc02pVMAgn0zGQDS0J/Dc2+VQ9KEe06NYJm9uQDdu0iQ0+/F930kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ooEfWaus; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ooEfWaus"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64937edbc9eso4428728d50.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 May 2026 08:06:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777993610; cv=none;
        d=google.com; s=arc-20240605;
        b=hMyB1Kuob1psHWFOS73mROlXo9S5RD2xR/7oaQWd8t7grPS8UfOKiBTp5rAbbnaSJG
         l3FtF8ACs51c3UZ89Ib6e+WAHyIHeI3qGcijPwnrsIYHpLi1tvq9osETkhygdibHQxEP
         Rz4GzXUGNmdzGzZjwUATFcH9ApUyLRjzrtGFehKWy7SHvNLMUuOkQ9FIFA+fdI+Y1QTm
         JZk91Z67DNO1EGrZKfWlobr+RcSnJbL8RzwYVRBudO3UdP5iUqyqLZf1wv0IS8fc8KZM
         EXMsxlYemttM6DW1gvdza6ZPYpyYzdNhK1Ty3yc0x/pg7RyU2M89wBjKLGl1gWkWzqN7
         dnfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KK+EABlJQnSkksMiTnYsqKc8DTcxDUuzT52kDsQHSVs=;
        fh=pQD12ICeH3N9HRgNkPgGgs1j4714I7d0UfTc4nUtVr8=;
        b=YQKAVKZyTvs2R6+41eCKXsO1XMzDNx1PrBe+f3J/2/V7OGoBeRTlwtyYpRsG+BR29d
         RRd4E4BrtF2I4Fzom1iwCcL32UxL/rELseovWvCk4/3DPSWm4pPA90KDQ7CKvY0abuoR
         Nyfsfmf4YyJ5tmh4p4JmntFfR/o7dO0y1cB4HnyS/aTYap386Pc2dVK03FxdFsd/UJoc
         8ogaKkEXUImuQA34gJaHiHpYCsED0r2ZhzCTzMyZSz1+g8CK88+OR9Qy7xwlqJQBI6X9
         Hq/BqZ5cSUvuuHAMsCHg9ZrKJRX1GiqR2HF74BmroCA8OxTa9IkLfs4v6aK5GTVX8S3Y
         TDGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777993610; x=1778598410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KK+EABlJQnSkksMiTnYsqKc8DTcxDUuzT52kDsQHSVs=;
        b=ooEfWausCilWZq3ni80VJbO5QWANJ6vonPxQfKk6q6MhcIiFqUf0lwMLgKcSjhMwSq
         bsXsBOZL1JHqjKgZS3Sf7SVdF4oBd326N15H+zMuDjwCN9iLJaYAstCTsKOzuTjmWEXN
         7mAi7CUiKPWhK9H2hnxwb9f7UT82b1l1xo8UrkHpJ4XusvHyVg5WIKQRuEdtnEAI3aiw
         4Rbs9C2+HwRY+9JqekCDr8yj7VbpQWRgTB0mABl+suvDo+2lqFWuX02PpWWsjexK6HTp
         AgyHAebY1f7sOmtsb9QlUicetRZdF1tV3I9kpJDIUKb/4sfB+wP7e8WWV5XRApbKwB7E
         RpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777993610; x=1778598410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KK+EABlJQnSkksMiTnYsqKc8DTcxDUuzT52kDsQHSVs=;
        b=S9DCJoH0LOeUSnmMksJrH38BslE4HL/Nl/U0tW7fG0mFvIuhz2DCrxnWkddXCUo5Ue
         /cF5EtYDowCIRHCVFV+IuT9xiRjYjh0cHH9+6auhEU9J5bKOPmBHZ56zEcrXCt2NGt6w
         9FAFldzyT5w1OescaTtebVytJZpJgzqJCA4PHh6of7vNOnViXyZbHRe85RkRAKRAvsXt
         YdnTQiWk4fnP4ADxmZTMNCVpDEQztobZ+NjtJeL3qS6llfY/hWY4oWEF9eVOWQQHAYnK
         mXVtN4r4Oo+ahPcL4GltA1pONe5VgJ0uvO9glz8/ufEV9em9OzWJ/B18G0PgK6Ln3gwg
         MrDA==
X-Forwarded-Encrypted: i=1; AFNElJ+3gIxeECvOa9F6ArKyKtQglNWeKMdjBhNR1BpcVLourfSqEymys1HW2GbUyOfJama11jNHX9QUeIGd1B4IhIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1QWaPf59pi/2oTw92RC+DntPbH8ZCNugACVVrj5V2Rp6G7vMK
	e9CYHLLM4jYmxWFQ/gBipUCc56uY5SLd3ck2E+cKH4bdZ7S0cPdH5qxnvXybBZYChLc4cWwGKR9
	JblmCDX3Te4vdU2Dq89lUNJ15/nwpJN4zsVB4ZWU=
X-Gm-Gg: AeBDietBaTLHpY5neFFciF/7Eg9pk/0TdZ/OirIpMqZ7a7s05n2c3aFwPaWZzPnzse7
	i7CaWH96sJEGb7xos/F5gSe4FDZsN0pbqks+YJDvr852njhqg2sqbYDvEGihrTYRhRa5dE6NkS9
	/jjsvQXMvKXQnC1YaRzsZiZEVJVF9EKxi38O/YYQ+gBDpWWLdNqpeaGMrJu31QGq69+Zd83V0Eb
	fUJMxmGZFbm5Qtghctvgnc1hf9IA51gnYdl6FIaAXc3dmTspSoY66H+V3WWsf7glujPxt2h4aoE
	l7+LY4krNvHXDErX1xXaX7kBq8mR7AFFSAhRDwbG+3umJOwj38hutgtsEDHahon/REL/KLSPbVr
	W6eQTpXbaIasUMwI=
X-Received: by 2002:a53:ac87:0:b0:65c:6d4d:a22c with SMTP id
 956f58d0204a3-65c6d4da3c8mr2433242d50.43.1777993609746; Tue, 05 May 2026
 08:06:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504-bluetooth-accept-uaf-fix-v1-1-1ca63c0efadd@google.com>
In-Reply-To: <20260504-bluetooth-accept-uaf-fix-v1-1-1ca63c0efadd@google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 5 May 2026 11:06:38 -0400
X-Gm-Features: AVHnY4I2JDyebrVZDyH6RpVPaaCOfJJfQHEg5lVnURoN9r-n09T7ubKx3gMkKxU
Message-ID: <CABBYNZLzyh7a7sZ+0U4DAq8TB6e6=WdNrfKrxGXMqnYAMT0KnA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: fix UAF read of ->accept_q in bt_accept_poll()
To: Jann Horn <jannh@google.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jann,

On Mon, May 4, 2026 at 11:11=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> Use lock_sock() to guard against bt_accept_poll() racing with concurrent
> close(accept()), which can lead to UAF:
>
> task 1           task 2
> =3D=3D=3D=3D=3D=3D           =3D=3D=3D=3D=3D=3D
>                  __x64_sys_poll
>                    __se_sys_poll
>                      __do_sys_poll
>                        do_sys_poll
>                          do_poll
>                            do_pollfd
>                              vfs_poll
>                                sock_poll
>                                  bt_sock_poll
>                                    bt_accept_poll
>                                      [read ->accept_q next pointer]
> __x64_sys_accept
>   __se_sys_accept
>     __do_sys_accept
>       __sys_accept4
>         __sys_accept4_file
>           do_accept
>             l2cap_sock_accept
>               bt_accept_dequeue
>                 bt_accept_unlink
>                   [removes new socket from ->accept_q]
> __x64_sys_close
>   __se_sys_close
>     __do_sys_close
>       fput_close_sync
>         __fput
>           sock_close
>             __sock_release
>               l2cap_sock_release
>                 l2cap_sock_kill
>                   sock_put
>                     sk_free
>                       __sk_free
>                         sk_destruct
>                           __sk_destruct
>                             [frees new socket]
>                                      [UAF read of ->sk_state]
>
> This UAF only leads to incorrect reads, it does not corrupt memory; it is=
 a
> fairly tight race window; I believe every race attempt requires an
> incoming bluetooth connection; and the leaked data is limited.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  net/bluetooth/af_bluetooth.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index 33d053d63407..d24897167838 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -521,13 +521,17 @@ static inline __poll_t bt_accept_poll(struct sock *=
parent)
>         struct bt_sock *s, *n;
>         struct sock *sk;
>
> +       lock_sock(parent);
>         list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q=
) {
>                 sk =3D (struct sock *)s;
>                 if (sk->sk_state =3D=3D BT_CONNECTED ||
>                     (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags) &=
&
> -                    sk->sk_state =3D=3D BT_CONNECT2))
> +                    sk->sk_state =3D=3D BT_CONNECT2)) {
> +                       release_sock(parent);
>                         return EPOLLIN | EPOLLRDNORM;
> +               }
>         }
> +       release_sock(parent);

There is the following comments though:

https://sashiko.dev/#/patchset/20260504-bluetooth-accept-uaf-fix-v1-1-1ca63=
c0efadd%40google.com

I'm not really sure if likes for the poll are supposed to be done
lockless, if they are, we cannot use lock_sock here and will likely
need to rework accept_q so it doesn't contain deferred sks, as those
shouldn't be considered ready for acceptance.

>         return 0;
>  }
>
> ---
> base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
> change-id: 20260504-bluetooth-accept-uaf-fix-df393cbda114
>
> --
> Jann Horn <jannh@google.com>
>


--=20
Luiz Augusto von Dentz
