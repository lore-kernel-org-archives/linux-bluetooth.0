Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8DE12FF88
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jul 2024 07:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720681898; cv=none; b=JSMCXrpNDNBViuS/t5X2k/vOTMd6oQHFfwDIdHmPgOTFOZyjZ9E4FNIciACNOPOXseVxSBnEXUH/y5HLLzBkuFyO1EOs6uVkdFDyihDUZiCmLjXnGrVuQT4rf5pyzu4DfvOf1Xi/7UGTQP5V4Ic8yTBPx58UVKDI3atx/Mb4yKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720681898; c=relaxed/simple;
	bh=VIAV0i8bfBGJmr2ASHi9uepl/tgYVYGPQgjFhw98zcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pw31RAT6Z2DFfUmtenEqG/ENQCjgjXIdFywtSmXGPoC3wPa6ZKPKTBGXQ9Qu+ZU6muJubKCWOz8G/Gdedm9/Z1R6uJyf3wqn8p0tgcZ8VcVSdbM2Bdp4dK40KDx3FPR+FOsZTK+qMdJwGxCcmpYXnBKKUmIo3mM6wOxm4PcLRyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LwArbRcz; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LwArbRcz"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ee98947f70so5342881fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jul 2024 00:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720681895; x=1721286695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8FpGfJhKHRH51INGqjbfreZcK/LNo4iyWKefVeCz8o=;
        b=LwArbRczHX09SzBLu2F7ctkxsGY5eoxRiYvWxDCwK5pbm/8HTW+B37ki7KuI6UZmxv
         O51el9nqk5wZ6mHIBltTQuDZwJ3uTpMYpmv8UfysS8mWEw4hA7reNGCNUDJin5CQvKHl
         sYYvkZ7dZBOmj+eY38AcM+qqACgSPPFReFGvOHiDhV1ErtiNMrJlzoKnpe0TxXxrung+
         ccHfuyU5kRkQcYmz6hHl488uLzJEQeCDof/tJOHu+DAPzCWT+MgMG8z1RjTJdUIvrnTK
         2OWJ4rUqc5KTIcr5lAH9EEjG5ICr4VNbzQnsFj57lMl3HrGgp0AwUHOCgBhkgTG8KdxA
         t/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720681895; x=1721286695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8FpGfJhKHRH51INGqjbfreZcK/LNo4iyWKefVeCz8o=;
        b=brXTb/rY3YkqlhPOAfZhI/FlY9o57ksUo3CaWMovqMZhardLZaIZOcJe6hAr2LjJNK
         ApgYnmcVThJXZW/VCVxK7ENytNw+KG2miAf7QwKGlXI93apXDQCoSNdgHtQpX6KJHlZ/
         RqHt5PT8iuVoQsDuRxQ+riGCfNcLsrJz3F3MRL0/mUSLVDhUnb4Db/Z3n+qUe9NGnkW7
         4waQzCFD0n1rRzOEH1QtT91/9BRIReUSFuv8amuY8c11tkankhVA/cc736LVt9+Mu6vd
         fbqt4uv0o5HcfbtL3QBB/H84XLuuxom64RgBQNL73TkAzt4NkoYONTjLzcVe0+4WAiuM
         aLHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1BKxDa1XBIa2GCB8l2Hn7I7Ixbtq0fujAcJBPvBTW1nDPZ5wNN5cbBjgfXuPmM64USDGXPZwPl/lAPGt6M1mqLSQpwkaqK2ylKPdPap2f
X-Gm-Message-State: AOJu0YxqyAAZc00bMxJf+GB+TPfeBafBPv6VpsxxP0dC/CtKZXa4Q5jZ
	kUOeRUCglhhhUcR4xhxWQc00QQzZB5DgKCbBq3QopY/qyjNCnHM3Gk1R7f9Hovyp7i2Yl0RAu5T
	Z7/HB3fLWU7yU0PrrSapQj/hsvXOTkHSKzSmv8g==
X-Google-Smtp-Source: AGHT+IHcmrV3Xm79/GKLrO5u/EIzHMqb39TGt7V4F8gME6OClLLzo6aZsZ4SHb9OWD9Ho4J3EkV7V/Xbc5AIozEv7nY=
X-Received: by 2002:a2e:9495:0:b0:2ec:1ce8:9a7d with SMTP id
 38308e7fff4ca-2eeb30b83f4mr49649831fa.4.1720681894945; Thu, 11 Jul 2024
 00:11:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709-hci_qca_refactor-v3-0-5f48ca001fed@linaro.org>
 <172064103479.11923.11962118903624442308.git-patchwork-notify@kernel.org>
 <CABBYNZKvSF9h1K29oex3kXm+2h+62gwJ8+YJPM0Orap6_xVDTQ@mail.gmail.com> <05ae1a45-107e-4d01-9cfe-648b52cbb364@linaro.org>
In-Reply-To: <05ae1a45-107e-4d01-9cfe-648b52cbb364@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 11 Jul 2024 09:11:23 +0200
Message-ID: <CAMRc=MfgBhMZvBD70bAxc1Lw-zTU_7ByaxBqPfgD0WZ6Hq+MOQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Bluetooth: hci_qca: use the power sequencer for wcn7850
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: patchwork-bot+bluetooth@kernel.org, marcel@holtmann.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	quic_bgodavar@quicinc.com, quic_rjliao@quicinc.com, andersson@kernel.org, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, bartosz.golaszewski@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 12:08=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linar=
o.org> wrote:
>
> On 10.07.2024 10:43 PM, Luiz Augusto von Dentz wrote:
> > Hi Bartosz,
> >
> > On Wed, Jul 10, 2024 at 3:50=E2=80=AFPM <patchwork-bot+bluetooth@kernel=
.org> wrote:
> >>
> >> Hello:
> >>
> >> This series was applied to bluetooth/bluetooth-next.git (master)
> >> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> >>
> >> On Tue, 09 Jul 2024 14:18:31 +0200 you wrote:
> >>> The following series extend the usage of the power sequencing subsyst=
em
> >>> in the hci_qca driver.
> >>>
> >>> The end goal is to convert the entire driver to be exclusively pwrseq=
-based
> >>> and simplify it in the process. However due to a large number of user=
s we
> >>> need to be careful and consider every case separately.
> >>>
> >>> [...]
> >>
> >> Here is the summary with links:
> >>   - [v3,1/6] dt-bindings: bluetooth: qualcomm: describe the inputs fro=
m PMU for wcn7850
> >>     https://git.kernel.org/bluetooth/bluetooth-next/c/e1c54afa8526
> >>   - [v3,2/6] Bluetooth: hci_qca: schedule a devm action for disabling =
the clock
> >>     https://git.kernel.org/bluetooth/bluetooth-next/c/a887c8dede8e
> >>   - [v3,3/6] Bluetooth: hci_qca: unduplicate calls to hci_uart_registe=
r_device()
> >>     https://git.kernel.org/bluetooth/bluetooth-next/c/cdd10964f76f
> >>   - [v3,4/6] Bluetooth: hci_qca: make pwrseq calls the default if avai=
lable
> >>     https://git.kernel.org/bluetooth/bluetooth-next/c/958a33c3f9fc
> >>   - [v3,5/6] Bluetooth: hci_qca: use the power sequencer for wcn7850 a=
nd wcn6855
> >>     https://git.kernel.org/bluetooth/bluetooth-next/c/4fa54d8731ec
> >>   - [v3,6/6] arm64: dts: qcom: sm8650-qrd: use the PMU to power up blu=
etooth
> >>     (no matching commit)
> >
> > Last one doesn't apply so you will probably need to rebase or
> > something if it really needs to go thru bluetooth-next.
>
> Bartosz forgot to mention it should go through qcom
>
> Konrad

Yes, sorry. That's alright, if patches 1-5/6 make v6.11 then I'll just
resend patch 6/6 to Bjorn directly next release and we'll avoid a
cross-tree merge this way.

Thanks!
Bart
