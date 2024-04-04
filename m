Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9149632C8E
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247397; cv=none; b=CT26vMO+2LqhXheh4zkYXTYrmaHNE241IIgTahi7KTFAYwjfkgpTZMizcRY5okaWAEWNPbkQQNHkZ2J+12pN1gA2k6489Vw78qBWO4SeMWJZQOzhUtA7g2GlxjWUY0OP2B6eYfSEMUnmhjGzFsoLzX3xLl1eSME4XPW/nzSVDkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247397; c=relaxed/simple;
	bh=ywTF/bRvJikN4R7LsiKyrpubVud3pBaGydWM/IDCMyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=leoqsOYTGRvDitqVZOtGCDbeO+8XBA77F1aE1BfGiVDn3g8/CLacww7q81Ovgt8frRU0A26WPs4DUw0KKoow9KfcBR3RyltY+JVTFJxXl7PHxTPY2MGaYzz0jY/FfPCt2i/l3Z8QNGWbh4yiy+NpObAP/KMBt12PhwYC7nGUxZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXFbcIxH; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXFbcIxH"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d6eedf3e99so21824871fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Apr 2024 09:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712247394; x=1712852194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxHRlAzWXKXOux9JRiv3nn2Vy83la2ZitJfVw9v0cZY=;
        b=KXFbcIxH7U6CalCLmu7ZItbkSPDQx0uuzAnNI/zhlqwXmiICRlVbtYZlYVha90ieWN
         /DBfPNLB8o/7LpgFFmW7p8CEzgMLn4ZvoQxMe+3nby7/9l+weANaW0ozXniyN0i7aqGV
         2Cextf3rTHw09HqRFYeX61aUc58BS7JiwiZINzaVKwXXbvOZszf5uSDUGiZL/3AuhElT
         7dEcW8CKQr88QqLHUtUrcAV44w8A1z/+7Ha4OJscXiniLs73JdQoMTYihn6M1y81h2gF
         QSHV0GORxGuFq2wU9LvrwSZZCQkaKTajadxvb8TccXUYImZTetB2kVcpv4NGcwaV7qUi
         gUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712247394; x=1712852194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxHRlAzWXKXOux9JRiv3nn2Vy83la2ZitJfVw9v0cZY=;
        b=FQew/uSWXmVZ7/ehTcCrjOpT7KG0fTjy8VXr1GYp2+1tLHB5Hp2tx4fziu4BJ3lcEd
         ScIpx9rHF1oa6INtvIJ9mrsHme89YrLZim74WfxnQ+l3/j3SS/dWp3ahMq9SfVpvMFpE
         L3Gu1g5wXYgODaWWIQo3JmEpgZFpj5ZwGOJZzNy9e+giInqu/nFjAjiPtYcwPIXp5hgi
         SqVneHL5ErnqjCmcXrdKZlNzAIfAerbfV/5FmWtGtUmWfJO1nyrhexPbfhOMlNVYwn3g
         KyJGVnBYu8Qy6PreCaHkf7VyjWKRMTrLjvMhcOStF8xzezCYoEjKal/LAJaR+pOODpqP
         mjSQ==
X-Gm-Message-State: AOJu0YyvqxYka1pLJWRByAlkjILZTd+yKLbuZcXSezrBCk29l/jQH2C1
	lg7f39kAD3ldEPkUv5gqIcPlLCSXbxMGd5Q24SK8oZj0jyaDJ7dImUmcsSYVnBuP35TMrp1Xyv7
	XNRBG/6ZihDOjHH9EOuZ4g/CGvM1su3Y0
X-Google-Smtp-Source: AGHT+IHnh+7v6xRHdXW+XdI4ijT0WuAcoSlF+QW1a+A4w6o+GBZOtw/JJ/43yWbFVYgsunQPF1bw1Din76ptU0v7Ouk=
X-Received: by 2002:a2e:9b48:0:b0:2d8:60ae:f37d with SMTP id
 o8-20020a2e9b48000000b002d860aef37dmr355600ljj.12.1712247393360; Thu, 04 Apr
 2024 09:16:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403205252.71978-1-dimitris.on.linux@gmail.com>
 <20240404024521.120349-1-dimitris.on.linux@gmail.com> <20240404024521.120349-2-dimitris.on.linux@gmail.com>
 <CABBYNZJjSp74CoJU2RYCft_nQi85EWnk9JOvyxMH8YmAtON+8w@mail.gmail.com> <0f681858-fe53-4964-82f9-5f3c3ee903e3@gmail.com>
In-Reply-To: <0f681858-fe53-4964-82f9-5f3c3ee903e3@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 4 Apr 2024 12:16:20 -0400
Message-ID: <CABBYNZLmff+NWTp3=5S5g8nx=KxJ0=PgxT7v9viO_hS=U15=1g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] Refactor btd_device_is_connected
To: Dimitris <dimitris.on.linux@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dimitris,

On Thu, Apr 4, 2024 at 11:52=E2=80=AFAM Dimitris <dimitris.on.linux@gmail.c=
om> wrote:
>
> On 4/4/24 07:59, Luiz Augusto von Dentz wrote:
>
> >> diff --git a/src/adapter.c b/src/adapter.c
> >> index 4bcc464de..0b7aab4b5 100644
> >> --- a/src/adapter.c
> >> +++ b/src/adapter.c
> >> @@ -7486,7 +7486,7 @@ static void adapter_remove_connection(struct btd=
_adapter *adapter,
> >>                  device_cancel_authentication(device, TRUE);
> >>
> >>          /* If another bearer is still connected */
> >> -       if (btd_device_is_connected(device))
> >> +       if (btd_device_state_is_connected(device))
> >
> > Perhaps btd_device_bearer_is_connected would be a better name.
>
> Thanks, I'll rename.
>
> > I guess the problem is that some service is indicating it is still
> > connected though?
>
> Newbie question for sure, but: As this is happening in the code path for
> "disabling bluetooth", shouldn't services already be disconnected here?

That is exactly what I would like to know, why is there a service
still indicating it is connected if the controller is rfkilled, so
while this should break it back to the old behavior we still need to
fix the service that is causing the problem so perhaps we need to
print its profile/drive name and figure out what is the driver that is
causing it.

> D.



--=20
Luiz Augusto von Dentz
