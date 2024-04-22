Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF5750269
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774449; cv=none; b=lp64dN6UKkuT8i0nXWxGIyPHkUzKo6MAOiJeQm/AwXHzy7MfMWI9xP/6FmEoh0AqKprTy62BIb0DOYi48T62stkIIVyVSRZKyEXElkzQll0YrJUYzqgl2yK2Sc7guSdeCHc7/uAbI9cIlkYak5gKxwXmJTqmLaBvcXo8KAZbI3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774449; c=relaxed/simple;
	bh=aD78rLqskgC914RCm9khoqMnLlDqno7mNTeyWzYamUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MnaAq5huL6N99zXK4tPrGdQbaX0JVBsfyvjAnyOEgk7ZBbry2xda3bKjELcVoa/h6VBydtBTM1K7xJtOXhuuJ6M+5jNGh4t4n26U5zY488hH57eRBi+QDEqvk8VKAAeA4ZF2JBpR4g8tDwzjzrpOvhMAJ5GBn+ITTVn9O3wS/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=m4x.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=m4x.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-de45385a1b4so3898926276.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 01:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713774446; x=1714379246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aD78rLqskgC914RCm9khoqMnLlDqno7mNTeyWzYamUo=;
        b=kEe193fot3y+2AOaN2jTVztnI4Da2fHhMkiO0fiZIgwr5bOUQYp54IYNartBYLfc0b
         Wy0GVX3tVATNaulhvun7h1qO3vWjFNuMfsJWahnSprp29peo94XUgBuj7E8LPqwkx8GM
         zbheGo4IhJ4+g6P7SCk8cPHEaiPu1ys7KT8aTHWMjhS9PDP0DXlyE75tkc1+4f2S65bF
         5TzI3Zh4yi6YU8dgIvZh6D+YKRJp4tPJ54kwPWlq/NIMwBTNdFz92LyGDCnn7+fzDNAa
         lWGCUcEOJLYBM4AA0h5KUZfedMxGezbdRxzlx0IJvVcuTquCk8dFnUpXNHPWwnhpg1v1
         AHCw==
X-Forwarded-Encrypted: i=1; AJvYcCV/riVc94UGkqq5aS2ToFw7RGFyLiReyBVnnj67KnUHdoTfjvKu7/xA5Ng6ZZ33gqd5m4RCF2ds/60i8oR5jwBP/tbVA2fl/x1wIUfUZ5Em
X-Gm-Message-State: AOJu0Yxn4iW9H8Di5spHWVWhM/C39oZZHmK7OfNQODwkOJhDH9527pgM
	7Aq736hAq/HXNKIlpQW7Qvh8sFYXeayhZkukKjjwD0OJ36pZ7PHe9qnuJeNfmqPRpf7Jl+N7X//
	EUToORTYF5njX+BfKpeAXUQ6JAY0=
X-Google-Smtp-Source: AGHT+IEXbCZSWU3g4FXj1qrawUvWhPPACO+jlqdCC5sZMwpmG56BhjWMWX1FBTaRWJRoaoBVZzPomrfAdD+x5fnr/C0=
X-Received: by 2002:a25:4e86:0:b0:dc7:4ad4:c977 with SMTP id
 c128-20020a254e86000000b00dc74ad4c977mr8441742ybb.25.1713774446122; Mon, 22
 Apr 2024 01:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADRbXaDqx6S+7tzdDPPEpRu9eDLrHQkqoWTTGfKJSRxY=hT5MQ@mail.gmail.com>
 <8eeb980a-f04a-4e94-8065-25566cfef4dd@molgen.mpg.de> <CADRbXaD5Fsy0dxjrVG2JAn1PA36hpoTe6=23=zbhx8NWNf_9mg@mail.gmail.com>
 <e723ec51-a1de-4d4d-870f-34c9427fffb9@leemhuis.info>
In-Reply-To: <e723ec51-a1de-4d4d-870f-34c9427fffb9@leemhuis.info>
From: =?UTF-8?Q?Jeremy_Lain=C3=A9?= <jeremy.laine@m4x.org>
Date: Mon, 22 Apr 2024 10:27:15 +0200
Message-ID: <CADRbXaA2yFjMo=_8_ZTubPbrrmWH9yx+aG5pUadnk395koonXg@mail.gmail.com>
Subject: Re: Bluetooth kernel BUG with Intel AX211 (regression in 6.1.83)
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thorsten,

On Mon, Apr 22, 2024 at 7:41=E2=80=AFAM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> Thx! Did you also test if mainline (e.g. 6.9-rc5) is affected? Without
> this we won't know if this is something the stable team or the regular
> bluetooth developers have to handle.

I'm now running 6.9-rc5 and have not been able to reproduce the issue,
so it does sound like it's an issue for the stable team.

Cheers,
Jeremy
