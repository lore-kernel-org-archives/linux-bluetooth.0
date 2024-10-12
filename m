Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20724DDC1
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Oct 2024 02:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728701876; cv=none; b=IARNMcQjGq2M/uGfBMPXbaMamyJc5brwdgrTwtNLr7Vd5veoixIPu1mqIzHUpc683oduo/TZoUexdFfUG3NJRPpERfuLQnSbgropV2IzVOGfSaiYEnDCSSNJ/EiW1C4D2MYDykzvqo8TIlTOw/1FMqcp1qeyGCBfdN4uf9D+34M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728701876; c=relaxed/simple;
	bh=/iIcJjtvBqnZ+9JRTj0dHaeS8qk9/tP40z+abK/HpFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZ64uB8uZcKswecUCKC8KjvpAqfdNwXeNumrW0VNBtU00nEvLY2uSLOo9ENd3WOPGDYny7LZoKksH3G96+Sq7nXyYX+abvTIv40Uvl5Qf2KLzAwi86GN8Uh76Wo7sTvcvv6oi3qOnH19B1apjImA0UojtXIdx3QB8JmWWbz09PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMIFzEpY; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMIFzEpY"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fac47f0b1aso24692991fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 19:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728701873; x=1729306673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iIcJjtvBqnZ+9JRTj0dHaeS8qk9/tP40z+abK/HpFY=;
        b=DMIFzEpYZJxHADmzI+7nXxmGRUfH754mVzX8DUZJHuANaPiuZXqV4cE/WkDFhmgFXm
         NP0a9HnesK+EfblKojQwt3KmeXL3h3mxJdPPGkEvz1YZevqYs+C2WvVxe7+s+J1H/FkV
         Ydp38DUaCt1OUJzYwFEoyVr3JRiSIQBYdSdGjo4xK5JlNgIi4mh19g4ozkHxuX1l9BCK
         dKukYsO/d1ugUO2/6pC2nooFyt0uGBEN5YqrizxDU8SRSbXFiQy6oYx5AlE08LgUh6EV
         Nx2Mxh+zBZJ0CnkRD82kzHWbk4QU9YnTV9AdAx72gbj2Pf7LQvdGTdv0YkUmjg5H0rFN
         cccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728701873; x=1729306673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/iIcJjtvBqnZ+9JRTj0dHaeS8qk9/tP40z+abK/HpFY=;
        b=rRSmAp5jx4I7qecIcpdc5UAKLEQ6BRWT3rLXdcj4YKgxhJY1zODCAnnXR6U80VgEaV
         ZNCsHiuq0DteCEQXETHobn18Z3Ih30Bc4IXu2T6lp9Em421+SKHofAcFOUg4B5aAUJkB
         MZhdtYfTQpkrmEs0GJMgVW7/hKkzHbgxn9xVX/hga2lr7DCQXsw09ij+15iC+XkhSfoS
         15VNxQ/Han+JQ0TCfEDoP9GHlvYYaWrks4kRAmTDBgwUTb97QWLudoc4b520bmoc5veh
         N578PkPsFgr3dYrRgQ84fKMZVh4gkm64DJMbEjB9zK+SN4rTfaCRkAar64b1avMRBUWA
         E5Iw==
X-Forwarded-Encrypted: i=1; AJvYcCX/kIRyui5AC4qvI1QHoefywIfufLP2jcTQ0P+X9lSzw7wUZezcufTnMzrX6jI8hq3WRXlvd/KeVnqinGZlP4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfm4Ot0KwY/AlX4EvJ44Uo263bolDY0xEpfs/s/edirSOXMI/d
	ra/r9h007lNdBrPyhrFgYBg3/zc8RwuxaIfr3ggazP0b6gmSqGV2o0Z2EMQ7iqRyABnOWXGvhIy
	+W+pQD4EdOf2hEVzvYeaRzv+AJNZafgoP
X-Google-Smtp-Source: AGHT+IHtQfVQO75lhF/Qd/pzwShDCT00Lngpjpa4eBkGzQTsC0BRddIM9U2n49rk2ycj6v9UHIhrNtq+aUceD/AfQeg=
X-Received: by 2002:a05:651c:2211:b0:2f6:6576:ae6e with SMTP id
 38308e7fff4ca-2fb3276c6d2mr21743101fa.21.1728701872826; Fri, 11 Oct 2024
 19:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6c599d9b-a000-48d8-ae88-ff424bf5ec38@panix.com>
In-Reply-To: <6c599d9b-a000-48d8-ae88-ff424bf5ec38@panix.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 11 Oct 2024 22:57:40 -0400
Message-ID: <CABBYNZJoUJCowqdPHyajKfV420bWGpOqqUO34Ooh67onZGQy1A@mail.gmail.com>
Subject: Re: Commit 610712298b11 ("btusb: Don't fail external suspend
 requests") breaks BT upon resume on my laptop
To: Kenneth Crudup <kenny@panix.com>
Cc: luiz.von.dentz@intel.com, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kenneth,

On Fri, Oct 11, 2024 at 9:58=E2=80=AFPM Kenneth Crudup <kenny@panix.com> wr=
ote:
>
>
> I'm running Linus' master (as of 09f6b0c890); resuming leaves me with a
> somewhat-broken BT, but rmmod/modprobe "btusb" usually fixes it, at
> least once.
>
> Reverting the above commit returns BT suspend/resume back to normal,
> however.
>
> If you need any further info, please let me know.

Thanks for the report, looks like this is related to Fixes:
81b3e33bb054 ("Bluetooth: btusb: Don't fail external suspend
requests"), we most likely gonna need to revert it or change it to not
call hci_suspend_dev/hci_resume_dev since those are tuned for
system-suspend/system-resume.

> -K
>
> --
> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange
> County CA
>
>


--=20
Luiz Augusto von Dentz
