Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2721135DD1
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Feb 2024 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900430; cv=none; b=IRnlQHPy6Vw3QWRYJnbrFsVhqO4NAR2qWRD2ZCQBh5gyNYC9EqPN3RAAsVSXpx+ITfF5zN/D7gxrhNHB43GDcQTRHgRfc5FBUr60Hb8Hjozc9vhGpj4NS4vPrK3rs3HVwqaY9U/hR8z0cf6PXk2ah7WYJxJ+mOhxENhffQPGCZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900430; c=relaxed/simple;
	bh=5csCslwBPVEbPRQ/j9SzMsOAt2QTURTbERYSBXXYIK4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hVZ9dMSJIxJ4QwwogigXbiEt39GPCbbH7bcADCHyGUNAN1e7uAz3liRwgB9Edt0hcWy0ANQ7BDu+BMby8mV+oRZ/KZI9ASkcDb5BjTSIb6gp51rbQPPJTWyHpMz3QXMhrCgwGacf8M3zEFMhqfnfL5Qu4r+CoFi4jUS+YLBL63w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpUON7NJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpUON7NJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 575EDC433F1;
	Fri,  2 Feb 2024 19:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706900430;
	bh=5csCslwBPVEbPRQ/j9SzMsOAt2QTURTbERYSBXXYIK4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZpUON7NJM2HAMNHX0cMBPRpRte89h0YoIwtIY/4OqnTZjhrWPiXv9rrCNvRmmja16
	 GiLS+mQ0/2TkREH0amKuzxfYvs7qIQPXwXOGWJtoHi3hMiIUEFZC7tcbXDKEoE9fJf
	 2p3BEEODiCWAHWtE87ZzrElzZF5otImizu8BWoNX0sUT8Gi33hqa1Z69f+3i4r6ypZ
	 SCdzT7rHXkL+nkzrhifx2pb9V2DEUMirhjnIhzVh0XG1psGtw0l9wKU9nOMH137dPf
	 xgnLrpJ8b7tRNdAuOjWEo0I5mLqwZfE5HhbxeWq7RFvHdsJ+2nT8srP1yP1dLucQa+
	 LX5Cb+CtcbSGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37985DC99E7;
	Fri,  2 Feb 2024 19:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: Remove BT_HS
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170690043022.7237.5046815232602883986.git-patchwork-notify@kernel.org>
Date: Fri, 02 Feb 2024 19:00:30 +0000
References: <20240202134854.1479497-1-luiz.dentz@gmail.com>
In-Reply-To: <20240202134854.1479497-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  2 Feb 2024 08:48:54 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> High Speed, Alternate MAC and PHY (AMP) extension, has been removed from
> Bluetooth Core specification on 5.3:
> 
> https://www.bluetooth.com/blog/new-core-specification-v5-3-feature-enhancements/
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: Remove BT_HS
    https://git.kernel.org/bluetooth/bluetooth-next/c/bd39a059da00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


