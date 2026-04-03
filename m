Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79B13B3895
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775238718; cv=pass; b=I82e40SbiOydgtmFCT3PNG71VVfWozfCs2XxSBkmfrOVbSsh1q6f017/0ZWHEJgWkClB/E3Q4AAwWTN38JKK+2SX9GHUJnNOrpJFcodU7JDjP1DivfuCaB6+ml9S0kWRZwIQfYOu6skTHIdklZfa9aF2kLuycY8AByg2yRcSEiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775238718; c=relaxed/simple;
	bh=/GuofaS6afgkYLOeabYbtCP6ad4zwgDCmyZW593Hcd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=it40B3DCY3lkIJoZidL5sSpdwlhnAVlPSFKFzXFF33RkxqObhbEazXTbw4PDDYZwY79q5deTV1D1ZN2L3+3jfcf8rcb8Yvm6na/YBpxViR/JlDWp6BPnCcZ3XuPpvy3WO//65ZQ8kjOE+CCscO5Z0YUTGRpUSMgq/lQpRdfTB0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pxw9Zij0; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxw9Zij0"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-649278a69c5so1662366d50.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2026 10:51:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775238716; cv=none;
        d=google.com; s=arc-20240605;
        b=j+DYHFiabiQGqcrzTC4yCkqXIVPxzySAm1m6tziyHL0ykfy3sg4QnUMH4zYQlAs2z4
         DdQuw4PEBpBwRbYtLJsOtVtZHuugnb692drqBMXTVScH0nmvIdrG9Nk8/7NbN9VGb54D
         fQlD5I67jSYb11Y7Wr0wptIvB6Q9U1bi3hOHOE40Dle0OvaCZ3hsrmfHqlPxflrYkgMd
         1W7ZW6PiEJGAWsu7BT79FCxkrwLx2PXCt0kUdrYfpUoL9S33NjBrHXWWyvHgtZOJ+IQL
         SDkN940+JZzpY0aNeeURfcoXdBqimODdkKrCwROR67q+JRsftXhJ6ibH7nTKpbf0Kb3m
         2MWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TuAxWFVTaAOtWl4GGnCFFHrE8RNuaXjTZ7b6KeFGrCs=;
        fh=5w8fbEJEAv2afZZwK/eRWZO5tQsyKAZBO54e88bOwek=;
        b=D8n01L/y4fRZnYqHI0lCwBnmlGsOk5PHbI+r1BHTeKSzC7Z9pBZ6iEWanHMfohg39O
         35ONjY9DjaI83UmB31/CV43KOBmnjSiRmNvHo5+dau0KgoQGcRyEWcXXF5xTZn88EW5V
         0PkbBts0fp2ZPXAtuCPGtXgNchjrhXVZYLwU2lZIXwhA4qKVoH/E7iDLqHLfinUeTk2E
         LHRA4gXa2yfWmlk6madR+kJmkdqtNSPhHygbaG7bLzBMN+nC2A4BHX7Fjs7siRJ6vZa+
         q3BwkksJEQjEue3XEdZWdfQCpHHcor9xEyZUvsUf4z+IbS4OHMscRuc/VAJMn9HA0QBF
         hz2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775238716; x=1775843516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TuAxWFVTaAOtWl4GGnCFFHrE8RNuaXjTZ7b6KeFGrCs=;
        b=pxw9Zij0DhLjAwZWxJDEdDZGVhoEsNXQIF5F2tAZESRz4Zb9fKkvlFI5sjRLZQUKo+
         rk731GSc0MdPM7Ztr33ns/yqeRoM4POuEorYy+/mTXyYmYfA48K012SAUPh39Bw/MNyY
         zZrOEDwvDeQGEhAKgGSKRakMbiyNCHdVBgdbHZAW2RqMyCgJPwTGMFzmCpy4X8dt+Ynm
         YqQ4FpnGunRVe/pQqtbRulrA9AQP/LaHVlX6vae/q8oxCer0XkT7MT1U7kBSeDUy2q0J
         srOIG4rn01pz1+ef2H8UFGNsHqB3OwpXOjtP3cqIoPd6r7wqmxoNdPF2VlupjAQUcQPi
         5rUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775238716; x=1775843516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TuAxWFVTaAOtWl4GGnCFFHrE8RNuaXjTZ7b6KeFGrCs=;
        b=hHUQVgyEAqKBEuC36n000FWFhwfio3HOxfZVKhm1Dvxg09G6gyUWhuLAwyzheZRnvu
         drwpSLbxke19atUw30kYsf7sZbpBOoCPbXDN1PT+fEvDTRTpTHACSvp7X1Isg+6grn7z
         YgRQiGpHtwSiUzrMbk1v3du64z5ATSemQjM5+5Da5e6+LbbYPKo2oFFtb8hVmhclwU+D
         VM5r78lRfdv2nPMp/o9QRdg/8lAF/XuVD0+d6qisXASbjmtZGpsJYRUNnbFxBC2VXEJh
         V10m5UuJuaao/Cq6xQhAD75xWfhbT2kNpFJ3WzgJsZLeDExf+GZ5apCt0z6A9iDdnS9T
         geXQ==
X-Gm-Message-State: AOJu0YwrvBZ7cJsRdb9XemAJryYdNQVSKhKDqbRG4iii8Z3z6xfILt6j
	TrAVOsgpwBdDzOfebVaueZ/EtQPugOV0B3Ge6Ub82/guDrKOgSuWFX0iReYrl90vgvho/bQUIVc
	sUF56Nw91cu385wIa7W/Jt21ca6GAKRQ=
X-Gm-Gg: AeBDievP0R/Lrn4ya63Kzg+g0dM6f/JUL3QgNlCO06cL54cHdUyL9Cf3HKahLA2b4+i
	enXOdCqfcnr0ATP/+SLvrMu+m12OzI97Ives0xZxnMFkFheYL6Yyo3obMFckeoMMQn7vle+JAx7
	BWdZhvASfkzplk+DvTDLjOKeDveRf4KvgqDOHVJKGNRFgi9AjRA/2NTnzc2/FjlTK1Cu13h2KsK
	SHA+ANHMDPGeZLYWuQgzkggeUkVyXIm12PSN/H7D9OeaHMKFjuxD/r3X73FNMCm0w88bnRgYh5N
	Tf/NeaAppkyNR8EOAi5liMpVn+w0j7svL79gCA1Y2Uep1DvBN4yva+bFg5ij9JamAoGLflxWMym
	TtLID
X-Received: by 2002:a53:d788:0:b0:650:1004:2a63 with SMTP id
 956f58d0204a3-65048800bcemr3215730d50.41.1775238715603; Fri, 03 Apr 2026
 10:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774454568.git.wangjiexun2025@gmail.com> <06a6b4549acba207847ce532dedbf1c95ab22d13.1774925231.git.wangjiexun2025@gmail.com>
In-Reply-To: <06a6b4549acba207847ce532dedbf1c95ab22d13.1774925231.git.wangjiexun2025@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 3 Apr 2026 13:51:44 -0400
X-Gm-Features: AQROBzDTKUUzqU9uA1hHQ5ZCJJYBvEauL7y3n1VLZM7Rp50HabzKGJsWazQn-5k
Message-ID: <CABBYNZJbttf4VnqNJsnME8DEJU+bO635ySRWofEDF--M+X2rgA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Bluetooth: serialize accept_q access
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	marcel@holtmann.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, yifanwucs@gmail.com, 
	tomapufckgml@gmail.com, yuantan098@gmail.com, bird@lzu.edu.cn, 
	enjou1224z@gmail.com, wangjiexun2025@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ren,

On Fri, Apr 3, 2026 at 4:05=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Jiexun Wang <wangjiexun2025@gmail.com>
>
> bt_sock_poll() walks the accept queue without synchronization, while
> child teardown can unlink the same socket and drop its last reference.
>
> Protect accept_q with a dedicated lock for queue updates and polling.
> Also rework bt_accept_dequeue() to take temporary child references under
> the queue lock before dropping it and locking the child socket.
>
> Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ("Linux-2.6.12-rc2")
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Tested-by: Ren Wei <enjou1224z@gmail.com>
> Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
> Changes in v2:
> - add Tested-by: Ren Wei <enjou1224z@gmail.com>
> - resend to the public Bluetooth/netdev lists
>
>  include/net/bluetooth/bluetooth.h |  1 +
>  net/bluetooth/af_bluetooth.c      | 85 +++++++++++++++++++++++--------
>  2 files changed, 66 insertions(+), 20 deletions(-)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index 69eed69f7f26..3faea66b1979 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -398,6 +398,7 @@ void baswap(bdaddr_t *dst, const bdaddr_t *src);
>  struct bt_sock {
>         struct sock sk;
>         struct list_head accept_q;
> +       spinlock_t accept_q_lock; /* protects accept_q */
>         struct sock *parent;
>         unsigned long flags;
>         void (*skb_msg_name)(struct sk_buff *, void *, int *);
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index 2b94e2077203..f44e1ecc83d8 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -154,6 +154,7 @@ struct sock *bt_sock_alloc(struct net *net, struct so=
cket *sock,
>
>         sock_init_data(sock, sk);
>         INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
> +       spin_lock_init(&bt_sk(sk)->accept_q_lock);
>
>         sock_reset_flag(sk, SOCK_ZAPPED);
>
> @@ -214,6 +215,7 @@ void bt_accept_enqueue(struct sock *parent, struct so=
ck *sk, bool bh)
>  {
>         const struct cred *old_cred;
>         struct pid *old_pid;
> +       struct bt_sock *par =3D bt_sk(parent);
>
>         BT_DBG("parent %p, sk %p", parent, sk);
>
> @@ -224,9 +226,12 @@ void bt_accept_enqueue(struct sock *parent, struct s=
ock *sk, bool bh)
>         else
>                 lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
>
> -       list_add_tail(&bt_sk(sk)->accept_q, &bt_sk(parent)->accept_q);
>         bt_sk(sk)->parent =3D parent;
>
> +       spin_lock_bh(&par->accept_q_lock);
> +       list_add_tail(&bt_sk(sk)->accept_q, &par->accept_q);
> +       spin_unlock_bh(&par->accept_q_lock);
> +
>         /* Copy credentials from parent since for incoming connections th=
e
>          * socket is allocated by the kernel.
>          */
> @@ -254,45 +259,73 @@ EXPORT_SYMBOL(bt_accept_enqueue);
>   */
>  void bt_accept_unlink(struct sock *sk)
>  {
> +       struct sock *parent =3D bt_sk(sk)->parent;
> +
>         BT_DBG("sk %p state %d", sk, sk->sk_state);
>
> +       spin_lock_bh(&bt_sk(parent)->accept_q_lock);
>         list_del_init(&bt_sk(sk)->accept_q);
> -       sk_acceptq_removed(bt_sk(sk)->parent);
> +       spin_unlock_bh(&bt_sk(parent)->accept_q_lock);
> +
> +       sk_acceptq_removed(parent);
>         bt_sk(sk)->parent =3D NULL;
>         sock_put(sk);
>  }
>  EXPORT_SYMBOL(bt_accept_unlink);
>
> +static struct sock *bt_accept_get(struct sock *parent, struct sock *sk)
> +{
> +       struct bt_sock *bt =3D bt_sk(parent);
> +       struct sock *next =3D NULL;
> +
> +       /* accept_q is modified from child teardown paths too, so take a
> +        * temporary reference before dropping the queue lock.
> +        */
> +       spin_lock_bh(&bt->accept_q_lock);
> +
> +       if (sk) {
> +               if (bt_sk(sk)->parent !=3D parent)
> +                       goto out;
> +
> +               if (!list_is_last(&bt_sk(sk)->accept_q, &bt->accept_q)) {
> +                       next =3D &list_next_entry(bt_sk(sk), accept_q)->s=
k;
> +                       sock_hold(next);
> +               }
> +       } else if (!list_empty(&bt->accept_q)) {
> +               next =3D &list_first_entry(&bt->accept_q,
> +                                        struct bt_sock, accept_q)->sk;
> +               sock_hold(next);
> +       }
> +
> +out:
> +       spin_unlock_bh(&bt->accept_q_lock);
> +       return next;
> +}
> +
>  struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newso=
ck)
>  {
> -       struct bt_sock *s, *n;
> -       struct sock *sk;
> +       struct sock *sk, *next;
>
>         BT_DBG("parent %p", parent);
>
>  restart:
> -       list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q=
) {
> -               sk =3D (struct sock *)s;
> -
> +       for (sk =3D bt_accept_get(parent, NULL); sk; sk =3D next) {
>                 /* Prevent early freeing of sk due to unlink and sock_kil=
l */
> -               sock_hold(sk);
>                 lock_sock(sk);
>
>                 /* Check sk has not already been unlinked via
>                  * bt_accept_unlink() due to serialisation caused by sk l=
ocking
>                  */
> -               if (!bt_sk(sk)->parent) {
> +               if (bt_sk(sk)->parent !=3D parent) {
>                         BT_DBG("sk %p, already unlinked", sk);
>                         release_sock(sk);
>                         sock_put(sk);
>
> -                       /* Restart the loop as sk is no longer in the lis=
t
> -                        * and also avoid a potential infinite loop becau=
se
> -                        * list_for_each_entry_safe() is not thread safe.
> -                        */
>                         goto restart;
>                 }
>
> +               next =3D bt_accept_get(parent, sk);
> +
>                 /* sk is safely in the parent list so reduce reference co=
unt */
>                 sock_put(sk);
>
> @@ -310,6 +343,8 @@ struct sock *bt_accept_dequeue(struct sock *parent, s=
truct socket *newsock)
>                                 sock_graft(sk, newsock);
>
>                         release_sock(sk);
> +                       if (next)
> +                               sock_put(next);
>                         return sk;
>                 }
>
> @@ -518,18 +553,28 @@ EXPORT_SYMBOL(bt_sock_stream_recvmsg);
>
>  static inline __poll_t bt_accept_poll(struct sock *parent)
>  {
> -       struct bt_sock *s, *n;
> +       struct bt_sock *bt =3D bt_sk(parent);
> +       struct bt_sock *s;
>         struct sock *sk;
> +       __poll_t mask =3D 0;
> +
> +       spin_lock_bh(&bt->accept_q_lock);
> +       list_for_each_entry(s, &bt->accept_q, accept_q) {
> +               int state;
>
> -       list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q=
) {
>                 sk =3D (struct sock *)s;
> -               if (sk->sk_state =3D=3D BT_CONNECTED ||
> -                   (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags) &=
&
> -                    sk->sk_state =3D=3D BT_CONNECT2))
> -                       return EPOLLIN | EPOLLRDNORM;
> +               state =3D READ_ONCE(sk->sk_state);
> +
> +               if (state =3D=3D BT_CONNECTED ||
> +                   (test_bit(BT_SK_DEFER_SETUP, &bt->flags) &&
> +                    state =3D=3D BT_CONNECT2)) {
> +                       mask =3D EPOLLIN | EPOLLRDNORM;
> +                       break;
> +               }
>         }
> +       spin_unlock_bh(&bt->accept_q_lock);
>
> -       return 0;
> +       return mask;
>  }
>
>  __poll_t bt_sock_poll(struct file *file, struct socket *sock,
> --
> 2.34.1

https://sashiko.dev/#/patchset/06a6b4549acba207847ce532dedbf1c95ab22d13.177=
4925231.git.wangjiexun2025%40gmail.com

Seem valid to me.

--=20
Luiz Augusto von Dentz
