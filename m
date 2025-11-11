Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BECE3328F8
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870288; cv=none; b=iw0u1KeyXz//6Xu6D07gaBQoFxeWT91fdp8RPonDCvOSysyLMCs+aOtnE2JD0OIu0YQ438vWFi+6U2WFDD5kpepY1JQKEIKlH7kCiZCbt7I1/N7NgvXIe4e165KFCPn6fpiQgUl9dRI4EUnIBIQBtk8JUVkdZhs36ZoIoby+SO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870288; c=relaxed/simple;
	bh=PZumaDDW5gxsL+FXIEHsxZJTuzIAEKFvYmh9j9CICKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHpdt9JQzPLIb4gb8X/fOvS+i8EH3st+cjV4zIa6Y7SViNMPl9a9IhTtudZkXKHENkehcwGmUWCICJati3RogZFZDZKuYlGk/1yzTXILXXDq2jFd2iCyrKQi5aFkNqHPmrf/YOjStDt9hVtu8RK3HGQt7acFONjGlUhD06jvGXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HN/NGMP2; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN/NGMP2"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-37a2dced861so8547741fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 06:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762870285; x=1763475085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuCdQmKCHj4HkzfzDWSUNZHCHWQgXtus3sPe8OAt8NM=;
        b=HN/NGMP2wUwX6kPs4s/2BAJ1g4wmbo8YsICAEcZZjbh76hQnUSGH1EeZxELyG/kfti
         HJoCE6TANeJp9JjjrKYtOpKONzNuWh7Nd1dIhf96TQ/YpPw0CL+9MccX+lgVmpetJzlM
         +cTlNWF8EmBSSTWStxYJWkvwRpcywHn7CsJaCF9eSW7K9QUIDc37i+JplrhLi2/Mkq1Z
         4yZf//Zn1DtmHgpEQCob9ggTT6wenhWKZZLovm2euOOB3WHBE8E07UhwGAIzTiRwbjzr
         SKoTNuOtGep2MlmAStUTJtWE9Cp5lB+qr4hjM83r2b8MA5C3x6TtXlM49TANExzqfnOE
         6piQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762870285; x=1763475085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vuCdQmKCHj4HkzfzDWSUNZHCHWQgXtus3sPe8OAt8NM=;
        b=KJWngSnjLl3SMIbIr5fBXP3ZAp4ARDfslgsbTdTQgRmsIRoMsx4n8j5IML8lBXAtnO
         RaV7kdIUAbwEo0bNAPrruY+8MLqIyhfuiF5H+LNEuNaXaj3piksy065aePEnaHKye9MA
         ywJAfmNGs5jSt9RyGiYiuyT2dXnuNQjduKT3I0e3bhus3txX5bU87Qefz1W7FtRoFErH
         RwDBwGauvjMqYSQ1ABe8zGvNbgCK/e8+Iyk1h5USHeCri6dCrqH9fyA1gfXGOuHd86aR
         81WSKFeaUZZT5Ss9mY7Y7c/Qn7f/cxRW2O86jwftNQFQm0IvVjQXCCLSHHgGOvmI0kxw
         klew==
X-Forwarded-Encrypted: i=1; AJvYcCXg88Pi08hBUSB1Zq/sgGaqC9POjr+VaHgWrmxuW/6XPfhXK2oAsgAsdjj4nOHeJL6YGic8mxspgYPmqPtJse0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9X2zeJiB3Gw8vzM7WyRsnJYuqVN/yd7D1Yzpuqt/g6yVfF1vK
	S4qGfk9FcyhyA2MjJjEXUD6uf5xNWxnjYfZrsgwJrL4l4bRZ01+XHua59cyMdX45QqnThItEYQv
	P3JLvXungupu9gI8Nc1LBz5fq2zrktcc=
X-Gm-Gg: ASbGncuZ/R2Sez5U+1ph61Ie9CaDTWoCy2cZm+h0VdALTOXpso1WbrR86MTNpiMhNp3
	trVUi6t7GY6U4t93D8tCoLq4+B/USXCXdaP4HQGXKTj/WBuzHrWseZeVra+HlUegYfhMlPUtrZf
	/iKj5bwG+OA5LptiIDvdPOon2qtvYZZQeSqxWSsbZyukEYp4v8CW9uPz0fkrjJTvwMsLlHq5ujv
	plO8Kdkm2R0FwWYn/NIrTANjytD9ddbsbkgmLz9CZuZdwZei2O0HgFIqmBrNo85VZy32g==
X-Google-Smtp-Source: AGHT+IFT7oIDrae/qE3wgtv4v+UXDVGgrtZ7bDYTyHuRVBbQvz7KKO/qlls4dqRA+LV25quIR0njnCKrmwU5mn4MedM=
X-Received: by 2002:a05:651c:4411:10b0:378:cd2b:5040 with SMTP id
 38308e7fff4ca-37a95398ea4mr7277191fa.21.1762870284951; Tue, 11 Nov 2025
 06:11:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110214453.1843138-1-luiz.dentz@gmail.com> <20251110164321.75f7edec@kernel.org>
In-Reply-To: <20251110164321.75f7edec@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 11 Nov 2025 09:11:12 -0500
X-Gm-Features: AWmQ_blTsx75uwbTjJKBZrdd7Jc-eEQec5pYYmSJLUJCXPvrmQX7faCowPR9WLM
Message-ID: <CABBYNZLvrYcYV4cN+v=sSxpJWZy7Fs7Y8BMwOo4vqOxuJuaF1w@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2025-11-10
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Mon, Nov 10, 2025 at 7:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 10 Nov 2025 16:44:53 -0500 Luiz Augusto von Dentz wrote:
> >       Bluetooth: hci_event: Fix not handling PA Sync Lost event
>
> nit: sparse says:
>
> net/bluetooth/hci_event.c:5850:22: warning: cast to restricted __le16
>
> (I haven't looked if the cast is correct but if so it needs a __force)

Ouch, not sure how I missed it, it should be using __le HCI is little
endian, will fix it and send another PR shortly.

--=20
Luiz Augusto von Dentz
