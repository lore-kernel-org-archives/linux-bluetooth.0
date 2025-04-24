Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C1C291163
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 19:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745521853; cv=none; b=ShiT+o9b6XWkbA/BB9kNpH7OrRh8uTh30SKp5ECqirEWzu5PfPZs/9q4fDecmAdChmwfQcRJzqu9XxFCc0UPTdxi/kGAuIA8CQu/0zOYFzBNeuoao8fMT42qwdFUerukypkx9lIvax5UFpQ35uJRK+K9dRxsJaerucWa0YeWB3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745521853; c=relaxed/simple;
	bh=UBDXjZGEwKGtTdYsz+5Njf+V52vv7oTt1nLM+wPJOic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cTOrr+quMs+56Ky5hB5HGUmoBQ5LEwIZcHezAuro3Bm0cqNBf5pn5CtXE21ovw+NjKeGPrCxcWyePTgtA3fxVkD7PAILAJxiphAz4VZ4sqI2qcpD5J3CQPRBVJk1Ufm+Z4DOX2vng2/NhwYK4uYfgM5gc46NOuKsSsi0YUIILIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBM3e55P; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBM3e55P"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30ddad694c1so16303521fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 12:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745521850; x=1746126650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p63iKecEpFiR9UYf526ZypQr0/x5dWT9n/6gVcVMQGk=;
        b=VBM3e55P7M4KbCu45OIis+y57DpP1rbTM3T1uGzEH879bUdccCfAqFvzvfZWxHARNu
         /A2IiLDEQYQRghJCGAaaVLsGy7COJx+Bhy0gczlGgcWvuZ3RjuypfcCYm20RPnVtBKB6
         o1Yc5bAP5fwYS8JQmxzA8fBAUZkkyL/yTfSay5u+nr4bEmTxcuLYH1/81VrbgMG28YD8
         XTlI4d7HDoTbDB3lfAsOOp2DsmYxc5ZVIyh4RLSOsGqzMu/O3e3kfqUdjRDiGUkD8Thl
         i3+R4fnor5F7dIqAPK1NDfjNPiXzIbZp63n6NirUIirIq2AfKbP8NP7Z61pm1KUmbB1j
         AIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745521850; x=1746126650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p63iKecEpFiR9UYf526ZypQr0/x5dWT9n/6gVcVMQGk=;
        b=koxtH6Ip4XcQN3m+kt1hHPEKBL5riH3VzwSl5cl8EayM7oYvri4g6XfGrbudprAgIb
         FbaqJWzZFfiQTcPU/sKeInlzajgNyRTwPfH1ojm99VnzECGEsphHFzA/9DdugxUwi9oJ
         6oFIS+y728UnYHL2hu/Y7sT7m4nTANzQU0WoGIX/j716vF7l7VoMGiQ+UfL3yVo3k1Aw
         sTQgaMWhduWbv3z92Qwuj6O1/pIdmQfVfSao7PQbtQcgKBULBuabsJ8FSLr8G++OPsUB
         WIQhqYzqyyFLIGha18EOEs5R03gY0CaV9+N6d+ie7busgBlk1VbYdxAWBnp1Zl39P3mh
         hz4Q==
X-Gm-Message-State: AOJu0Yzm3iOlO1nfHjgP3E7mWLVFuF3Ol+Qu9Z8OIYMCbMwYPwjbITM7
	RFhLzlwxrt0w+zRKdiHFq2nzioaLu+Jm4lRdkHMIkNRSlHRpJ3zkagBdEryWKUwnoxVdzGoUlEv
	wbO3F7GjginRA1hN6kqwQ3aPWbisWCA==
X-Gm-Gg: ASbGncsSW6UtwiC6aX5HEpvo0kw+oXqR95JIDDE3QcEPP8kd80i69Anz4aW6EzDrTfw
	yhXJI0N0s0Adchr9s7xpyvqXemTMAGJhx8EKg9Dnpuuo4CjRrwNMpVdzzJIS6lkMt1SRZL7QxHQ
	rq3sf5Rvjht0hov/FQ6+V+
X-Google-Smtp-Source: AGHT+IHldMmkVIfiSO22zZDJq8KepTqDzwn80BMThNJHRdfZ0Y8jicBn8fEpnF71dmGHjAhdGj2qnRl7N1FRlWVK5F8=
X-Received: by 2002:a2e:b895:0:b0:30b:d156:9e97 with SMTP id
 38308e7fff4ca-318a7b0b45fmr3147991fa.8.1745521849909; Thu, 24 Apr 2025
 12:10:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66d361ea708bec460cb214662421cc9295ee2c7a.1745521149.git.pav@iki.fi>
In-Reply-To: <66d361ea708bec460cb214662421cc9295ee2c7a.1745521149.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 24 Apr 2025 15:10:37 -0400
X-Gm-Features: ATxdqUGkaK-t63dWM3hXnecixiqjICc3-YpgGZ4_G3EBJsQxiH6Jn3cy8qXnIB4
Message-ID: <CABBYNZKJLo5LB45G8fKjSZEoso3Km59BwsyvQBsavW67j8zj9Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: copy RX timestamp to new fragments
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, Apr 24, 2025 at 3:02=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Copy timestamp too when allocating new skb for received fragment.
> Fixes missing RX timestamps with fragmentation.

This seems to be missing the Fixes tag.

> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>  net/bluetooth/l2cap_core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 5ca7ac43c58d..73472756618a 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -7415,6 +7415,9 @@ static int l2cap_recv_frag(struct l2cap_conn *conn,=
 struct sk_buff *skb,
>                         return -ENOMEM;
>                 /* Init rx_len */
>                 conn->rx_len =3D len;
> +
> +               skb_set_delivery_time(conn->rx_skb, skb->tstamp,
> +                                     skb->tstamp_type);
>         }
>
>         /* Copy as much as the rx_skb can hold */
> --
> 2.49.0
>
>


--=20
Luiz Augusto von Dentz
