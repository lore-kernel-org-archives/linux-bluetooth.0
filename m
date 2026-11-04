Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801141;
	b=cyOXXInxdj6mEAYuUp4GOYpYL/bXGKZWpLNlCZgnjY+mACf2Ge3d6dvfFaYCwj+IBKKp
	 +Mx9mJ8pCPDIDxGokkcJZpf6RG92k7tDK2QfM5Xve0Irb1ou7QtCce3fwEiKZ5FNxPOqR
	 4z67k6qYYzWSQT3cyOmTcMwhzB/1UlHzR8fkjKNfhvzhN99tI2PkkDoVis53kYb8aJjBR
	 rZVmjMGZyShXQM+lhVV81KjTFcu0VXOCa1aKUonDZpoHVnR+fmCeSO4uVsWCtrUbkgWW0
	 S6ttzETHebPDcAA92oHECGqio14IbjTBKOoiL0ni6KHqEK19jtlH1+eWOY7dNVULidA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801141;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=y71W/g95fxF/Ugo5XgvM8Qi9UKm1XDcqPUoTQ8bLpHg=;
	b=FEGn8Y47RixPApLCKyD2cxwApEI2ApI/5NQ7ikXiPWs6dgKxeZuAYBqG2+LSRy/Uabzf
	 w0OMMgFwR31epOLBoCuTDZt7WzNCf4g4S/Syz2LQLqk53H0K7Zu2EiQ55KXKN/x/1Nz4V
	 9ic6ECyLqZBl0k2wudJfAjKzQRi0ropyQetnuYKgbLLSMzHbG28XlRSjd5XWCu4MzZloE
	 FZM5xe9vbBx54baN+aC6gmhJtD/I2ZGGjUP6OAI9+ndMQuONhL0NGMYrx2WNdXyOcJXXq
	 tzQEMpK4brV4A0XrU/EZYXTcwZxC1CXgN1jeZR8pZ7sK+v0tFQ4GW9tNpBiuHB66xDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lYguVNeA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 71E95606A326;
	Wed,  4 Nov 2026 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lYguVNeA
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0FF621F000C1;
	Wed,  4 Nov 2026 14:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793801141;
	bh=y71W/g95fxF/Ugo5XgvM8Qi9UKm1XDcqPUoTQ8bLpHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lYguVNeAyRnaWoBg62QkdfXprDJUFLRfgOS24FjH+LxnHoSWYB6NnTwn8CEKcBmNv
	 WNZwkv1htuBZ7DNuf6Nzhww+H6pPtE56+8nUZZLV0LH1m5oU+qAkrfiv81u4t2o5Jm
	 1KT7Ss3iciq5QtIV3wutDt3VENYFhnu4vrbQZbuQEG8YPGzR2DAXljuXvjIPkElXUx
	 ubAd1QEgEp34Qo+wSU9+mbFUOqCFbYn34sJWzAWRHMV0TS7PBXYWtiN7wXrBCCaclr
	 uC2Qq8z/5QDtQtLlRVC1oeb/8a2krv1UHS8ZmL4F09L8VV4nudSNl861DG01Uuf9yS
	 sj0TBo9MGs68A==
Date: Wed, 4 Nov 2026 15:05:36 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Stanislavs Nilovs <valorcool@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] Bluetooth: qca: Clear 5th byte in TLV tag 27 for
 WCN3950
Message-ID: <r573oayidxdd7x7mwh5y7m6q6fbcwrsmtaxwksvfhwslt3yoxj@w7b4hcwanhlk>
References: <20261103103529.804025-1-valorcool@gmail.com>
 <20261103103529.804025-2-valorcool@gmail.com>
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
In-Reply-To: <20261103103529.804025-2-valorcool@gmail.com>

On Tue, Nov 03, 2026 at 12:35:29PM +0200, Stanislavs Nilovs wrote:
> This fixes an incompatibility issue of TLV with 5th byte set to some
> value in Tag 27 (Deep Sleep) and the QCA driver for WCN3950 SoC. If the
> value is set in TLV, then 2 symptoms are observed:
> 
> 1) The QCA pre-shutdown command (0xfc08) always fails with timeout.
> 
> 2) SoC becomes unstable. During power cycling test it could stop
>     answering to any commands and QCA driver enters into the "SoC crashed"
>     loop and can never recover.
> 
> Setting the 5th byte to 0 resolves both issues - pre-shutdown never
> times out (so, is always replied) and no crash loops observed.
> 
> The Claude Opus 5 (Anthropic) was used to create scripts for dumping the
> tag values from TLV files and compare the differences. The fix itself
> was written by me and verified on real hardware.

This doesn't need to be in the commit message, please put it under the
'---' next time.

> 
> Signed-off-by: Stanislavs Nilovs <valorcool@gmail.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
