Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06885172CC
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904209; cv=none; b=kXX0bffO3jfjLQSN6XogsXk2QwbTREGrG4tQNmZuIQUa+ShQc3/I1simsQkkbwUed7XTNtPLbS5gDyEY2/pxZD4528e9+RTleT20P1dNSWV+RyKzkA4lBKS3rFaqJR0HXBWoJq/ZAjby7smbbeIle6/LO0GM88cfMYng2DlToo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904209; c=relaxed/simple;
	bh=LLPauhRaQOPqAxNiG2kzc4NFY7lJO/jVvp06C8VzSuc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qv1Sjr/otHCUiY2Q8UssULjIAp8gs0y0OvGKRc6gr4fMIRGzvm9m2QdpK3gPSMlloGwBIM6WABSLR9CeCTg2y/gCsYJhI9N//wuJiIVwTMWPJbaqPeo3Si86QNh9rUkkBPjB4fYii2qLA56RYlikYsVfMVyJuA2AUhaWAWUAnh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpMdgu0/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpMdgu0/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA551F00893;
	Tue, 13 Oct 2026 15:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791904207;
	bh=df8YzqCMEo4plcDWsmR+bMeLu+rHYKjs8d1y7/zs5Vg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QpMdgu0/X6taSb+t2lOmlqQDmwqTRX08ve+pOpAYtXPdq91QnSxm6opNUtHmtY83I
	 YqXcwQhJMdMfhJjwba3gJpjlN5zZcMJkKVfN67MdK329Jwc1nezkjQR+JvK0O/C0oN
	 Wr5Fd6rrMob5t0luMBe+iQ6ErCcZuRQLANrS+y4GivjQgBXI08hdf4hY79ku/VD2c/
	 kPiW1pAamD+VGTZJ8LHE/+DagvnhPwB8JqJbkf4hiny3BoryXJjYVudvhu5sG+vlzC
	 MOK5DGGuYj2x2wY0StHyTU+SEHJ4+lElogR+utDYqdBgXMRGcjpocJ1d7oVZLWaCrR
	 RV4dbw8O8nGBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B441339D267C;
	Tue, 13 Oct 2026 15:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND v1] Bluetooth: btusb: annotate Intel Otter Peak 2 USB ID
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179190420626.367533.9204356092652177402.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 15:10:06 +0000
References: <20261013092128.417705-1-catherine.l@intel.com>
In-Reply-To: <20261013092128.417705-1-catherine.l@intel.com>
To: Catherine L <catherine.l@intel.com>
Cc: linux-bluetooth@vger.kernel.org, kiran.k@intel.com,
 chethan.tumkur.narayan@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 13 Oct 2026 14:51:28 +0530 you wrote:
> Move USB ID 0x0043 next to 0x0040 to keep the Intel entries in
> numerical order, and annotate it as Otter Peak 2 (AX231) used on
> Wildcat Lake.
> 
> Fixes: fe225f96a79c ("Bluetooth: btusb: Add support for Intel Otter Peak2 (OrP2)")
> Signed-off-by: Catherine L <catherine.l@intel.com>
> 
> [...]

Here is the summary with links:
  - [RESEND,v1] Bluetooth: btusb: annotate Intel Otter Peak 2 USB ID
    https://git.kernel.org/bluetooth/bluetooth-next/c/609a23989d63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


