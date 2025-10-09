Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCB015B971
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025224; cv=none; b=IeWFwOSS2M432GghwSHE/vP6XWmR0UHsjxOgySO0asCZEBJozeCxWvuHUT+BqF3UgtlgxACWAc+WS98A+sNpJ1fVRgyy1egLpol6M+f5MrRMpKit/dX6ZMBtkKy6T+8iAaATqfWcJwvP0GCzBGJ6KPZ1i4FibxDS0CcZIQ0CTwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025224; c=relaxed/simple;
	bh=hNrNahbkizsmmcQjBq44vJao29JhfyOBofALAzUmFBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dwtEvL4/wRIu75WxOrzA/vYV1wBV4vTl95ryQJ/RRM8vZeBKX38p4+yucAU584j3kmgAUIYYTk6/o5ZeHqAQs65VKXVrf3SJOlgZYMcnwbAmEHqs3nDYmFVLZSycHo9wXATbY7bJIdiKDnR9WjMyfLL4rEG5cWm0tto3IfZxRv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEycGCC7; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEycGCC7"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-58b025fce96so993243e87.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Oct 2025 08:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760025221; x=1760630021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDGjCS3pQIg9saKHBPEIhfFW+9w8/RSdyM6nZkG9+gM=;
        b=jEycGCC7CgAK6/vU14qzuLFZlejHfxq4ecT2ZOcgwE2w3pQPQ4/DhfUWRd2QdZPimp
         hsciClVJKFEtEUWc8dfTly7P989HkZcuMy0OUccyjhgzWD7we0f0OUqUK1qqefBkyLkL
         mowSnJlGg7WE3PzTOUIXBuh555N/hEhTfn1WdiiftLcHxaxCOve+rEaaA8i4BL+T0Wvm
         kbRBH1F5IFIfyppLKJK/WyzIDo2fspEhE0ZbDXdNb8YR+tnJxpYakOXx3l27eQaMTPhb
         4VmAwLN99puCUWtVTbs4iteFCQcSZZh+G4R6io7LsbUhDWVI5jYpKflX/My/hYpsmCZI
         LSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760025221; x=1760630021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDGjCS3pQIg9saKHBPEIhfFW+9w8/RSdyM6nZkG9+gM=;
        b=AuMsprdurld9kOcmzma5kkCT5JM6LW6ZvIEjJrLf4qdpc/g9yN6wmOTV72+ZuFGNKJ
         y0uTsfxmSqzXy3gmarXHpJyBNOLI+evKx0NGGqW3Ox5wU4E4VaKOhqSu3F0s+SRMGDnK
         Ue1kUR27eiPDaJNWPm+3Glrek8YEgZqXMyq7/5OyApQKHdVCytiS2cbX25IfVUXIx+i+
         412UYwpl3SNMzFnWkAAxzKUHlgiBXd5MXU9zJezP5/SlS9KOI+f7QBFzx1YZm2biOxKj
         Pd+blntsJdtf4ik5K/PGxqyqKlzI0p65Uf48Uox7g0dWu75hTm5WAVvCyGHpujf7xQIo
         ZtEQ==
X-Gm-Message-State: AOJu0YydA/o1Li+vhn2QHeOebWyRZOj8Rp79wVrW+P+jNMBXWpe7zWuz
	DEzra5//asjbVJu6qHcwTg1uuPdb74WDFny1DdDzZeSLQArytjDJItWeEgFqO/N2XuV9b+WAApV
	GJqZ0jCs9TFWpfBA6ZDeTxTekblHyWzKRoxk4
X-Gm-Gg: ASbGncso/MvNG+QONqzIB5YLhs4qjki/qnOSwxRZSJc9Z4co1L5s0z5FiLKOih89Uq4
	AB6TaXaLr63KJC8F3xfLvwxm+zMYFap3WEvdOonRS5PuCEr0cnsAuYoCmx+yjut8GyPCk9/VFGB
	wqz/JAJ8ABr4ZcGvtOlQ1cTaaQv3C79dshD0cJDdWZ3SaK43ARJFoQ5WMGzek0d0KXUXbEaOBeE
	Uu2Kt4hNDMNeQMGXn3sVTJ5AWe64w==
X-Google-Smtp-Source: AGHT+IFN89seZMGD2IaSKpIv1ThCQL0iojkSG+MaEeJoLO6u0viBWO2LJf708YclRYbsD2U+OTOP6f4rcz+/zzOSZfQ=
X-Received: by 2002:a05:651c:556:b0:36d:4996:1c78 with SMTP id
 38308e7fff4ca-37609d39db9mr19880351fa.10.1760025220400; Thu, 09 Oct 2025
 08:53:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009071159.359476-1-frederic.danis@collabora.com>
In-Reply-To: <20251009071159.359476-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 9 Oct 2025 11:53:26 -0400
X-Gm-Features: AS18NWA0SKEuB4UcZQPflILhlr2YCY2dKI_5TNm5qeAXi8HAaWhCkqjc0ZzNtWA
Message-ID: <CABBYNZJo4z67N4RbNAgfdMpJ1swQt3360ytCTddkzBhHrMzxrA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gobex: Fix abort for SRM operation
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

On Thu, Oct 9, 2025 at 3:13=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> The OBEX Abort operation currently triggers an OBEX session
> which prevents further OBEX operations:
>
> obexd[327475]: obexd/client/transfer.c:obc_transfer_register()
>                0x50e000001380 registered
>                /org/bluez/obex/client/session0/transfer0
> obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0:
>                ref=3D3
> obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0:
>                ref=3D4
> obexd[327475]: obexd/client/session.c:session_process_transfer()
>                Transfer(0x50e000001380) started
> obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:
>                ref=3D3
> obexd[327475]: Transfer(0x50e000001380) Error: Transfer cancelled by user
> obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0:
>                ref=3D4
> obexd[327475]: obexd/client/transfer.c:obc_transfer_unregister()
>                0x50e000001380 unregistered
>                /org/bluez/obex/client/session0/transfer0
> obexd[327475]: obexd/client/transfer.c:obc_transfer_free() 0x50e000001380
> obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:
>                ref=3D3
> obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:
>                ref=3D2
> obexd[327475]: Unknown header offset for opcode 0x10
> obexd[327475]: obexd/client/session.c:obc_session_shutdown()
>                0x50c0000010c0
> obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0:
>                ref=3D3
> obexd[327475]: obexd/client/pbap.c:pbap_remove()
>                /org/bluez/obex/client/session0
> obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:
>                ref=3D2
> obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:
>                ref=3D1
> obexd[327475]: obexd/client/session.c:session_unregistered()
>                Session(0x50c0000010c0) unregistered
>                /org/bluez/obex/client/session0
> obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:
>                ref=3D0
>
> As its highest bit is always set to 1, and so its value located after
> G_OBEX_RSP_CONTINUE, the G_OBEX_OP_ABORT is part of the operations
> constants.
>
> This has been tested for PBAP and BIP-AVRCP with Android 15 and 16.
> ---
>  gobex/gobex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gobex/gobex.c b/gobex/gobex.c
> index 0e33ececf..df80d79f3 100644
> --- a/gobex/gobex.c
> +++ b/gobex/gobex.c
> @@ -382,7 +382,7 @@ static void check_srm_final(GObex *obex, guint8 op)
>         case G_OBEX_OP_CONNECT:
>                 return;
>         default:
> -               if (op <=3D G_OBEX_RSP_CONTINUE)
> +               if (op <=3D G_OBEX_RSP_CONTINUE || op =3D=3D G_OBEX_OP_AB=
ORT)

Let's move it to a case statement as it was done with G_OBEX_OP_CONNECT.

>                         return;
>         }
>
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
