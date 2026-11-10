Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328810;
	b=L9++3b7ELIhiO/0Dm9zN0Q4lnB6QnrekuRySVkURcG9nXESTFXIiRQD+Trd+j7NxBVmw
	 0kTvXRXcjMgLyvSZLDgJK22CfM48AtK/JLFxfC4nMTcdEByoVLUT/P/nGMjwoN79ECd/l
	 2ndZflIqM15dnQGb8iIJb/QvKHDVMisWJRUgmk/ON3awYwRiMbHUDg5UurY38/ky7zFzw
	 Hcy0wxibDrVd+Yojk/cAMCU/Zaf7xCTOMYwI2MlpO4K89QiPpVJl3kp8KFw2zVLAqppQs
	 zTd0XaB+//u4pS/uBIvm5InLZ9m5wXrn08P4Cz3qmNb7+elHKWo5uNfrn0UAoKBEqLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328810;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=N87ASrUOWCsKhYpd7BoXBTKcCyAvQxT7Fz+F4zHGVCI=;
	b=wJaOyC/IJRAcRkxO+XSgz0k+88ksd57ORv/jT06P+D+2vD/3hfAg4f90z4gJIyJeMYSG
	 Dmz5Qmgk1Vw8DUvTjgHT94BFZStkVRp6YHYEWETN7Ffl0o+EUGRNAlB9SyENM0ZoC2H8Y
	 s3eu5PC64CKTcbnK93D1wsWD1j1RzDceqs7rpgnkDDMgp5dRQoYGkvJNWcJLZBg+/Pmd0
	 zDa7gJrbzakkZzkTL1DUibpvk5BBjSzWNo+w64NwFera5HHZWMIr71DCn5OMUUWmV9bx7
	 iElTcioefzAFZfxzIbkvqY+mC/DaVmx1S8Cd+I9fmepky1Eje5EzaUrHlh/7NTzQh8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iVnQaDCL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6312606A201
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iVnQaDCL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F5C1F008A5;
	Tue, 10 Nov 2026 16:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794328809;
	bh=N87ASrUOWCsKhYpd7BoXBTKcCyAvQxT7Fz+F4zHGVCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iVnQaDCLnPhz0mEkPhl/u9PqyJiM64hNtRmyR4LYdmq+HyLCfMstA4tAQCZDcOZLp
	 TgKVSiom9u5Tg0kmsTYCwqBfanVt+8yewbuQhwz5N0jeWYwc3FoZY3zEyCEzIlW/ay
	 s6RgMuR5yskUb9Q1e+at0ykHIej1F1YF0WU2+0ZqLizkDo+qC2sEPFWw99KJ/MQ5cd
	 PjM83BFgHZUWcgFnFzaofSeFzCQEAT+mzi7ec8S/CKmSOKqT1IFZIEvzv2NzcmTfWj
	 jqWWDG33nUFF7GTSKYwhUidhfadHBQW2RH4A6Kljt0osN3o4a1Ar1g7zLcafwjWXGq
	 iyROeg9dsLmlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E08E39D5FE5;
	Tue, 10 Nov 2026 16:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] bearer: Fix Connect refused as in progress after a
 failed attempt
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179432880792.4080412.17915800166430164235.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 16:40:07 +0000
References: <20261110080311.71913-1-kevin@simpleble.org>
In-Reply-To: <20261110080311.71913-1-kevin@simpleble.org>
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Nov 2026 00:03:11 -0800 you wrote:
> Connect keeps the method call in bearer->connect before starting the
> connection, and releases it when the connection completes or fails.
> When the connection cannot even be started, as when the adapter is
> powered off, the call is answered with an error right away but stays
> in bearer->connect. Every later Connect on that bearer is then refused
> with org.bluez.Error.InProgress, until the device connects some other
> way.
> 
> [...]

Here is the summary with links:
  - [BlueZ] bearer: Fix Connect refused as in progress after a failed attempt
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=89a7a7cad54b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


