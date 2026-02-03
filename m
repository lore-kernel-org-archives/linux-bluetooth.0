Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE3136EAA9
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Feb 2026 22:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770156008; cv=none; b=LsNb3Y0VrNjpavvjxwaijymdi7tTx/grEw5ySm5FFt08j16dxxRrS4HxE7K3BG7LIliGnEQ9e6sUNXgC6CUSx0bxiIbiN/S6pj5ckxww+B8J44R/cCeC5JI4aCcF7DmIRgsdXiv56n/yw0D/GIWR1/tL6POUbxznz14fy3GzxJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770156008; c=relaxed/simple;
	bh=hWIVHtOCfXJkjxtEsqhZNpTx4jUdx+sgruK86cF08ng=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ceafAb2WVqs/58ZdsTazTriHgMFIti7YofhoGxmM94xlDz8dnWbu1xNBV3NwwoTALtgtI+y/3HoXDi4AT196pVb/siXmFp4JNK+onKHSqnegSuy9pnOpIh7difp0by+BovSnxfgbtTf1Rpcy+DWwIArFlGxRai5A3lNIc9QWGk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/aPj4rX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/aPj4rX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167CFC116D0;
	Tue,  3 Feb 2026 22:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770156008;
	bh=hWIVHtOCfXJkjxtEsqhZNpTx4jUdx+sgruK86cF08ng=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j/aPj4rXhc7/DZCLyOC6TXJdTpqHbX8oc2ENF7XfjuPlVStnX/8V5qRc/cZw71ZvA
	 MRMRjcGsoVPiLdAtqNjusDWjswOCDjsWxUKbRo1toh/DB0fezcoYRDm+XLuL4oqRo8
	 1aLQKbs9Rk5P9aaczzdMbAFMJIYF8SYKHFmZwq7S2AZ7z+rL/uYNxN3Novneq15GYq
	 rHwGoHmyM4cBu/hA9/CH8eqqlSfe7uUo5NjY1Rq0eUs/uFfxehBLMJAI2AZIVNwN1/
	 j//g00LCO62E0gfNRlbIhr2QvMGJulg0hGxBygIiAGAr32IkL7fTV9xPhAhPN9rZyZ
	 YpbSlFUwJ1mFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 90F573808200;
	Tue,  3 Feb 2026 22:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_core: Rate limit the logging of invalid
 ISO
 handle
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177015600413.2076541.18136252143920998524.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 22:00:04 +0000
References: 
 <a62daa4ff8e59ef01438d96484b45cc2273db1f3.1770146705.git.pav@iki.fi>
In-Reply-To: 
 <a62daa4ff8e59ef01438d96484b45cc2273db1f3.1770146705.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  3 Feb 2026 21:57:21 +0200 you wrote:
> Some controller firmwares (eg for MT7925) continuously send invalid ISO
> packet, which result to "ISO unknown handle" error spam in logs.  It's
> not important to show all of them to the user.
> 
> Rate limit these ISO error messages, similarly as we do for SCO.
> 
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_core: Rate limit the logging of invalid ISO handle
    https://git.kernel.org/bluetooth/bluetooth-next/c/294cf04ca959

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


