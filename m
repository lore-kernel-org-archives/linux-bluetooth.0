Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD55648986E
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282640; cv=none; b=UyRxQQXcq3ca23Vyqw9um310nv767DOB/FhBwqhkqNarVXgvNz5LiZx/iT3NoivZ/jAAzpj3e5KBA4i3sPkrgJI/+ZTww3bbXrDObDi3QeRtNvlZSI+xzwjYzE2rsK9fOS62fycbt3pyZYGq0YviH2HI2LFY1G2rCBSLng4C4tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282640; c=relaxed/simple;
	bh=ZrQuMqy5uBsBDcgHPFdZ9qrEDBqpzn/5bpyyFgMg0/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdugimlQsBp17jpS/zHSkakyE9O0A1MGtuwN/J/W8YfWm3JP7F7bJlENwWLy/e3G9su8zbrOAXzCUBkcEnP8LRzMrR85cnSHDC6fnPy9CFrTGb9Jc1qENLNOvcq/QPs7oZv7VP7S4y1xHdsybmqAkv/n3BwWphyx5P4TWPBHPZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCg31dLc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCg31dLc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7AD1F00ADE
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 17:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282639;
	bh=ZrQuMqy5uBsBDcgHPFdZ9qrEDBqpzn/5bpyyFgMg0/I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kCg31dLcbcJxsvNlIiGPaRvYTAolRwbnyrTNh7df0NUa4SNd71rD+avlItPibQq/X
	 FYX+850hphxZFeRTMs8ClOCNv3svQ18/42jU7k+arfharYQ8S3H0DTQPecYGubx3iw
	 f21rCa1wCg3O0EpK/s6wrcXMCoJbv/Ym/LHyq2gJ7knsY0XSfeiaSZ7StTnQy1yIA2
	 jsF1Z6p7SKGFCZyg1ziXv923mzlnTNmOS0GRvC2zv9GM/l++idppV7v0+c/jObCgma
	 I3EPRMKxXn1zPoDSRKXeLy1UT8Zu1caYHajFRmGRrG4a0jiY7a5c85rsdfPGIdebHn
	 Kev6e2kF0cGhQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b0115b9e17so1137049e87.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 10:10:39 -0700 (PDT)
X-Gm-Message-State: AFuF++lIn6+4skQG2MewsfrrJ/WmMXXzNZb2yxnjQhmrVC1kzAht05ED
	WglSlK1zg/hSigGw/clLP7n6bYYR5wAw8pWmxyiDGmcEZ9kzPqmks9yXZ3kYtbF46oO8CE1eCNX
	Q+PTZBVbh2f0SZvqIz2mtJF5KiXi7WVQ=
X-Received: by 2002:a05:6512:12d2:b0:5b0:129c:ed85 with SMTP id
 2adb3069b0e04-5b5e68bdacemr11077650e87.1.1788282638096; Tue, 01 Sep 2026
 10:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827110242.1203546-2-andy.chang@synaptics.corp-partner.google.com>
 <20260901023300.1382808-1-andy.chang@synaptics.corp-partner.google.com> <20260901023300.1382808-2-andy.chang@synaptics.corp-partner.google.com>
In-Reply-To: <20260901023300.1382808-2-andy.chang@synaptics.corp-partner.google.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 1 Sep 2026 19:10:25 +0200
X-Gmail-Original-Message-ID: <CAD++jL=0szwyknJ8S7nCgFyxwws-WxeqJHi4w2L=o-T=4k4sDQ@mail.gmail.com>
X-Gm-Features: AcwNN1UH0p3Wtr3eiA8KmHVuccBgaAV41TvtLXXTmB9WfWrOei9guGrG77J8GIA
Message-ID: <CAD++jL=0szwyknJ8S7nCgFyxwws-WxeqJHi4w2L=o-T=4k4sDQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: dt-bindings: net: bluetooth: add BCM4384
To: Andy Chang <andy.chang@synaptics.corp-partner.google.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 4:32=E2=80=AFAM Andy Chang
<andy.chang@synaptics.corp-partner.google.com> wrote:

> Add the brcm,bcm4384-bt compatible string to support the
> Synaptics BCM4384 Bluetooth controller.
>
> A fallback compatible is not suitable here because the BCM4384
> controller requires a dedicated firmware patch file (.hcd) matching
> its specific hardware ID and revision.
>
> Falling back to an existing compatible would cause the driver to
> request the wrong firmware binary and fail the controller
> initialization.

I would word this neutrally like

"any operating system must discern the proper firmware to drive
this hardware and the compatible string will fulfil that purpose".

> Signed-off-by: Andy Chang <andy.chang@synaptics.corp-partner.google.com>

Either way:
Reviewed-by: Linus Walleij <linusw@linaro.org>

Yours,
Linus Walleij
