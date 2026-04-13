Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9963D9021
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089494; cv=pass; b=i7/xSUWCoy4mDpu7D7lKyPrFFsT14Uz0AJdJqb/lD/pxk8g748a5sMWIg3G9IPsdgqLHAW/4DHZrrXW9rpE2Rh9K/sfvUTdvQueu7mHH4+QeqIdXXsKDIpUkDuhYvdxq8VrIAb2ig5+tjPYxwFMKUQUuh1d+ymVVpZlkgYNVQeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089494; c=relaxed/simple;
	bh=bT9M9n4XOV8yqBZqbYEWXJ4ln1b1YhEtptjZ4KTGE8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Adn9saBEUNMoaIV+YRrH3uyIFosQALhyv9YO41b6USeA00RhkfDcs+cP6rd5Gx7MYEv+SiOlrfgEwMX6F1sAlBzHl0grPXXsU15kJcTTXNkuukWnUvOuwZgzvK9O6VFjBcMMnd4EwOxXlK6k3Sa8GBA45cJwq0nrlSg8fg4yJ1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBiaJQi/; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBiaJQi/"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-651b4d09141so2184425d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 07:11:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776089492; cv=none;
        d=google.com; s=arc-20240605;
        b=PCf8APsUhLF9iLd0UeFLIeVrub60hztbSr20Jg6N9EnvkAVYwI5NZYWH/CLks9Hz1Z
         fc0yS6fLa4tCjTQl2RdbBNCu5Hdw3P410JLIM1GRdvGlauLOkjyaVJAZO30bPFBR4uwu
         klH5FFlNaR04JkQMwzUVJjJGfkpxEbQzcoQyw0JWBZWPxXZUxo9Nib/yawUbj4kXV/98
         3OI/LSYlFhJsJUGLWIqMRo2oGvo6knm/yehd2ZoDVDxKnNFPLe1YtOrqN8cR4jF1rAtI
         GFvKA1xnyD6VjPtZsFuGWO3l+eDtU+hk70Bqx3tnd+516HRnibxslMUNQ4E6sohgf/lE
         Acow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FpnyTQSu4pDMNNPRZu+lnNkKWw5DBBz1SoIVT6Ykkgc=;
        fh=+kmeEFbZYmdRlWNzNV6CADohEzLLae+LOw5lhYupZcc=;
        b=SSC1aPiQeSIWphpytG34TcEugOijexD/InsNxVToU5Go18EMdtQZ5P0acQilUxfIv1
         YNJMNpAT2+wxCRo2AnWYRB2Z0Sw/e6VKx9FUD4bTaxrcKDIs9384RyqxLVC1e7a9ySGA
         VpoKMVffxeh2e4DTYIvc/DDEG4JT053a6z9Na/YDFzF4OiJ07wzS78NDhTXx5WRM7JCs
         NA1SQyOEf7W3zYVFjR2MZ1L0BUfEs1fC1KccPIyGdfnAZ4r63DwdY+6w1SJOT7tgfF2r
         RIs+SYTygzvZVtgoM5Oe4a2kE5Nd0fqRn0ykVwViH2OyDCrb4RDJQBYd27MuuSJ0yD8u
         6tnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776089492; x=1776694292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpnyTQSu4pDMNNPRZu+lnNkKWw5DBBz1SoIVT6Ykkgc=;
        b=HBiaJQi/htoNJsWAb137bTgqJaIX52RX3s8NFK1+vGL8Y7ypOqAI5+22m3DJilOKgd
         bqWAom8abgETb0pySF7GW/GuI9kiY6Yjuo1T0FwRvvxa0OntVke8xzzUlfEeeHrVReuC
         NC8qsThKsXFdVNkHe+GNbjA4dAc39kLRw1DaaZcCASFPXNPeYORVsBggRcxkxLXvqUh1
         KetDHhD92vht1Lk3VfG8+gHoa137ozLTCPXee1/AaMMa3h1joyJmeB3jj1aOYrT+x7j7
         ffLdoQYoqi07ZVemOTJ3qXKQecUTwQl8ba1/uMC8bNSWiGABzVYP9dKwnN8Jq4Ua0zCK
         pxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776089492; x=1776694292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FpnyTQSu4pDMNNPRZu+lnNkKWw5DBBz1SoIVT6Ykkgc=;
        b=e2ZAusRUQCVciJWQY2/udw1CANEa3qPOVHCkVamNV0cDu9iQ8M3L8DzwHOtCqZ1r+N
         YwvH0khepXBHIWbsf/0Uerv98fS8WGTg7naZCh3XurZDWP6I8dW1Yh0C3B/giXOrrWhk
         dMl1B/p3KiEnA/82zNjHzkmUytUMwIO5vdzcTWqYpuxep5kEmQ9f5uGxeuSP4/K3miKI
         YnxjInJyfQA6jnLsNXDmNyPvUBLZxhFLVsWCQuNK/unsg5+khqd6AxEvb1ha4KPs2An4
         hnN58436JgvfyPzpCQUmhFVmdToff1xSIGpKQAitASqRTrZjMFDIbtgYOtD2QGZf98/P
         Df6Q==
X-Forwarded-Encrypted: i=1; AFNElJ8QQ2ZJOpdxqOcHhGczqlBYqHKmPf77uvBQclpGfYnWZyb+g2vVKdjYQDfRBReHPyypug6C4QPq75Hvd7uWItY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH4UaA8r4T5KPjKp/iCd3Xo7m9uy7sQ0geXN2kqf1ufQciae5+
	P6j9Lu4SB196JUdJWGtmJA3IedQuDgzSs50qC801rg7LPR0OV605TdTu3b1yuLtKhWsz+G9KzMl
	dZEMrc2XSoOVRfC535Z/b0qZOQvtE2Yg=
X-Gm-Gg: AeBDietswEoRQALs2XyEap4DSBLhJsI1Hr07tcXhNnFpVMcVf7BS+lNPZl55CfDtU1m
	4xXNaSO35lCETq1XLfi/huTS/q1ERvLtOFR22CqNvuYRzfuGdl0/303oNkTphqbcZ7oZfnD0OX1
	lmp00pyqiceEK2CVnwXOkrJ5mn6uOtIpphp92XeaFLpLDYB9gTxNz974k1BpSaLZSc/UDGOTB9C
	ssaJ9z+F+DJK5FAuCj5qK4AGRR72f9V9BU4X7c11KzzUalJGEmKVZr9f1R4gGUsDwvrgQyqwk8Y
	B5s8ZkNLfThfZ36APWx2Iicznd8m+OkW8pDopw60ANcMnwQXknUJbjxvsLhlr2091qRklg==
X-Received: by 2002:a05:690e:4185:b0:651:d4ee:8e4 with SMTP id
 956f58d0204a3-651d4ee0a12mr1180322d50.8.1776089492134; Mon, 13 Apr 2026
 07:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413132247.320961-1-luiz.dentz@gmail.com> <580f7972-56d5-4968-9dcc-32adc31e0673@redhat.com>
In-Reply-To: <580f7972-56d5-4968-9dcc-32adc31e0673@redhat.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 Apr 2026 10:11:21 -0400
X-Gm-Features: AQROBzC0eEI8SZRnxEM5vEglLMfdTCm_9b7YfdWWRuzp_gnamR7LXYwG1b7IomA
Message-ID: <CABBYNZK5mMbuzvjAquy49vSk0pLRnk_s8oqEut1se4DToURn9A@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth-next 2026-04-13
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On Mon, Apr 13, 2026 at 9:41=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 4/13/26 3:22 PM, Luiz Augusto von Dentz wrote:
> > The following changes since commit 42f9b4c6ef19e71d2c7d9bfd3c5037d4fe43=
4ad7:
> >
> >   tools: ynl: tests: fix leading space on Makefile target (2026-04-09 2=
0:41:40 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-nex=
t.git tags/for-net-next-2026-04-13
> >
> > for you to fetch changes up to c347ca17d62a32c25564fee0ca3a2a7bc2d5fd6f=
:
> >
> >   Bluetooth: hci_qca: Fix missing wakeup during SSR memdump handling (2=
026-04-13 09:19:42 -0400)
> >
> > ----------------------------------------------------------------
> > bluetooth-next pull request for net-next:
>
> Net-next is closed for the merge window. I guess Jakub could still
> consider merging this, but unless you want it very, very badly, I hope
> it can just be postponed, as the PW queue is already long.

This update includes quite a few new hardware supports. This is a
resend because the last one was dropped due to an invalid 'Fixes' tag.

 Btw, I don't know why the entire PR needs to be dropped if only a few
items have invalid tags? Can't we just dropped those?

> Thanks,
>
> /P
>


--=20
Luiz Augusto von Dentz
