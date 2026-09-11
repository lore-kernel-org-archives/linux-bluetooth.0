Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA442F7EE0
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 01:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089427; cv=pass; b=MD4rRbKB7KuvcOKvCkfRM3mhYcdZ99iQaiGOMmYnq+dWHLX9+Ur0Yk4x/GTimHpKSSAn23VSa11Ml8kl88PZqCJi8gU5hNZPfUgiEkMxX1b91B2fjPIrVy9KsJJEYLTNj0dg+ken64pEm5BAU2MEuqvAiiZSWIrIE6rfUCjXdUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089427; c=relaxed/simple;
	bh=5q+iL/R4cDrY1TpT6uISBmPsAgAumboJPqFJbP2vER4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrevwsB+FMMdngQymduP5dJVPxxuSRslKTfB1m4OJw6+gUGttR52OcWM0VKArXKGEelVg7uICDejccc8wAMEeOzIACbc0B2yvKDqoZKzz1Abm9aBKGnbOTC95nIre+qzX7Ypt2dvy6GG6mh8Xa8gcxHWkQzevqa+8y34PQwY64c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HijGppF3; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HijGppF3"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb766bfd3so5516201cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789089424; cv=none;
        d=google.com; s=arc-20260327;
        b=jfxipRoSj5glpKeR0GIPBFXKIDDf2e3wsgvya/BhmUuQ3cBuP2D8ArFuveg3KcF5Gq
         q0TJdyOVtOvA5Hr4EmoHnY5KYxXjhCXqT+HG4dkbKQXkX0do3f+u6mU7abOCbvfGAHam
         tw0jjBTiSWLvjBww/q6h1UhyPkpteQL60GqMBr3NmYkOaihGs7qh3UnE9L+OSBHSPPke
         TacQo/be9sqX55hjShYfC/NSyZBp5F9bELf2RVP5jHWqXTs7Dlq/7kLqUP0soP91FZTS
         cN4mLIR4bY/zlt+rmD1I/dmr7D8mTOTZMBH2Hc2saNeeSwdayO3yWM54+7D9SUNPKPSL
         kqEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d5p9NQgPpyH0j9JiAgxiWq3LurVs8yYrQVoiE1QcZUw=;
        fh=F7E9fTj73Ng0QpnQM2eqiAlsKftULa+b2eloOEugHLw=;
        b=Mf5Tk4ziSdVqLoAVjS1AbWXvr1cb3ATcH+MK8eWln1k4v1fWwaGE+rwbn6g48DRzKv
         eAPSv9BIdb30y7wAISW5C0f9HURrGHsoHCOOZY/DzgpnlC6ACYkb2n0iy/RJ3gBiNz1u
         0vODpUpmRTl9y6rQdKdhkQxSXXl2x/1yBFn5+UaLJxC/D3QP0Ic8sbyl8d1TcFz3uxC9
         WzhE/cP6pnYpGgTLV9TLJr6FTAymyMo+rWk2hwGrueo4JDqTwA0MEOHSt7kD3u9H3A3a
         982SNDWHYjFgRCmky9rCXVvRguhQsPfrc8jG0rMnb77KUZTceTideroBsauxJY1+sfRg
         JDvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789089424; x=1789694224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d5p9NQgPpyH0j9JiAgxiWq3LurVs8yYrQVoiE1QcZUw=;
        b=HijGppF3YqI7mjQm+WRnchhbkLIGAn7xuY3LCkZo8iMrhJ1aQ4elSuEjtahnX4xhaZ
         1o4PGE3JPPQNog2RSzhnr0ZeP+TeGRBy0b8igJr+EByUjDl1S5u5jMiNK/07KSEAYWJ0
         A3W+cGhtl42Z54+D0OEYIvUPwO5VGMTWxyDkC4JasInYOJPE8gJy1TyFw+z8KWkBc2Xr
         gmfEWAG4rDDUKOCGHafU8aql42Fqx+lZ6w50GGKHOD285WXr/mOVPJ0XKWG2AHhSHoXv
         2id6kA0htS1/G1IfTxmv2m3LlCDlhSHd9eeRfJq2YzbXV2TRPYvaGE4MJyZaPMChHPsL
         OWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789089424; x=1789694224;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d5p9NQgPpyH0j9JiAgxiWq3LurVs8yYrQVoiE1QcZUw=;
        b=LCnE1i4bz/qgSPu8DPb+xrmTQqt693ZFvaawRk8hYHivy69sF45QZW7MQSZmpmTo10
         bQtVsNnEjaE3PT4Y7M+kiLx6U8H4x0gPdDCdqHL7ti6GzlMWHB8BYcQhqVhDKDXqbbxx
         w8utG2Lu1J7b00XCtxqTnf1X3BNKae5JtMF2mxX4PNavu7vJcC5eyF9zJt5BMIiLpXtm
         ao6V/7oTD1Sa0QGOd9hTeVBzdaBzCvTqzuF+Z/2Ck8NlDgieHrrFc9qJ7+m6v0x8BwdQ
         fCW9cUHlpfHvakdFkBc/bAlhkKlG9OUNeN8c47XtwHlT1q2jMiML3aFaGuQWyjFdRtQG
         AnCw==
X-Forwarded-Encrypted: i=1; AKwUvBwQjt4KyD3yOq6Rqe0kzMxaijlf/tsVKiAbPyBKrmz9+ENjAYyWnFC5V0cPMQ/n/rQhv6CpS+QG04k6MVpaFPY=@vger.kernel.org
X-Gm-Message-State: AFuF++l2HWRaMpCguiVyCideB4/hGbRIXUeI8d/3jL9NcRAw4N4vQ+C5
	C+Yhn+T/l56AuqR4Rvs/CJqfaM2cG1n3ppZqsPTYDny/P6vENY2APICXR91qarOZMqyi2mPQQkg
	1DEQqdeh4HFSeHUv/vNg8PaWFdituCfqDIgx3jf42
X-Gm-Gg: AYBFou37BzIo+Z9SXgPe5qI1n75BcixvPImQLCWQuoAXaJfdK5EMGO0E6lFBg0c697N
	x3wJE2hCqhoWmlkT3Sw4rXzXxAKQaoeowbjoE48xtHp8JqNIYLmzRwIsuTFrotYRYreqLED6tT1
	5Hd9F5pyfWVLv52Beat6Mnj1WfExfx0Y9EcblxOMtUT6oATvItcl0TVMOiLqYadPnLskBZo0QgI
	VeNejF2mmiKmUvnjQB6sbI74a2uaPXECqa+PdtzzOnaL6/6Ct+uiW347SmjQ8FrGIU4pBvB3Ob3
	8ICYLlvkZL2AViCVMDWZFzD/Chzxfx/6Ys0pXiK1WfTSrlG4bRxqQ+aD+WaN4bJQZ3GHdozOTqY
	wlpJW+kf/9YOIB0WT1v6qHrV8bLY+jS6FehQ1lcJBVfTdpyNyFcrOJ+Dq7FYKk1HvLkApAPGip0
	pALM4A4Ma+UMXvd5CnDXM93N0o5P+TBQ==
X-Received: by 2002:ac8:6f11:0:b0:52f:64c4:8094 with SMTP id
 d75a77b69052e-530c87226a9mr49908141cf.39.1789089423282; Thu, 10 Sep 2026
 18:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+0ovCgMrVBnn+0d198i0th0bcr0EAwNZ=0juh1ug8DdJX5mPw@mail.gmail.com>
In-Reply-To: <CA+0ovCgMrVBnn+0d198i0th0bcr0EAwNZ=0juh1ug8DdJX5mPw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Sep 2026 18:16:52 -0700
X-Gm-Features: AcwNN1VGil1vFMyCvGxTO0Uen3SBrfMM4J1yekoBWYuH_50vYwcqY9LxSE-7cx4
Message-ID: <CANn89iJg-10Xy_N_h3Et3wTasS_7RMkwxsz3XKmzYc7mLhKa-Q@mail.gmail.com>
Subject: Re: [PATCH] 6lowpan: do not compress headers that are not fully present
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Alexander Aring <alex.aring@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, falemi@asu.edu, 
	Simon Horman <horms@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 1:31=E2=80=AFPM Farhad Alemi <farhad.alemi@berkeley=
.edu> wrote:
>
> lowpan_header_compress() pays for the IPHC header it pushes by first
> calling skb_pull(skb, sizeof(struct ipv6hdr)), but that pull is a no-op
> when skb->len is shorter than an IPv6 header, so the unpaid skb_push() ca=
n
> drive skb->data below skb->head and into skb_under_panic().
> lowpan_nhc_check_compression() has the same missing length check,
> committing to the next-header compression path without requiring the
> nhc->nexthdrlen transport bytes that nhc->compress() reads and
> lowpan_nhc_do_compression() then pulls.  Return -EINVAL from
> lowpan_header_compress() when pskb_may_pull() cannot produce a full IPv6
> header, and return -ENOENT from lowpan_nhc_check_compression() unless the
> IPv6 header plus nhc->nexthdrlen bytes are present, so that the nexthdr
> falls back to its inline encoding.
>
> Closes: https://lore.kernel.org/all/CA+0ovCjTsygN76s2o=3DTZqPqW8v2gBhmRnz=
+q6G-NaB3Cq-YPqQ@mail.gmail.com/
> Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>

Notes in a semi random order.

1) You forgot to tag the net tree in your patch.

2) You forgot the Fixes: tag

Please look at Documentation/process/maintainer-netdev.rst for more details=
.

3) In net/6lowpan/nhc.c, calling pskb_may_pull() inside
lowpan_nhc_check_compression() can reallocate skb->head (via
pskb_expand_head()).
When this happens, the 'hdr' pointer in lowpan_header_compress()
becomes dangling. lowpan_header_compress() continues to dereference
hdr throughout the rest of the function (hdr->nexthdr, hdr->hop_limit,
hdr->saddr, hdr->daddr), leading to a use-after-free.

4) Callers of lowpan_header_compress() do not check its return value.
In net/bluetooth/6lowpan.c (setup_header()) and
net/ieee802154/6lowpan/tx.c (lowpan_header()), the return code of
lowpan_header_compress() is completely ignored. If it returns -EINVAL,
they proceed to transmit the malformed/uncompressed skb anyway.

5) In net/bluetooth/6lowpan.c:setup_header(), there is already an
out-of-bounds read before lowpan_header_compress() is even called:
hdr =3D ipv6_hdr(skb);
...
memcpy(&ipv6_daddr, &hdr->daddr, sizeof(ipv6_daddr));

If skb->len is less than sizeof(struct ipv6hdr), reading hdr->daddr
is already out of bounds. The driver's transmit path (bt_xmit /
setup_header) needs to validate skb length / pskb_may_pull before
touching the IPv6 header, and must check the return value of
lowpan_header_compress().

Thanks.
