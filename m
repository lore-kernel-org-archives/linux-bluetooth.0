Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EC13624BE
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Feb 2026 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141300; cv=pass; b=BNjTNAVLaN/n8Z6aRpgpL8CutY+gG/gVRlFBA5WRzjCx/3ZEofY5otACSdWwLsIe6Sq/REJITaZDn+q6xPqBfplABP3oOFZT6Kna/loRJ0so13Oy4Rq2A8mAFWMOv2Cy61ezDGDKG+OHC0gLMC1fS9TDfV9y5AdugQcNn4lnjeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141300; c=relaxed/simple;
	bh=gpuGqaeJkr9yPbRbblAZ9dd3VyOI8NFdocGVxgjTXiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XL4/ykSQ2FihuopB/9b35xxrLrdafBfZmn6cW43+xbIBxtGAgxtDDGPKVHEL6j8aXwIQxDDTItfLIZK9m2WLRCbR8UOTvXGqkpadi8FH9vldCtJMDJKW1p1oz40rHMnYSoie031jjTTrp+PVyJ5b5Ph7iL4bl66lrFwD6arUTO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKbdIfr9; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKbdIfr9"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-794ed669269so1256297b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Feb 2026 09:54:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770141298; cv=none;
        d=google.com; s=arc-20240605;
        b=gRVGeEIGeFXcKsk2t7H6kSgtxkMJA+OojtR7X9AMwL3MULiBw8kKWmUXNKKuZmZuPr
         EaSTefg06+ei6OGxjg1W3WOjZEd/rdpEg6FxY3Zvv1q2n2dnlB/nM5ODXqtBI5C/vAOT
         7ROaiSiXU2lEJWalJdo+SNf/T/37zeRSIhWtPbwg4xql04Nh477PYtJSQVIRvk6R5grI
         ++I51FCD5plUlOVmtiKmrPwLL2T4JvbJ3W3XKisDf0C5v2BVNR18LqBwykJ3Z11GijW9
         XlmBCCztZXYEKi1tb1D2tu8HF/WddtvXdy1J8mcKT5gnAYmp8+VMtP2FvtEa9iG5bPnV
         V7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gpuGqaeJkr9yPbRbblAZ9dd3VyOI8NFdocGVxgjTXiY=;
        fh=1riOFKqEEicIHxx9JG4Y6uo5bLGLrAQuEqF0xUdvIp8=;
        b=DJZp3Tlx+2tp4kP5e2PFcgc0Df/fUGmt/CYcNE5uLcUlyhqDyfr1Ng3teTilog+b1G
         G8qsMkd1uu9aiI/P30S+Y1eOH1s/kDHzu2Dxr2FF8WIRKMxhKok6VZbGQgPimlxNOBk9
         n9HEgogwn8tXicZjSmCQ8Mf7FEUwOyI/vBWgtDcgZu7UUHS5o9s0BZh8SQf3TVXGAuVy
         n4kSjtCzsGvEysxNv2RCEKyzcJRvxtOV39J1H/VAL0RsswZizuTzGtzTbiT0xeSjH6h3
         zTiH02hOsyDbazjmZV3kD2j2cbm4s3Z9MXPTFq7mxCED2W1UyHisY5mGLMXgkrMKGWwC
         nZ4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770141298; x=1770746098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpuGqaeJkr9yPbRbblAZ9dd3VyOI8NFdocGVxgjTXiY=;
        b=LKbdIfr9+ikVcLzUsRuCJ6aOHhYMKvNN5emC6ZU3qqm35nOxsjOixDlYlYCe/e/mRd
         4+vGAiN5nY6oWT9U2PNHemPc0NY6sXqPGtDR1lQU5+xp4CIx8udIywobjjQm/3/6m+7O
         uLM2GIiosEuJn292pX7PjEyJcXSt1j6UXRhTMTaFba5XhMQ3vfo/3wa+vvWJdkhrb5fl
         7CGWWsxLXKcW+pqFwRAWdwPKI9YGP1Qwl9c7HAA11SQA9/5GQzlrPgzN9899T9Irf4WI
         OSSIZg9xWPBlNgxdhFSErfG7hfke11beji5GYCEzIDCXopTGOFYH5na/IeJ62M5gXS+b
         gr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770141298; x=1770746098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gpuGqaeJkr9yPbRbblAZ9dd3VyOI8NFdocGVxgjTXiY=;
        b=DV1HUhoWpcVa/WPbWzjxoJ+7QNGc+OMpAE7D3bX2Y1UlRNWLE5Ui/mv0T7yzkR5IdU
         LYbtXB/pwBSWB0hv+4Z5YWuY4o9zm6IYugWGfFoMv6AuhQiLvN6tpds30TFecee5EUhK
         tZmScmW5RsaXssoy2DyvdXUMV/dsZSZ5kxIpXa/NsF7F2e++IZeHTPzKESM5kNTdEtEK
         ec42IQJkr4mKNXqB+2KLlCsNEeNV762Kqo6NFj59sTPObm/WoL+zwihu4+qMnCfRrawC
         Kt0gy2wFYxuH8AQ/UXS/7qw6rEHwU1wwPtK5fK3xrE1HBTAxu/mnxzw+Lq2nQJcyR/Gd
         xtvQ==
X-Gm-Message-State: AOJu0YxQ81g6PppsQUq8HeF4mL85Q/ZJMSEFwwfYvvFX8shK5htkBlx7
	b9dpyPPnzEuoNu3p/SqQkK2FmtUjilwZfIiNyBxWnuMfJK/ZStSZkRYYY0C/aF0VCLIKyUzkiNS
	RbfYDPkMkokmPbMuA6pmwLI4pkTaNOuw=
X-Gm-Gg: AZuq6aKUS6PkFaixmEdr1u5cS6QjuMWmIU5DIiU3WAigEBlCDmoEm25NnWxacMwyaNQ
	VY6+RZbnTJdvj+ZwgNEGs+ApVJVsEKAju5jKbmNQUBllcBM2dFDgyHEkZvrj003xqmpi2DDgo7e
	uV5J49cXMinVxPwBtOE495/1resbP42cKMX6Ii+w7KedPS69eJuakwVBH3k69DsymwyirJyZCFJ
	X4f+bsVItyilLk3rLYQZ+I+xnX2w0K6Dyrr0IcMTDFxJ6g2Q2eQf0E0RUA2R0WDrdPoGhAyInkd
	Epds2F8IhUGBFMPfO3C3akJXKy8SXhlH1sy75FBC0mV7L19eGp/g50I=
X-Received: by 2002:a05:690c:ed5:b0:794:d9f0:2375 with SMTP id
 00721157ae682-794fea323d4mr2988427b3.0.1770141297727; Tue, 03 Feb 2026
 09:54:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALpOmYvQUnA6YGinVxfDzqewP1dcL_-X7NVfto4YsMtZL3x2og@mail.gmail.com>
In-Reply-To: <CALpOmYvQUnA6YGinVxfDzqewP1dcL_-X7NVfto4YsMtZL3x2og@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 3 Feb 2026 12:54:46 -0500
X-Gm-Features: AZwV_QhPsmwsvgbYy0IFjEr_MdKjain5a4pMDeMbRqwQd11JVNhHarWfx8UrtvM
Message-ID: <CABBYNZJGUcO3AjVf-APKtmmvUHnq88SmNMmYCrhBXZEVpPDNog@mail.gmail.com>
Subject: Re: Bluetooth not booting with MediaTek MT792
To: "Khaleeli, Adnan" <khalee27@students.rowan.edu>, Chris Lu <chris.lu@mediatek.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adnan,

On Mon, Feb 2, 2026 at 9:26=E2=80=AFAM Khaleeli, Adnan
<khalee27@students.rowan.edu> wrote:
>
> Hello,
>
> I am having an issue with Bluetooth not being detected on a new Ubuntu
> PC using a MediaTeck MT7921 Wifi/Bluetooth combo adapter.
>
> The Wifi interface works correctly, but bluetooth is not detected at
> all. Running bluetoothctl results in "No Default controller
> available". I previously managed to bring Bluetooth online temporarily
> by running:
>
> sudo rfkill unblock bluetooth
> sudo systemctl stop bluetooth
> sudo modprobe -r btusb
> sudo modprobe btusb
> sudo systemctl start bluetooth
>
> However, this workaround no longer works after reinstalling the
> linux-firmware for bluez. If I can get any help with this it would be
> greatly appreciated.
>
> From, Adnan Khaleeli

What is the kernel version, also it would help if you send us the HCI
trace, you can collect it using btmon -r <filename> and then attempt
to reload btusb to see if it captures anything.

@Chris Lu or perhaps you have any insight of what the problem could be?


--=20
Luiz Augusto von Dentz
