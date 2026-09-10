Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7953672AA;
	Thu, 10 Sep 2026 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789069877; cv=none; b=Nrf8B7cjmOznVmAae2iqJtoTB0PUymuGvw2HQQwrfEpyvg1kNDfiSM3nGdHjw53nR6O67MEKD0tH9Fo1T1pcHpZr2stnA43C+cPEEPQWUNM1/ewEYRTIBNURA/mGLjIGRbCgsQ5Rqx8DO3G+OmapJZbtiTU1r3e+Qr1b2BeVYTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789069877; c=relaxed/simple;
	bh=+ZmeW6Ahxr6X9c8NuX+fyO3j4vTaRBv4SuWp1X80bg4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N92jWFuYLIMY/pc0tzPM3y0LdOrNlIoNa1KJlf+zvhAcq76UyTmpFWcB6SHSSpkHVC/zcmcWki2nvH1oQP/8666LYwFcZWALRU2au5B9fkI2Zrla8IjIntcc8AIgv4nA/3yrwEaqB4icwfQLJ9b8E7Vu3580DNFy4Hw/BLtRTas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LU23WuY/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LU23WuY/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3EB1F00893;
	Thu, 10 Sep 2026 19:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789069869;
	bh=sCWpRaS4L+MxiLqaKafxhBWiAz+GKu6SYgYdLlc3p6A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LU23WuY/RbYpJll4frBoEmDYDW9wXiIGGZSh/NvzRoZvNz4beNdoUEQL9cxQRlyOz
	 8GF4I/KWifKJohVMwzLQORdH9XUUBKBS64D0UeJ1J8MG5lAFb1uD1sf00+OKUWZwfa
	 2i3h90w79qIJFUAlM8WaQ2AkGKk/tnl9GkFmkLrRPY8dBnix7wZU17e81K4DElkIbe
	 PwZtwO1C0pJoUWNhyQc3lEm0nxTd6DgVENNMoSbF3Zom3nBRs6U8uaSL8fYwp/C2Ga
	 9Llpw75ydTcQYBKtFkEsDW6GPIUuWcXNrc3exBwwVDiPtovr7Tm6+AAGdKmjrFJdQm
	 RQiOoWJY/8NNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568EB380CEC6;
	Thu, 10 Sep 2026 19:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: Fix code style error
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178906980687.2055460.13615750651234605058.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 19:50:06 +0000
References: <20260825122207.101868-1-deaner92@yahoo.com>
In-Reply-To: <20260825122207.101868-1-deaner92@yahoo.com>
To: Jeremy Dean <deaner92@yahoo.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Markus.Elfring@web.de

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 25 Aug 2026 12:22:07 +0000 you wrote:
> checkpatch.pl flags the zero-length array members in struct
> qca_dump_hdr:
> 
>     ERROR: Use C99 flexible arrays - see
>     https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
>     #3110: FILE: drivers/bluetooth/btusb.c:3110:
>     + u8 data0[0];
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: Fix code style error
    https://git.kernel.org/bluetooth/bluetooth-next/c/ca10117e55df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


