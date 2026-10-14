Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A42656511E
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998419; cv=none; b=PxwMEhTxWAyEQkPw9YVRHWWSwbKO8WBmQxRlERavSrFHdgFAjdvG9deCneiUlr56yc2xFlGzJpI7mtNx35cfbJU+lJfXtxmCNkpD3Be83kGi8WB3zVUaZI8tuII+RkWrE/mo7qamGp5uW/I/O4kV0Bm+uzpyTOLz8JwpNWvzW28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998419; c=relaxed/simple;
	bh=rE0D6UV79De1uj0xdxIK3XTSRPeT1PiQS2M5z9MUPBw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tqNOBgoQ1CJ+YQMzY5lUV75IlFAXLfoXiRCP4pA7yKVOYWjNpJ6/VsgRDiQPBUC8CTe5htKBa0RbIrU9P2ZqJG1D8WpoIeN4TtbCJS48eq8WtBqYHIT7R68/+NhZ2ap+JRgU6y5kxdoTFRLmz2TMLBbjEWCrgk4c6PejnjulbEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9OW0uMf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9OW0uMf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0747C1F000C8;
	Wed, 14 Oct 2026 17:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791998414;
	bh=ylkMtOWfhw0GirPcY1Duv/YuidUcW5AtjuxGfIYPsKs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=H9OW0uMfYifPiOtio/Dc47YvQgiBl8QSnZ7247+FAt8Jmg9g/32FBYQV1lcsmhP8S
	 +urQieYfJQ/DXZFCx1GtHH0KDX/GPbRv0f5VWfVKAdvQXSHB9NvcCj68aDYazF5yJt
	 qpthTAwGjjuJqn1dQYunig5I4OkwzbYv5Kh/yMvpG1PQxWblvnPxQfsCAgcj3+fUTC
	 zXLHnjUpmIBLyeG3o9kV8dn0/E7HAz/UZRKsoj/uxZNXj6hp3CraRXVhJRHX9NpNd5
	 MSQWzYcUzxIgYRrPXIi8j3EihZfFSReNFP9iLUs3vtElPBZxXvDyg/ZUoVNDbw2pFH
	 6beRHj0tKC5tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F143339FD335;
	Wed, 14 Oct 2026 17:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: Fix the LE Read Connection Interval
 response
 layout
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179199841251.2868755.14605653330503918734.git-patchwork-notify@kernel.org>
Date: Wed, 14 Oct 2026 17:20:12 +0000
References: <20261013142202.544985-1-luiz.dentz@gmail.com>
In-Reply-To: <20261013142202.544985-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 13 Oct 2026 10:22:02 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The response to HCI_OP_LE_READ_CONN_INTERVAL carries a
> Minimum_Supported_Connection_Interval octet between the status and
> Num_Groups, which was missing from the structure. Without it the minimum
> interval was read as the number of groups, and every group after it
> from one octet off.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: Fix the LE Read Connection Interval response layout
    https://git.kernel.org/bluetooth/bluetooth-next/c/d7629e8dabbc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


