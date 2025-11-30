Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE73123645D
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Nov 2025 22:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764542935; cv=none; b=PZwqgih4/Kch4QGqbUn9+mkjHIz3q/iYBltha79PpYOsssDxypy+ehqVs9tOKKAnrB4GdqV5NxsQ08awtQ6J/p1uXv/fDeVnMWl2j/hj5LaNNyVYbI29dyGZWA+Zuc+TzZmEai7qWEgw2wGERJBZUw3xm5lUKUf+7fHTabb0n04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764542935; c=relaxed/simple;
	bh=9sX9/T9/9JaM5/R8U7tkFVXzo3VPYq145U8+UrL1z9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQQOCfLdCvU/l7u/Syh9aBdqzVibvI5XXPhdYEIFabtIjF6pIApKqG3ap6mRTXFhZJoWrJbjUjpccit0RAwfWr0vuWgiany4PHk1vYXjxUHXSL2fHiULN8hWJIrVTGM58WU//Ag+uGxD5vXAfxAbsFAgHdkLI0GU29JqM0THHfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kauhHKYa; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kauhHKYa"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59581e32163so2812114e87.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Nov 2025 14:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764542932; x=1765147732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sX9/T9/9JaM5/R8U7tkFVXzo3VPYq145U8+UrL1z9Q=;
        b=kauhHKYaP+qehL0UWPjhc/3W13kobg65MIl/6C2wL/EdhNQMJWX14HlbCVYAj7//qM
         SmMZua7rJ+6IXD5PkfLDjjfHtUVsKro7xIfKp1ZAzOi92wkFitdDhXAiI9lmkBjw6AXw
         nxcYyOwN5EOVkDA2x4/W8se2t5sP6ujZ5sx5mOLQZz3zhbDEyAdIYk9VGYC/IA2J7Vt0
         njKhwgNijlkZEjfdekW6ltX431v/FD/gPcSkDari6VLgt8vCk+I68oK7yTBNO8z+i7bI
         7Z+aG1w9W1hc0R/kvxfXqJFx8dxqF1MBNdV/yDU7a6W1Ra+BdI1xQPpEAI1mySmnoWkL
         igsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764542932; x=1765147732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9sX9/T9/9JaM5/R8U7tkFVXzo3VPYq145U8+UrL1z9Q=;
        b=X5/bj+P/LjKUe9M6Fqz+h9Nj2fBzzVt0kQlBSuw3uFVUydB/ZJCLSSC2qimBKNpITd
         LZsFyhUffqU3V17cph8cjBdP9Ra39xR1odjn4kebX7hRCz1o87zsB07XNfvue6eoRjcJ
         Z09fSs/88DuxO7ZeuO7Ta+JsEb96sEl4ezQBWkR38S7qt3GGBdn0IeBQm2EXTYCGAggm
         /MXz+9O5xObzavATD4d77moHLp1BDXmOr3AQXt2aYAxUa7cRneJY6h15v3Fy2F6aUmzN
         rZqUipuwKhZlHBp5FesZiuLjRlGiiqvnvB0uggPuNrK7kz9ptGeUCwinZAHG9kdIN8zx
         /lrg==
X-Forwarded-Encrypted: i=1; AJvYcCWDx8Zu90+nsYChHaepM57iiv4I1+oK3o4UZTFGdB6lY3/MScAUypQsEUyxqL6eu17ep/MnW188M8jcjtwulBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7D9LOVi6YkcSj9IBAsjuXHKg9msG9hdYiUDw1dB/7gc9sctZ6
	9cK104eOVik/Ld8Po1VXdrhGMNUryA5SPuKS/6ML/QDoLuhAug/pTx/4fUuwqBoyCWkoKJPfwoG
	FZJa13fiQdn6kDqow/wwHJpptmiN8DP1Hm32/
X-Gm-Gg: ASbGncuTnlaZ/riXcsu/Yh+5g+6bbtt1Wi17LikwSq3W9qA6mzUwCiuFOGEQc58Z72J
	eWOv4RyyZH4GQoGbZKXdJf1iqrjGYclkxnf1dI5hJROjQIT/tLoHU/qhfMC3O5bGN6kLNoXxWX5
	OUdT6GXXTsMpp+vEwcU/rL/n2ZY7iXiMiPoX0UmHtn/6hxCPBVnrTtdHJ4lux3rFtowEiRwGOsQ
	dM12kgAsDT9d/g3C9/TWVtICI4ftqEN4qjBBbdAockI+yAuO/R3sxZEUOJ3agFVoaAFF9eum4TR
	t2xYLBVArBIzTshd0imVwAFt0Iccxp3KlfCZgg==
X-Google-Smtp-Source: AGHT+IHT3CIhmpbMpuFvZDufy9OkfSrZunDbFVUdJduyAArFbcRKZUiOYcb3BeMA1b9dMO/0sMcVVHr51wwUWwxmzCs=
X-Received: by 2002:a05:6512:4016:b0:594:2582:7567 with SMTP id
 2adb3069b0e04-596b5259bb7mr7711611e87.38.1764542931789; Sun, 30 Nov 2025
 14:48:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5AQj25sJi6nHX+FO7D3eFPLi7_7LpBQfHW9qXQHH2nQsw@mail.gmail.com>
 <CABBYNZLfGVoTVcNTyVd2snYdebK0_S2Y3fdW0bNfNnYtz9JqaA@mail.gmail.com> <CAOMZO5A6Dp14VRH=sEEdK65nja05gnK=gZc7qjaQZm3BSVLhhw@mail.gmail.com>
In-Reply-To: <CAOMZO5A6Dp14VRH=sEEdK65nja05gnK=gZc7qjaQZm3BSVLhhw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 30 Nov 2025 19:48:40 -0300
X-Gm-Features: AWmQ_bknb0z3yNIIMKcEtwY0NquU5gW_s493D1U6OOEvMh4mPkyaCU3rglYOU4M
Message-ID: <CAOMZO5DY2POZVKO30O0hQvcyuMs7d7pEyKTVQ=mvh7DDocWxMA@mail.gmail.com>
Subject: Re: Crash at hci_conn_cleanup() when bluetooth service is restarted
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 1:27=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:

> I appreciate your suggestion.
>
> I tested it with kernel 6.12.53, and the problem did not happen.

Ok, we'll stay with 6.12, where this issue doesn't occur.

Thanks
