Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7744D1E47C4;
	Wed, 29 Jan 2025 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738182010; cv=none; b=j5c5F5+N361ujFfoR0+0jUO1biAdgt30T6bkKSae/Gy8Q4CIVmMdWTcYj2/Trel60VpFIpt9YyQxs0+gEmeNa5n4df9K/f0dwUisn3PlKSI9jamHyW50cPR+ZzAt/lVdb5NR58CL3k9/7GVqAdZ/W7vbb3bWGU/jXp+cizSjNY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738182010; c=relaxed/simple;
	bh=D2as7KYtaK/0+gMotkf55EdhN4rLOM9KpAEEmZqApxM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qv5kPjXgfQdCSeXFOIRIBBaLtlNf9X57Il5/JxtW2rBZRYKfy1Hef0MV/ugFZKDysXURuRYSYgU5OZ4zrTHT2Klqcmq0Rq/LqNvUHn80mYq01pqa42e3M1CJ1346N8oWtR2kIOXZOt8jObOFVelwk+5PphPN9NOSXd8quXZAHa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1fh2TxD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1fh2TxD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F39C4CED1;
	Wed, 29 Jan 2025 20:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738182009;
	bh=D2as7KYtaK/0+gMotkf55EdhN4rLOM9KpAEEmZqApxM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I1fh2TxDU1nguy4QDMQOtH+2ospJDuXNLf/BRAW8y1ngkFX67zugAUUzBgE8FCaFz
	 3yVB96aTBMOdbv6/PHRSWsKA/dMOk5JQuw4vsQiYnae6ULu9Znjw9G7boRL9FwlEPE
	 Yo41h10dn1niCoOzAtmqogHqigI0CgCLuu4N03m8x2+ZC/nI2vymrx+r+437K6lc/q
	 VA7Ae0BO3iJKfrPvnNbPgzSzLPWFsukjaywQrSKsQW/Gkg65RxRbBVxRYexQcCni8V
	 J0oaH3ElmH+hbs1/tYUpOIzsdFcD8wEIvKvpKgK7fgSlGK0EYMHJLu6HJ7LmNOkF5p
	 EhDKwAZPOzUkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A71380AA66;
	Wed, 29 Jan 2025 20:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Fix code style warning
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173818203600.417583.6021608947109289550.git-patchwork-notify@kernel.org>
Date: Wed, 29 Jan 2025 20:20:36 +0000
References: <20250129123330.391567-2-deaner92@yahoo.com>
In-Reply-To: <20250129123330.391567-2-deaner92@yahoo.com>
To: Jeremy Dean <deaner92@yahoo.com>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 markus.elfring@web.de

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 29 Jan 2025 13:33:30 +0100 you wrote:
> From: Jeremy Clifton <deaner92@yahoo.com>
> 
> Output of checkpatch shows warning:
> drivers/bluetooth/bfusb.c:368: WARNING: braces {} are not necessary
> for single statement blocks
> 
> Remove braces for single line statement.
> 
> [...]

Here is the summary with links:
  - Bluetooth: Fix code style warning
    https://git.kernel.org/bluetooth/bluetooth-next/c/a2a245849af8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


