Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DF63D3499
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772037636; cv=pass; b=bUcuHcdYqbbJGKdupBgoJySVPPhiaNvD0INfu7hNAkerUI1tcIH3GFx4fzOZ14YyNxPK0AmSKrKAIkD61WGLvw+9PaACg2gRJGA9pXez3peTRXEr6Vp0JpShmkGEeUyb7ouxzzzcRt+ZitnG/NDUG60PKo+J2hn7SGR6oUUrxC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772037636; c=relaxed/simple;
	bh=umXUASNDnowdy0cQoTNJ8eGOesf/GYoFg0bCqUttGFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QElqDbljr3EahtCgDun9ORCqvRNq7RziwxCEEfteN58Pcfeikuqj65ExNYJwsT7jNvlLwjW4LuDo/iKspFjIKoBy7C5HkuXBFtLGSYa3ECbptBikXO/oeeHuEKWyVlLyhLmblTnmO72n8jGRENEg8La642K6YZckruXNAn5UaUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkS50ur9; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkS50ur9"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64acd19e1dfso5948787d50.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 08:40:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772037632; cv=none;
        d=google.com; s=arc-20240605;
        b=FDZdDXq0W65LusID3RriqwnYTt76G4QpAjdcbq0sl/Yx8EQw/2qlMug+03KYDPxCBP
         qAyVoHNwl+byWpx1LzO/vK9bKHfmfdxJ8bhcLfJFomN//zz82w/SS+xN68bBqx6kejSr
         1lKjTL+oFL+dZ20VgTsFh/AZK1EPBLrUuj/9jgg8rYNZpdD5+0vu2h3fd662e3mwIS3g
         1t65MXIDtuynl03j92BTId56Uq9vbFtSWEl/jYL9pci0KkAoKrBBMfr/cqjKbeETY058
         V8XjDZpEJEL+9cptjDKbwNp3IPF8ggv7txZLKE3k+nsjCLilrPTreFoocYZZ6jKu6Qfb
         oxgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QVKkuzLtw9bV8pm4EIaTCo3H2NrrDGv5Y9i5c/zywXQ=;
        fh=kQa6Wv+jZCCo0Dk13pUerCaj03ZHdzDdDvtl5YYmgPQ=;
        b=Dab07kLtL3Gbb0fQoMLqs5XZylKiV180161ZN/v/qm3lnTXWiio+xSdjn/SDm4VWAV
         0auMa4zFWf2LHBNijB6tQyzoeirysA+gtlaMuXxsydPwV9uIoDkZ6OoH2V5/G0WMhb5T
         ls/Q+CQEj4HfqO0JSQ8mhEQuDe3nT3bSnSDlE3RtH7xzmhKjDNZW4uIbbAZWUn7aXx5g
         uoMVu3vIf/wZsluTdiBiQFZ1jqDOY11nFzNPjfPrhtCe6xjolN2Rpkf2i4+CgtXAyYwu
         wTmPf4/qw25W7LGQUaRWarKO46BthhJypqBAUDp1KTOcpdaXySze5kRGAduuVFH8uRh9
         xduQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772037632; x=1772642432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVKkuzLtw9bV8pm4EIaTCo3H2NrrDGv5Y9i5c/zywXQ=;
        b=RkS50ur9KqgPNnCEQYl2L2pHJYYFDwOhb7fUojOjy2FvdpIW7bh1Vk4NdIrLck3HwX
         0RwuSkj87sOJh4qmFSKCYTcJFinKsD/xvA9UUAzu2BDRdsBbl1kaBoB71dDiAx5q8FCX
         mfcNGDUKc0THqd3Oe4izwVBru9ngTYBFWZiYJOICfPLFqtU6kA4byImObrSPlj025o3e
         ap67vqn9y43V+6A4bBFs+H/v5bcenAJm8NlDtV5D3wgVifMQCKxODfaAm5j+mH2afoR8
         DM85AB8myQ1tJWlkp5Ss0pPHquoB8df4eRuoKQ/yVmLZP3BCEmCQjGFKsjmjzQE4uOJm
         pxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772037632; x=1772642432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QVKkuzLtw9bV8pm4EIaTCo3H2NrrDGv5Y9i5c/zywXQ=;
        b=AOaXGcPGuw+lHLAHwrYQn1yxp1XP4mluodXMtqQUNKX3soiQ7X2J1rYDa12jLRAT1/
         qsUrq94nKiVoO/b7OaCq4W/O3snFXOZ9A9+qdKmp1slyZ1wzpLmS+IHZSXLzVnU6CEuP
         4bx7tZJfn+jzqiSZDosT+bblyUppSSfxt4rWRWYzHAWgywoFdpt4Sw9fZD+/5/fGHg9G
         8LAv85v/Sf+PFO6+L8ORddZeUEzbRucXqKvwt0EmwVF8s2OhOYOkMbsGMqLVw87k+0V3
         APM1ZvYoQq8+NFg+thZO3udTjFy3lFUsjo6pIxPjA6OFKdcDrzTe2e5C1GZQ3vB3vtHr
         qdGg==
X-Gm-Message-State: AOJu0YzScSu6tLOBbtMD/mIpdA8zrGliz5f+CEUN8MrKz1RYK2ixNJK2
	tHxbj2OTM58WaieuUoXdnnFUSBq06R1Wd5mAQwxweL6lqtzEVP9aQrs8/Bq5MPfQ2Q9/X3ssvAz
	wrmrsD/e8x/5yauhDn1e7yYRqSM3iPljb+BJAxS4=
X-Gm-Gg: ATEYQzzXsGUzRrSua1S19yu1aY8ayeDwEfBq3YhkMRDElhIOakgO7KTRxJYbv+02yy1
	ojAnXvItXaRXMAKDeym5R8WA6qbkgFg07j641IjEVJ04euKGRnlOpLQqX7LWO3S1AKI/AMTo2t5
	yd7YN2s2JEzxin0ePp1zrcjHKjr+Y+5ku653nhwu3HG52K84l2A1InyemKdc8Ttl2nomKH+6t6x
	FucbijGJJH5TpIdazmujyz/wbr2x/f7BN1mRvyM0eGtVuymmjavf9c9ujcULJazWEA5p/xj8Eoe
	8V0vrVNRQByOhXR6Imf3WVZYFIAz/9+J5DWo/M9bMjwVuGytIq8yUNTCS/dTNXAbegE=
X-Received: by 2002:a05:690e:1209:b0:64c:ac70:9437 with SMTP id
 956f58d0204a3-64cac70a263mr1493496d50.78.1772037632442; Wed, 25 Feb 2026
 08:40:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225161715.20394-1-ceggers@arri.de> <20260225161715.20394-9-ceggers@arri.de>
In-Reply-To: <20260225161715.20394-9-ceggers@arri.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 25 Feb 2026 11:40:21 -0500
X-Gm-Features: AaiRm532hJ86tnghzcc2iLvbF_EK1zuTNFZfXaO0bPphigrABkitb4TlVEsR2xg
Message-ID: <CABBYNZK-foKpbaxdWOxRnFSxo93gZVJPQhb-h=DhP1jcMAe1zw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 09/12] l2test: add comment to -O <omtu> option
To: Christian Eggers <ceggers@arri.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Wed, Feb 25, 2026 at 11:22=E2=80=AFAM Christian Eggers <ceggers@arri.de>=
 wrote:
>
> Clarify that this option has affect for BR/EDR sockets only.
> ---
>  tools/l2test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/l2test.c b/tools/l2test.c
> index e49289a4c774..7bdf58f0e776 100644
> --- a/tools/l2test.c
> +++ b/tools/l2test.c
> @@ -1338,7 +1338,8 @@ static void usage(void)
>
>         printf("Options:\n"
>                 "\t[-b bytes] [-i device] [-P psm] [-J cid]\n"
> -               "\t[-I imtu] [-O omtu]\n"
> +               "\t[-I imtu]\n"
> +               "\t[-O omtu] (affects BR/EDR sockets only)\n"

Actually this is no longer the case since:

https://github.com/bluez/bluez/commit/290f9973c9069f293367284e95fd338a221ab=
90d

>                 "\t[-L seconds] enable SO_LINGER\n"
>                 "\t[-W seconds] enable deferred setup\n"
>                 "\t[-B filename] use data packets from file\n"
> --
> 2.51.0
>
>


--=20
Luiz Augusto von Dentz
