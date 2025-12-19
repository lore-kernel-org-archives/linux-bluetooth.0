Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A4032A3CC
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766154466; cv=none; b=oKTKJxfZF21FgDeRZ2BALGlYo7Q36azni2s9qofg0rqOyb630fxOa4YoCOZTdXF6w6zG6crtyPdmXHyT69aJQzY3BaPvdHt2O2kwijWQNYNIAChxeFa4ljqEm9wtfcYSy/sb1Ki+5zZ9tOpFuu3ZowEr89klaUh88md7jB0JNt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766154466; c=relaxed/simple;
	bh=i6yKzKkzFVHvrkW109/RsT8RDMe0gmSoElAvGtM6Y9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZzj0CN1mbLibc+FNinXI19Ukkn4Brqn8LqshXNu4rOZdqtI5l5L5grD7gOqYaHSjYPqbBvzHLmKAh57FED4k6a6DMW8Pkwxwu+JCmixOtw3W/UAHBItRyunUyTbJw2mLwKk1IVyKY9ZEF1U2tzAGbBWrt25O9MXcZZ6R+Z7e/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a19ufa70; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a19ufa70"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37fd6e91990so13565851fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 06:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766154463; x=1766759263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1yF0sVIe4b+TGoqeLAjfr0wQe6VhGV3SlKXDVPcnvI=;
        b=a19ufa70mpHYU5m+bfAOdr9HxzJ9l7ox2RlNsCJ8DcPi9g+Frolmuk9JFhJy+gFs0X
         8uSxtZcQv3w8xmF5JnQW43m4ecl162R3ML1PnNA39LKOZBGm+XaZWXjCNBotkqhzYuo+
         Rt2OL7oKajFGWi/k3wcC4RWSRghwqzHN45svsoDSukSBjjpIL14eBkbjJ2sVKqaEed9G
         xC1GmYgzv4X4lJ0mhNnnyxFJ9WBPrE89YOpnJ4YqP3CkHBAuqdxUb4cfIRPMAE8d2KKI
         wJJs+MRAPzFjEEa1Cr9hVc5PbH648hswQZaR0c3K96zAUOOM5sF/NLL9HIxbHNi9u9DU
         iNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766154463; x=1766759263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q1yF0sVIe4b+TGoqeLAjfr0wQe6VhGV3SlKXDVPcnvI=;
        b=TTgk54EWthIyUyRBf9f8V5XolQSRLHUInFU4hqxQkwHLlDP/zMnGGC1PHLshTqaCHn
         9LhBlWf9pdiUADCKqJ3HR043U8hW+SF38Cspww8eASIsbkTlV0swwFYT0HOqmVlEMblK
         lkoUT4OBLK9wKjADmIjHwSxVR3Vd619FI9ZECKGxFvAdUVuVxbgyDZOcFRRn7XN5zOvM
         d36kGO1WvtcPn0243HHWsCIu0We68O0nPJjUeGUeSqDhT6JlEAGVbokjM6nbZ/ws3Nm9
         4rCKA5jIKSdC1lm9Kr8Pdkq5u8mPBT/vCuR54oWthKbpYj1rXmWuBxkQ0lGyE+Fq0NI3
         m8zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVapsY3U1C2lKbUH9pewLU2UVI5eNy4ABzcXav4arSSxdCN4zK5uaif9marjngdu9MpSR3hSmL4HnVsgilycko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzvzQg8vXuJTXAnKO3trkAQO6HPWD5Xb7lGNhz0Eep6B4VZ0BD
	O0VIwf/fSJH+MfF35FyxcNxjoEQAY/j6tdxOT/E1+yNWwskqqd+h/CaQoh74Rb/GOb1W68JRPMM
	IKGID/gGqgP9PZ8WE3JxDvIPlTyuxkXM=
X-Gm-Gg: AY/fxX6a81PSTTEF/Epy8TklqECSwbS1S6EmtMq29mCCnAF6OeGbp8qZ/VLT6KftsIM
	mmhgmnZc/g5uPnZhmzMCyxZ76fhOh2q0dyO+cdLdzGNuNAj2jZ4k+gSZAbitiSVf/3IpxU92noK
	F0mJsitSy5gTIWzH3o2PVfSAFqsKbF42F0kg8xkR2EHNXgcMRHXAVRkM2CxH6M8Um/Rq8UKm4Kk
	T23t3IFoG7UvTCP9IeygN+kOXNJOc7zULsc8OvF49dYAcvkSeRsxeN9llQmOIIE9pRLOA==
X-Google-Smtp-Source: AGHT+IGTePuCc/cNQuzDUl08P+Z5eGmY71+2Rox+04POLmJRiUj2KRy5gXqVGXUYAGf4HECmh6YhOO/vOss8ga/hDLA=
X-Received: by 2002:a2e:800f:0:b0:37e:8881:d2e3 with SMTP id
 38308e7fff4ca-381216b9af4mr5570711fa.24.1766154462756; Fri, 19 Dec 2025
 06:27:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217112523.2671279-1-naga.akella@oss.qualcomm.com> <e1f053a7-791d-4433-b7ba-ea17a03ddfa7@redhat.com>
In-Reply-To: <e1f053a7-791d-4433-b7ba-ea17a03ddfa7@redhat.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 19 Dec 2025 09:27:30 -0500
X-Gm-Features: AQt7F2oMAEupy3WThb985bfnSm7nE4ExAatDY4brpjD9axv5FgMAERmDTXnjjps
Message-ID: <CABBYNZ+dDFH4Ki=UvPNc_HSNPMb09gpOeNYs698TR7-c2k_LvA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_sync: Add LE Channel Sounding HCI
 Command/event structures
To: Paolo Abeni <pabeni@redhat.com>
Cc: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, anubhavg@qti.qualcomm.com, 
	mohamull@qti.qualcomm.com, hbandi@qti.qualcomm.com, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On Fri, Dec 19, 2025 at 4:09=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 12/17/25 12:25 PM, Naga Bhavani Akella wrote:
> > 1. Implement LE Event Mask to include events required for
> >    LE Channel Sounding
> > 2. Enable Channel Sounding feature bit in the
> >    LE Host Supported Features command
> > 3. Define HCI command and event structures necessary for
> >    LE Channel Sounding functionality
> >
> > Signed-off-by: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
>
> FYI, Jakub enabled automated AI review on the netdev CI, and the bot
> found something suspicious in this patch, see:
>
> https://netdev-ai.bots.linux.dev/ai-review.html?id=3D999e331e-1161-4eec-a=
d26-fafc3fea6cfd
>
> I'm blindly forwarding the info, please have a look and evaluate it. Any
> feedback in case of false positive would be useful!

Actually it seems valid, any chance to enable the AI review bot to
reply to patches, or maybe pickup from patchwork, directly? Or perhaps
we can attempt to create github CI action for it, anyway thanks for
the heads up.

>
> Thanks,
>
> Paolo
>


--=20
Luiz Augusto von Dentz
