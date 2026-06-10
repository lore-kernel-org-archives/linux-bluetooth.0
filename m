Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8230438D6A2
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079474; cv=none; b=ELVv7w5fMEGWqlTrH8gB7YuguvIKQL2pjCiDNaXpSttxCkrOVlJV7oNR9ifE985fZjQW3RGpPwLEANfjlVxgXogNuvmYFaMXUmWNxZ1b9q3ftm9KRswouAQJi2a7zW2XW7XsCZ1cdSSYUHebwBTh2VkVd01sDAo1GCBH+YhplvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079474; c=relaxed/simple;
	bh=EztlkaJd9gHp+3rz396EIvkoYHLVnmoIMg7Ox8UJMiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDI3v9WoqInBcExLrME3fgG1TCVFotVmz67LIjLgS7mm1Wds9DVbFxtCmtL7dwC7NvDOEWXoExG5iU96kSxhv3gXuqEjxintoVLHLbz5qYCYLBNejAXmso+hBqzUpQAE6d9t1N3SHfvdCtKTbU+GtSzYvmU1/t0dFJdPKKkwRI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwJkHWty; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwJkHWty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1E41F008A0
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 08:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781079473;
	bh=EztlkaJd9gHp+3rz396EIvkoYHLVnmoIMg7Ox8UJMiw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NwJkHWtys4/Ts7sNo65xaI3Nci/MaGBDTPfUdh/5hYGSJvnLRtg7tHn8WHKmNepUt
	 Mu7zpGuT3175nI0QN8z3Iv4HvDZ0g11AgraPlhD6NekgKzH5k2k+089chzMCMsqeof
	 XzStHhVmnVT1bxdxQprX/cXyWl3FRs4TlhcQyeG2dSY1IeQmFTsB9qd9/Xorxe/ogg
	 1dIKFCR+pbVciXDH9ZEk+CubFJbUDYihHbsRE1XDAvsFsoilgCs5V4VHhdP0hlRenJ
	 OXrv4RbRSP0AWobRhxBnmbACaGpvP90/2D7Ww5sMKTGF4QmVVlmHaqyeFcYpkGCfyt
	 pPw+pVyAZ2oyw==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3967724bed1so69917671fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 01:17:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8Up9nPJteCg1L7BUYUCBgVmXqLjiZNGx/C6nflMx4mh0h9Yp7gPktQcUjNyO1lz2vGjNy9qutABB6La5z/TIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYPFN3sS288uy6P0tB5jjsYTsAwDKbqMXmXf9sapavjzTXZLUR
	eS8EjxAF8lHsxpNW8QAzsD3pPq5Zwb1vZLYlIck/K1MgOYd+yZVn2leIyf6J08MXJS5HCOxx42N
	T9SXiwk+CwYHtuur0OnUMw9cHjrYTkLRaS6ePClc93w==
X-Received: by 2002:a05:6512:1114:b0:5aa:7ad2:f4d5 with SMTP id
 2adb3069b0e04-5aa87bad505mr786523e87.38.1781079471995; Wed, 10 Jun 2026
 01:17:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609075417.1160702-1-xiuzhuo.shang@oss.qualcomm.com>
 <20260610064232.2385866-1-xiuzhuo.shang@oss.qualcomm.com> <CAMRc=MdojC6T1RuqRNE-ssoRw1pKyUHyOS9AD0ROfCpPPOqw1A@mail.gmail.com>
 <c0eee7b4-50ee-4635-b8d6-fe9cb4ea05a8@oss.qualcomm.com>
In-Reply-To: <c0eee7b4-50ee-4635-b8d6-fe9cb4ea05a8@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 10 Jun 2026 10:17:38 +0200
X-Gmail-Original-Message-ID: <CAMRc=Mfiedea-sjp_c7OHcgwXSY2NWHHx1ZhcF0qHk9qL8yx2g@mail.gmail.com>
X-Gm-Features: AVVi8Ccm_OV-7Z3UodygMzh6-MiEsifxELJBKPIHj2hdMprATO4EGMaRr9pt9Ek
Message-ID: <CAMRc=Mfiedea-sjp_c7OHcgwXSY2NWHHx1ZhcF0qHk9qL8yx2g@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: qca: Add BT FW build version to kernel log
To: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com, 
	quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com, 
	shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com, 
	jinwang.li@oss.qualcomm.com, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 9:36=E2=80=AFAM Xiuzhuo Shang
<xiuzhuo.shang@oss.qualcomm.com> wrote:
>
> Hi Bart,
>
> The main change in v2 was the commit message =E2=80=94 I added the motiva=
tion and an example log line as
>
> Paul requested on v1. Carrying your Acked-by (given on v1) forward was ju=
st to avoid losing it. So
>
> v2 wasn't sent solely to collect a tag.
>

Well, I don't know it because you didn't add a changelog to v2. Please
add something like "Changes in v2:" in the future.

Bartosz
