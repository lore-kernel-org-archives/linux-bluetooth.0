Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0574D47DD70
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023254; cv=none; b=TmarZvfsgOKXFhDQM399LscZlmmeS468Ym14cVEIqm960DksoYF1VZ6AeEx0Kn300WXcVIDI5/d8zrZN7xkj1+IhcPLYgT6sXwl6wKqH4kO4k3eWWe30i7IIWDy4tJXfqbTIdDMZqH51PM8otKaWTUWCJv67d+JznYVVcZ5HBJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023254; c=relaxed/simple;
	bh=bTMw+5errjuo3XY0UGkkJhE96EhsUAsa59mCY/8m0V8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iVwdABoJhY81nlS5/Ol85REWQxTAROMWIFw5UsfMTJycGj69/eLhM1c8u9ucJFOv7zwEnU0PuzNdtI/K0za+ipf4XW8xMj3TVISZU1Wd7eCKHjcuuOpYtNcNMP/8vP13ClCnIsCfvEUQwpMc+EaapbVrLvyM1pdqJl6Ix74Fbhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KarwtdAF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KarwtdAF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8341F00893;
	Tue,  9 Jun 2026 16:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781023252;
	bh=h01BHHsW/GZRmZhtnacRs8yBOqidbGeRRyA71ss8CRs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KarwtdAF/LC8zA+U1tT6IE6j0cjsmkJiBrxEjnfW7Old7NpzZFQp5BzAsmKz19Zno
	 sa8JuwMX0bW73HdFlCxVk2PdkYz34KVivt8y8xa+jcYTaQNPo9uGZSNNebdZS4zEdT
	 SrknfeLwPjcsUmAWjgEoh3+0HEhoHAbhDXgntusRDG5dVaxPS2lmWY64CZzJyV7Cru
	 7SDV+DQiIFHlcWL0p8QF9c7FqSOQZaIAXvAPSqPdVxmnhhSUDKgkd0XjHsmdhm5AhN
	 cnajTnL4/UrDR/gy7oz22JrhroypPvtfjwGXlK+FCm17u+GjstDVBdPxapvuEMS4lR
	 fuVZDJIiXs9Lw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568393930989;
	Tue,  9 Jun 2026 16:40:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Add 50 ms delay before MAC
 init
 on BlazarIW
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178102325088.2135346.3443074751306554716.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 16:40:50 +0000
References: <20260606003637.94628-1-kiran.k@intel.com>
In-Reply-To: <20260606003637.94628-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  6 Jun 2026 06:06:37 +0530 you wrote:
> On BlazarIW, fast restart cycles fail because the D0 entry to MAC
> init does not complete in time. As a result, MAC initialization
> does not proceed and the controller fails to transition past the
> ROM boot stage.
> 
> Add a 50 ms delay (worst case as per HW analysis) before doing MAC
> init in btintel_pcie_enable_bt() so the shared hardware reset flow
> has time to complete. The delay is gated on the BlazarIW PCI device
> id 0x4D76 so other Intel BT PCIe controllers are unaffected.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btintel_pcie: Add 50 ms delay before MAC init on BlazarIW
    https://git.kernel.org/bluetooth/bluetooth-next/c/202af099928b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


