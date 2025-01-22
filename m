Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F73653
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 05:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737523983; cv=none; b=JY0OLPs8qJzh9D3q/5gk2tS8Er/aDDRYmGIfRTsS92br4zwApyRnGArPG1K3aPj29Ngu+gCAq3tPNllVLHDjsUQBmwZ6ZpcSGsWtSkaXsvzZIL1qJO98pnz4yxD208EjELaeyl1MqZLChKq1dUdTS4nlD4HmkKzIkw+VUESxJMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737523983; c=relaxed/simple;
	bh=uMpwTcj/mLcTcP3DAB55XZezjUB5itWX89t+RmzjKMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GVpHv7cdHPw9K5+ywl2IdJjj+fmkyfEC1YlvSg2LITDNu42ymVYU1GNlppM3vWe3g/2ZyLCUGJwac1K3v5OqrboNBGoCYlPSId0rWvY3ezGBNCtVX6T82rvmCHfyMH8MspZ6i66Kwo25FcpThAo0gyBxtqAB6GtOzpaRbGKnqOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JIuFjjHY; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JIuFjjHY"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e46c6547266so9343152276.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 21:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737523980; x=1738128780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJSX0gOEK15OF0iglCVwhDrvUbcIuieAsU3NbzoyowQ=;
        b=JIuFjjHY3n5K8zYwB1rbOdgR46dlxAz+IkM7SwZUb+DfSHDnBia+6pM7tfvGCpklrr
         YL5ukk+6gKYqe0wfpZV9ppa3rO5bUBlriQrCikZlfUB0ZhHbexkw3wOCchqBOpWqhSUz
         IQq6Lf/wdpLea8GsT2D5rJXg6SMsG1AtYjTNT5/wByBeC/PmwesywWx8ar+FYUZmrvKN
         +Lzrk+Q3EDG8pXDGz8Hf+CtzyGmQYHEJWKIlk8s8rbBuqqyXud6duDV5bKjRoH7twoBx
         Xukb81KzLY73BE9501uoskcBcyyZXU41uxa5x6J7TGXj3fdaoI64loN1lEN30GKtHj0G
         DwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737523980; x=1738128780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJSX0gOEK15OF0iglCVwhDrvUbcIuieAsU3NbzoyowQ=;
        b=QKJjRrr0D/NRs2KQjn6AgiTcnVzk78fzQBaQw0Q/ug/0ku8xqQKD5GkbbnlTUUXGLA
         bs2FT2u35HWNiQt4tRxAFqTKnBGF1xoycKWZ7Y36YPphkclziQhhOPSwuqtcNcJmXTT3
         LoyUSP5OrJg7gpxm9Gxxgq3wQfSXtosJuTYSy6I3bKYwxpfN5MriiTvVhEl26925jvEm
         f77OT6nkXdteWU/b0YmO8kjkhTXRCuNtM/BTx9emo5SkBxvOBuCQXICGSRe1fZQHxwiR
         5jZsikGjLpcqJJCnBJJ7WTEF2tGkhRPWr8QqFDaZDGgFYOg+SmGraSXMFiTXEHl14VZ6
         85yA==
X-Gm-Message-State: AOJu0YzSlc5SPgD8p7iXmqI6V/EcOPUzVFMBYlVcvP87ONZvO+hiNFtz
	zD56L7OMND7b+Muhjoh+nT7iJUNY6n/PSqVkxhDhky4y84NnZFJtt3fCJOqXmiXvuXm0ZbiobR8
	oNOIqESwiiwcS3LGDoUR30ziJXRd8FpSrDMJ+D7u3MErEj3oxUaqF
X-Gm-Gg: ASbGncvOye7/SFq32QHdAAx3Ib4JXKEupM7DuevQUbAzeEyzstOm2szssGuAPQsdhrV
	Z97rkHypUa2Nrvi9U3E+i7K+YO0kbQqFWe8pN/FVjDp2aVEimRJDG
X-Google-Smtp-Source: AGHT+IFNomOQ5zdixZau4gHFZE+lLZdTF+Ts5j0J2WcAlJ3sO36KkXcXQayIsI/bRXFv3llynIhiSwjYmwiSrfTMKZM=
X-Received: by 2002:a05:6902:2409:b0:e57:476e:4306 with SMTP id
 3f1490d57ef6-e57b103ca27mr16616169276.8.1737523980069; Tue, 21 Jan 2025
 21:33:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122131925.v2.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <20250122052100.2410368-1-chharry@google.com>
In-Reply-To: <20250122052100.2410368-1-chharry@google.com>
From: Hsin-chen Chuang <chharry@google.com>
Date: Wed, 22 Jan 2025 13:32:33 +0800
X-Gm-Features: AbW1kvawQapmD4XchsYIOlUVvVLp-doQ2lQtEQrNqRnVOqlaXCWTOxv3HefOWuA
Message-ID: <CADg1FFdEiL=rpthPdO37seiKAucfSQ-b=AX51gfy4DC3PpF7zQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Bluetooth: Add ABI doc for sysfs isoc_alt
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Wed, Jan 22, 2025 at 1:21=E2=80=AFPM Hsin-chen Chuang <chharry@google.co=
m> wrote:
>
> From: Hsin-chen Chuang <chharry@chromium.org>
>
> The functionality was completed in commit 5e5c3898ef49 ("Bluetooth: Fix
> possible race with userspace of sysfs isoc_alt")

5e5c3898ef49 is the first patch in this series, I assume the hash would
change after it is applied? Shall I instead squash this patch to that or
shall I wait for 5e5c3898ef49 to be applied first?

>
> Fixes: 5e5c3898ef49 ("Bluetooth: Fix possible race with userspace of sysf=
s isoc_alt")
> Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> ---
>
> (no changes since v1)
>
>  Documentation/ABI/stable/sysfs-class-bluetooth | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/Documentation/ABI/stable/sysfs-class-bluetooth b/Documentati=
on/ABI/stable/sysfs-class-bluetooth
> index 36be02471174..8cc5f3cfe133 100644
> --- a/Documentation/ABI/stable/sysfs-class-bluetooth
> +++ b/Documentation/ABI/stable/sysfs-class-bluetooth
> @@ -7,3 +7,17 @@ Description:   This write-only attribute allows users to=
 trigger the vendor reset
>                 The reset may or may not be done through the device trans=
port
>                 (e.g., UART/USB), and can also be done through an out-of-=
band
>                 approach such as GPIO.
> +
> +What:          /sys/class/bluetooth/hci<index>/isoc_alt
> +Date:          22-Jan-2025
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
> +               If the HCI device doesn't support USB Alternate setting
> +               configuration, the read/write fails with -ENODEV.
> +               If the data is not a valid number, the write fails with -=
EINVAL.
> +               The other failures are vendor specific.
> --
> 2.48.1.262.g85cc9f2d1e-goog
>

--=20
Best Regards,
Hsin-chen
