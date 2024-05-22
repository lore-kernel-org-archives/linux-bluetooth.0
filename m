Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0092842078
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2024 22:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716416349; cv=none; b=Ukj4MfqGKG5Bo5nOIEnsP6e7F8fL6IrrofNKaq2HiHaue2TIVy19+i4EbUTrWrkYPpXWDxZfD/5X2OimMayvGTxms9S5Uvuw4OnxNWV9e5qNRa2HVQrI6xqXqHb8FOLMJnjEJHHOVqZwleHqQQDeBBXxIOxc4Ub4xV2+jtFSM40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716416349; c=relaxed/simple;
	bh=swwro8lOZgvb3QDkxq4qjw5SkDE6YkcxR3UDNunhgjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msdj30tGe4ShPifo9zUk16j3ym5Lkbnjh/iSmhq8rfVAZdCSC2/1WOfWox66EponvTUTxCMGz2rr0l/gUSm8PGAOD6Q5zkr454jwQkb+RNrdwxyM5BiDtf971IPPXCd3xq8KK/o7iSxLaDTB/HKbRwYcVXQ8XlYeA0SAP/i7aS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vo1S0kIo; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vo1S0kIo"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso1984a12.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2024 15:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716416346; x=1717021146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhrevzC6PfRPXcTVZKdgRT8gCvrtytd4Oo1yvznuYr8=;
        b=vo1S0kIocnO+7JNu2yVpq6kFxVrRiUgn60vLk4EGZ7KsoUK7deRm7/CovIesjdW7Ig
         LjIxAotbJmbn0rbsJgF5cTBJekhsl2CMkXFGa2iTW/RTqlb6UEcW6eJ55ITAADKNcNzq
         c1T4Nvp65Po7+ddgPNbZARXgxT1Bm76xPKBSnusfhwz6ajMpw9zt8sBm6IWdkxILjvyu
         D3RBYgWDvMft7QQh8JZf7o9o2LP2xrlClLKpHMjKbbwONyvqtVVkdUeCL4cT9IUfrGVd
         gLMAeXMbcsNMWyn+B/gp2sbLwMnz2Gz5v+rbh62ubpxbo65BSSrhUwfXW291QQSfiadr
         OJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716416346; x=1717021146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhrevzC6PfRPXcTVZKdgRT8gCvrtytd4Oo1yvznuYr8=;
        b=FL9VfMbD7wtC73Viuy2Lj9MzSpOGiEi/c5yRUVRv0JE1dwvcQMD9AxB0Q7SiWp2H+x
         IkU6Bh61CYRTZuz9fhVCKygSUUqBE0HDwCEFMbcXTTZia4FUHMcoq3V5+b9eorKxO6eV
         W5ozE5U5MrRiBJNp8sXTdmJaheL050IJ/+wzf4HsKXFRLg3IEC6VAw0SRidRUKurktfp
         7Reoy/jMGo1q8MuPyPqzastKxDkwByHAKFk+yitsPpqiEJKPz1W5tSvxZvsMXd6Amfn7
         clZsPIQapoi9qoqEStOYrvBIRuiHWW9iNCJHVt46Zx/41JStSViHtkXqbRHbpZ81rBrn
         TvbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk3LZnIxBT5ivKRzBaDhrym41pn6id3o7wdzyKpmh1CSa9kIGn1tYkbt72bppFbP///Rdx3bs6C5UEjVUuqtud+xPe0neId9eiFuFcD9be
X-Gm-Message-State: AOJu0Yzo8HLX/xwaBqJTk6Z1XcO1kmmchA9+B3qZ0A5aRmrYEIKk/M0C
	VESM0muM5MIzyeD3htFkTcI+KTll8Y5ld7PJ8NLvu8TtRPJwVZ/mizDoO2IDKHYje8WBlJEea/+
	aMGS/u6zuGWn/ZKwwRKWp70OeHKlZZG28WMoN
X-Google-Smtp-Source: AGHT+IF62mCggB+fp0Hi8G7QtAYVSXNBfMqCEAUF0DXMxHEcTp4ynDaEWTuM179DypO8UKzQBxEYxqqj04GQD38VKbA=
X-Received: by 2002:a05:6402:3551:b0:572:e6fb:ab07 with SMTP id
 4fb4d7f45d1cf-57845a7c1b2mr12747a12.7.1716416346140; Wed, 22 May 2024
 15:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517170246.1.Ia769fe5fbeaa6aca2edfb01b82eb7df0c6955459@changeid>
In-Reply-To: <20240517170246.1.Ia769fe5fbeaa6aca2edfb01b82eb7df0c6955459@changeid>
From: Guenter Roeck <groeck@google.com>
Date: Wed, 22 May 2024 15:18:52 -0700
Message-ID: <CABXOdTdPM7b5uYGnQ3KbN+9AzKb=D1Pq-TZcftO1_z3efXjg9Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: If memdump doesn't work, re-enable IBS
To: Douglas Anderson <dianders@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Stephen Boyd <swboyd@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Johan Hovold <johan+linaro@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Sai Teja Aluvala <quic_saluvala@quicinc.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 5:03=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> On systems in the field, we are seeing this sometimes in the kernel logs:
>   Bluetooth: qca_controller_memdump() hci0: hci_devcd_init Return:-95
>
> This means that _something_ decided that it wanted to get a memdump
> but then hci_devcd_init() returned -EOPNOTSUPP (AKA -95).
>
> The cleanup code in qca_controller_memdump() when we get back an error
> from hci_devcd_init() undoes most things but forgets to clear
> QCA_IBS_DISABLED. One side effect of this is that, during the next
> suspend, qca_suspend() will always get a timeout.
>
> Let's fix it so that we clear the bit.
>
> Fixes: 06d3fdfcdf5c ("Bluetooth: hci_qca: Add qcom devcoredump support")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> I'm nowhere near an expert on this code so please give extra eyes on
> this patch. I also have no idea how to reproduce the problem nor even
> how to trigger a memdump to test it. I'd love any advice that folks
> could give. ;-)
>
>  drivers/bluetooth/hci_qca.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 0c9c9ee56592..1ef12f5a115d 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1090,6 +1090,7 @@ static void qca_controller_memdump(struct work_stru=
ct *work)
>                                 qca->memdump_state =3D QCA_MEMDUMP_COLLEC=
TED;
>                                 cancel_delayed_work(&qca->ctrl_memdump_ti=
meout);
>                                 clear_bit(QCA_MEMDUMP_COLLECTION, &qca->f=
lags);
> +                               clear_bit(QCA_IBS_DISABLED, &qca->flags);
>                                 mutex_unlock(&qca->hci_memdump_lock);
>                                 return;
>                         }
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>
