Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40A7219EB
	for <linux-bluetooth@vger.kernel.org>; Sat, 17 May 2025 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747487574; cv=none; b=oXuH1hvy0bfIXIPOIi1WpZ3TFO/R4WkMA9reHEDdFwWvk2oy6E2mAFduX/NCUi1bQYSg/qxF7nG7xHBSMG6xNIu0S1pIEG9KDtLe11beXYd0pTwATCrPLBeUImUTRzXVu/0XKq0P9qTdsVRAMxHduHWMsbA5Zjm5UuOT44vkcw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747487574; c=relaxed/simple;
	bh=1jx76fA3cVlIZLgCxx7+hbDlR5ABImV1SEpOOWw2Yes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkiIKkK1p/ObQZ9TQVOXBNhR8bUERKv1qgcb5IRmk8oSKQNF5thUd3IsivnNsTBulcvUOFvJMz+r7E0qHznwb2JtBImPVx1nno3K9QZAYKOQLFPi49oAT3mJ7GqGFdYbRKkN2NAxECvyLYdL/i9uQ2PqykDeD24LXH612WzpIuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaHoc2Z4; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaHoc2Z4"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-550ef1da73dso1316236e87.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 May 2025 06:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747487571; x=1748092371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOKYsBnUPrxv89hI78lJyu4gsLniR1D6doDhzdDF6wI=;
        b=HaHoc2Z4W3llBnu/ZUBxIcOsi9P8vfxJx6u0YYZxXq+fwePl2CDz92rRkUi/cq1daV
         AOezR1mCYGJCdA3dq0FmsMJ8E7eJnOVaRZUvRWZfxiwubnSofMqS4FdJgfz1eHDmSop+
         LvzIC3CyYDNvHDh7ChAIxRobvUipGUVY3AB08XQN4/urZRzE9M3rDs9/klfingshljLH
         5CRoRS0u1YF1z1X7cT5JAB1XlsfTT7NmPj+rf3hw8/FdJbfiX7SmV/pZBv2an85ah3RR
         6GYrixzlLNta1pPmc+xQ6VG9FQzEauwBCZKnkMgWNjor3nvQGviuft02/Uu6uL3OmC78
         FQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747487571; x=1748092371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOKYsBnUPrxv89hI78lJyu4gsLniR1D6doDhzdDF6wI=;
        b=SrgHmQ4ChVxqX34u589l8vdatjtQzWNWymKPW2+2g2C7F2JwxmaxUxnIbIR/n0+DPH
         15ZAUGjTSBE6LzwT7oU+u0eW/y0Mv7nKEa1/yui67C+N5z3dr6yFsrjiS7MqftlIG3Qi
         n4qe1Y+laNoN7DQkJ4uyH/7WCjZ7USEUx+Fk5Cdzwz/PYzH6s0/+Qz/WHKL+SKn1BRjn
         GtO4+Y7ODkEojKtAfmTLqLs+xE1CMxFpvF0Ma2g6uNYv22bjwHuDm1pqFCZnJ3J+Voff
         gYPZ6r/Z9mTASfahH2K+DD5gFzreBDoLLrn/uEuX0ttmITZq/Xcyc/KVEZCJQHObs0FI
         WphQ==
X-Gm-Message-State: AOJu0YxTc8XRTv27vqedRyegDWpm9EXdmH/X5X717X1DTy6cjEcKbBA0
	ag7wvyKFKKIZCDCFvuM/DLGDtcsslwbMxZqnWTH+b0JZcb35w8ej7iMxxykZwIP+
X-Gm-Gg: ASbGncsvDnmw5EG6Iwd7t88riMC1N7DqiWS1oKrYAjWpMmks4gpyJ/5Y2h4R2/ho//v
	BQ/eIeZfI/FQyEe/c1octEFOgyS3ai7bIQf+L1dCTZ4WKvFMjdmdwRQWD0uSh2NY7Hsf4Fk3lKr
	VaCILDDX24r+6ACtHzNCt1w7E9iRZxy222eplN94PyjWa33J6+XLfgqeOQr173m2rPRbW6XdQMA
	/xYIF56CUD43dZEDNl/SYAc8oMaHmdUeCZrtgxKXAzWdHznRV+zQ6mQ8kwJsoTanqHU5e6esGv8
	VVWynNRJA5TpyMTK2YKkGwBEtlWyRBupAcgs3dQUT79QpSpd
X-Google-Smtp-Source: AGHT+IH8xNd7Zj0tNhsEI2TPWBRG+4Vw+3LEpQ05NKsSM+wZ4WlSIDnnkDpsU8tfWe7YWb4s82J33A==
X-Received: by 2002:a05:6512:6310:b0:54f:c811:8b76 with SMTP id 2adb3069b0e04-550e98fd0fcmr1392679e87.36.1747487570427;
        Sat, 17 May 2025 06:12:50 -0700 (PDT)
Received: from eldamar.lan ([2a0d:f302:e054:54:ffff:9a36:ead8:547c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e702c9d8sm910352e87.181.2025.05.17.06.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 06:12:49 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 5CB51BE2DE0; Sat, 17 May 2025 15:12:47 +0200 (CEST)
Date: Sat, 17 May 2025 15:12:47 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Antonio Russo <aerusso@aerusso.net>,
	Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
	Andrew Sayers <kernel.org@pileofstuff.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Do not start mpris-proxy for root user
Message-ID: <aCiLTy-IuqV6V7WA@eldamar.lan>
References: <a15e6919-9000-4628-baec-a2d2cc327903@aerusso.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a15e6919-9000-4628-baec-a2d2cc327903@aerusso.net>

On Sun, Jan 26, 2025 at 08:04:27AM -0700, Antonio Russo wrote:
> Hello,
> 
> A default installation of bluez results in the systemd user unit
> mpris-proxy.service being started for all users---including root.
> This unnecessarily exposes root to any security vulnerability in
> mpris-proxy.
> 
> Please consider the following trivial patch that changes this
> default behavior.
> 
> Best,
> Antonio Russo
> 
> 
> From d9e02494e661109607c073968fa352c1397a1ffb Mon Sep 17 00:00:00 2001
> From: Antonio Enrico Russo <aerusso@aerusso.net>
> Date: Sun, 26 Jan 2025 08:00:26 -0700
> Subject: [PATCH] Do not start mpris-proxy for root user
> 
> A default installation of bluez results in the systemd user unit
> mpris-proxy.service being started for all users---including root.
> This unnecessarily exposes root to any security vulnerability in
> mpris-proxy.
> 
> Inhibit this default behavior by using ConditionUser=!root.
> 
> Signed-off-by: Antonio Enrico Russo <aerusso@aerusso.net>
> ---
>  tools/mpris-proxy.service.in | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/mpris-proxy.service.in b/tools/mpris-proxy.service.in
> index 5307490..118ed6e 100644
> --- a/tools/mpris-proxy.service.in
> +++ b/tools/mpris-proxy.service.in
> @@ -4,6 +4,7 @@ Documentation=man:mpris-proxy(1)
>  Wants=dbus.socket
>  After=dbus.socket
> +ConditionUser=!root
>  [Service]
>  Type=simple
> -- 
> 2.48.1

Looping in all primary involved people for adding or touching the
systemd unit file. Luiz, Guido and Andrew, any opinion on the proposed
change?

For reference as well discussed in downstream Debian in
https://bugs.debian.org/1094257

Regards,
Salvatore
