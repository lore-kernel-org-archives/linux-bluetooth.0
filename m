Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CCA17166A
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712339151; cv=none; b=R9u3PwazD/DOI+rQM3R/olSrJTGUjc5A8OuWi1Bi3z+GmbDcYajrYS6TNWjx1eZaFk1M9CV9Qais9LkWT5QlZp0glDepUdewqFe2Vx/YW/jS9D8xJA6DFDSyoUV1n0b/7ddqThJ5LUC8+UbAcSmmMhqCc+EWyxSVppaMNeD/x08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712339151; c=relaxed/simple;
	bh=wTKr7S2CnGDPCH8KeSUhRKLbKn96nzFzodF76YgrJho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSymoc3IJx/e6QtH9ehajjoWvSR/+mzWIc1ODL6oaX/ODkBOok4RoPLecEzMxViu3mKuTMBGZ7GrtO9auf64tHMS307Ho0yUMVMEm62+wrYZWVItu4TfvGlGfATJSKiMFvxga801opkDeXRaRIAPWmm2O4y0zQt6WtAdWqEgRHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PZppgxgv; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZppgxgv"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56beb6e68aeso1444a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 10:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712339148; x=1712943948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTKr7S2CnGDPCH8KeSUhRKLbKn96nzFzodF76YgrJho=;
        b=PZppgxgv3sXQ5rxBacQdn/ZCVjKHGo/bOeV+IPdhHr1lRFql2XWpnBDmpThAhNZLMJ
         8LEt9Ja2ub9Trpfrypt/+CVvFnaLaFoigDmmZEZ6Wz2D1AEaP5WsJkRJ1ZuH7/p6vFwJ
         VYUlnUNdNfPqEKKw6PavVhDV3bCLzQ8/fu90lt95UmV+QvtJbRRudaoPsT8yiyho9oKP
         vRkv3ZBpG2/rBcbbIz3/CHZ2Im7QKAf4f1UpzV+vsZWtilfIYssYhBmQ2vCdM+cnC3vG
         +uGrTioOEk4cOepPAcjvwO+gmk55vIZJylySm6fhjX2auqd3y2EfXgA5jKgYgeXK9Cz3
         u87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712339148; x=1712943948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTKr7S2CnGDPCH8KeSUhRKLbKn96nzFzodF76YgrJho=;
        b=GnlLLwrB32ePAGTmOwiuRTUmLQqdkaGpPlHjbFtLN7TEwHvc8MVt0VGJ0hZNQXliUc
         gOPNf38fDbxmdAtC/LbNozSmvYh8jBh7KDn68WAXJMy5xqjEWiveaYLr1IhVCemuW3mf
         fh9M/Gb9X98ejkHTZwzzebZuN2GHuW+gTZFyjA8lTmXXxmfBrYBmrUHObzWPhzcObr5T
         XSuaP7D929xG3y0ttz2SFSWUGXhFBTddcykK/F+dSYX5qVqXGGXAxhnRV2ziNKCFKjMO
         9O/jQRXLzcdtqdf+OsargJT/mAxIxXGUTPmkFzX8EupI3g/69a+9PYvXvwqXIaji26SP
         As3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSj+6EGT4+uRpVcxKiNy1lwziM2dH3kcJY+X2KHJnmCnHnCuNKWFujeaAe68NaLAkoQl3SrNmG5pgf9Mpk3cxRL+NkQIpyiPYgYamfw2Ix
X-Gm-Message-State: AOJu0YywyXPOCPp2KBOICDvAfTZRkOSUvNGM8F+NVPSXVwu5Zxo4V5W4
	YuoRFiVK18K7tHv/mDMa06ATmwL3VuwZ+lT75aNB0xnTOQ5crDipuAB3ZM3JY6B9exdL5pIqYAC
	DPWJiunudX6yY4nvo55d/rJDk9mDvo3BEtiYd
X-Google-Smtp-Source: AGHT+IFke6+lQWu9zNJbcE0cSexFTPrPSGmDeOHgeNv57K2lPwQ0sztrffp2byynXgEUGPFmDFwUOZ2UrYxWydLMWbQ=
X-Received: by 2002:aa7:d94f:0:b0:56e:2239:bcbe with SMTP id
 l15-20020aa7d94f000000b0056e2239bcbemr5277eds.2.1712339148083; Fri, 05 Apr
 2024 10:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404123602.2369488-1-edumazet@google.com> <CABBYNZJB+n7NN2QkBt5heDeWq0wbyE1Y4CUyK9Ne7vBRnmuWaw@mail.gmail.com>
 <CANn89iLweXJRLdn=v6WbqtvW6q0yLz_Dox87+GAnZUmx0WevKA@mail.gmail.com>
 <CABBYNZK08zDX07N9BTcFku=RSzc=W_74K2n2ky5f+qSexSLM+g@mail.gmail.com>
 <CANn89iLO9hO9QqQtNh=qEmLy+tE2Dr7fe9Nuj2dxYrG-z0Cy5g@mail.gmail.com>
 <CABBYNZ+F44x3aYK1kKUi8vLJT04QF48ONzrW06YJz=aq_oSHzA@mail.gmail.com>
 <CANn89iJzJc+qNgwnEuzGReXqp6Gs7hWnex0_+f2CP9eTuohZyA@mail.gmail.com> <CABBYNZK=oKCcMv8GEx__XiR+tSUwoTnwRkh2-6tJw1He9oGr6w@mail.gmail.com>
In-Reply-To: <CABBYNZK=oKCcMv8GEx__XiR+tSUwoTnwRkh2-6tJw1He9oGr6w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Apr 2024 19:45:37 +0200
Message-ID: <CANn89i+TB_cb9tSHW+8dAiqWXpAmtw=ktVG3WujiJfL2WcASiA@mail.gmail.com>
Subject: Re: [PATCH net] Bluetooth: validate setsockopt( BT_PKT_STATUS /
 BT_DEFER_SETUP) user input
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 7:38=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Eric,
>
> On Fri, Apr 5, 2024 at 12:30=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Fri, Apr 5, 2024 at 6:24=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > ave used this so far (without risking a kernel bug)
> > >
> > > Fair enough, if we don't really have any risk of breaking the API
> > > (would result in using uninitialized memory) then I propose we do
> > > something like this:
> > >
> > > https://gist.github.com/Vudentz/c9092e8a3cb1e7e6a8fd384a51300eee
> > >
> > > That said perhaps copy_from_sockptr shall really take into account
> > > both source and destination lengths so it could incorporate the check
> > > e.g. if (dst_size > src_size) but that might result in changing every
> > > user of copy_from_sockptr thus I left it to be specific to bluetooth.
> >
> > Make sure to return -EINVAL if the user provided length is too small,
> > not -EFAULT.
>
> Sure, there was also a use of -EOVERFLOW and the fact we are using the
> return of copy_from_sockptr so if it fails we just return -EFAULT
> anyway, so if we do start returning the error from the like
> bt_copy_from_sockptr then we better figure out the errors it returns
> are proper.
>
> Btw, do you want me to spin a new version containing these changes or
> you would like to incorporate them into your patch and spin a v2?

Please go ahead and submit your own patch(es), thanks !
