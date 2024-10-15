Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DB11C2327
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979465; cv=none; b=Dd1UWfJ2QlC3JWILiSm4Q52mgCCng66DWQU+1cL8llyOxXvc+PIwHqE9qaNseg6bRu4PVNKj+/sDVyv/a0C7ECMNEitAffRXjTy/l6qADgmMSLpDDRW2KDbhJrwTlsWGzWwooWt7RgK7+oZhhj0bvRV/FUWB/da4MSCz1tTZHUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979465; c=relaxed/simple;
	bh=jjdIGCXHtqrrmc4Zac1h6TFtk7ByfeGFj5BklO3jkIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQytljmWeUufcemGMbReytLY+vHjoN3ehOcO5Jh4o+zMYVwcNbj4FuOZZ2tCNlEfEneZ7ZO1xXIpfsUMgR1c0nDgKPYWc7gYtRR7WQkZfdQpn6iiZ4GKjnIZNAQouYH6g3tm+Ex40MpR+oHSer0pL29lTwFfptOOCnjcOua0xSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hnQu98/6; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hnQu98/6"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26d8so8611544a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 01:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979461; x=1729584261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjdIGCXHtqrrmc4Zac1h6TFtk7ByfeGFj5BklO3jkIU=;
        b=hnQu98/6K8SfIZ+dZFCoVE4e3xhktR+KfmU5DsMYkyCurs6E//JqSiMA2A789KPzpe
         BG7ka08xP3QYQ4vgIhQNXCzJr+93S2xq9YTll6CfXlktnSbaKnQNn2pFS+nWPyk6k3hG
         Em65NimtywSQ34dbgDVQ/hYVA8K7ugXXPtSboyZyt/qEOQJposkJO5qAAq+4ADq0t7aD
         38EXzUyZEW+4D+SlhNZ5RrnaUzx9JZfl2sV2sHwRK469n8kHWM5TNydQi/z47zkysnI9
         jBea0/FDWp/BL0wVA1b+4b7Yl3pE14YOBqUFiCUKOgYJrjZ7EWJPvaexBhq+diT69fKt
         7/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979461; x=1729584261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjdIGCXHtqrrmc4Zac1h6TFtk7ByfeGFj5BklO3jkIU=;
        b=dv3SkCpv/zUM93Q2HvKVuSAMmgBcRqdmJJM9HuuQcY3GzZfNGtLXYkqLudzeLS98cB
         4/eASNetugoYimNxkcGtdxK/K9CsQMQTgIslVqpZRq2dpgqx129Dg1vUpLE22RtN6TlI
         5Cusx2aj4NWDRiHBZ9/L2dGcIZ7biKpxSg2nPJGugKEgf4Ma4DjgmQ7i0trEtcukUEoj
         dE+g7FaZMB9FyHmF7UbdbbIdzFyMN1UepfIuKdnwqjenqUBtVKFRj3GHJT5wsclxC/EA
         5NO3wHTaEKk+P2EJoLvkkuhmzDLbg02ij4BqMyuvGVI7EQB/VfZaHp35qrjmC8BARx6S
         XqRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqWrYjDg07OJK2wp9vt//C1xZ/3UqGkL/nH80PbMr6PLutMp58L6RGMdOuZfrLBiITfw1Ig4+0HLrNXQ/pRpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7EkSioeoTnzbfeC7pNzg+ZTTiY0fnkykceMC9ro+c3wDarSRX
	W7+BsVDzgbmQRZKwbgTsmnTJs9aMnntbOSAT+fc3SaRXjg0Sj31NhfVDlrL8FxCWI99v7lFlLF/
	MmsnOW92aOLUiSrEGYzbFfYPvquZS0d+WfCHx8beydw7SzmRvzf86
X-Google-Smtp-Source: AGHT+IFVLMYXDjozz3EMts1UX9Vb6aOFr9R871a4tPL9AtIGRY0LFuArOfvBuHL22PThUNhjYOA3RaMjZm6fTzoit6o=
X-Received: by 2002:a05:6402:1ed0:b0:5c9:87a3:628f with SMTP id
 4fb4d7f45d1cf-5c987a3637dmr2709862a12.10.1728979461246; Tue, 15 Oct 2024
 01:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153808.51894-4-ignat@cloudflare.com> <20241014212956.98604-1-kuniyu@amazon.com>
In-Reply-To: <20241014212956.98604-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:04:10 +0200
Message-ID: <CANn89iL7tdEr6_gpQCsLncNW4d2NonTVR0pTgxY4-O556ZQiJg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/9] Bluetooth: RFCOMM: avoid leaving dangling
 sk pointer in rfcomm_sock_alloc()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: ignat@cloudflare.com, alex.aring@gmail.com, alibuda@linux.alibaba.com, 
	davem@davemloft.net, dsahern@kernel.org, johan.hedberg@gmail.com, 
	kernel-team@cloudflare.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	miquel.raynal@bootlin.com, mkl@pengutronix.de, netdev@vger.kernel.org, 
	pabeni@redhat.com, socketcan@hartkopp.net, stefan@datenfreihafen.org, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:30=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Ignat Korchagin <ignat@cloudflare.com>
> Date: Mon, 14 Oct 2024 16:38:02 +0100
> > bt_sock_alloc() attaches allocated sk object to the provided sock objec=
t.
> > If rfcomm_dlc_alloc() fails, we release the sk object, but leave the
> > dangling pointer in the sock object, which may cause use-after-free.
> >
> > Fix this by swapping calls to bt_sock_alloc() and rfcomm_dlc_alloc().
> >
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
