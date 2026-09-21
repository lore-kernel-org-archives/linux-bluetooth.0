Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E88348C66
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 06:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789972146; cv=pass; b=MQVvgf9FSCSxIP6gXKThsgSoPo2f/BGstoHVUM505/u53uzrUh6Zvk5Ca/2+nkMz4r1qsViJWEAMjwszDQsR4NnXhD8hpZJBPxD/dBM8n4bNf9Q6eAgZ7mQ8+n44cyO6mMFwZMDSrR1/Q6M1Z7pVRwckLyQA/gPsRcFhTmcydv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789972146; c=relaxed/simple;
	bh=0Siashewy5HhEPnk9HS99tg2e28h1SWRdqME48VRI1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srtxa9iOQMfnsgK3tSvk36QGnrXqjSqPtRKKTVjQeUpN0UprMdvCqL8QbYy6gHZxccfFdhpiUpPO0LdGArGJlJbwoNu7cbduleeB7EwZytFlKQiagn1DTXs+RIp+hMV41bb/7Pp3G3VJgh9kji0PSmnkI8qLpOe6PTKHcdrQEvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWvXvPS9; arc=pass smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWvXvPS9"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-7fcb425fc2bso1533073a34.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 23:29:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789972144; cv=none;
        d=google.com; s=arc-20260327;
        b=SNIh9dU1f0/IB7nDse0/CT+WK5HJE5jAqacZiBlV/FVFuOrBA8H5dYW7NyNQa4qOS0
         yiYOQxMeROzD6pJ3tpb6uRNHuqhR6QE7c129xSVzepG/ho4E9d1mk7q8Zj9eZ1KxucOf
         JTMpOjrFKr5/07rqVKkUF69+XXIfvMxa1InRPANyK6OWE7wzvGYPU6U8iGDEFz4GDXj0
         jhOEJlBTeJ7xVpPP8Dmf1v9/1ki02IZY30ShRha0ZgEI2lIjy8PsfCD5vFn1ZxBx/fEF
         4aAmNUatzNnjvh/DuupjZaxq5J9Kw9rWoA7g/vCSv54IUPoHuq2cP5eb/6iI7ilOASSY
         tCPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4wszJZxcGrPvXsxoKIoCvqOUAPqt6rP310SMxZK2Rx0=;
        fh=SHuSR7Qh/Cx19nLoWLPIUjaMZH4PDAsk14bazaHcNT0=;
        b=qtbODbcntukCjAiFd5+zzVSQQ3P/eImew0hoYMgWMyduoD1y9E+8iFBKevLIGTaSo6
         jVo4OMvMI7Xv92o3EU1ssFPy8hTLK3/vHWMuUTBrS5x2wB9ytM+1fpXIt4aGTtZBIBlJ
         wHzaprVGgKPb8oD0oZHc4lM3YVxMsycZdh7kKOf8bcvq5mfGSAXQ0ubCpL0ndvaGxOIU
         oSzcuT+xZgjjFvVoHo0UUvJDCX5IhGLybGHMqJFPPFIHkBLx24YCPcdGir1mkxnPjwjH
         /LSmCHfqqAxtD7xXR04wgFoe9+JvZyhPTCc6VEwl8g4pE3Mgxi1x4PW7OE/3dSpMOj71
         T+XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789972144; x=1790576944; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4wszJZxcGrPvXsxoKIoCvqOUAPqt6rP310SMxZK2Rx0=;
        b=MWvXvPS9Rv2Mi5WEWoRs5vdkhLyIOEMvXVPPsRofBfG+93YFEROpc64c1Vu7yhbTlF
         1h+xahMqzMByWGFMahTNItzGD3fwG6f3eASCJHVOL65OTrx36BKTwYZ8l3tPGOt8lfy/
         uVPnXbc6oyUasX68XZrd1AD+dc4v7hpuwJEwxZ1H0lrdKKk3nCEq3gZNt/OmZgoJb4eQ
         XQWsHSVcyXRGzR5/2k5ZQWS0TrSCi0TePRSxXS+5MHsei8guon/IRqYGV2oAwyAknDFP
         eusolKdyZMwrVqITeTW82DfdD+cIFLhzt/gVkDjYHCQ/WDTi26Ti3s1Wgpw/SuoMYRtc
         mMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789972144; x=1790576944;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4wszJZxcGrPvXsxoKIoCvqOUAPqt6rP310SMxZK2Rx0=;
        b=gfF3t0x81v/ByR0J6v+FrSIPKrXu+D6Zv5ccqQXRlfPjH0lyoFQeeuCqUqkm2KA6CI
         rCAhEboKR37WhT/gCXsfwLMygCEYjskOC3/LKgP9bwWN1/1OOG85leM1R1u+zFKcV2Rt
         Uon6jFOtjRIgbwJbSYzrLPCKGMgrEhOoVPa3maDMirtJe//sydq2ZF5p2+cTooxxQn0j
         s6JEjybCSot/aNsp3NCdfm9Qxhh5TEwSOH6fSpsmtWiaFjYpWCwlGJzIEM17J6UcyHhX
         l+mav/rmKZH4L6cXyq+SVZWkYfgaxk6rdTo8vkuTihZi7JbWust1cFrXpPveMA5kS19Y
         JUgA==
X-Forwarded-Encrypted: i=1; AKwUvBy55W/DDs1h+S9Wn23tAgwpntoLeM3xWNOzk0fdtZMTmrWFThN9pUw2BlNPP2cD+fCNMYO3FFdMGNyghUcSYBU=@vger.kernel.org
X-Gm-Message-State: AFuF++k03JSlZKnbAB/RjEfqbhhloma32Xmus84rRldxNjIqg9uGP+3Y
	Nmqfgun7D5KdxWV4AP8zWMLi9ZbD4gqGJLySuzszsXaapqxor56rwVNtHjDGxpthm7ij3W1xkR2
	EbvMU6Nic4abm/Qh+wnM65hjiMEhm3gA=
X-Gm-Gg: AYBFou2QuNAiQAhfTzWRk+73LSd8RKizzCZnkYROAoUm/UN0yu3cgg7UTB9NOaRJHL/
	bsJkAzwdqNb4shnpbq3iHEigMTcEw/aDWeBO1b8hh9ZdbV5sY36/a5YVO83uJxBeZNsQoNkB2on
	dLqW4KI146co8nmohc1w7/ZalOoUXcvfR59C7BF2iURmv2Dk9Jt5wMc03+6D7n3ROwOabvRksek
	jviuQrqHrcqLHew55AbqFtbhIlpS3LMI25CkWNCRSUnMNRXGH0gg/wWtjMcPCjTDGFEq0+sC10O
	TT37++lW8LZ9WL5q5fKoHIKrd3IDqDAdJ2QNOaMSCpX4+t41sF2hAJaaLuke1HNZD31+IBzsOxv
	84fIQS4HZewhmnKfGA2BensvamTtGPNE82ebmidjQbQ==
X-Received: by 2002:a05:6830:2b0a:b0:805:98ae:214d with SMTP id
 46e09a7af769-80de33ecd00mr10242435a34.23.1789972143862; Sun, 20 Sep 2026
 23:29:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915070119.45143-1-skokovmaksimevg@gmail.com>
In-Reply-To: <20260915070119.45143-1-skokovmaksimevg@gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 21 Sep 2026 11:28:50 +0500
X-Gm-Features: AcwNN1U8r60wVh6GjLPev53mlYoIMZzkkVTykoSGJW9ylpZ52PDeMXNGWieYPeU
Message-ID: <CABXGCsOK6Cpxskgu93oNW6SvRenpEMhgYTmYNCpm+btoqkFPkQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: RFCOMM: free the skb when the DLC has no owner
To: Maxim Skokov <skokovmaksimevg@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 12:02=E2=80=AFPM Maxim Skokov <skokovmaksimevg@gmai=
l.com> wrote:
>
> rfcomm_recv_data() hands the skb to d->data_ready() and returns 0
> without freeing it, so the callback owns the skb from that point on.
> The tty implementation frees it when the DLC has been detached from its
> device:
>
>   static void rfcomm_dev_data_ready(struct rfcomm_dlc *dlc,
>                                     struct sk_buff *skb)
>   {
>           struct rfcomm_dev *dev =3D dlc->owner;
>
>           if (!dev) {
>                   kfree_skb(skb);
>                   return;
>           }
>
> The socket implementation returns without freeing it, and the skb is
> leaked.
>
> A connected DLC can have no owner: rfcomm_sock_destruct() clears
> d->owner, while the DLC itself stays on the session until it is closed.
> Data frames that arrive in that window still find d->state =3D=3D
> BT_CONNECTED in rfcomm_recv_data() and are handed to the callback, one
> leaked skb each.
>
> The leak does not stop on its own either.  The remote runs out of
> credits only once RFCOMM_RX_THROTTLED is set, and for a socket the only
> place that sets it is rfcomm_sk_data_ready() itself, below the return.
> rfcomm_process_dlcs() keeps granting credits, so the remote keeps
> sending and the leak keeps growing.
>
> Free the skb, as the tty side does.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Closes: https://lore.kernel.org/linux-bluetooth/CABXGCsPe5wykd8Aj-hm+SJ7S=
GQyb8yoGNnx3XDpPmBathj+EGg@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Maxim Skokov <skokovmaksimevg@gmail.com>
> Assisted-by: Claude:claude-opus-5
> ---
>
> Notes:
>     Noticed in the v3 thread of "Bluetooth: RFCOMM: connect the session
>     socket without rfcomm_mutex", where the same leak is described.
>
>     Found by inspection.  I did not manage to produce an orphaned connect=
ed
>     DLC on hardware: it needs the socket to be destroyed while the remote=
 is
>     still sending on the DLC.  A kprobe on rfcomm_sk_data_ready() over an
>     HFP session (RTL8851BE, btusb) counted 31 frames delivered to a live
>     socket and one rfcomm_sock_destruct(), so the window does open in nor=
mal
>     use; no frame happened to arrive inside it.
>
>     Built and loaded on 7.3.0-rc1 with KASAN, UBSAN, PROVE_LOCKING and
>     DEBUG_OBJECTS; HFP and A2DP sessions behave as before, and none of th=
e
>     sanitizers reported anything on the RFCOMM paths.
>
>     v2: no code change.  Removed the trailing whitespace on the blank lin=
es of
>     this section, which git format-patch --notes adds and gitlint rejecte=
d.
>
>     v1: https://lore.kernel.org/linux-bluetooth/20260914173044.5249-1-sko=
kovmaksimevg@gmail.com/
>
>  net/bluetooth/rfcomm/sock.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> index 958081adb9..82aa38715c 100644
> --- a/net/bluetooth/rfcomm/sock.c
> +++ b/net/bluetooth/rfcomm/sock.c
> @@ -48,8 +48,11 @@ static void rfcomm_sock_kill(struct sock *sk);
>  static void rfcomm_sk_data_ready(struct rfcomm_dlc *d, struct sk_buff *s=
kb)
>  {
>         struct sock *sk =3D d->owner;
> -       if (!sk)
> +
> +       if (!sk) {
> +               kfree_skb(skb);
>                 return;
> +       }
>
>         atomic_add(skb->len, &sk->sk_rmem_alloc);
>         skb_queue_tail(&sk->sk_receive_queue, skb);
> --
> 2.47.3
>

The mechanism matches what was found in the v3 thread of "Bluetooth:
RFCOMM: connect the session socket without rfcomm_mutex": for a DLC
whose socket is already gone, rfcomm_sk_data_ready() returns on the
!sk check, and rfcomm_recv_data() does not free the skb either - its
kfree_skb() sits on the drop: label, which that path never reaches.

The tty side has been doing exactly this for as long as the two
implementations have existed, so bringing the socket side in line is
the right shape of fix.

Reviewed-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

--=20
Thanks,
Mikhail Gavrilov.
