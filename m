Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C7D2DF13E
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658208; cv=none; b=n1ZdrhYx05vtJ/jte983Zq2+y0i7GeoXopsaAm2pN1zgAaKzl7EA4NXhBJwWZ3Xvbokd0dCbgOjfzB3nSGt/JpT5vlh8RU3/I779jzarCqD8YyaVWS0CorqZPS3RewpAlr4kOuntJ7i7Gpi6Dbr0q663oey9+3S5rQzhl131h44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658208; c=relaxed/simple;
	bh=a8SWe3fSnR5f/KnzGsFuF4HEGNqPqc+Qobvsf94nMLY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RKBCVWRgwmEfx3sjuMJETsVktDmoX+oZPFLW2bkb2BBXTnDN5u0JLbmYzw4WdwaIm7Q1uZoot5VXCf+pnsUw5YHEz3wdzKnkTrg3+ceAH90VIJQFMoDrWW3AhiXp0n31AU21Zd6XX/uMOrNJMKxQ7DdIPnOcQvEcqtjBFO1thV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nN4vN4zP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nN4vN4zP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43352C116C6;
	Mon,  9 Feb 2026 17:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770658208;
	bh=a8SWe3fSnR5f/KnzGsFuF4HEGNqPqc+Qobvsf94nMLY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nN4vN4zPp002iF/jeLPhtjjfFd9BDUAIu6dwWYdPl+a1v/O6zffiBFWgIZvUFJcHz
	 MQdVPuJDBCwM1sOP73gKlSE/PvRsDMs5ZCJKl/+Fxxt1yEj4gJHGe2U1HDWwDJ2BiI
	 lyZXKbZO6QU/xy5cOefUnVoH71Iq7XT2QWaETehDr66jwX/4/H4LcEuassKLs1unNx
	 VhurF4rYI1gbRmRECni4+uhGDGfEG13msJtkwLX8bgR8Ww9Az7UBDv0R4hhvsPl3N1
	 VrfA436Puwa1QA3wL2xDHjLtkKfpHzHksCPcbNSSstsWhiG9QLITxWzdizFW4o/oCv
	 33GXLsxG8WqBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4802D380AA41;
	Mon,  9 Feb 2026 17:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Fix invalid response to
 L2CAP_ECRED_RECONF_REQ
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177065820408.3145846.2267494553011334610.git-patchwork-notify@kernel.org>
Date: Mon, 09 Feb 2026 17:30:04 +0000
References: <20260205195742.55530-1-luiz.dentz@gmail.com>
In-Reply-To: <20260205195742.55530-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  5 Feb 2026 14:57:42 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes responding with an invalid result caused by checking the
> wrong size of CID which should have been (cmd_len - sizeof(*req)) and
> on top of it the wrong result was use L2CAP_CR_LE_INVALID_PARAMS which
> is invalid/reserved for reconf when running test like L2CAP/ECFC/BI-03-C:
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: L2CAP: Fix invalid response to L2CAP_ECRED_RECONF_REQ
    https://git.kernel.org/bluetooth/bluetooth-next/c/13f98d3499ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


