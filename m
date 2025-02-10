Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A456A2566C2;
	Mon, 10 Feb 2025 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739211455; cv=none; b=c443pIuwW/mmMvHrKTf2xg01yYr/FRr+BvcDQMs4V1hOo1F/Sq9fT+Dx/Hd7XoHBvlif3vbhP5xk/2VfzovG142F6iF0z+ZSCMrOZPPPVd5+2HrglHyd/duVt7TnPW0UqGbpKiP3sPoPJYxcLtlmS+3/qwZ0CHaKAEUteShdKpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739211455; c=relaxed/simple;
	bh=u1ps5n03+FoaCgzrAwacz576dxFHVcurQ8nPSbZWBAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmbvUB2V1UZU5gEesdTX6fxZcVMhsPjbPh8YU5vUOPYkxWpLRHGUi0RfVaYlP1+vMX3IiTU9Lb76E6nVOs/zWLpipQpbo8hu6B9c4LC7BT/cOgpecLeEklbyaLQxjQFtHRCOKX9ILHxqtMwR07nGxJIDb0skEt7Mvyxu7/SV+18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQSC78q6; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQSC78q6"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-308e9ff235bso14205881fa.2;
        Mon, 10 Feb 2025 10:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739211452; x=1739816252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MphtP13wqewLaIDYhmzym+mzMSk6usQLectNwb0w1vI=;
        b=KQSC78q6rq1thggPRwI70AvnFfCPHPsjl4rNC543OhBGDtJ40rLxbuwl7Vu/kCDVrN
         yBFWw5bkQk6qwPGaFoIVgywoA0eoLv9nI5/TeDvCU/1OVslrX4DulPd+S67+ntnUQvBL
         djBiq/qn0oWm3cXZ/sfSu3DU0CQ5c/Zo73hflCGnx2hE2CuhhlL1heQxUjeIIqUu1Ylg
         u/xaONVqVVJKuqPYFKlbE6qEHcSeIjOvCqrCTv0FI1DG9U41aDbNpisS6Hmf5PMTILv1
         HPIxqO/WNqLLgpB0AYxsbUETNSSbzeKFy2rFl4mSgOTsKE0Ge/SIV/LUskY1T46RrLVx
         nkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739211452; x=1739816252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MphtP13wqewLaIDYhmzym+mzMSk6usQLectNwb0w1vI=;
        b=iJGqiqaVxFuiOcW55jl89ZjoECcywnX8AVM8rPixjSsnuK/bEc3grdi5Er/+QcN8om
         KuuYRHANB3H943ibnaDpY+J+9kA2ahRtbPtOpa5IEbWhLk0MQDk5ya5u4OvbgWUGyqBN
         S91emWqcHQ1dNORT7qJxaLSd/M7AJdGPulyVlE3ltWjQWthufJU3OpVqW32uyTttf1TS
         48o6gplrtGaAweEIaQPQ6GTU6lwws5IWJZSBesgc3M/GNWFP6p4n3kA0x38YkXmfdNY+
         dvMlb54c6XNFAAVsaH+ID/W9S0r2K+Q8IZHh9tKL0vdnftDPc1fOLUkcQsktBUsWo+xW
         KLDA==
X-Forwarded-Encrypted: i=1; AJvYcCUzEo0yN3TDDRYib4jehE+dIFkCc/zz6iPg1gVmoODBYMMffKRFB/OD6wsJdE1yQVMij/ghefH7DLcUIZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxkysWMQMcfGfMwgsNQovNs+yNNOesaLaa8PSUzC6iESL8Ytp/
	9UsP3GPdA4k0ctba6N0diWsrrDZdBRqg9FnLx7v+I0nyxw8C2DRuTpz5YxumW/zmPQoRGYShF0X
	8seRjFROCwbTMf9VreKWT0iFGBTs=
X-Gm-Gg: ASbGncukxBNkRfmY5cIfY0/dlkfs2L88BaNNsZa2429FS8LgbL8//4HKpa1vEMaN5/f
	D+VLlCcBKwtYsGaQUhtV9h+qZ+i3Jz4l3eVEuEfbuJaJJwrzY5gJ8XijfPE3gUFlxJhrkuTo=
X-Google-Smtp-Source: AGHT+IFfav3fUMifuO5Ua/dpywtgPFO0cOLOQ01R70bEHL5Poh3QU/QQ7zCc/CMCs3ptmXFsNQI17c+HAa8MM5rl6N4=
X-Received: by 2002:a2e:9fc6:0:b0:308:ec25:9004 with SMTP id
 38308e7fff4ca-308ec2590femr23133251fa.35.1739211451405; Mon, 10 Feb 2025
 10:17:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210183224.v3.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <20250210103244.646150-1-chharry@google.com>
In-Reply-To: <20250210103244.646150-1-chharry@google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 10 Feb 2025 13:17:18 -0500
X-Gm-Features: AWEUYZlQ2qVAj_CuTOecFBPz7pNVivVyzswO9D4QM2Ggfc8zoZIud3VUJ-Yvo8k
Message-ID: <CABBYNZJ1LbN_3H1pJsZ6mH1nY7ijb9nbuPSJJwqyvJnC0=U6PQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] Bluetooth: Add ABI doc for sysfs isoc_alt
To: Hsin-chen Chuang <chharry@google.com>
Cc: linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hsin-chen,

On Mon, Feb 10, 2025 at 5:32=E2=80=AFAM Hsin-chen Chuang <chharry@google.co=
m> wrote:
>
> From: Hsin-chen Chuang <chharry@chromium.org>
>
> The functionality was completed in commit 5e5c3898ef49 ("Bluetooth: Fix
> possible race with userspace of sysfs isoc_alt")
>
> Fixes: 5e5c3898ef49 ("Bluetooth: Fix possible race with userspace of sysf=
s isoc_alt")
> Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> ---
>
> (no changes since v1)
>
>  Documentation/ABI/stable/sysfs-class-bluetooth | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/ABI/stable/sysfs-class-bluetooth b/Documentati=
on/ABI/stable/sysfs-class-bluetooth
> index 36be02471174..1168e0318e35 100644
> --- a/Documentation/ABI/stable/sysfs-class-bluetooth
> +++ b/Documentation/ABI/stable/sysfs-class-bluetooth
> @@ -7,3 +7,15 @@ Description:   This write-only attribute allows users to=
 trigger the vendor reset
>                 The reset may or may not be done through the device trans=
port
>                 (e.g., UART/USB), and can also be done through an out-of-=
band
>                 approach such as GPIO.
> +
> +What:          /sys/class/bluetooth/hci<index>/isoc_alt
> +Date:          10-Feb-2025
> +KernelVersion: 6.13
> +Contact:       linux-bluetooth@vger.kernel.org
> +Description:   This attribute allows users to configure the USB Alternat=
e setting
> +               for the specific HCI device. Reading this attribute retur=
ns the
> +               current setting, and writing any supported numbers would =
change
> +               the setting. See the USB Alternate setting definition in =
Bluetooth
> +               core spec 5, vol 4, part B, table 2.1.
> +               If the data is not a valid number, the write fails with -=
EINVAL.
> +               The other failures are vendor specific.

Still not really convinced this is the right way to expose it, it is
not an HCI attribute to begin with, not sure if we couldn't perhaps
add another node to control it or add via USB device?

--=20
Luiz Augusto von Dentz
