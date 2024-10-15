Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F8B4428
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 04:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728967961; cv=none; b=tUIJr4uoyooYhP0i8/3cMFY/asm0WcnZXY3r1k68eE0E9Bn3xTe6rBYtGSVKnhwOWNaYu3uHpRAFyYfKxqpBtc8kvxKpPqrnrfDHdZtUAR4fvXSnt8K2zfuffMCs6DS3DFPLPG+b9qNGrx3jJa/KErL77SxZb5Pjw6X23EK0O84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728967961; c=relaxed/simple;
	bh=RPykLgYMdLDxPzBE22J0+SM2QnMSSPWqRX74HBp54NI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUC3pFN/HvYwIiHTCs7fxRrlhRpVrOVFppHpooJABwoTkJ+F9YVFXPFEXg2mlw9/DanZnLIusFS5hbgKw/GwWRYkL7GuYpDMiM5EJewpuJ9uBgDuOjK1DuBOe8W3mMBUZCDGrDMAUt7NU3FaapvvfWrG1BVfTtBz9bL3YWUba0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=OQqs7p2u; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="OQqs7p2u"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c95a962c2bso3635208a12.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 21:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1728967956; x=1729572756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tWqqKxhh0W/7ivNqGTlKJCb3/UvZfM/VJDc1l0Xb14=;
        b=OQqs7p2uTdQ/utQkYhiIbxreYb2A3+8/6w6S5NCQl4WF4vc/wOS4CCyu9T7PqLzQeB
         c/lPtxllcUb0STZr5AuZJB008Msrs+eUBlyIcyIw7Y+4H7TUnLnoUik7DnvpOjYKgL5i
         9UnNCVep+GxANE0TKG0QBtddxaEoIdr3XVdWbGJQcnfNnmFDtQ+CaC/j9331eHtsTgOA
         efYo2NiIUq0Qn6ww0sBC2f9d51dbYgMNw8roonZDugalyN+H1QqeeqS31H9yQ7jJz8dl
         l7PWYZ3H+38LZBvxnOhdKM2C7uQOYyiIO5cBsvNBKs/W+Eg57bbPdKjYrrt33XI6Ea2n
         PUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728967956; x=1729572756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tWqqKxhh0W/7ivNqGTlKJCb3/UvZfM/VJDc1l0Xb14=;
        b=S8NHcRN7HzrE61DVIZKASH5HYkg2btcllf7l3mgFz9TTMoX4kkcLYylcNhN+43B+F9
         e47vhTRSYIrcTmcaphrMwgL95+ILeIT3qMjq0vG8X1WGop754ahWPYiu5XGv02AVnw1d
         m9EGE7/WpmphKbZAcxR4M4iFmydOvdxxlRUkSEGSThIQM+cRPtAKHYfnSAht14tFUpvx
         ffx8IGctC6jeBg0h7JhXBbMw25NkIvRMClw9GEea7BJ0UJfoL/VosgwZrH/9dh48fLV4
         HUosj31hAHqyzAzj6TXK45MHrJq0NG87cZeQNebTwGdz1p99LrEUmhIm7QTB3rU9o29Y
         GIIw==
X-Forwarded-Encrypted: i=1; AJvYcCUNLnlyXXjVueA9UbFeJBm9g6xPLHvjABAqPFIYetjOXI9pkP3RpfLuzWaSB8r3ie6jfvNYVzRZd9gsNtwBbnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMo6VSDUZDG4knbzsrfDjBq8P2+YyT5kR6v3UJQi9/6qiswK/F
	+5HYYOZODV6Xj3oaL1/zFE4SILnc4gJWQgnDCnTTbNekOCrQtB2OCXBHiF61jX/nhrvAX06Qu2E
	Omf+X3qDqGNSgxNsPWYO4i+hv8kz4h/p25prmMQ==
X-Google-Smtp-Source: AGHT+IEU/y1a6FgQfI8YjfSVfdTShpUrSSTkz/b0IuV43k0+CLIh2c64950510hjkg2XerOUrGRbQTlqPjI3HimJE0Y=
X-Received: by 2002:a05:6402:5c9:b0:5c8:a0fd:63d6 with SMTP id
 4fb4d7f45d1cf-5c948d24835mr10997520a12.20.1728967956209; Mon, 14 Oct 2024
 21:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014163001.4537-1-everestkc@everestkc.com.np> <31a73bb7-47ec-496c-8a65-02e331051e0e@linuxfoundation.org>
In-Reply-To: <31a73bb7-47ec-496c-8a65-02e331051e0e@linuxfoundation.org>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Mon, 14 Oct 2024 22:52:23 -0600
Message-ID: <CAEO-vhEg_whKPkWmym99+a1Lx2kU5CcBCYrz6unKANbCbV9dHg@mail.gmail.com>
Subject: Re: [PATCH][next] Bluetooth: btintel_pcie: Remove structually deadcode
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 6:02=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 10/14/24 10:30, Everest K.C. wrote:
> > The switch case statement has a default branch. Thus, the return
> > statement at the end of the function can never be reached.
> > Fixing it by removing the return statement at the end of the
>
> Change "Fixing" to "Fix it"
Will fix it in V2.
> > function.
> >
> > This issue was reported by Coverity Scan.
> > https://scan7.scan.coverity.com/#/project-view/51525/11354?selectedIssu=
e=3D1600709
>
> Please include the output from the scan. People can't see this report
> without logging in.
The issue is no longer visible in Coverity. Though the code is still
the same. The issue hasn't
been fixed. Should I remove the link too ?
> >
> > Fixes: 5ea625845b0f ("Bluetooth: btintel_pcie: Add handshake between dr=
iver and firmware")
> > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> > ---
> >   drivers/bluetooth/btintel_pcie.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btint=
el_pcie.c
> > index e4ae8c898dfd..660496e55276 100644
> > --- a/drivers/bluetooth/btintel_pcie.c
> > +++ b/drivers/bluetooth/btintel_pcie.c
> > @@ -391,7 +391,6 @@ static inline char *btintel_pcie_alivectxt_state2st=
r(u32 alive_intr_ctxt)
> >       default:
> >               return "unknown";
> >       }
> > -     return "null";
>
> What happens when you build your patch with -Werror?
> Do you see any build errors?
I compiled the intel bluetooth module without error. Will mention that
in V2 patch too.
> >   }
> >
> >   /* This function handles the MSI-X interrupt for gp0 cause (bit 0 in
>
> thanks,
> -- Shuah
