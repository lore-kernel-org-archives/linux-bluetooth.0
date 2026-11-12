Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794511226;
	b=UPV5menznIZkMy9nMdX9rNzxyec9wLyXU4KT4wTW9nur+xfrcjQFq7ZGpLiaJlWyDAo+
	 1rOxAhfdLZORv4jcMCEfX9cYFznqgaeiSY8ZNL9yJgMoUjETJrSQV4twd5sAG5QWDvQ8d
	 sU61GrJGqyLm/+ZpnxAA8/QVW+ig+apdfDAD28zr3VnQFkRb1JvfsKVqwv+urJoVN5+kO
	 VTqYySccfvG1fDM4kW8wEiYevZ0pg40ra1aQs86ZxPSi8ANxr3G9IjEib0+p4QaxRvW8L
	 TNRVZ3cQrq4Tjl2iUk7QPPlY2QwHdHcOj4lxZI68HAdA2uw60qh5WkWtxODbBSoQN+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=4n7QpXbjdzKs5E/QIytIxlQMJVNHtcAO43KXppNYH3o=;
	b=ulALepcCvDWc+/OgtSzlAorQkdKyisvURtNkUQHjZ6QUpULqc7+8H6tU1igAB0nmAeux
	 6sUItL3u9KoQCF72Lcz8sACN1tjXkZ3RAdPQhr38KaSAJduSDPGsb/AjD6vcxF9ePddhU
	 Lp8bDq64z7XagT9hAStNF+TZ3PvT/16obk1+jcma+mN8qb3wi5+MbMe1rZCcZ+XtIDvLu
	 ErB0JBJyaEiEZWS5rCR9KkkgZCqlVQDASZPP+gUD81A3ntOxzBKUEqYlStiB+U6b/3QrO
	 XFVM1jRZp03yuNDyCQE0lSsxCuiBxkI+/OtjgKW79A8QtTZTNq2HJc+knTyrOHo8bnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=chmfI7TT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEDE606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 19:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BEDE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=chmfI7TT
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67c05273c38so204683d50.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 11:20:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794511225; cv=none;
        d=google.com; s=arc-20260327;
        b=rut+CUsbP3Kkz6NnnqBwXrCdCqnX2smbtWOahr3zO6rhR/h8IV3sN6Y5vdYakHi3d9
         hXFb/WA5WeLnm8QEM+u5WmvXgYlOXHhQ4Hrq5QmkuVzfw55+DFkjHYx7oNZAXZEpPy70
         eGtRz9Q1KIRNuhBwzTAebzEQu/tkLYfmvyqIATBoPThUHKx7BHYo3oVLbaB16gSgoQvN
         NpYYgasthLSlWFXWW+5ogmetjgGtVQik4C9/CfPFKguIA221PsdeNBsyHmo2KHBHGWus
         rAwiPPbLZfUHPfx4Pv4W5KrPkHbqoSRn1IuwvR6cus8rqBJJBAoFHki1rwR9/21fydeV
         vJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4n7QpXbjdzKs5E/QIytIxlQMJVNHtcAO43KXppNYH3o=;
        fh=fAVvqa29TMCSLQ1BWo+IkeTh9vOt2h2EvlnFWIq0DOI=;
        b=oiT7nSPuFMkFl9RVGo/ON4NjYQDG+jLqd0WKTpjCUK8jszA1Y7ubhMNC08Wq1S3FdH
         pB6uGoicX5EXh1FV8CttEDebmLnpKZ7+bGdL55HRcUTujlUmjCeZFBt9y95V2emMlrD7
         r6JOGBalPHRU9UrPZz77dkz+pWlP766zm5KQ9h+NWSLBZigf87dmy4NPbBw4vebsEwma
         gvFDPu3s+LsA3IsBSKGhlWaq2q/P5WJfc7bcofhJvwNPBXJvWfgo5UPBFfiqSolDEQeY
         q7AbvSgDpy4Fm0FATo5bnYsDXtPwG9HYugyqEja+/5cx50/1GHqDSGmM/0eCRpzq04Jd
         P6ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794511225; x=1795116025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4n7QpXbjdzKs5E/QIytIxlQMJVNHtcAO43KXppNYH3o=;
        b=chmfI7TTqrQ2h7EoU3jxruJrUw7/TwkMdNt69ctw2kEos0OIVDAWs7JRZzg6xJyOXB
         9Puc7t3RisdHncd4D0ls1tDyLXcNGnG4K8TVAstBOmXkFCU9ujHWtRbzWHf+kIE1o8p/
         9+crdBVEpQy30mDelv9Gs/9VWBLvx/NVqkHpg55ixWDM9u2SmCPQVfnz65eO6M0n0qY8
         S4WcNqqSVKTF/Xa2eh3arPyN0Eob/nJY/7ObEukwaXzCaq4IS0sLZx+tspbrlD+sTet3
         9U2vJXjXVYc5lIhTUdCUmgztnVQMsrKt/EVDT7xmU6OGlndwBwXjsd5OpWpcFyAzC5fi
         Zr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794511225; x=1795116025;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4n7QpXbjdzKs5E/QIytIxlQMJVNHtcAO43KXppNYH3o=;
        b=fkWxV9SziQyeXFHyUlYyKdUZhvDdvB3NDL1Vy8T8cN8cJYu5+sOGjepdATDYhwLibd
         x/y7sX+NlwI9biw5Un8LDlquPhVlLLde5t0WdZyDGT8CiHIgWXlxBKjJUZcAWomWJv/2
         zHVW5SLXpUklfslt9gB/Je6w+kk05Ypz8EHzbeQrGKrfDu/cMHDsOBFEnpR3YsAAPNVA
         j6k+eMGaWpchJNit2BHwhQYAqA6KyOgO+I2Y7NFwmE99a6DLiAzG/VU2vVccLvANg2ec
         R9pKpz6BaHpjJSzkW5Z6UjyCscwFfjw0kLE3qpreMr7yoYeIL7V84qaZJE+tq2tbr6S+
         Vi+w==
X-Gm-Message-State: APuU4Z+CbvyOisfTaNKRk01BsHpVc6+Al79t7AQUOcHHc/mqsXutcTEX
	iWYHvMn4Azkd/J1M6XqmmbqVKlXc2zs20qK9hslWyc/HM/hi7CC/lCEKwyO8DcgY7Tca9rd4fJ5
	qXZ6YFGZjsVJLEgxgFzf4JyinY8iJIOUX+A==
X-Gm-Gg: AYBFou3g/1pRREAk2oWnofAJ3DYPzFXepQTIv3uepFUMbLbnxEOXDrpQdl2sLjoBrWV
	90qmmCGBFS5NiJEVihGZdzv/uaE230b8V2gYiFtKKkVDcOhYH7gEWatiJL7ZBHpqPlpAKOny/hy
	NgI4cplaex7S8l0Yy3x05aiZHN0ZbX0I11b5djGFLmYB0vqYUE599bOGRkq23JDyqBTJTo8vwg6
	d31p4iyrjzwZm4RHVCqkrD4IhEDydS01UBP+i3vPLft4f5rr8avTotY+gAm8MYQmSOMGOHYd5MI
	bkRUnpPkt7GtSsV6/5RirYqMMM9eJgeXHNVmQIepPQUcnkFWTzYPsBeWBGXnxrjdDoESkgP1YnE
	QKOX4zcTXo1zV0+CXbbSavzp3NHNPEY+1j2fYNyw1nRCAxKtPf+vrEqI62GQOky+IhXjmFfZoCd
	xvBn4Knrv4bRQ9bByI1c0HW/Ebiw4xAPBRDOw2X4H/ivfCle3WP6XRrOGXLCQ=
X-Received: by 2002:a05:690e:408d:b0:67c:1b93:c8f2 with SMTP id
 956f58d0204a3-67d897536cfmr211883d50.86.1794511225141; Thu, 12 Nov 2026
 11:20:25 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794504552.git.luiz.von.dentz@intel.com>
 <58959d386b3510668043b393074e097f773e09af.1794504552.git.luiz.von.dentz@intel.com>
 <fb7500035873e36482ca50348f156805c48c4af6.camel@iki.fi>
In-Reply-To: <fb7500035873e36482ca50348f156805c48c4af6.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 12 Nov 2026 14:20:12 -0500
X-Gm-Features: AclHuK869aV68viiVRjTkNWBRmAmGnxnNGbAm6xUdN28DwhNPPW2frBUEsouA1Q
Message-ID: <CABBYNZK7_TbHtDi8+wXgZK+G1gbFvZcHjf8Gsk=pObxeRQcMBQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 5/6] doc/functional-bap: Document clearing a
 cached configuration
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, Nov 12, 2026 at 2:04=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> to, 2026-11-12 kello 13:14 -0500, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > Describe the test where the initiator clears an endpoint twice, the
> > second time releasing the ASE whose codec configuration the acceptor
> > cached.
> >
> > Assisted-by: Claude:claude-opus-5-5
> > ---
> >  doc/functional-bap.rst | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
> > index fc367e0f9181..eb04e6520aa8 100644
> > --- a/doc/functional-bap.rst
> > +++ b/doc/functional-bap.rst
> > @@ -230,6 +230,30 @@ test_bap_unicast_desync
> >       single ASE of a CIS, so a failure of that one can be told apart
> >       from a failure of the initiator to enable the ASEs separately.
> >
> > +test_bap_unicast_clear_cached
> > +-----------------------------
> > +
> > +:Setup: As above, with both transports created.
> > +
> > +:Steps:
> > +     1. Initiator: ``endpoint.clear <remote PAC Source endpoint>``.
> > +     2. Initiator: ``endpoint.clear <remote PAC Source endpoint>`` aga=
in.
> > +
> > +:Expected:
> > +     1. ``Configuration cleared``, and the initiator removes the trans=
port
> > +        of the Source ASE, which the acceptor moves to Codec Configure=
d,
> > +        caching its codec configuration.
> > +     2. ``Configuration cleared``, and the initiator releases the Sour=
ce
> > +        ASE again from Codec Configured, so the acceptor moves it to I=
dle
> > +        and removes its transport. The Sink ASE transports are left in
> > +        ``State: idle``.
>
> ASCS iiuc allows Release from Codec Configured to go Releasing, and
> then back to Codec Configured, so it may not possible to get rid of the
> configured endpoints.
>
> Samsung Galaxy Buds2 Pro IIRC works like this, wasn't possible to get
> endpoints go back to Idle.
>
> In this case, does the current patchset accumulate pending
> cached_releases?

Interesting, but I guess we don't have to follow that behavior as a
server. Therefore, we can assume that two consecutive releases would
result in the state becoming Idle for this test, although we cannot
assume the same when acting as a client. I guess the open question is
whether we need a configuration option to say if cached configurations
can or cannot be cleared to emulate both behaviors which seems valid.

> > +
> > +:Notes: Releasing an ASE in the Codec Configured state is permitted
> > +     (ASCS Table 3.2, BAP 5.6.6) and is covered by BAP/UCL/SCC/BV-106-=
C
> > +     and BV-107-C. Without it, an initiator could not get rid of the
> > +     codec configuration an acceptor cached, as it no longer has a
> > +     transport for it.
> > +
> >  test_bap_unicast_duplex_enable_one
> >  ----------------------------------
> >



--=20
Luiz Augusto von Dentz
