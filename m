Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096CB60B90
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Feb 2024 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606474; cv=none; b=NouM/SAbqG75TXesB2U6DQ6kCIMHxfvv6lYyYQGumEaHynm9uvQFvSiFFh8xdctd/SbJoyT25rhxnnCBoW/zaJg9xbbermeD8kE7fuHSEpn7X7xGilh5E5rk4VLxGnFe27lNc4ZAZLyVQJJzSBPiLBEFqiW086aqkJ3IRxJsSUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606474; c=relaxed/simple;
	bh=kqp89DPYfndOK9yZhh4NaSGggHdOQcZhZfq25J31Fa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JV8/ieUXMmzwKwf7Tk31lYkP4Y7LdvQc7EXIGA238vLg12hpoHN4z9POljkwRv3XFDobCbpT33OGDKOvRw2I7h6eyPU8arCCx9/fMNUiiNPF7atfC/5VcR9X/PWcaVLpszH55zNY85tAs71VCckngC/upaSygFZaec1PMd5Vxe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjskc9q4; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjskc9q4"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso7648461276.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Feb 2024 04:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708606472; x=1709211272; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hCovU9meDl7yv1ERM9sJWtInrcmFzCnYc1TAhRuYXRM=;
        b=fjskc9q4GN+ANiGoJlONzDkLh8izqQ6/IbsR2zyfbXEtfzjTB3Q2IhjCtn7P4dct6A
         7xDc7ntAEQYw5shqI31PUPm2sD1KFU7BDgB/EZV6X0t9sqKCCkzE5OLsTtpI0AHaRwPf
         7C/vmuiqAN+mLSN+EocAhF3zOq8N4QaK5aYbBOhFiaDJVWCYJit2S3I5hNTeSnvoGvs+
         E2ORf59UUOL2UXRKsfROZ2Ex+b/pR/9FU0a2F1Vy93QnLYqk5f8X3j1/9Z+7dOld2Uak
         yZSikHTFgGJ3k5Pood2bY6q9plUKGgpp9GVQBvxJ0daDyKtnSg3gnq2ZP4TYA5cdgy8B
         uDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708606472; x=1709211272;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hCovU9meDl7yv1ERM9sJWtInrcmFzCnYc1TAhRuYXRM=;
        b=dnGc26FxiSIgvirSwlgBNPffT4AMvNUQ3tffp5EwUm81CEZIA8qIzAvQYy4/08uVqR
         JqyfUhDfkxIF23diVzKDLdYN4kfMADhBGFE00jSXQaS9bWFGi/pfdXBoG7djJPgu7V7k
         xeoxjJHsmlNw4H6uhlXsDwhoV56vyU5ZMu/WCqEUCLjmR/T9T7X+ZXsvbfxYwmG20pwj
         WICrk48rzl6JxqVZ2BMdfv/BUtzKbck43gnvrBzgABBCYGUjak5ue8jRbsMX1hwrGdt0
         E97hjjtaxPR12t3tJ+OnFXsSIK2LTOxMHS2rIkOzZoH4Bj7FnswvMJpYzzumD6OmbUGG
         e9qg==
X-Gm-Message-State: AOJu0YxrMbwTdUVFv0d3/Mu6dWwRZjpEItvOwUO9AsbhtpcgrS3DQrig
	WLj1z4xasxiwPbL9eXSQ2ng7pyhf9CQO10qe3Hwe7mOvT0bz1uFZzW8vsVpJ+acs+Y6PTGCbYpI
	+8ofgX8FZ/MSEmtGMR0HTBzyrWZzuGdWh
X-Google-Smtp-Source: AGHT+IE5dJ9OWIagGkmH8QNlUuKsUAP+z6VjG/CjR0ZYu3bLZ5uWtNj4oDHKoYT2Wsq14aUMZyb/+p2yHCrVmq9QYh8=
X-Received: by 2002:a25:6b0b:0:b0:dc6:2152:3889 with SMTP id
 g11-20020a256b0b000000b00dc621523889mr2337720ybc.7.1708606471890; Thu, 22 Feb
 2024 04:54:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221111901.2807853-1-joakim.tjernlund@infinera.com>
In-Reply-To: <20240221111901.2807853-1-joakim.tjernlund@infinera.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Thu, 22 Feb 2024 12:54:20 +0000
Message-ID: <CACvgo529avv_gypHc4tO6VNmZU6Md0V9ZapQnLLCE_3vdjOT2Q@mail.gmail.com>
Subject: Re: [PATCH] bluez.pc.in: Add definition of libexecdir
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
>  lib/bluez.pc.in | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/bluez.pc.in b/lib/bluez.pc.in
> index 3d6e59616..1c2f30b33 100644
> --- a/lib/bluez.pc.in
> +++ b/lib/bluez.pc.in
> @@ -1,6 +1,7 @@
>  prefix=@prefix@
>  exec_prefix=@exec_prefix@
>  libdir=@libdir@
> +libexecdir=@libexecdir@
>  includedir=@includedir@
>

It seems to be unused in the pkg-config file. Why do we need this?

-Emil
