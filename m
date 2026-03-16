Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46C139A041
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773668268; cv=pass; b=NXSSPDxQ3odn8bD2euP9DvK9SM2xrxoCv8roGZCzdtj1mKNmAEZzKitLNpD1nbh8itLLigFeiI/wgHiof5n31NLqw3+hsaiVMMyHbpyDxAU7ploktFEug1JH+Ph0rmipVMUoZe+KDFOOZiyEN4Q80gM7nFfOKWqN6ssuZ8SRFCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773668268; c=relaxed/simple;
	bh=ZQbJdw4m7a7vr9wG2YCSdkMWBugt8y6G8mKfL4tly3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrwC/el8HA3bRdqEPGR9F3ZUX4lyG9KxQ3pRcTSGmRgdMytiEpzJZ+xuneKv1CPV2caHqlvKu+bTUJs0qEa4Q3RyZB7eifh76J6Zkr4OFhse3kpNB8PIhohLCEjwmvbSalHW2FsAzBRGGPkt83m8HZ+fJFEBuVSWWd072V6I+90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVRCXpDS; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVRCXpDS"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64c9a6d6b70so3747039d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 06:37:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773668267; cv=none;
        d=google.com; s=arc-20240605;
        b=TnrKb3O3gkzutqKOvO131z2kBGswCq1/t9KCt2y/hcDPGg9G/Se3nm3xDOb0pR6Yut
         9kkDxmdGC1BHzHsSHZSzLE6yixqJwGBB6xv50mN2Qvae8SNX24GYDMSU/X1COjRjuq1E
         RaFaDiqfakCG5wYwoJOFxI6j9Z2K7b/xr1cfT2CCoT8qj/Npk212O5blZlXDSv27dUzf
         N62BAdL9IixBjxDrZaltmjfasJRA+Zv2kqNL1e6+BezKxNI086c6NcC0r2omzPXvtpzE
         QCx0HqnMjCIjMwGygkjCG/0uvi3x8fvYb51a7MMBUr9vswgjfv/VyJrKoT60FKeqO65U
         8Ggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZQbJdw4m7a7vr9wG2YCSdkMWBugt8y6G8mKfL4tly3A=;
        fh=AE/deCm8l1jGpeAuwk+JoIx4YWXoq/5XlnkrXft/D50=;
        b=emKOXar2Y7bQsSQBR74FsUctlJTFr7BxxXj2c/QhVeMmBTbDnJuOg/iCKzbVjn+Ks9
         ZL9+a3mzaZntC3LdHe/RpL9KNIiU3w/fvLMmOdLBd0mNihSHAVRVR0eLB+npr2s4/IH+
         X5g3rBeIxx+r4K8D/WaZfKmCbm9OQ5TzxUlQJxslc/5nPBz5VA8muRS5Oq6quAyxOoX8
         asfTYgL+1xz/Y/XB/ajP2+26elEiDIDCPjoAwO/odMrmCQZhg0Of3upQj+lMl8swL27T
         AVwa7U5TgyASvO89cfFG+nl6nLKfDCSuApEi8avpc66J3TaZ6ZXhOSSbhLGH7gFVyuzq
         oNvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773668267; x=1774273067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQbJdw4m7a7vr9wG2YCSdkMWBugt8y6G8mKfL4tly3A=;
        b=KVRCXpDSDq5NJXZZRWqJCrOgdE4UNQk36Zmcd2X7xIpbDJhZ5XMmk0UY7RyqSwLFTU
         VXpMCoU49JPz6iwfnmvoiPy7Gn1QxfLV4VDGUE1GgaNSzyDpLXjf/0c2VLN/cvMprtFl
         /HTys2QOAEEaoComgFubzW3pCk1nD4b5YmpSajjL1DHHVbVv0AYHb3Ax9pK3c0W+CaEt
         U0chCqtOIX5snK3Lh8bhv0K2j7J4NS4NkwgeWlzw+7wP6PjyKrsfLl6/wceONfuPj37X
         dBadPiFSogrgq/gFeGGh+2BZvXoyETE5WpvCDsZ8prZGqyT969nOI2gVTxFcu3P2c5zi
         nKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773668267; x=1774273067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZQbJdw4m7a7vr9wG2YCSdkMWBugt8y6G8mKfL4tly3A=;
        b=KAYGEhOx6V1gJQ9djfqpDgetsNZ7Iv2mmrduiheA7smCX3zBwrWcxyjV5+jOZzTwjO
         HLHluojpZwuulmDOkptKetPeQBxX/i8IENMPoNcmFlQCEM967NHIVVGJIhb/8bKxUzjB
         d14x54wewWbB8SWOdoRFbw2VHx0KOCIRyl1SWBu0Z5VtN6fkzFaXAPkdc0J8JUuSeqUx
         bviho/4/Gg5AW99qud3PDrpCQZR80A7+nBez6ESO1A4gzF4NmpXPrPq9RfsXUfpyZv3u
         onqGCkRHkF5jnCS4oq39E6SxdxrOBIHqeEJhbqobyDqh4bwYpj0ZcLtxtwtFUU/za7CZ
         Rb8w==
X-Gm-Message-State: AOJu0Yy472U7ToMB6R66P6MVQJjiU9bKE7M3s+N3Hpb20c8xSuuOusLz
	SIOKazm3re3urvn+r+Qkg3w/HKCkGs2f9BQG4ScjeWSF9xCcPMM3OeL1ILKNepeJRoQ+JYLYSbD
	rQkgUvP42UuCzVWrt2H0P/jabREsiG9f76TcHKZ0=
X-Gm-Gg: ATEYQzwG1sqV5rRwoZC+y9vmiqhShW7hoxa+PY4OYIBks1hGgwvbtJ2yfBN/wkPWnqx
	Fh9cT7oJmLtrBxe+i3/1II4Btu2BARrIB2PiJr2X5S6fpcXoAUlI/ytaxPyWXkr2KvzBzoeb3HM
	lK33X5tsD4J50H6ElV6Y3hJZgyPqaKAIQLb7HUiKSwjAr2m/n2y4EPh6ToKen7gzbD4VXVh1cg2
	WeW7d6itFZyNk9n2RSLUDy2b2k2jcklRvf/HwJ8QP7UU4bh0vLd7eHX8TE+B5Z8l5yLgiungVPo
	Jr8E+qy0qQJ1uVn1Da7cux/vtA+LIRbL44D/wR/btq3v6dko+niNG8Q5TiBp8bxD9Fw=
X-Received: by 2002:a05:690e:ca:b0:64a:d672:dafb with SMTP id
 956f58d0204a3-64e62f59bc7mr10734861d50.8.1773668266553; Mon, 16 Mar 2026
 06:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZL3W4+eF5ap7dS9ZSPmYkTLgmAEJ0H=OkC04x0LfXuqLA@mail.gmail.com>
 <20260315194407.13904-1-joanbrugueram@gmail.com>
In-Reply-To: <20260315194407.13904-1-joanbrugueram@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 16 Mar 2026 09:37:34 -0400
X-Gm-Features: AaiRm522YGnUJeXBGw7loaBvQ8NVLPghHbWdJSWDyuBtNp80Ntjh4o6XGfRKzkg
Message-ID: <CABBYNZ+reKNjLhs5f_xjqdDP-jz3jjkoDpm67XUOw7QUjhKTmA@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Fix not tracking outstanding TX ident
To: =?UTF-8?Q?Joan_Bruguera_Mic=C3=B3?= <joanbrugueram@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com, 
	Linux regression tracking <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joan,

On Sun, Mar 15, 2026 at 3:44=E2=80=AFPM Joan Bruguera Mic=C3=B3
<joanbrugueram@gmail.com> wrote:
>
> Hi Luiz,
>
> > > I had trouble connecting my Bluetooth headphones on Linux 7.0-rc1,
> > > and a bisect landed me on this commit 6c3ea155e5ee. A revert fixes it=
.
> > Weird, there shouldn't be any logical difference but perhaps it's
> > device-specific. Can you collect the btmon traces? Actually it would
> > be great to have the before and after traces for comparison.
>
> I have attached btmon traces (bad/good) to the open Bugzilla bug.
> (https://bugzilla.kernel.org/show_bug.cgi?id=3D221120), hopefully they
> are helpful in diagnosing the issue.
>
> I have also done experiments and found that the regression goes away
> if the IDs are not re-used, for example by commenting out the `ida_free`
> line, or by replacing `ida_alloc_range` (returns smallest available ID)
> with `idr_alloc_cyclic` (returns all IDs before wrapping around).

Interesting, I didn't consider that the implementation would care
about reusing the identifier as long as it is not outstanding, but if
making it cyclic resolves the issue, that's probably the case.

> Though I'm not sure if that is just masking a Kernel bug (e.g. IDs
> getting released/reused too early), or if that's necessary for my
> hardware to not get confused by the same IDs being quickly reused.

Even if it is a bug in the remote side I guess we don't want to just
break support, we will just need to make sure using idr_alloc_cyclic
doesn't break L2CAP/COS/CED/BI-29-C qualification test.

> Regards,
> - Joan



--=20
Luiz Augusto von Dentz
