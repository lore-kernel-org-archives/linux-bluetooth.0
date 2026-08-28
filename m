Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E717D46EF60
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787925053; cv=pass; b=klHVpZMIj4TAjDudzSaHArnQUixm5eKWg+slS55BqCnJqFHAtu8IcGXuv2IKODi08G01Hub+DrgpI4iQ6gKMt9kKSunRKGvjQQfbvUBbO28Kmuq2CfOzTLT5Xzz3esHfQLt8RnTAhIHSDL2XngDH/ncSM+cxTX+5m3bYt2pgi3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787925053; c=relaxed/simple;
	bh=J1GLMA2bKRpCZM6M5sJ2dVFywb8YOGnwkG257wnUWqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzJD0qnnG3dzokbwO5flowGa+UP80gHn/8rvHINAqkyl1yIgxsk++HEtms2G1hmbrA9D+49C3WDfcjrU3yRAfNQXvul0O3rp1QP1Z0R31v4jqLga+cng11OY4vLXhy1v0AiAafWO9gVuQ9bwsSNFn6QG1ovNO8vkAEx+szOw578=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pu3Cr8G8; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pu3Cr8G8"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-85dbc24d398so7567867b3.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 06:50:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787925051; cv=none;
        d=google.com; s=arc-20260327;
        b=seOHuKGajxmtjtR30yOxoj6nwJ26RozLAsT+V9gHW3GGQDBPbCVs32p3Gy7nVlyHya
         YmL/YZtT9VHf6PsOBa98QHhuiq8VUilDrt2GdK8NNCAuYQ49uz2hSthzqHsWXxM8y1Te
         gBOt2CSLWDAzjqMyiNz7N7QQrZs7AGcAaAQPPxZtbE7zzYNp1xqnVZhXCjSX6KFabAq6
         RHIDEXkMYAwgMFaKfeE5Ajwobs2CJerKiw8oxM8n4bU9LxlCs/XTjRJUN5S4eu4w3+p6
         78+8lRBTzRC+0Ia/W/n4XI2q/9NRnlK2IyADfaeVfBHRf3jBUZEGkRP9IlJQlUgg6ZE7
         MLeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=64SJ3fmIGzYxyFkqWkIrKuo7vHzyCWtN+93mzavW4W0=;
        fh=fAVvqa29TMCSLQ1BWo+IkeTh9vOt2h2EvlnFWIq0DOI=;
        b=qlxjNiiPpK23XWgX5sjqNXx1dIbY080hmB79VV8xba+0NcUF/rl42wiI4KfdNpscK5
         ccfMUh5ztCUXMQNfOi6eczjGf7jFaJiA/IXSOGQUvDszuqwwt8rCjy+SxbQlFsmnxQZU
         2/Vn/uwO3m3aJgSCxDEFNyAkkNuHKzpnfLEdwSdqamgmfSGaY9sBUlZfERjtGz2Mwwt1
         4DUw6t1/wsenCHMoaJkOacw90SxjkoppdXyrWGdpiXDYpJSxuhdDThdoXSIO2aS/2nbF
         p+aTVBxJL3gZlVsf2rpwu8fJqF7kB8ufl0q5dlSN1qQJImuqzY7o/DAESQawt81W6qjl
         tIjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787925051; x=1788529851; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=64SJ3fmIGzYxyFkqWkIrKuo7vHzyCWtN+93mzavW4W0=;
        b=pu3Cr8G8rddj74cB8pidNjy9essf7yWR4VOSftN9srqcCGjfV7WZjpZiS0lDI+ymiJ
         FSAszawGBPDEG8bnrpyhaItZEvi9xSFx7DATrjRMUs+UzgdjhGugGdYbzfMZvvnPpf/f
         BWfrV13aUpts7UrMDurll/VVngMXGCY5A7dHteMu3FgiicsAg9qwAMuZkuc1KxYDBqpv
         zbUQ5DwN8QsL+2B3zh+t6dZRvKYMnHVHIA+PHVyDmiLuOC7dcTG49MEN23aI2CxRCIIL
         7rhHoZlpzGnSxhXaLqzAjZVf16wi+uvaDKmSGAAwowoLKE5R0Zi/UU20791IwpJu6NHv
         uYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787925051; x=1788529851;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=64SJ3fmIGzYxyFkqWkIrKuo7vHzyCWtN+93mzavW4W0=;
        b=Njvjgi19kN+/fxyMMxRCbfz80FBIquv9bHuzB/g0n2DvGiD308xGWACfIBve3124hr
         pwy4OVj7QtRZdXtBKi1Jgaxbl1rIftvfxhOvc8X6PumidzsuqhSrNhTfyzDl1HAe2vmV
         E9lMT3bXW0S71fx5nWDTe15JU+mdGAeog8rqcGRD2mtoVYIyh/ss0YsEzBSTmVG+eWTn
         TDM7aJEYwzD0mq/IiAifoA2VqNhTOZ1LLeogSGwmv21b1ZvcQpJi5zeLp2iQg1q+xrvr
         +GKzgJQb9q0X1M/LLzyqBiJU7Vnilp5RmP268XdxN3pw3LDGyWmIR6WEVGKQeitYmYC9
         jE2A==
X-Gm-Message-State: AFuF++nGGDdBT0RDhjux5w04OuZaJRJScv+0iM5pnrB/WrnSiNS1DMfT
	UA8gb7r5vEem3pzOO0SmRcruU73WuA+8yt0TkdrGbMnq3LqBAKPty0A/NXDiZP8+mSBzovLvIUR
	zvfZuZ/Ye5rZAfdT1/85BoP+/ZaXNqWQ=
X-Gm-Gg: AYBFou1B5fXXjgSvv22MH4VbHcHVzr0zt46r++aJel1Gpy5klbZT2y0Ze9tU9t7oM57
	v7IMyu/n3z9yzj8OjmqEriiDwJZHiELWXzamOWRvhkANqMYzBikyO94Ca48I4nK/TzFveSLU4Xp
	G/psDS9MDDr1WFvQrs4OW4V9HKmUIhe1y3w9ccV71CqC7Gc3tr/cn6leqrsQx0yX/WsJ8MOK3UH
	vvLAMJbn6E8RxjJ36FcQULnrJY5IyNmpanJjBZOdH92N97mdsctwVU1WnKWWR9vAqhByBx4azum
	zMCMh3qOoTeD72KOO/CxkJROl6OuxvNy42Dz/VKlJmMSesjv5wTmR/X+rGNr2CGXqOD1ynCXtNA
	zcEYfYxtMZSGjE+b+Tj/WQbww9GsyXoIyzzbv3hHRqg==
X-Received: by 2002:a05:690c:e254:20b0:85b:f1ba:4cdc with SMTP id
 00721157ae682-85d6a9b047amr26552687b3.12.1787925050581; Fri, 28 Aug 2026
 06:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827180149.415744-1-luiz.dentz@gmail.com> <0186ef45e8d10fa469fe31f32d24b54c672157a3.camel@iki.fi>
In-Reply-To: <0186ef45e8d10fa469fe31f32d24b54c672157a3.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 28 Aug 2026 09:50:39 -0400
X-Gm-Features: AcwNN1XILCsTViBOtWaIshk-lOZaz5vu1P3YWTkRYx3ghLOlvQVWrPHcyt2nQWo
Message-ID: <CABBYNZ+qzL04d0cdKd==wFr_Gtz9gCa3_iNv0B9rE=R8pdpajg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: SCO: require CAP_NET_BIND_SERVICE to bind
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, Aug 27, 2026 at 7:41=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> to, 2026-08-27 kello 14:01 -0400, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > SCO sockets have no PSM or port namespace: binding one simply reserves
> > the ability to accept any incoming eSCO/SCO connection on the adapter.
> > That is equivalent to listening on a well-known service, which L2CAP
> > already restricts to CAP_NET_BIND_SERVICE in
> > l2cap_validate_bredr_psm()/l2cap_validate_le_psm().
>
> In current Linux userspace, sound servers that do HFP listen on SCO
> sockets, and I think often don't have CAP_NET_BIND_SERVICE.
>
> Do they continue working with this change?

Good question, that said this is a part of security hardening
otherwise any process could start listening to an SCO connection, and
the sound server would stop working. Btw, does the sound server have
any special capability to, let's say, open the sound card device so
perhaps we can gate it on sound capability as well.

> > Apply the same restriction to sco_sock_bind() so unprivileged processes
> > can no longer hijack incoming SCO links.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  net/bluetooth/sco.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > index 3d4362a09df4..e4c26551e513 100644
> > --- a/net/bluetooth/sco.c
> > +++ b/net/bluetooth/sco.c
> > @@ -667,6 +667,13 @@ static int sco_sock_bind(struct socket *sock, stru=
ct sockaddr_unsized *addr,
> >
> >       BT_DBG("sk %p %pMR", sk, &sa->sco_bdaddr);
> >
> > +     /* Binding a SCO socket reserves the ability to accept any incomi=
ng
> > +      * eSCO/SCO connection on the adapter, so restrict it in the same=
 way
> > +      * L2CAP restricts well-known PSMs.
> > +      */
> > +     if (!capable(CAP_NET_BIND_SERVICE))
> > +             return -EACCES;
> > +
> >       lock_sock(sk);
> >
> >       if (sk->sk_state !=3D BT_OPEN) {
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
