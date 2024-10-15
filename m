Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA011AB512
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979605; cv=none; b=ayxOyoH4T0pMp0o6RcjfKUpscneqIoF/cSVOWSZCp91Iyl1UGBCY2d1vnJ2wK64eNbWt+GNYslRMd7HTTi6AV268A8jvH93Gai8uzhy7GlLs4grHgW5RPEoUnyJ+HAfCjHrIZGyCuh+Xlrq2ZZUsVIyL6qQkdrF84+Wa8x2vJM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979605; c=relaxed/simple;
	bh=MnUQlUTrmLKSN5pDHrMF08s+M/AmbbftkUAMLC0mhYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMic/wTr6D944cRmvwHXc6221AAwK5DPB+msLkzjhZWu/HFksr2shhbsT9RF7BApnChShYch2AoHXDexUcezyFqDrD7blAGoUiKIZJ55sXQQE2LayuwaL++ZrfYjr8wbmhwdexZCutcFGTjHPP6gZGGyVi2pocC4ja+l7Wt7ikA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lr94FdLR; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lr94FdLR"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso7345057a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 01:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979602; x=1729584402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnUQlUTrmLKSN5pDHrMF08s+M/AmbbftkUAMLC0mhYI=;
        b=lr94FdLRow5MpDSV69VaIs5JmCt6yA3bF5N+2cuNzTNVxeZ5cyu9iFXK8Nuxr+0bS8
         m/rPR4N4bAYeelgljVzkabv/4WBXiEYO41dZT4lL0rSL986fAGiQ7hdx4gBY86etmC3O
         MnAVF2dAMR131qOR4+bu2E57CYPFXXTeH/Gj/n1/KjFm5eRI2SuHYPALwDHrbbxLqRxv
         zV64fsEI1GgVBIFeGqpxVGHQh5gVicixv2SoVUIxFrE6NKzTlE8ROEkWYVLqdKyVwlfL
         /XbTfKFF5GGMNKUlpUgI/0mH55vnol7kzJfxQTc9xW3qEKHaUfzotThbljaIE23TE5c5
         DKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979602; x=1729584402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnUQlUTrmLKSN5pDHrMF08s+M/AmbbftkUAMLC0mhYI=;
        b=L623SBxFb7eVQPNTyS0vTwIE6/kgBJVdZ2mlF0Du6iAT68w4yDI2rDLoX+3YyL/huK
         NQSU3hg5JmuSMIwpLBPlOeT92NrpFyTEnci9SvSGx7NwiI0054qNzs4ZLOEv/hx3v0q4
         QLbGsRNDfjX+2cQSYS02ye5LN3YrQJWhxVa8mXrHxSOaJ0ULjrJzLprhAxJM/Sd8Uwi1
         cl4eySvbe9fdx425R/QnmOODHvm79jd29wecM2WroCIE41IfoVLLLSXYAj6lha1WTUYf
         bhRmVBpmTPuA+PXhd/KrTkf/iP3Wzq3RH0Fd5ZBqoD9cbUE4VuTXZNggmS+bs4Gk6R8K
         GfjA==
X-Forwarded-Encrypted: i=1; AJvYcCVe1vGZfrhaVNxz3M4a/C5+RmmpRyjyY7WWd6yTjLSfrvqc0M+zDLEZRvEFcDnoxqUrQ9ruj1fsl7cPtplXSk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6WgRnOgrgi/S6DtSBHp/6MzvWeBzN8Vi05GI6fmcIqg9YOnZ4
	K7ZQ/o1W49NeFBsNcVNzb4t5lUDPUaQQy0V83ODt2CG9FAFs3vouCW454hSjL0CMS8HNBHmeu9P
	TS9c9YeAtUY4rfFan/YK6eHSzWUmwGyVicqpm
X-Google-Smtp-Source: AGHT+IHX6XMf3AiOgHYusjY2hNGSXpUuy0ABfjJ3dJvLGNh+47L9g5T2krprPD/SxUBg5s4JP85Vt3VKjMD2UkK3OMo=
X-Received: by 2002:a05:6402:5251:b0:5c8:9f3e:5efc with SMTP id
 4fb4d7f45d1cf-5c933544887mr15998193a12.6.1728979601480; Tue, 15 Oct 2024
 01:06:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153808.51894-9-ignat@cloudflare.com> <20241014214046.99495-1-kuniyu@amazon.com>
In-Reply-To: <20241014214046.99495-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:06:30 +0200
Message-ID: <CANn89iJdmrOEYy3sH2A-1rBE8sVyDJq2yx3jVy1GmKoeqr8cTw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 8/9] net: warn, if pf->create does not clear
 sock->sk on error
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

On Mon, Oct 14, 2024 at 11:40=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Ignat Korchagin <ignat@cloudflare.com>
> Date: Mon, 14 Oct 2024 16:38:07 +0100
> > All pf->create implementations have been fixed now to clear sock->sk on
> > error, when they deallocate the allocated sk object.
> >
> > Put a warning in place to make sure we don't break this promise in the
> > future.
> >
> > Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
