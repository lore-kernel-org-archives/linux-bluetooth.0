Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812AB3D810C
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168878; cv=pass; b=L45TLrSnlQ7sZ4r33qRugLEzsioEDtvyObZm4ecC5Vr6cGaR5iHJBoyoajlXSb5Dkhtcy9Y+KcqSaYFvzIXe4cbK4mHojfiPx89yakO/jwnBvTAPIIJpuhNYCgRfkTry9jYY8NQ33KHRQbc210+PvY1Sil4YMtEACtUK/fT1xfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168878; c=relaxed/simple;
	bh=q10VzBkB2pq4QNp2zfHKGr6Ca+oT+tEYjX/lb793kOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCd3lqIqFgLTcO3kJnwGwgVeOimwj8Kfe09A5+qqrKmmM7PQ+9iW6owAMRpBUIKgQrNpLVJjO8YEO9tX1yI493MgASaD7FgzTrZNlOp+zTS3DMRQWw/uTwrmwU5Ihhz4UI+T8b1lmv/FouRWwAlaWC6S9P4MRBg6f3VanczXjm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jJitIXpz; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jJitIXpz"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c2544ff970dso500312866b.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 02:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788168875; cv=none;
        d=google.com; s=arc-20260327;
        b=W5qDTviaISwheO9DqZk2jiP3GnGfxp4+xmnqPm0m4rf4QSMpyTZBbAwhl6NIEp+iev
         m3Hx3wqv6OCA+VZCEJSuMu9MmncCKgKCIoQs3adDVp20O2KiGYXPhJxHPPs5yATgDwC1
         Y/yxOB1L0WEUlfvroygTX0BnCC7tca3rvuTSNJpppGhhkNMEdsSZjTJ+jy0SEzIAQY6l
         vcqiB5PKqFKb/LK9C4WkvmiQPZVSwMY1SQb2Nlx41rtOlsd/OFB2KUnblmaLurc7oiOP
         lJvUQ9ORjt0vHIRyDJJShA++YHpYkDJHyN8XkKTm9jkcmdYOs+zzH9aaRgIPyZSKpM8H
         N5qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UsNW+bOUezawPMhJi0LdgKQenUPI6J7374ic34WfjWw=;
        fh=/Mfk1GDUTIXbbVs/g5jn0MST3hWyNKcvPlL+vo0UG1c=;
        b=CkpyXnDeOMZMFA5awPWYG0ynUs8JkS53flAqwCjZNX/ew6WdZJfZhOEP20Oz4bqbtY
         yDp+yvNzj/c4+TpRs/kOylXjHrn967hyjdUw0r0Y/m785+z445UCYQju5LZ8YTW6qXsV
         OkVB8eukn7dODTWz3deQuuidMiApERl9CCQOWC2Hk6y3fworlyHYYWcMDwH51sVwXQ/J
         uX0MEc5I0LMKMhHEzM14CT/3+XeOOzfAgiZCFQICd6eyNjBw6sWtoXqiGgF5Nj59bB5t
         0FZEbrm+/C/QdQzUFK3PcU7DaQP4B/CgQ3bfrzsJzj5VjXhxEDBoxF4Wr2tT6jJeonRz
         nNbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788168875; x=1788773675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UsNW+bOUezawPMhJi0LdgKQenUPI6J7374ic34WfjWw=;
        b=jJitIXpzL0asfeBrCuen2QTrVbcX0buEncJyF+In6HPREGiHMoXMH32ftopXuAiNhD
         3IACRB3ITc11yaTFIxRp3f3dGOlyfd8VGxh2pblq0a5g3hhp0HMnmnCESF5hXMkmHyy9
         mfI3P1hLcgfxnnyXRdYyCsLRSCNeotd4fuJIcv2A9QHmaJM1coiNNjBJhwPYbEmAQzjU
         6OiwHfdfa/vDtcD0rf2Me7J6FyNoAuLcJbKo0WdRVjCC5E7x185ZAlqQVKoSD78yWro1
         nRXRorv/Z2lEbz0OMuEwW4EhQi/kukq2yCMdTp8xeFhujOBJD1etYJyQR5Zj6btbagOq
         GyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788168875; x=1788773675;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UsNW+bOUezawPMhJi0LdgKQenUPI6J7374ic34WfjWw=;
        b=Fglga3cRil2fZ9G6Ktj2oZAWoffGQ9EcY2m3CVfwkLc/EkpBNJAtT/C9vqAFahJoLO
         f02CW1ycVe5NnBIRbs5YD2Ty9fWVaYtrhLUhLVNNdDtm5LajJHGt1BABzj8dOYDlIZZz
         4H4R8UL9LqhG7e/6QDiqgH79tNpCE6aeQgId1iury+WS18gRzNiJ7a32s+CYRBdkVLa5
         K7UuEb4NuL9RsImjdOIXqLtne828Wo2vNQYCot+UMsiJmmiVq4O4g8IL57uZxkADLCl6
         l3WOpkamqFUq/yxbvWzvWxRGT7C2Oxlc7C3nDEmNCm3YaHg4Ct9H97TotHnfj9rh2EYv
         ToTA==
X-Gm-Message-State: AFuF++mDOKenHrOHM5dyGHG/I4mRBUH2LvslohZYbxywOvL0/oh9PUNe
	6vDNgX3jbijvtggBKD+bRa/USIdt5DA6ApKowrIQsOut1D0vjJs3SKHGvo7ddgHotuKS5BZRLpd
	FRIoYj5/Vqq6rvUlobw9g+eaO8gJieC/9SSckcy506g==
X-Gm-Gg: AR+sD13ZkCpXBGUOfJF2Q+elKp9Qe169fvMUX3IFK6QOPKDYq0+TBjXDo/O4PSOctz8
	DR+FELouD4za6cKXVtJ89ruEKlXVjyZm+8/YVH6SIaEzy2yhY3phEL8iwnh1rsHba/WRjeBiGoj
	7WT9fzGLWQCqpGrJDwQ5WKXLxCHwq/56O5waQXJVYWSe4Qzn7OinKnX5omaeITn5ighRuf6iozX
	WlZ2w9YkrKWolTR5Jp5gMvKosrCbhQZv6uKRytbT+la9DJXDA6X2sIvb/71d7bsYmV+Oc7+8K07
	PtHYF/qG0SjawhKxfr8AATbj8uN3tMziVbtkKSsVp14l
X-Received: by 2002:a17:906:7947:b0:c25:4ba1:5953 with SMTP id
 a640c23a62f3a-c255702dfb5mr1639734466b.11.1788168874731; Mon, 31 Aug 2026
 02:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827110242.1203546-1-andy.chang@synaptics.corp-partner.google.com>
 <20260827110242.1203546-2-andy.chang@synaptics.corp-partner.google.com> <20260827-uncolored-onlooker-d62c44a3323b@spud>
In-Reply-To: <20260827-uncolored-onlooker-d62c44a3323b@spud>
From: Andy Chang <andy.chang@synaptics.corp-partner.google.com>
Date: Mon, 31 Aug 2026 17:34:23 +0800
X-Gm-Features: AcwNN1VP0Yfh6sec6kZE6kJacWoF9mvzSerldBb-9Msqti5cyfrQxgnjl9Rv4AY
Message-ID: <CAF8VQdEA7=LRpHaVOVZxRi73kRf=0pK_etJOJ5oeULtgw4k5Bg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: dt-bindings: net: bluetooth: add BCM4384
To: Conor Dooley <conor@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Linus Walleij <linusw@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 12:38=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Thu, Aug 27, 2026 at 07:02:41PM +0800, Andy Chang wrote:
> > Add the brcm,bcm4384-bt compatible string to support the
> > Synaptics BCM4384 Bluetooth controller.
>
> Please explain why a fallback compatible is not suitable here, or
> alternatively if it is, use one.
>
> pw-bot: changes-requested
>
> Thanks,
> Conor.
Hi Conor,
A fallback compatible is not suitable here because the BCM4384
controller requires a dedicated firmware patch file (.hcd) matching
its specific hardware ID and revision.
Falling back to an existing compatible would cause the driver to
request the wrong firmware binary and fail the controller
initialization.
Therefore, it requires a distinct compatible string.

>
> >
> > Signed-off-by: Andy Chang <andy.chang@synaptics.corp-partner.google.com=
>
> > ---
> >  .../devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml        | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluet=
ooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.=
yaml
> > index 95501e858e6f..612d21123aaa 100644
> > --- a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.ya=
ml
> > +++ b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.ya=
ml
> > @@ -31,6 +31,7 @@ properties:
> >            - brcm,bcm43540-bt
> >            - brcm,bcm4335a0
> >            - brcm,bcm4349-bt
> > +          - brcm,bcm4384-bt
> >            - cypress,cyw4373a0-bt
> >            - infineon,cyw55572-bt
> >
> > --
> > 2.25.1
> >
