Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368808;
	b=yFeviqOKhKcU5jy2ZfA/lvvIxGUKyP/ou03IQwfu74Jn7KGm2nO3H81VaFDonUHg1lJH
	 P+tmIKS+b2W2BxFyi1hA1DdCcNxOxyrpDsJ9UhKMht9/vSwaj3Jh5+DxnWS/wPLjRpaFY
	 4B1qxLvgkV09TrdzSkLF/yTr6WdRqVTAx0OSq+BRkrFjZS2l3tTZcx1wRcsMHycL6AhPc
	 53vpw3fR64NFdFUUj8dkHCt/K4n1M11SJ5Cwak7Hn4wSTJsjGAgqyRDa8/kXmh7igw8+L
	 nRpZFsesLW0T41GY/3xCbj2kqIwsVJfHtO2i4E/lAa9QC2BGnaQnbKkKMDZYDCZWOfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=W2xpSAbTLfSkk//6+2S09YfgmDNTg33ZJ0KqZmHBUGE=;
	b=hicgzZPcuZSNzQXv6JbkLoRURsXMR5u7kqcH9DsWBFblUn/zceCyCTqSlp4JQmVB2UE7
	 TTyqlnx9lbPz1SpUjyZZtI9RgPRYYBs16h/75fjrtO+EIy8fAHcWIsqyYHwZH3mtgeawj
	 6chj6bjrRwkznuAmEf2dvmwmbQOpIIqWapDc4ilRlIjUprDivx+aa2qtew14OVKkne8FH
	 nsaQA/DlKic5/XZT7nkxm54eLg5/Ign39435J55Ul0HnMUI4FcQyWvHjKNBG8g+3kAqVZ
	 fcx0Wh+q/Ue+qYQ2n6x3bfp689pzA+3LcgkMsZDM9yYF8gO6lk3ZkWFBARzT+yBg9WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ATvCcXPc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC0D606A31F;
	Fri, 30 Oct 2026 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ATvCcXPc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497591F000C1;
	Fri, 30 Oct 2026 14:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793368807;
	bh=W2xpSAbTLfSkk//6+2S09YfgmDNTg33ZJ0KqZmHBUGE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ATvCcXPcQ+3Yns0KJJpVZ1WcGFCTMh0fm6/I5m5uYx9fRXZCUAuJTV08MWypuYANx
	 hsSI6nH2euz/h89zLAyib8zrsbv4rMKpWreo64x03D//kql/DLIImPIeCLzaWsvyqb
	 kofkgcp9YMc47K2dBhZ97oXenTVvuj6ZDxF7JlQrdxQqD2bRgov1Vri0MGXU1RS0Xh
	 CwhRmkdfKR5lEHJ1Nl93xL8P7LVTMLdfmt9ZefBKOZu7kequTQ8wiA00+dD4FJG9U2
	 UndP6CTNerMMAaXQsH4T7L45hiAbVeBWYcYeRUXirRjjZjf9of+uJiILFW+jyWCgBx
	 sszi9aDeI7bqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 402053800465;
	Fri, 30 Oct 2026 14:00:07 +0000 (UTC)
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
Subject: Re: [PATCH] Bluetooth: MGMT: Clear disabled connection parameters
 when
 loading none
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179336880606.1091505.1791997839483529343.git-patchwork-notify@kernel.org>
Date: Fri, 30 Oct 2026 14:00:06 +0000
References: <20261029202832.35354-1-kevin@simpleble.org>
In-Reply-To: <20261029202832.35354-1-kevin@simpleble.org>
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 29 Oct 2026 13:28:32 -0700 you wrote:
> Load Connection Parameters only clears the disabled connection
> parameters when it loads more than one entry, so that loading a single
> entry can update the parameters of one device without dropping the
> others. Loading no entries does not clear them either, though, which is
> what bluetoothd does when it starts without stored connection
> parameters.
> 
> [...]

Here is the summary with links:
  - Bluetooth: MGMT: Clear disabled connection parameters when loading none
    https://git.kernel.org/bluetooth/bluetooth-next/c/b621473a7fff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


