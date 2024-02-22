Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D469812EBD4
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Feb 2024 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708607185; cv=none; b=G1askWU4qFzgkWe82k8uM3hm3iRFbZTGZpz06+Eaay4LExWSdmljmQ6/oIcGPiBItyEKizRPR7/0DFxW7R4xu123HFcxy6jVSNtUs52f/1X7aEsatyiHCeRktYMcEhFWS0lJyZuIZf9KS4yGwY2QvgOcvcRjuGjtwrX3RoJA17A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708607185; c=relaxed/simple;
	bh=WzGVCg3FDI4Jb6JinKmu0mQ6Dcc0yViPwoLhDYvuqrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTAjWMIgpbB8V+G/H90snYNPMJkgyHz3ITcTBxZOLqp/YqWY6IBzswARUO2M3CRkkpK4ne+R1RrLpY4OgEJRHwX4+kzxTRlrvqDz6onafLBJNmCIUJIZmZK6S9J5zyiJVoLM7t6EhHMiy/ntccKBHHcS8oU9O9UjR+/oAnCr5TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmBsN4/A; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmBsN4/A"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-607dec82853so74121057b3.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Feb 2024 05:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708607183; x=1709211983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eKhPv+xCz7eVUyJS6psDaUYVOFKFXTw490lXbJaQ8KM=;
        b=GmBsN4/ATd//70Qx0bMz80EAhpjM+R6fLijCFMDjDWgotck6tTAAcpKJASLMpBnygV
         j/0WoCfac9waApyLL9LejLEcKzRvvmEG/dbhLJNqtw3Vm51cMDtprbDo2fuqFToJLEWB
         oAl5vbCIJ9t6pZHRSBEYIaOYVkCq0XJzQ14442fg0uw7ra//k+PWAjwIYnIsffyOzZKD
         /04PaIhL5B9jcdyOSXJGoxnJWsavXRCcOEtklw9nBBI2Q/fDb38VzZNj5Wk21lGR56ri
         yjvXV9uPVY6IKEJPwODM9Np2OSt0A75jyb6Ic752Qs3ZiXQRfawdKzWbVLxTCpryyePi
         W9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708607183; x=1709211983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eKhPv+xCz7eVUyJS6psDaUYVOFKFXTw490lXbJaQ8KM=;
        b=orciHX+0ztbZt/SlFEsEvux6rhofORT0WxDQDgA1E6hUM7zWMFCmhIPdoZfEjol7gF
         OmEjG+SJpYP+p2DWZ0HTJpYWwHZVeI0Q0mKvfoWwNDe+jVgwblaHWryZZYKglJvxyGpS
         W1FLsWwPce9BNDUCdgtpWvPbE6LakajnZXbL4GYngh3f98k0b4UulADaZ+TxcEhSoXRm
         Fm2hbPqnJ6sThWteImqRaWDnti8xcTRY1+jKCUATzuUzwqRqNnFNeUxw0o6Pb4Lvts3k
         Ki2atG92e3kqXobhbUEu1Ga8ixrOdeMH0Lpxj59oHF0D0MEWSRifOq97+IpYfbrjMjgm
         QOaA==
X-Gm-Message-State: AOJu0YxpcdgrscZrEFwwe84jpr1mNjtsIkY3euZEaYcbhXt08P4E34+r
	oZBDZR0nG+GPZdQc4JLyjlzrTuLxIaqyJad/51WXjE0okIuTTGQnbsEUgf6UB7tHciJOVU1Fpog
	nvTR5aPcw+CAIJuEx3HdrWfUhVgY7TM9Pd4I=
X-Google-Smtp-Source: AGHT+IGnYATLkZKyzwYu/cDITy+emcsJbtxRA8w4MZ4J6nzUiBP89nA5f6cxiKTL5ErxKaEM0kj1QoMkFYbZgHAU0mw=
X-Received: by 2002:a05:690c:e06:b0:608:aecb:1a66 with SMTP id
 cp6-20020a05690c0e0600b00608aecb1a66mr46011ywb.20.1708607181353; Thu, 22 Feb
 2024 05:06:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221111901.2807853-1-joakim.tjernlund@infinera.com> <20240221111901.2807853-2-joakim.tjernlund@infinera.com>
In-Reply-To: <20240221111901.2807853-2-joakim.tjernlund@infinera.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Thu, 22 Feb 2024 13:06:10 +0000
Message-ID: <CACvgo52M-Efhp92u=fd8qDjV39SWvuoakLgt2JtFftDmZ2pn4g@mail.gmail.com>
Subject: Re: [PATCH] CUPS lives in libexecdir
To: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 11:19, Joakim Tjernlund
<joakim.tjernlund@infinera.com> wrote:
>
> From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
>
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> ---
>  Makefile.tools | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile.tools b/Makefile.tools
> index 044342e29..b785ebea8 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -538,7 +538,7 @@ endif
>  endif
>
>  if CUPS
> -cupsdir = $(libdir)/cups/backend
> +cupsdir = $(libexecdir)/cups/backend
>

Is this true, can you provide some references?

Looking at Debian [1] (which contrary to Arch has libexec) - backends
are in /usr/lib. Glancing at the cups backends makefile it's using
SERVERBIN. Casual grep shows that libexec can be applicable for
BSD/Darwin platforms [3], which are out of scope for bluez IIRC.

-Emil

[1] https://packages.debian.org/bookworm/amd64/cups-daemon/filelist
[2] https://github.com/OpenPrinting/cups/blob/master/backend/Makefile
[3] https://github.com/OpenPrinting/cups/blob/535fdc2b38fc3f3819233344556c45f4e8d2620d/config-scripts/cups-directories.m4#L246
