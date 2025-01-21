Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005DD1F4E48;
	Tue, 21 Jan 2025 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737477553; cv=none; b=k9A6TAW0Lf8WZMP7cVrz9Cvxs3SfhKa5agVWkSVWQ2JsbhAhjMjr9WjN0IqRrXi2bxc8JzoaYTcaBMSHkzlbUeW0XnoC1HL9Hr7psJ3niT7qwE6J/4/+O6rWixT5YmRBnIBIdQwjIbWW3n9m9mQfUQkIJ94ionFRmZXSBj5NaLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737477553; c=relaxed/simple;
	bh=ChbUddCvmP1ffSBaDwqfc94Ut36UUYoON2JE/SMVPRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qbX+dATebLp/d72xgdOkM+AAWEg8e1ikOG7uF18H3OG40oB4ss9qdiJh0ngvHi4kc+1sPyZyifUYVGWH3DkesPAwYO3hp4AQFdEM1mY/xj5WKPSt2xi/vERLOQYBivZoFTRJCBbGPMZeXBensnRHfiHrVhgFlIvz3w1bfpc/3sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsWEXuA3; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsWEXuA3"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30613802a6bso62495211fa.1;
        Tue, 21 Jan 2025 08:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737477550; x=1738082350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+TiN+caa4BI4WE5Y7nJyWjmv780a+T0H5TBqhtKBxQ=;
        b=EsWEXuA3iducDjmIH64ha9xl5BoyMfIK6jISZdX0urlqfscuxNH6+2i2H9IzCDwmD/
         v+HV9esBvek0MtCUbAAyY7T21SgzFI8TOq0EFpQfLqegZeCq1FFFYwMOmNMZF3PTTf/R
         NfCCsK7XhQmZaGNUhs9UR9LvfRalYDoAdlYHcNOs2d4yI5FleDQKs2+kK6EPblblf9Tf
         cbSztygrp6jego06BjeEuIgp+m9ky+zjBNCSLvInCllybuZr3VZeT5kSsMGryAOJG9fZ
         qxdnqnZx5W+4wRvWSQ76VgY8wVnUlnmXi/oP6Q03efHLCB9k4Mnj9HpYsay84XD4L1Wz
         s2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737477550; x=1738082350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+TiN+caa4BI4WE5Y7nJyWjmv780a+T0H5TBqhtKBxQ=;
        b=QaSSBqCdOF3kt93u/MHBUIV/jdqLT29rCFO6jFNYeATNS+IfvZxwvGb9lh1uqU7e+k
         w6pX6z51daJYaMDzLSydmoy+DtrxB6c352WWyRUNHTgct+woS0Jug2JQ7rYV/rmmI4QG
         Sxs3AgmmSj0/d3pAJDY4TPXA6XuDJpJoM2bgzCrYy6jnM35PfVLfsvtPRPkbHV4FGbJd
         dQrU6p7/Xy0WwIqikbEjAYtks+lo+e/ZINk2S/aLqJUXSbUjf1puHaFY1790dNtTodrG
         5RU4VtNUljq8bCc8Dbonts+mr8pC8PeaZHz6P02tUG22eKNzqHhQLGVu9hftzC3td8+V
         o5BA==
X-Forwarded-Encrypted: i=1; AJvYcCXzbETvRlamVKb7i/3D6aujYWuclVG2HBdnKjNp7I/7fOonlL7geM3LVAmG0fP60jnFYkCTFgargPw05J8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXD3BvSR+Y6U1rrgyKs1s1ckow9PUzG+NTfXbq+Q27ily/RZh4
	s6n2U++Ai0O6T/I8PEmH1su06SyKLGfDcVbydgRqO1o+k3gWOXAtNmxVQdLDRSuiiF44UzTb20y
	FJ1zBptjho0WoM/TGpnS/Ak3yjNY=
X-Gm-Gg: ASbGncstSoop4TKPN8sKB7gbgntBng30FoqOpnbFI1j3jjrEvfWCSQTdfC6bMfuCtbu
	+4pcLP38Y/RShHr8EC22vWYR1D6slnAuQ9oEPovwURil1pHnk+Nvj
X-Google-Smtp-Source: AGHT+IGRrwxDTyjljXWTpL/feglq25IMR4bOENsqXYntI+uQBEWkuHsAVY9fhs60jxC66N87Ot8PWrwJi2Ox9/v+fp8=
X-Received: by 2002:a2e:8e3c:0:b0:300:1ea5:1655 with SMTP id
 38308e7fff4ca-3072ca899f9mr47871311fa.15.1737477549843; Tue, 21 Jan 2025
 08:39:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120164732.v2.1.I2524c9a7d322be04b38b29bde3d7d1e578229cca@changeid>
In-Reply-To: <20250120164732.v2.1.I2524c9a7d322be04b38b29bde3d7d1e578229cca@changeid>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 21 Jan 2025 11:38:57 -0500
X-Gm-Features: AbW1kvZcEzLV2whk1LJ449ejN2vQdisgsVK-BgJTSHjercrRyDd2dY20ksbrXXk
Message-ID: <CABBYNZ+vwXNcP3gHhVdDHDZ9maA5rT_fOgyg3VkAy5gO8x5ocw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Add ABI doc for sysfs reset
To: Hsin-chen Chuang <chharry@google.com>
Cc: linux-bluetooth@vger.kernel.org, pmenzel@molgen.mpg.de, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hsin-chen,

On Mon, Jan 20, 2025 at 3:47=E2=80=AFAM Hsin-chen Chuang <chharry@google.co=
m> wrote:
>
> From: Hsin-chen Chuang <chharry@chromium.org>
>
> The functionality was implemented in commit 0f8a00137411 ("Bluetooth:
> Allow reset via sysfs")
>
> Fixes: 0f8a00137411 ("Bluetooth: Allow reset via sysfs")
> Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> ---
>
> Changes in v2:
> - Resolved review comments from Paul
>
>  Documentation/ABI/stable/sysfs-class-bluetooth | 9 +++++++++
>  MAINTAINERS                                    | 1 +
>  2 files changed, 10 insertions(+)
>  create mode 100644 Documentation/ABI/stable/sysfs-class-bluetooth
>
> diff --git a/Documentation/ABI/stable/sysfs-class-bluetooth b/Documentati=
on/ABI/stable/sysfs-class-bluetooth
> new file mode 100644
> index 000000000000..36be02471174
> --- /dev/null
> +++ b/Documentation/ABI/stable/sysfs-class-bluetooth
> @@ -0,0 +1,9 @@
> +What:          /sys/class/bluetooth/hci<index>/reset
> +Date:          14-Jan-2025
> +KernelVersion: 6.13
> +Contact:       linux-bluetooth@vger.kernel.org
> +Description:   This write-only attribute allows users to trigger the ven=
dor reset
> +               method on the Bluetooth device when arbitrary data is wri=
tten.
> +               The reset may or may not be done through the device trans=
port
> +               (e.g., UART/USB), and can also be done through an out-of-=
band
> +               approach such as GPIO.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 797e94ba74f7..e949c3ac7846 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4058,6 +4058,7 @@ S:        Supported
>  W:     http://www.bluez.org/
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluet=
ooth.git
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluet=
ooth-next.git
> +F:     Documentation/ABI/stable/sysfs-class-bluetooth
>  F:     include/net/bluetooth/
>  F:     net/bluetooth/
>
> --
> 2.48.0.rc2.279.g1de40edade-goog

We also need something similar for Bluetooth: btusb: add sysfs
attribute to control USB alt setting

--=20
Luiz Augusto von Dentz
