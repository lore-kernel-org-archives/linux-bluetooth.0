Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BE93630B1
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777569443; cv=pass; b=SgLzYnrfyDQ2/MepYvxUfbd/P0iyKWzjrWE22ynxxNyI2ef8tabDpP0xKwt/lutBJCkrNWUsBgJVf54pKpuD1ewj5lGD52yhEPvLTUM5lzYWeZ7yiVQnyeQH2xVd0lIpsVGIz6lol32IIS5D1WxV1J99kMj5aIehC5WhHM8FRUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777569443; c=relaxed/simple;
	bh=xmlUvms7jbdQ6jObUvE2V4NxlxV71FYkVh2c+YJ28h8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TozBogaAA+XPwNwOohSFlGZxFk9B/rvbdxXeYvLz+NBl86e/CNP0qaumbt5MhV4FkqAbBJ6sU8W6Kuqj9rP3cakAtj1vKbxmOgnzr2I1OhRtWuf/IrW3j2Rab73ODem2l+2xDjL49fFLnjJnRjzqJ14tnN0tlwh3T+jnmYGLPh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CovOWcW8; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CovOWcW8"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-651c5d525f6so1062393d50.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 10:17:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777569441; cv=none;
        d=google.com; s=arc-20240605;
        b=OoQwWFDBXCAZb3lwFiS7uKSMKBCIjt2LESiuloAvfL6hkP2PG+mttuPE1zw+z96ao9
         FKQ2magRRJwiDrrTA5k/qr5s3P6DRXKSemU/SD+TVOjns1j0z6DrfQsEZ+lbRczAiB+X
         8MQ4peFWOh/ZDKNEGA0yIPWfUE8JTm4HeGgyQkPb0DLBHy2JSDnU8JgSup7oHu4uzL5X
         iosfyoqky8SW68tB9t3EXHE3ih0Yo5UbXFqtxPhkPbDVDCQheJ+8zaILDqPMTgnIZXWn
         DVZvcZkXSoYdh2hj02FZDLXuKPPGy1UBbG84ic2rVJljr4pDcibcoAFGWqpuuf+HUGlM
         agIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ha0rgF4Ilfcxptzl06v51LwEiI+VXaaWgoLeb5OWN3Y=;
        fh=/JS+b5oe9KkSfyrkqzdb83dGJtOrC21OBUWmK99Vd0U=;
        b=BXVFxj7+ujvIYrSs35t15caelpFvbQfQN26j0ox4aAAHobNWyIZrAXzd9oT3G/JtgQ
         EKz8Ny7pOXLzApeiXE8tcoY5IGscrh/YS+qDC6ya1Q+14KNztnnVl+lFGgdbcCmDlKqy
         fmPhu+rH4cSc2519v/5AwUUqkCCNmXEMxM5DD6BJOCeinzIGfX0I+JL+v8xcqYDnR/Wk
         vqgDykxTPzL85i992lj1qT1oNwGyd/aUIJUrn+7L2j/Eg6EI2z6Si2HNpFKUxpDz6Fhf
         c8dMPS00u1kx16a2LO+W8mMkSJd3gK4uE9gEiLjJsJXK3JLVY+ejHne9/c2r8HwulbAU
         DC6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777569441; x=1778174241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ha0rgF4Ilfcxptzl06v51LwEiI+VXaaWgoLeb5OWN3Y=;
        b=CovOWcW84jC7RWp25i3JqCHXWAfcsLdoImUZzkhgQZvmJ9y5dpxbYGvN0rNwPM63+f
         +veDO8LEEcAyo9S0VeimHSkUrtXQ53TRYfj6NRY9DgNh2HfE0YZaoADl8mdZ1q157OLb
         EE9tolFr6VhWI8JwMwzWbJkbcfmrCvtEQsbJdsANcR2mW9l0jyhS/dP3ER8Mq1ngr4EB
         sqbVr4VceyRZxDBaWYn6f1owoHXldBeArBch3imT1hOGaVBaLP4aWXzC2DcMXmp8OqXD
         4C4f+haECdZDG1ao04BVhKEvGjsXmYJgEIG9uyYWxPDVGEVKkz+GRYFaS3HvHcyQkFy2
         oQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777569441; x=1778174241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ha0rgF4Ilfcxptzl06v51LwEiI+VXaaWgoLeb5OWN3Y=;
        b=iaFH4Oib8X0ch4/i1m0Wt2MmaGzH3T6rtfaCu1GPlNFVPQT3rMP/RLs+K0M3t+FER2
         FOQMJO66mRMTygNAw9QdCQN9zs59u5LbW1shRJuRwtoIbV9S6VIRHj3mWoaNqGLf7Dru
         x5XhFh8D/g0s/1fovYWDiCXA4+shLUf24IqPwdbSr7A1PT+6h111N77A1Z6Uqj3yJ3S2
         u+UJxKwEa3fKbEXxx/XNCx2w1FOboRiqQospP3UslzFVDmHldlrpZbZKyCUYQ2QXshf2
         YRyrdIzvkJE+BXXd8DcfaPO+T1f8OrAkVqvWtt6aCWDyPBZbXq5AUhdivVYVJ9LXrTAg
         0brw==
X-Gm-Message-State: AOJu0YxavebXtD7EjBvERonNNbgw/PFZM/Hp/QmYRfLx0Mxf6JVIQk5W
	64ViNMjXbGtOFRgmBySaR4KEAvw854MIpPJ96HzaYD6e8P2qB0ZSn9qzYHfcbQihYdFUJTION+Z
	8piAP8RT7LZ72ToOieh3iTBPTWFUPTIE=
X-Gm-Gg: AeBDiet+UuNCYtJo4oXNuX2NL9/hF2XQKhPzqrnqw7/11XsocKAnmRhwfPprJYKGEsU
	aO+tpuZEUzYgmgKGDUSLbR1IPVsWSifWJpiwT+kKCoQTaRrtamPlaSFEs9Q3tSUolsd1kg0OtF2
	nRIwMoaPwx0w57lTV785p8FIAtSPfr8447fJYPX/PTQTXT1xMqy96vFm+3cLqZ7g2b3rOYkX79q
	aF3kN48MVzLIUQcC2aJmDqYnlnS/EABbd0NmMMEi+tyC5FBLxde5lWmm/q929ruNHP2aBAw62oj
	NadQDEksspA/nTfGqXn1ZR4Gs81knE/mV0GTCBKrvhXK/GFIK2W6vox5vWvOijYlgwRdflzqNwq
	kYPqK
X-Received: by 2002:a53:db4e:0:b0:657:8b53:bd42 with SMTP id
 956f58d0204a3-65c18dda124mr2437866d50.34.1777569441287; Thu, 30 Apr 2026
 10:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AS8P250MB079109F82C16BEDC4F9FE584EB372@AS8P250MB0791.EURP250.PROD.OUTLOOK.COM>
In-Reply-To: <AS8P250MB079109F82C16BEDC4F9FE584EB372@AS8P250MB0791.EURP250.PROD.OUTLOOK.COM>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 30 Apr 2026 13:17:09 -0400
X-Gm-Features: AVHnY4JApx891aGHP7nLh5SQa3vkfZx1uBEMocpDau9aHtZE1upWH-Epuj2FbSA
Message-ID: <CABBYNZL4P1HkA_FMFkBu0Ou-qi1a6Atv3ae-U32r2U1JgkOe1A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: l2cap: fix UAF race in l2cap_sock_cleanup_listen
To: =?UTF-8?Q?Safa_Karaku=C5=9F?= <safa.karakus@secunnix.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"marcel@holtmann.org" <marcel@holtmann.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Safa,

On Tue, Apr 28, 2026 at 7:30=E2=80=AFPM Safa Karaku=C5=9F <safa.karakus@sec=
unnix.com> wrote:
>
> l2cap_sock_cleanup_listen() dequeues child sockets via
> bt_accept_dequeue() without holding a reference on the returned sk.
> A concurrent HCI disconnect can trigger l2cap_conn_del() on CPU1
> which, while holding chan->lock, calls:
>
>   teardown_cb  -> sock_set_flag(sk, SOCK_ZAPPED)
>   close_cb     -> l2cap_sock_kill(sk) -> sock_put(sk) -> kfree(sk)
>
> all before CPU0 has a chance to acquire chan->lock.  CPU0 then calls
> l2cap_chan_lock() on the now-freed sk's chan (already safe because
> l2cap_chan_hold() was called first) but subsequently passes the freed
> sk pointer to l2cap_sock_kill(), causing a use-after-free read on
> sk->sk_flags and sk->sk_socket.
>
> Fix by calling sock_hold() immediately after bt_accept_dequeue() to
> prevent kfree(sk) from racing with our traversal.  After acquiring
> chan->lock, check SOCK_DEAD: if l2cap_conn_del() already invoked
> l2cap_sock_kill() (which sets SOCK_DEAD), skip the duplicate call to
> avoid a double sock_put().  Drop the extra reference with sock_put()
> at the end of each loop iteration.
>
> Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Cre=
dit Based Mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Safa Karakus<safa.karakus@secunnix.com>
> ---
>  net/bluetooth/l2cap_sock.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 71e8c1b45..4475d3377 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1477,7 +1477,15 @@ static void l2cap_sock_cleanup_listen(struct sock =
*parent)
>
>         /* Close not yet accepted channels */
>         while ((sk =3D bt_accept_dequeue(parent, NULL))) {
> -               struct l2cap_chan *chan =3D l2cap_pi(sk)->chan;
> +               struct l2cap_chan *chan;
> +
> +               /* Hold sk across the chan->lock acquisition window.
> +                * A concurrent l2cap_conn_del() can call l2cap_sock_kill=
(sk)
> +                * -> kfree(sk) inside chan->lock before we acquire it,
> +                * leaving a dangling pointer.
> +                */
> +               sock_hold(sk);
> +               chan =3D l2cap_pi(sk)->chan;
>
>                 BT_DBG("child chan %p state %s", chan,
>                        state_to_string(chan->state));
> @@ -1487,10 +1495,16 @@ static void l2cap_sock_cleanup_listen(struct sock=
 *parent)
>
>                 __clear_chan_timer(chan);
>                 l2cap_chan_close(chan, ECONNRESET);
> -               l2cap_sock_kill(sk);
> +               /* l2cap_conn_del() may have already called l2cap_sock_ki=
ll()
> +                * (setting SOCK_DEAD); skip the duplicate to avoid a
> +                * double sock_put().
> +                */
> +               if (!sock_flag(sk, SOCK_DEAD))
> +                       l2cap_sock_kill(sk);
>
>                 l2cap_chan_unlock(chan);
>                 l2cap_chan_put(chan);
> +               sock_put(sk);
>         }
>  }
>
> --
> 2.34.1

sashiko flags 2 critical flaws with these changes:

https://sashiko.dev/#/patchset/AS8P250MB079109F82C16BEDC4F9FE584EB372%40AS8=
P250MB0791.EURP250.PROD.OUTLOOK.COM

--=20
Luiz Augusto von Dentz
