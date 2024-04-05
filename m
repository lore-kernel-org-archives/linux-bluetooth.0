Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979881B962
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334643; cv=none; b=jtI88s6qVRP8xteGsprF9YKL/tuLA4GdZga81NequlgbPaI016/hqrsicIj8xlP8pUCp2+AA8Pm2TrUvO9CmbzZDmtjwojltqGp5ial0lPW9zf9uUEZ+VidAzPddvuVbwaLphB+aSw2FJiv/o/KCW5Od9TQlQWC9lbeDXx2y0/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334643; c=relaxed/simple;
	bh=mZAO0eGvkxHG2mpyu+CTArarNbr1y0UO3cO2sRLcGX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OxjLca9fBhtZ6GJgdDfG3fra9VEflFt9wsOdTMYjFpspoIrZJNKB1s2wyLSFhoVtpBQ4tNMS8nxccuOl41l6HzX7cIE9BTFDa82WyOSZXby6iyr9GhrLb50Q0arRKHUoVnBtlTX0Tm9pvp0Ew5IwLlrURu2jlOOt0ePQ10RHSBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Cfaaa53; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Cfaaa53"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56beb6e68aeso13842a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 09:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712334640; x=1712939440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZAO0eGvkxHG2mpyu+CTArarNbr1y0UO3cO2sRLcGX4=;
        b=0Cfaaa53DzmmjnfbvYyIM/VTyn2u1ZkXnBM0g/B1Rh/NmHcw8hiB8N3Co73zN6ttNo
         XX1QUzoX0vpMeOAyPdx6E4Twyc9MZAMffCxS4UTW9mpUFyMif+Fy5KPVosanUSm5LEaA
         XEcofDgRlsBQzAmhimWNxWCzeRhb6XhhPgT3gLTPagFxdKSJ9igQjPsUmrCQuoI15S7o
         2W3jsaF/29a3pgwJrQCKgN5MHubNYqB/pojcTjiJkcQEd60RuVC/n2g7ytl3w8i8OKkY
         Fg6tT205xQ5MI9C9vU6Gyqr5a8cmywld2pNWEgfMRLhRSGgEQ9ie+tJ1VoN8pHGwkxZX
         g2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712334640; x=1712939440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZAO0eGvkxHG2mpyu+CTArarNbr1y0UO3cO2sRLcGX4=;
        b=T8SnoCX3rjaXdis9Gto4wjjOK90qgngi/U5Yljg38nYt6RcwpBDIjJlej9a6A2IyMU
         Lk0KYOmjAnyW81S8Vd4ge9QriT6oXLr3zFE+AK1UKWOBBvru+xINoZbm0dFIVbVQwDq7
         Mw2OM4DW5lQmEX1uDt6rG3J5ovue52bXvxd/I8pxB6ztDEnqV4dJsJ7BQbrimI9OwbH+
         CnUCnn3qLv/5GdhVeHhjMnm+zYOnozruq5rA+ntFYiAYtvyA/aBhUv8hOI69KJsrplEu
         kwaOPJ+BXKbq/EL2ltlPemLQcgU0W7IcGOdLFPqoHFyMPSEt6V0UP6zQ21yO08PYIAlP
         ApZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnKVMeFBgNiEHKPrjYRfbzZU31iMKCPfUciQMGVOrzXPP7wUIwh34bJKTLX0lInujxzoTlFpD5AhVFRvuiDYgEVe6V2PJMZF1hC9BhugR6
X-Gm-Message-State: AOJu0YyoIy+hKX2U13nRWpH9eXevx9qBtjmI2An3ePmv0AJ6JHOR0yJ7
	0GRacNAF3xTLd9pXu3rujTPqLffHbB5qh5qvxpHka0DTYaLMcYP4J13bcgSo57N5x41F0W/xCRF
	pP7wW7Dd5a2UpenSMZn905OPD1RCm5v/39ggz
X-Google-Smtp-Source: AGHT+IFIxTt/47oN4xzxy7w2j/J2GRzOa4Y/2PA00jhLgiVN1DOFojIjGH5/gYJ9pa8ukyqCNzixRZgQzN3Sa197xBE=
X-Received: by 2002:a05:6402:2035:b0:56e:2b67:a2f8 with SMTP id
 ay21-20020a056402203500b0056e2b67a2f8mr239524edb.7.1712334639671; Fri, 05 Apr
 2024 09:30:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404123602.2369488-1-edumazet@google.com> <CABBYNZJB+n7NN2QkBt5heDeWq0wbyE1Y4CUyK9Ne7vBRnmuWaw@mail.gmail.com>
 <CANn89iLweXJRLdn=v6WbqtvW6q0yLz_Dox87+GAnZUmx0WevKA@mail.gmail.com>
 <CABBYNZK08zDX07N9BTcFku=RSzc=W_74K2n2ky5f+qSexSLM+g@mail.gmail.com>
 <CANn89iLO9hO9QqQtNh=qEmLy+tE2Dr7fe9Nuj2dxYrG-z0Cy5g@mail.gmail.com> <CABBYNZ+F44x3aYK1kKUi8vLJT04QF48ONzrW06YJz=aq_oSHzA@mail.gmail.com>
In-Reply-To: <CABBYNZ+F44x3aYK1kKUi8vLJT04QF48ONzrW06YJz=aq_oSHzA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Apr 2024 18:30:26 +0200
Message-ID: <CANn89iJzJc+qNgwnEuzGReXqp6Gs7hWnex0_+f2CP9eTuohZyA@mail.gmail.com>
Subject: Re: [PATCH net] Bluetooth: validate setsockopt( BT_PKT_STATUS /
 BT_DEFER_SETUP) user input
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 6:24=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
ave used this so far (without risking a kernel bug)
>
> Fair enough, if we don't really have any risk of breaking the API
> (would result in using uninitialized memory) then I propose we do
> something like this:
>
> https://gist.github.com/Vudentz/c9092e8a3cb1e7e6a8fd384a51300eee
>
> That said perhaps copy_from_sockptr shall really take into account
> both source and destination lengths so it could incorporate the check
> e.g. if (dst_size > src_size) but that might result in changing every
> user of copy_from_sockptr thus I left it to be specific to bluetooth.

Make sure to return -EINVAL if the user provided length is too small,
not -EFAULT.
