Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9815C42B740
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204658; cv=pass; b=UFfVT6IFsJpdEjJNH2e8GJJGeXiJ68BEImZ5/n0rRmRp4Jhs37rPCD0lR9/1MivW2PlG/Yh5RQFUnUo9AxW4E7kysyWlVHZwJ+atZhUptI6c5Q0GbPowhOMB/Q30Go2FSl5BF1efz7vaLCnVD5tav83xW80UQ1dorM39yNsJZ5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204658; c=relaxed/simple;
	bh=MElBKCSk3FkYCTCIjFHrVwb+DlGceZESdp/1beJSGLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRMUxigdYIWhiHMPL9L5NNCYmi+6y8QMaMfhiMx/9tlUVL0+O31toyHP/7H556K5qZeIyLUiO1h2MjZveXZ8YgC3qzaYozmFFcb1s+jX3PlBa7ZR+kY1dEg0BzOGGKu3I0BJKZ95bX03/9IVwYYGANbqohrAm4VunhYqLLRmlEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPJw2Qsp; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPJw2Qsp"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64ca9ec3ee7so2147843d50.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 07:04:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772204655; cv=none;
        d=google.com; s=arc-20240605;
        b=F+AKMDksVk6Hh62VbOdyWBkGyZJPg5E9xGvtDu0fUuPF3aGDq1CRfTU0hYMzCbdWGd
         h3fXxky/kYbkE5WrEyFOhaiwXYYQGtIku0qa7ed7jLDkLa9MKgQ8tgqcyi8ah+HyH7cw
         QmjL6vkqtXzPrJvw3SAz26R54pU9Bhs5zj7QJb5gvkzlXPU3/a2woV0pP58VoYUCES5q
         3lssPkwbsYZpbQlOeD+UvAz1AYtocJWpOPo2uRr0PHZWp8dQlt2BWYOk3C7AsuvpFP9o
         tr5aCVhCLTfO1RnoAfIYJSubhzJXmItc5sMZ3hzIgPc5HK4tomQeKmTPAnFXMgPxAzQ4
         CivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CUYxghmGwOGbN0KgXnyZslmrUmV22dfFBHamuG8+TkA=;
        fh=WSdjmQU1QbgeFmvw406+ZyFygjverx1Nu2xoj6r+OUY=;
        b=CpfSB3zGarnFZfI3dgjzJ4X/mj/gUfj6/4FkFGIHmAJFkR0xO2/FUmElBnWPh3XPC9
         UJ/4l/W+2ZtcPadABixsxC+AEQCZb+fpylVshMjg2uaaf7fm1qNjCzx9uRxNQCT6gFYu
         uuA4+WbvcXNUzO6KxidbN8dYAmiwuBqmbv0tRVujSkvvPNn2eyt8hwoLjEi09CHvKtBs
         TH1ez2SD40/r0/ABWScQ/ncDI6kNdykumMMRy8yrXf5UwW8hNoes3AS31w168+VrFNFc
         oSmkwabF7mSWG7GBDk4SHI0RrXGEZhg0fNKrZBGpJD9HXj7FJJYfbeELlT/ACOU6/Zax
         mLbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772204655; x=1772809455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUYxghmGwOGbN0KgXnyZslmrUmV22dfFBHamuG8+TkA=;
        b=aPJw2QspAsRdGENrg1WNtVZOEmp4q6ScHiJbH7O+5matbtR+AK+i3c2PzuFe8ac248
         TQRsNPe7fAjmHj10MaOH6ZikNutTyYH6gWPN0dQo6zQ7XY8vOgsKDnoPIBkFA0IVRN4w
         x+08G4cYbtrzL6NNItF27/ungnHCNKtXwUmG8MP20lL7YvRvKiHn16Cs1LzpVrM5iari
         bH/y3PMhZAcRPrJQ/dEBsWXdQDWK07Y7xMOg+aYfOIQ3RHp6S4X0WzZHBHyJPrYggyJD
         wNhwtFTEoSeU17jAy8Wm0g49nVlb8eAOsn6WEDa1xugrH37hVIZgTiHz1rb09VUg/x7D
         4QAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772204655; x=1772809455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CUYxghmGwOGbN0KgXnyZslmrUmV22dfFBHamuG8+TkA=;
        b=tXgQF7/wZGI4admcHdHHqqgHro6/jb6vGzBjDRe3kDpcAghWLo300fyuaXLgwY903K
         K451GWpgVhCUzCxczkz8vAk6ti9pwOIoiVL1PCBhBcu8x1z3MBR7AK6NTOITk83ciqq9
         f2Cd05vZv0Z+Bj0ZrzsXCdJ9VcocPn/718hglYa0aUqOZkl37wYt82xAgDvLFN5IKKMn
         HvA6zm7YIrquXjyhXJJPD0Edh1pcorW9aVObyILcKHMsHd64E7anw5rklmqElHQp19a3
         Rr62KnlInanPnOJW3YZdAdeVwjnphF6EvigdcDs9YEYex/Xu8jxuOYm2prkI2cHq6juv
         faoA==
X-Forwarded-Encrypted: i=1; AJvYcCWwdJgA38Lun0GEWOywhNTWjpHBflvp1s8FDwvV0t5kxlrpK08lq0xOTN5FN7Mmx9HMQYvHE3Ab9Fg9o08uoM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUKMWve3JCjRe/bq962QOE2G+lCQph37Tj7Z6jMntGVgZWs0YL
	WUETZLhbgQgnKIctnhEWoH5ND01anKe7nqBjua+1blniEEeGrL1dEsoq4hr+LCY1Jknnk0ugjna
	nG8RShLoC0PKu7HUcrLTklD3YQqBNqUI=
X-Gm-Gg: ATEYQzxguq/wTZExh7BnBO7Mf/876gryWyTF2thwkEmeKMn1QNYKydILgonHLNRO8tK
	GHxP3z6eKORDNWS3k/Rm1USr6kd6uEzAi3aqEfwQaSvtWxpjMF3TXS5JJc9Vxsa1sYFIsJrus9z
	HHOe8OOjDYvXO40CANTxOvx6jO1iCvbvQ65eWk9Eg4EEfyNUv3k3+N3bsApIOn81vA059tEZgc7
	uxzN1oqK2Nl34hX4xru1MtpWO50Bdzb6nORKzfBpa19hcVZssB8f4ITsdvUJN4AWvn7b67WpsqT
	YG2UsH1biowtjCd9OGZktswK7BQNXXP7p/YY54P2zwuTLT7QjNziUcnMZDTyMQwILyw8koqbbvQ
	FJqkx
X-Received: by 2002:a05:690e:40d:b0:64c:c00b:e774 with SMTP id
 956f58d0204a3-64cc23464ecmr2159511d50.82.1772204655435; Fri, 27 Feb 2026
 07:04:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225013527.17605-1-ericterminal@gmail.com>
In-Reply-To: <20260225013527.17605-1-ericterminal@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 27 Feb 2026 10:04:03 -0500
X-Gm-Features: AaiRm53eoGk-aRauOnYoza1TeZNCsnb25lFHXfzdfohww3bZgQck30SpoLU1GFY
Message-ID: <CABBYNZ+9Z8Yd9mRhgz0N9kSSvLR-6euPf9CRA1Sop_D8zV8wqQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: HIDP: reject oversized report descriptor
To: Eric-Terminal <ericterminal@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yafan,

On Tue, Feb 24, 2026 at 8:35=E2=80=AFPM Eric-Terminal <ericterminal@gmail.c=
om> wrote:
>
> From: Yufan Chen <ericterminal@gmail.com>
>
> hidp_setup_hid() duplicates the report descriptor from userspace
> based on req->rd_size. hidp_session_dev_init() only checked
> rd_size > 0, so oversized values were accepted and propagated
> to memdup_user().
>
> Reject values larger than HID_MAX_DESCRIPTOR_SIZE and return
> -EINVAL before entering the HID setup path.

Well this has the potential to break compatibility if a device
misbehaves. So is this causing a real problem or is it just defensive
coding? In case of the later, we may just truncate or something, if
that is not already truncated somewhere else.

> Signed-off-by: Yufan Chen <ericterminal@gmail.com>
> ---
>  net/bluetooth/hidp/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index 6fe815241..ce68b3c27 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
> @@ -815,6 +815,9 @@ static int hidp_session_dev_init(struct hidp_session =
*session,
>  {
>         int ret;
>
> +       if (req->rd_size > HID_MAX_DESCRIPTOR_SIZE)
> +               return -EINVAL;
> +
>         if (req->rd_size > 0) {
>                 ret =3D hidp_setup_hid(session, req);
>                 if (ret && ret !=3D -ENODEV)
> --
> 2.53.0
>


--=20
Luiz Augusto von Dentz
