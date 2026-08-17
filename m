Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE463B6BEB
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968041; cv=none; b=uG83syRoU+34OGn08PS9BirSrjjZLhyltm1Yp8d75ZW+p+VjeQUT18NI+EBt6rmjdVHGSbSc1kzUXsHykFXlPubZRHMX9qqxXCTPFm8RUevdRb/4XZyPsIABe0RFY30rdcmYTXrieKfzl3w3vLFOnpuJLVKVFEXpOEzmOsKeTqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968041; c=relaxed/simple;
	bh=U3XqmgG/ogS7Tz2bG7imcA7Kj50G2K3nuGGq6dDcpnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXZiqXrr7WAQNn+D9QsRL7vdTTw8WaHDKuyEVj7ui94FAfspPTDEWzRV+6y17CoGO/9VpFTWqLluO6tzIfrz8J6TF+YmaRqQIWLOH8tmW9VxGeaN/va1p/zgmYNMBbgPjlQYXy05OZ53RngbMVP3fEmibottQ0ONHqLjVE1xnLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRfDAFIS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRfDAFIS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99421F00A3F
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 12:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786968038;
	bh=U3XqmgG/ogS7Tz2bG7imcA7Kj50G2K3nuGGq6dDcpnM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RRfDAFISozqathiOmE/UsBu6wRm4yQbHjX6cxqVioexnLxRMs94+5rbMXXfTIDTGY
	 bC3C2FHmpSXi+/2kt2hm44Y0nSDpFgZWgsVdto/tHDafwgZDU8AMsA5hl5a4TwHdiT
	 6sIqu4qiXw8d30+N/pTxHvhSztEbcZ8MvldbdRiHqZfukArvVSfyWSu/iZyfJU990M
	 nYay95ZOIG3Oaz4akYvuE6lKYAhCLhSgUgQuQf8szfpmG/NFs2nN/y152AtUkFOwFW
	 t+eU5nczvzisQIEzNKnZ3hI32ACVhhfzncYBH/8dJWS8HGasL+SD1yXHVaJnXY9RHi
	 skxTjLZYotjrA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39f927721f2so20463071fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 05:00:38 -0700 (PDT)
X-Gm-Message-State: AOJu0YyntH5qVDsgWrjavyZIAQtyTGaxVbUpY2Ue3OkUvNeYeAk4TTTJ
	BLMdY0Z6c38PA7We20wCgdlupAtE7PYq1lZhCamx43rw0RTzZv+cXndXtAlXm/pzvDvZWBhafGS
	O0QzK/tlElzoPNYSh2Q9uPt7BZXO/GC0=
X-Received: by 2002:a05:6512:2315:b0:5b1:5a31:8603 with SMTP id
 2adb3069b0e04-5b45914b27cmr3822108e87.55.1786968037593; Mon, 17 Aug 2026
 05:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817092723.637956-1-kaihsin.chung@synaptics.com> <20260817092723.637956-3-kaihsin.chung@synaptics.com>
In-Reply-To: <20260817092723.637956-3-kaihsin.chung@synaptics.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 14:00:26 +0200
X-Gmail-Original-Message-ID: <CAD++jLmfOwkxcuz1=CeFtMFnsE3d0tY725P5X7rnwv7TTbzkEA@mail.gmail.com>
X-Gm-Features: AcwNN1XdE0YUxvGSGFwLGHrE7ptqfK64JYxhKITaHjxjewXwfICYW-oh1y1zJhA
Message-ID: <CAD++jLmfOwkxcuz1=CeFtMFnsE3d0tY725P5X7rnwv7TTbzkEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: btbcm: Add Synaptics 4384 chip support Add
 support for the Synaptics 4384 Bluetooth controller by adding the
 corresponding chip IDs.
To: kaihsin <kaihsin.chung@synaptics.corp-partner.google.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kaihsin <kaihsin.chung@synaptics.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 11:27=E2=80=AFAM kaihsin
<kaihsin.chung@synaptics.corp-partner.google.com> wrote:

> Verify the change on the VIM3 platform
>
> Signed-off-by: kaihsin <kaihsin.chung@synaptics.com>

What is a "VIM3"?

Who made it, for example.

Just extend the commit message with some basics so we can
see what this is all about.

Other than that it looks fine!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
