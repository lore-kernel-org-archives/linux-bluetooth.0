Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318723;
	b=YRYRaAs2WTKm1p5cpRKNkectPqVcCmD46Mmp25fe9dHWTT4ErMMbajt2qer3PPk+MtOD
	 LRKy65tAoqEyUAaqB2g9RaWyW2/CYPy8Rucs0yIzSbOXGCnUfUDZO+X1/2IUIqi2ptYpo
	 mFKxMsvygmG0p9WqVRn6y0DAxUYCs0MkEqevJOJInlUDTRd7gFMnDHWl4KRLUS3IKUnfN
	 0uON0X/X2Pyh20xbxHmoLfWo37j17P+XIp4hZ06qISWW2/OJ3zePlLf7akAP75G/hXJLH
	 eI1oFgSMc8WXJ4DwUw84st88LZvWESY+cU0fy3lDpZhGIzS4FIJanhnz+Ehqy62cMbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318723;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OwiHixbB0gSoUHwpEoRYDWh04tLZK7JEhgg1SVZOTIY=;
	b=Aq7MIBQ7RxFai70+8Xa2fuMTP1a3yl2ZiEkTNXW5z6IbGRNryDH4P6y+q4c8Bu3RnJK+
	 Gs7m5VhuXa8GbCs72+aikVZ4s27PdKKv6+1KI5kdlas7WsLGFc819rbguhiSPxNEuAM1y
	 cOfhiNqhUf8HtSsIbgnnuPxsI/Oo9UXQgoebvc1n0rmbyHYySt1C3YwqYSLKUyjKtkXG/
	 y847c5DzyXRn9AnRLSEu/PR0BUA4IqmciybrIZfvYGbAuAMaSAiXNQGyVPWC13c+FwZwu
	 JDRbBk9ZnwN4Zn9HtO8S9Z18Ql4dIzsaF3798BIIlB/FrwBcLt0B+wXIbyqec6IAWLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mo68Yo2i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 45B4C606A31C;
	Tue, 10 Nov 2026 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mo68Yo2i
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4A4581F0089F;
	Tue, 10 Nov 2026 13:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318722;
	bh=OwiHixbB0gSoUHwpEoRYDWh04tLZK7JEhgg1SVZOTIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mo68Yo2iJODpDfXBnYKhRBOdMiSz8coFRoLz7fubBoCMzqD+jj8CWCQKN0dgYlwN2
	 F9MIepRTrEIAU9p/ePaT26uNcU2bH+MovxbGJehKmbqeUyKRMfdzev77F8XK5BW1JS
	 2VTIs4KT44WcseUlDdCuFsBdsMYYZeaPMOEU36IZRSv/8LQL5ZUE7MmLd81rEoY2DW
	 kHChPadgHruwMn8tBqdMKgmUG/nVROjWUDmha3b9gUzYDgna3nZ8Raspa4XE3d1B+t
	 jGJ8jOBgpwmO/qAuk3aojWhBZutJpRKD7BsTgQNOr++bJ21S1jCFHSSKk11NzVCN7X
	 SzFJ3hUq4SjaQ==
Date: Tue, 10 Nov 2026 14:52:00 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com, 
	wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com
Subject: Re: [PATCH v4 1/2] Bluetooth: hci_qca: Reopen the UART after
 enabling QCA2066
Message-ID: <au5qgd73yj54e4xvesadruebszqujclc7ltv4ikrzcbppnbakv@lld7zw5aug3z>
References: <20261110092929.234617-1-shuai.zhang@oss.qualcomm.com>
 <20261110092929.234617-2-shuai.zhang@oss.qualcomm.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110092929.234617-2-shuai.zhang@oss.qualcomm.com>

On Tue, Nov 10, 2026 at 05:29:28PM +0800, Shuai Zhang wrote:
> QCA2066 does not reopen the UART after the controller is enabled, which
> causes RX/TX out-of-sync errors. The UART has to be reopened once the
> controller is powered on.
> 
> qca_regulator_init() already enables the controller and then reopens the
> UART, but QCA2066 does not go through it. QCA2066 was added with its own
> SoC type and handled in the default case.
> 
> Let QCA2066 go through qca_regulator_init() as well, and handle it in the
> other places that check the SoC type in the same way. This also applies
> the baudrate switching, flow control, shutdown and probe handling of
> those chips to QCA2066. btqca.c checks the SoC type in the same way, so
> the firmware version is also shown in the log.
> 
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---

As suggested by sashiko:

Fixes: a7f8dedb4be2 ("Bluetooth: qca: add support for QCA2066")
