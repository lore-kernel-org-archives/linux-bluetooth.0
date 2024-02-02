Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEA25253
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Feb 2024 13:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879173; cv=none; b=q8x3GyTTkNZarMru2Flz04p6HRcKdvAl6utsT6nmKrctPzv5uB79+e1UX5P1tbnQWttjo3cQSP0IH2vccu8rvmP5+M8qvZlEWf2x+FflwgBxfLfJl76vvbxuYZj/uyDYET7PvMZVzdcJJfCjRJmfawWiy99+5NqtoqGdsEGyCc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879173; c=relaxed/simple;
	bh=0dxT2bZfqUTaN/pgDE3v3v3YQiHSfOH7dfGHB+kmRmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fajVcyodxUloeaWNdHe0NKdNvbEZ9eRXs2RTGFXlhx4fLjxkx7s34hByMwuIj5PnfQICuNPNegHoip0dM6h2EM4gOYvD7MDULfL++wLhN7XhinZ0SniVGVUOh7rLEZHpuYBUg3+hUtjKogHmW346arCw+xsN/GCGqhGbIW2NqKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=krb/jVRI; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="krb/jVRI"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7d5c25267deso879232241.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Feb 2024 05:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706879170; x=1707483970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dxT2bZfqUTaN/pgDE3v3v3YQiHSfOH7dfGHB+kmRmg=;
        b=krb/jVRIzFSy7rofP1kdGAN1lBPMRGaSy3yXvyAR8qAJ/pJXXQYkLdo5cHNuP3YK5H
         qKJuQ17g0kaiEuTHn91wZRikrV//iD8lekH50jVs/Y0M67gX98Lg7rH1iU4mDLviBnp/
         3e5Lboy0RHc+dsoVmTCnu2WnjyO3ZDwBel2VkFIAxdadWIfXaIUQd/y8YlCHnLhzYFhy
         sWyE2JNnKhYvITTW5SIdCL+YNzjrxYT3omFkSW2gpcNjzuMjKGk7TpxhJOi82SC173+F
         COLFkotOjz4hBAfxqwP7o2zfb7ukpqBYVMIrwia1EMAXrP6ZMGEUCEEhH4qgH/Gk3Dnc
         wggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706879170; x=1707483970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dxT2bZfqUTaN/pgDE3v3v3YQiHSfOH7dfGHB+kmRmg=;
        b=Uo5EKZTsZQBRU5Z6V2iIdQlDDeADHlbDa38N8967GUJUPhlZMGBDQKm0dVq0563WrJ
         GIVeIwjKTjECxEeAysnNhTDWjoTaysQGhgDCvQuEiX/qUo5GgOgVn5kP9xX7Q3n+6Ktm
         ItlnE/df/bNnNn5DTElU1+zLGtnWzaRw4wTa4RUuzw0nmZDpqA+KwftH/bSBFSSN6qTJ
         gav3Vo0BiVKIDHtq+PbuttGH/gFdNAy8WpDUwHW6nUhhlAXve6yxuUM4ncB/Jww1nHIp
         045L5bqC/Ed76Ky6Sfcc+ZfrPYq4q1ivbH6QkvwIKlRgQPxbkKHNDWsJ5ZKmN1I6ilX8
         etow==
X-Gm-Message-State: AOJu0Yxi/x7vEC+4htyt0R2PgicQz3lv+Fs9V8XVgbg91V6cSU9gcwlh
	HoYcud985UeGRyqZlx8a78bU089ZB2J5g6Hoi01j2vD9VwqGOsXtGpCONAXlAmggMNvXiaolE73
	E8uEKxXu0RejirRm0j3nVb9+p3S2kqXQ87adkmQ==
X-Google-Smtp-Source: AGHT+IEWSGGwOYOwE9UNS4a7/BGQ5J1Iy+sfg/cwAIy6czcrvkxuNiWzhaxMEH75CieiMzMPxqerQJsKsDuJ/9HoZ2E=
X-Received: by 2002:a05:6122:3a05:b0:4bd:728b:c108 with SMTP id
 fp5-20020a0561223a0500b004bd728bc108mr8581270vkb.8.1706879170735; Fri, 02 Feb
 2024 05:06:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201155532.49707-1-brgl@bgdev.pl> <20240201155532.49707-10-brgl@bgdev.pl>
 <jb4hzijjxjv4kiy3cn2fuc5ox4x5uutredbxiwo2fvnkh2xudf@5w65qtp35ase>
In-Reply-To: <jb4hzijjxjv4kiy3cn2fuc5ox4x5uutredbxiwo2fvnkh2xudf@5w65qtp35ase>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 2 Feb 2024 14:05:59 +0100
Message-ID: <CAMRc=MdQ_uRq7a24RYt=KRSff9sw_1soQ+8ONEpNXy0emk5ChQ@mail.gmail.com>
Subject: Re: [RFC 9/9] PCI/pwrctl: add a PCI power control driver for power
 sequenced devices
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Abel Vesa <abel.vesa@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 5:03=E2=80=AFAM Bjorn Andersson <andersson@kernel.or=
g> wrote:
>
> On Thu, Feb 01, 2024 at 04:55:32PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add a PCI power control driver that's capable of correctly powering up
> > devices using the power sequencing subsystem. For now we support the
> > ath11k module on QCA6390.
> >
>
> For a PCI device which doesn't share resources with something on another
> bus, the whole power sequencing would be implemented in a driver like
> this - without the involvement of the power sequence framework.
>

Yes, this is what I did in the previous incarnation of this code[1].

(I know, I should have linked it here. My bad, I will do it next time).

> I think it would be nice to see this series introduce a simple
> pci_pwrctl driver, and then (in the same series) introduce the power
> sequence framework and your PMU driver.
>

I disagree. I was initially annoyed by Dmitry asking me to do a lot
more work than anticipated but he's right after all. WLAN and BT
consuming what is really the PMU's inputs is simply not the actual
representation. That's why we should make it a pwrseq user IMO.

> One case where such model would be appropriate is the XHCI controller
> (uPD720201) on db845c. Today we describe vddpe-3p3-supply as a supply on
> the PCI controller, but it should have been vdd33-supply, vdd10-supply,
> avdd33-supply on the PCI device.

Sounds like a good second user then!

>
> That would provide an example for how a simple PCI power control driver
> can/should look like, and we can discuss the PCI pieces separate from
> the introduction of the new power sequence framework (which is unrelated
> to PCI).

I agree it's unrelated and it could possibly go upstream separately
but the particular use-case on RB5 (and other Qcom platforms) requires
both the PCI and generic power sequencing to be addressed.

Bart

[snip]

[1] https://lore.kernel.org/netdev/20240117160748.37682-7-brgl@bgdev.pl/T/#=
m72f52254a52fcb8a8a44de0702cad1087d4bcfa1
