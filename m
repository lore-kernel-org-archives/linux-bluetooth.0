Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD8F3ED5A2
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778087117; cv=pass; b=WDsc/wHRzB7TLl9zL2PB9c+vS+7wlSp5D5n9WJ5/sLwa5cijy9Cq4iIdnYJrX0yHFCOyOL7x1zLf08qErnqG0rYaO8Bc6SPtV4zIZvW8IhkB50J2POmUN7ySL37kRtI3BZ4+jaYUY6VXUIT3sQDhSKiTAIEVJlo5urYeCvSepSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778087117; c=relaxed/simple;
	bh=FOCvTSM0N8kIVI2ohKLXOcDmAd449ytZgbptOtLxDJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMEg+OhLbABoUE2w61qENSF+ctWMU41gBaqeo5dKW9iwXDyG+Mov4kaPppMtED4C+tsM0RvzKcvS60o3/BB14EhnmY1c+fcbkYweEYcLwFKnXbDcGPna3BlxgLz3SnRWGYQe6dalFPzEOECc9JPq5c2XxcBDW8jqLpoYNAT9SZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B23gzbxQ; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B23gzbxQ"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67bf769704eso536a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2026 10:05:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778087112; cv=none;
        d=google.com; s=arc-20240605;
        b=OW5+frpQAdnqvqi87YW0a5/z5Npq6nbz2TsVYjij9EALjJU+udTvwVCfV2svAxd6GB
         ZdQEBY7kpqozn2ZRHc2j/XH+SWVXww03ETkXoUj0Npr6KOC41TBw9xhifZN4v5X664QV
         yigkb9HdK+AVp7rUrWTRKHRYSB24lavru96zUsU+wovr+xAIes3hvM9yEzD8ZLGJkKFU
         LWBbAJ2vkt5OQFdVjYHzspgJZFEIKW+2YFqbUy3/M6IQRsRWoU8Rrqxf7jvzCBp2qP4M
         xeTYupKI2iTYHaTEHd9ENUikMrxL2mFwsvxnPDnAOk0Jsh4SZvqCLkTmWFs6cgudIQOn
         ZDPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yGQ/JV9twT5dQgcFaCi6ZWO+OHcCu7eww9/flq/MLqc=;
        fh=avDYlbM5vuHm70XpXqCc22pcVprfhqmsLlMbImwm1v4=;
        b=RtpACiMFT6jxgLSxAQEJs2RwXB9kdCMJmnXI/OpiB4dQiKUOxS0YlEBkWRUPcsvaX6
         309NOh1Mo/V+/+BA4hxth2MUJ9duxucuAiLk7luMAcKKEXCnwuCTHLpD0mTIf1+wblyb
         T8UDSIX1fkM4anKNZEqVkF1iNnn7JDE0wK57yVu15/8bUsr30nftXL8p09ThiVDhs2nC
         SoheqISVJXpU+HcUbLIjmVg45Vx5+fZYd8DX8V7yWui1GzUT8ENexpxWkC5rwc6YX+iv
         kbCdV6k/l6nWqvfrAwMgru0M990PZX8xl9aqRz5vr++dhppSQDG4Qry0m3xGqaE6JXHd
         JuoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778087112; x=1778691912; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yGQ/JV9twT5dQgcFaCi6ZWO+OHcCu7eww9/flq/MLqc=;
        b=B23gzbxQgif7f+HY/fHh7QSQWNxy2CDAmVSGwD3pxloYqYH2HQW7ymqRoua1IMXi8K
         bkN1PoaVrDHT6ju2uxuJypetdWv5S+oKd7Lp8sZeB4u5Cf0dedPKfFCc4EQly6HV1XjQ
         y1jG5ErCTrVW7Gm6PpsJVddoVmUfNfrdLoLCcdt2Pv3hHdpzYOIewbiEgyqpJSqK6g+W
         4iNAfwd6Sfmo34G73dbBhLup9AtYmTk2DNJSuK7ckaWI7JcfmnhGl62U9KNvpx5JDqJR
         gcXEg3q9FF95kZKqFc7pDZ6dbSAxfLDfDM/rzmNhcU4ZgKk6rQt8GUH7O57MSW5CAVWY
         bohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778087112; x=1778691912;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGQ/JV9twT5dQgcFaCi6ZWO+OHcCu7eww9/flq/MLqc=;
        b=Okn/Kk0HX7hgcEPee+TQ8FJL4aFNBhZMOjslnEA6vJb8hPh2nnyJ/c95ZLz0UwZ8po
         SzrzTuKQ3xan7jOOTuZ8G0633SAa2qispXhaP8Wpr4GflPqfmiy4MfWW3ha5+3pSeTGr
         t+2piLR3jczrhWIbpkOS8aA3DJCGm5TFs8Oo7fPuwC30pKbXoCYZDMiH/H/NXpGIATcn
         ZNinnCMV9g22ycPm/mAq3DW3GZ7f72yz/P+s8y4HkUvnEqrQ+m2UZaQXCM1L3bnLLBq5
         mO1LjQmQcbX3B4f6cX2t8wxBYy45yvA0b7LVhyXiCgx6txNgCgzEuHRyEAsuds4T0kpX
         KlVg==
X-Gm-Message-State: AOJu0YyUTyEs554MMjxQghHif4HiOXcD1eSotlz7vVzgcidBR/2Bl/ZX
	5D6syCi/5eiqcUNPH6k4kDjRuUucrmsmY5JEdBrYO5nownJ9Y+tilWfoA2EE/NWldJuaDOiz6Pc
	fQecoA8yVY5mt/1YTKdvGdTuzzCpFELnI5Kk9IKxA
X-Gm-Gg: AeBDieszt2hNXTUm4E9a06YgRvaudLCfYmb4PqWl3lvh6UPgaeJapCNmq+9HSdvoWPh
	nX8W4xPJOch0X0m/uJFWT//sLaQ5xr2/qkct+ocMAtktfsC0lw0b3YKs9lEocjpDMQgbDOQP6um
	No3qt8KL+8nm7q5u2j8gLupEMvLynPNEAUPDPmhWVZ6glYPh7pELmWS84wBW5xlNR7kTnDkL9ld
	x0Nh39ZuzjMVZPxNvGhDROSH1bZyf9G3mvJH/kddq2xMYPVmroNL67e93lrDvXObZ2a3D9jkNDQ
	bL3EbfWdVXcoynRJcR01jQhVzHWZhX8qjIb4UQh9GdtN+HROfqJ9mP4tTphg9RAV+FpAgQ==
X-Received: by 2002:aa7:c999:0:b0:678:8834:1b49 with SMTP id
 4fb4d7f45d1cf-67d63d7e7e7mr44533a12.1.1778087111807; Wed, 06 May 2026
 10:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506114338.2873496-1-n05ec@lzu.edu.cn>
In-Reply-To: <20260506114338.2873496-1-n05ec@lzu.edu.cn>
From: Jann Horn <jannh@google.com>
Date: Wed, 6 May 2026 19:04:34 +0200
X-Gm-Features: AVHnY4Le4E_WtjtvKWKAUov-e8jcXgizcNumpuo8Of_JZYYBF-U9j9e9FHaykm8
Message-ID: <CAG48ez0R5iGL6HkMS_Mp=5TuWQWKKinGZVv2PjtBVa3EcHkhYA@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: serialize accept_q access
To: Ren Wei <n05ec@lzu.edu.cn>, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	marcel@holtmann.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, yuantan098@gmail.com, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn, 
	wangjiexun2025@gmail.com
Content-Type: multipart/mixed; boundary="000000000000af6b2e0651292a75"

--000000000000af6b2e0651292a75
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 1:43=E2=80=AFPM Ren Wei <n05ec@lzu.edu.cn> wrote:
> bt_sock_poll() walks the accept queue without synchronization, while
> child teardown can unlink the same socket and drop its last reference.
> The unsynchronized accept queue walk has existed since the initial
> Bluetooth import.
>
> Protect accept_q with a dedicated lock for queue updates and polling.
> Also rework bt_accept_dequeue() to take temporary child references under
> the queue lock before dropping it and locking the child socket.
>
> Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Jann Horn <jannh@google.com>
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

The patch looks good to me. I have some comments below, but they're
not important - from my perspective, this patch is ready to land in
the tree.

Reviewed-by: Jann Horn <jannh@google.com>

> ---
> Changes in v4:
> - no functional changes
> - clarify that the race dates back to the initial Bluetooth import
> - update trailers
>   I noticed Jann also proposed a fix at
>   https://patchwork.kernel.org/project/bluetooth/patch/20260504-bluetooth=
-accept-uaf-fix-v1-1-1ca63c0efadd@google.com/,
>   so we're adding his Reported-by tag here. Please let us know if this
>   isn't appropriate.

Thanks for letting me know that my patch was redundant, and for
listing me in Reported-by.
This addresses the race I described.
(You could add the line
"Closes: https://lore.kernel.org/r/20260504-bluetooth-accept-uaf-fix-v1-1-1=
ca63c0efadd@google.com"
after the "Reported-by: Jann Horn <jannh@google.com>".)

[...]
> @@ -254,45 +258,72 @@ EXPORT_SYMBOL(bt_accept_enqueue);
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
> +       sk_acceptq_removed(parent);
> +       spin_unlock_bh(&bt_sk(parent)->accept_q_lock);
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

This check seems redundant? The caller already bailed out if
"bt_sk(sk)->parent !=3D parent", and lock_sock(sk) ensures that
bt_sk(sk)->parent can't change concurrently because bt_accept_unlink()
is also protected by lock_sock() or lock_sock_nested(), as the comment
above bt_accept_unlink() documents.

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

Hmm. This looks a bit complicated to me, and I find it hard to reason
about how accept_q walks are restarted after temporarily dropping the
lock; I think it would be nice if you could instead walk the
->accept_q while holding the accept_q_lock until you identify a socket
with the right ->sk_state, then drop the accept_q_lock and lock the
sock. Something like this diff on top of your patch (completely
untested); I have attached a properly formatted version of this diff
that you can apply with "git apply":

```
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 9d68dd86023c..26e7c7198522 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -271,50 +271,36 @@ void bt_accept_unlink(struct sock *sk)
 }
 EXPORT_SYMBOL(bt_accept_unlink);

-static struct sock *bt_accept_get(struct sock *parent, struct sock *sk)
-{
-       struct bt_sock *bt =3D bt_sk(parent);
-       struct sock *next =3D NULL;
-
-       /* accept_q is modified from child teardown paths too, so take a
-        * temporary reference before dropping the queue lock.
-        */
-       spin_lock_bh(&bt->accept_q_lock);
-
-       if (sk) {
-               if (bt_sk(sk)->parent !=3D parent)
-                       goto out;
-
-               if (!list_is_last(&bt_sk(sk)->accept_q, &bt->accept_q)) {
-                       next =3D &list_next_entry(bt_sk(sk), accept_q)->sk;
-                       sock_hold(next);
-               }
-       } else if (!list_empty(&bt->accept_q)) {
-               next =3D &list_first_entry(&bt->accept_q,
-                                        struct bt_sock, accept_q)->sk;
-               sock_hold(next);
-       }
-
-out:
-       spin_unlock_bh(&bt->accept_q_lock);
-       return next;
-}
-
 struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock=
)
 {
-       struct sock *sk, *next;
+       struct bt_sock *s;
+       struct sock *sk;

        BT_DBG("parent %p", parent);

 restart:
-       for (sk =3D bt_accept_get(parent, NULL); sk; sk =3D next) {
+       spin_lock_bh(&bt_sk(parent)->accept_q_lock);
+       list_for_each_entry(s, &bt_sk(parent)->accept_q, accept_q) {
+               unsigned char state;
+
+               sk =3D &s->sk;
+
+               /* lockless version of the checks below */
+               state =3D data_race(READ_ONCE(sk->sk_state));
+               if (state !=3D BT_CLOSED && state !=3D BT_CONNECTED && news=
ock &&
+                   !test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags))
+                       continue;
+
                /* Prevent early freeing of sk due to unlink and sock_kill =
*/
+               sock_hold(sk);
+               spin_unlock_bh(&bt_sk(parent)->accept_q_lock);
                lock_sock(sk);
+               /* socket is now locked, redo checks reliably */

                /* Check sk has not already been unlinked via
                 * bt_accept_unlink() due to serialisation caused by sk loc=
king
                 */
-               if (bt_sk(sk)->parent !=3D parent) {
+               if (s->parent !=3D parent) {
                        BT_DBG("sk %p, already unlinked", sk);
                        release_sock(sk);
                        sock_put(sk);
@@ -322,8 +308,6 @@ struct sock *bt_accept_dequeue(struct sock
*parent, struct socket *newsock)
                        goto restart;
                }

-               next =3D bt_accept_get(parent, sk);
-
                /* sk is safely in the parent list so reduce reference coun=
t */
                sock_put(sk);

@@ -331,7 +315,7 @@ struct sock *bt_accept_dequeue(struct sock
*parent, struct socket *newsock)
                if (sk->sk_state =3D=3D BT_CLOSED) {
                        bt_accept_unlink(sk);
                        release_sock(sk);
-                       continue;
+                       goto restart;
                }

                if (sk->sk_state =3D=3D BT_CONNECTED || !newsock ||
@@ -341,12 +325,11 @@ struct sock *bt_accept_dequeue(struct sock
*parent, struct socket *newsock)
                                sock_graft(sk, newsock);

                        release_sock(sk);
-                       if (next)
-                               sock_put(next);
                        return sk;
                }

                release_sock(sk);
+               goto restart;
        }

        return NULL;
```

I think this makes the code simpler, and it reduces the line count;
however, I think your approach is okay too, so it would also be fine
to keep your approach if you prefer.

[...]
> @@ -518,18 +551,28 @@ EXPORT_SYMBOL(bt_sock_stream_recvmsg);
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

nitpick: This READ_ONCE() is not synchronized with a corresponding
WRITE_ONCE(); that's not really clean, and it might be appropriate to
mark this with data_race() if this is intentionally racy with
potentially-torn stores. But that's a minor detail.


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
>

--000000000000af6b2e0651292a75
Content-Type: application/x-patch; name="locked-walk.diff"
Content-Disposition: attachment; filename="locked-walk.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mou3lwee0>
X-Attachment-Id: f_mou3lwee0

ZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvYWZfYmx1ZXRvb3RoLmMgYi9uZXQvYmx1ZXRvb3Ro
L2FmX2JsdWV0b290aC5jCmluZGV4IDlkNjhkZDg2MDIzYy4uMjZlN2M3MTk4NTIyIDEwMDY0NAot
LS0gYS9uZXQvYmx1ZXRvb3RoL2FmX2JsdWV0b290aC5jCisrKyBiL25ldC9ibHVldG9vdGgvYWZf
Ymx1ZXRvb3RoLmMKQEAgLTI3MSw1MCArMjcxLDM2IEBAIHZvaWQgYnRfYWNjZXB0X3VubGluayhz
dHJ1Y3Qgc29jayAqc2spCiB9CiBFWFBPUlRfU1lNQk9MKGJ0X2FjY2VwdF91bmxpbmspOwogCi1z
dGF0aWMgc3RydWN0IHNvY2sgKmJ0X2FjY2VwdF9nZXQoc3RydWN0IHNvY2sgKnBhcmVudCwgc3Ry
dWN0IHNvY2sgKnNrKQotewotCXN0cnVjdCBidF9zb2NrICpidCA9IGJ0X3NrKHBhcmVudCk7Ci0J
c3RydWN0IHNvY2sgKm5leHQgPSBOVUxMOwotCi0JLyogYWNjZXB0X3EgaXMgbW9kaWZpZWQgZnJv
bSBjaGlsZCB0ZWFyZG93biBwYXRocyB0b28sIHNvIHRha2UgYQotCSAqIHRlbXBvcmFyeSByZWZl
cmVuY2UgYmVmb3JlIGRyb3BwaW5nIHRoZSBxdWV1ZSBsb2NrLgotCSAqLwotCXNwaW5fbG9ja19i
aCgmYnQtPmFjY2VwdF9xX2xvY2spOwotCi0JaWYgKHNrKSB7Ci0JCWlmIChidF9zayhzayktPnBh
cmVudCAhPSBwYXJlbnQpCi0JCQlnb3RvIG91dDsKLQotCQlpZiAoIWxpc3RfaXNfbGFzdCgmYnRf
c2soc2spLT5hY2NlcHRfcSwgJmJ0LT5hY2NlcHRfcSkpIHsKLQkJCW5leHQgPSAmbGlzdF9uZXh0
X2VudHJ5KGJ0X3NrKHNrKSwgYWNjZXB0X3EpLT5zazsKLQkJCXNvY2tfaG9sZChuZXh0KTsKLQkJ
fQotCX0gZWxzZSBpZiAoIWxpc3RfZW1wdHkoJmJ0LT5hY2NlcHRfcSkpIHsKLQkJbmV4dCA9ICZs
aXN0X2ZpcnN0X2VudHJ5KCZidC0+YWNjZXB0X3EsCi0JCQkJCSBzdHJ1Y3QgYnRfc29jaywgYWNj
ZXB0X3EpLT5zazsKLQkJc29ja19ob2xkKG5leHQpOwotCX0KLQotb3V0OgotCXNwaW5fdW5sb2Nr
X2JoKCZidC0+YWNjZXB0X3FfbG9jayk7Ci0JcmV0dXJuIG5leHQ7Ci19Ci0KIHN0cnVjdCBzb2Nr
ICpidF9hY2NlcHRfZGVxdWV1ZShzdHJ1Y3Qgc29jayAqcGFyZW50LCBzdHJ1Y3Qgc29ja2V0ICpu
ZXdzb2NrKQogewotCXN0cnVjdCBzb2NrICpzaywgKm5leHQ7CisJc3RydWN0IGJ0X3NvY2sgKnM7
CisJc3RydWN0IHNvY2sgKnNrOwogCiAJQlRfREJHKCJwYXJlbnQgJXAiLCBwYXJlbnQpOwogCiBy
ZXN0YXJ0OgotCWZvciAoc2sgPSBidF9hY2NlcHRfZ2V0KHBhcmVudCwgTlVMTCk7IHNrOyBzayA9
IG5leHQpIHsKKwlzcGluX2xvY2tfYmgoJmJ0X3NrKHBhcmVudCktPmFjY2VwdF9xX2xvY2spOwor
CWxpc3RfZm9yX2VhY2hfZW50cnkocywgJmJ0X3NrKHBhcmVudCktPmFjY2VwdF9xLCBhY2NlcHRf
cSkgeworCQl1bnNpZ25lZCBjaGFyIHN0YXRlOworCisJCXNrID0gJnMtPnNrOworCisJCS8qIGxv
Y2tsZXNzIHZlcnNpb24gb2YgdGhlIGNoZWNrcyBiZWxvdyAqLworCQlzdGF0ZSA9IGRhdGFfcmFj
ZShSRUFEX09OQ0Uoc2stPnNrX3N0YXRlKSk7CisJCWlmIChzdGF0ZSAhPSBCVF9DTE9TRUQgJiYg
c3RhdGUgIT0gQlRfQ09OTkVDVEVEICYmIG5ld3NvY2sgJiYKKwkJICAgICF0ZXN0X2JpdChCVF9T
S19ERUZFUl9TRVRVUCwgJmJ0X3NrKHBhcmVudCktPmZsYWdzKSkKKwkJCWNvbnRpbnVlOworCiAJ
CS8qIFByZXZlbnQgZWFybHkgZnJlZWluZyBvZiBzayBkdWUgdG8gdW5saW5rIGFuZCBzb2NrX2tp
bGwgKi8KKwkJc29ja19ob2xkKHNrKTsKKwkJc3Bpbl91bmxvY2tfYmgoJmJ0X3NrKHBhcmVudCkt
PmFjY2VwdF9xX2xvY2spOwogCQlsb2NrX3NvY2soc2spOworCQkvKiBzb2NrZXQgaXMgbm93IGxv
Y2tlZCwgcmVkbyBjaGVja3MgcmVsaWFibHkgKi8KIAogCQkvKiBDaGVjayBzayBoYXMgbm90IGFs
cmVhZHkgYmVlbiB1bmxpbmtlZCB2aWEKIAkJICogYnRfYWNjZXB0X3VubGluaygpIGR1ZSB0byBz
ZXJpYWxpc2F0aW9uIGNhdXNlZCBieSBzayBsb2NraW5nCiAJCSAqLwotCQlpZiAoYnRfc2soc2sp
LT5wYXJlbnQgIT0gcGFyZW50KSB7CisJCWlmIChzLT5wYXJlbnQgIT0gcGFyZW50KSB7CiAJCQlC
VF9EQkcoInNrICVwLCBhbHJlYWR5IHVubGlua2VkIiwgc2spOwogCQkJcmVsZWFzZV9zb2NrKHNr
KTsKIAkJCXNvY2tfcHV0KHNrKTsKQEAgLTMyMiw4ICszMDgsNiBAQCBzdHJ1Y3Qgc29jayAqYnRf
YWNjZXB0X2RlcXVldWUoc3RydWN0IHNvY2sgKnBhcmVudCwgc3RydWN0IHNvY2tldCAqbmV3c29j
aykKIAkJCWdvdG8gcmVzdGFydDsKIAkJfQogCi0JCW5leHQgPSBidF9hY2NlcHRfZ2V0KHBhcmVu
dCwgc2spOwotCiAJCS8qIHNrIGlzIHNhZmVseSBpbiB0aGUgcGFyZW50IGxpc3Qgc28gcmVkdWNl
IHJlZmVyZW5jZSBjb3VudCAqLwogCQlzb2NrX3B1dChzayk7CiAKQEAgLTMzMSw3ICszMTUsNyBA
QCBzdHJ1Y3Qgc29jayAqYnRfYWNjZXB0X2RlcXVldWUoc3RydWN0IHNvY2sgKnBhcmVudCwgc3Ry
dWN0IHNvY2tldCAqbmV3c29jaykKIAkJaWYgKHNrLT5za19zdGF0ZSA9PSBCVF9DTE9TRUQpIHsK
IAkJCWJ0X2FjY2VwdF91bmxpbmsoc2spOwogCQkJcmVsZWFzZV9zb2NrKHNrKTsKLQkJCWNvbnRp
bnVlOworCQkJZ290byByZXN0YXJ0OwogCQl9CiAKIAkJaWYgKHNrLT5za19zdGF0ZSA9PSBCVF9D
T05ORUNURUQgfHwgIW5ld3NvY2sgfHwKQEAgLTM0MSwxMiArMzI1LDExIEBAIHN0cnVjdCBzb2Nr
ICpidF9hY2NlcHRfZGVxdWV1ZShzdHJ1Y3Qgc29jayAqcGFyZW50LCBzdHJ1Y3Qgc29ja2V0ICpu
ZXdzb2NrKQogCQkJCXNvY2tfZ3JhZnQoc2ssIG5ld3NvY2spOwogCiAJCQlyZWxlYXNlX3NvY2so
c2spOwotCQkJaWYgKG5leHQpCi0JCQkJc29ja19wdXQobmV4dCk7CiAJCQlyZXR1cm4gc2s7CiAJ
CX0KIAogCQlyZWxlYXNlX3NvY2soc2spOworCQlnb3RvIHJlc3RhcnQ7CiAJfQogCiAJcmV0dXJu
IE5VTEw7Cg==
--000000000000af6b2e0651292a75--
