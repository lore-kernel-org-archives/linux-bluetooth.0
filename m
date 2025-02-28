Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE0C23F36A
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 20:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740775206; cv=none; b=eR7iKO0ghCOG2Jh4LlBEC+SiadEXbf5/gYuTCtc+o6nChbpuaaReeQKag8ZOsx4jGkRI6FJJ/yrqyG7dnEJIbXhZU1/rZm/Uzn/NwJM1y2gaJ23FXBPU0zV4Akg98hq7wCrY8ZhtUwtdNtmvJ8Sgb8cx4neOj9d1dbwngcduGZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740775206; c=relaxed/simple;
	bh=1jblbtq63Gn0SK5C3pFh2uCP0H/PJN4lElwF7VfDdnY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c/t0GqmFcG+AMsuAt6UuWGUMp3vgUlpAwTVLIDXSMMj/ZTA/OjKaCSXHEZc+ia+PRjCvNOKo1LGnhT3eSro/zaKz4UgYHIn2L990vNJPWPinDfdIfHiQC7i/7Riux5SJHATmgG9LnTdqoeptYjsBW1pp5SMZpMF3bl73RI7jok0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bb2iV5p2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bb2iV5p2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB6FC4CEE2;
	Fri, 28 Feb 2025 20:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740775206;
	bh=1jblbtq63Gn0SK5C3pFh2uCP0H/PJN4lElwF7VfDdnY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bb2iV5p2DFPpBIAqSY29/78OKJROXFuY113fBbxprKTm3skbLeLURwSmrC18mGA9q
	 XTVohjJ6TlP3GFhSAgidc5BMGLxMMoFFp4hV/gO2ZoIBFwOEMG7zMw4szvnOyjlJD9
	 rDu7H2KYXXzMgUY9rqyXvWys6adb2pVMDE54+AHhoBS9ReO1kWEOmrG8j2XM5xnMv1
	 z9xkg1I/f0a0JX+JHDs5ZYvqqHXYI0rAOXThBs9Vx5SE5OSLUTnE8KBx9QCsFN0Act
	 Pty1tG+SqlUneZcIukeFmP+H32I7kIT+JrHp72nX141qK7OaDuZ7+FBETUpNDn4Afq
	 nqWnQ48eq5Asw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE00F380CFF1;
	Fri, 28 Feb 2025 20:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/bap: Fix state transition of sink for disable
 operation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174077523823.2271257.2250324465664049393.git-patchwork-notify@kernel.org>
Date: Fri, 28 Feb 2025 20:40:38 +0000
References: <20250228175048.3471469-1-luiz.dentz@gmail.com>
In-Reply-To: <20250228175048.3471469-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 28 Feb 2025 12:50:48 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes a regression introduced by 173045553c15
> ("bap: Fix not generating releasing state") where the Disable operation
> no long caused the transition to QoS configured for Sink, as per ASCS spec
> Table 3.2: ASE state machine transitions that state transition is
> required.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] shared/bap: Fix state transition of sink for disable operation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9efc138e9808

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


