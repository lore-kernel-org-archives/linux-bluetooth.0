Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1899619066B
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745503793; cv=none; b=e4MTRB/Xm910VFK17QnvIkWP/3EvUSXyqICDxdvR83ex8u8aYpouS654E3d0oi2H6J3tsMK21ozt483nr12AKYPKAwXgrivjtLHDzxdC8W6dZBTsVzPGqXPIHol0ZFePh5aDQ4lFg9AcEWSzWzRROFPNCMFHTJksFISsjQvpXKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745503793; c=relaxed/simple;
	bh=D7ipQXaPZPVQ56z02GSTMik5QndMagrlvw4As1ozQMQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iSuHgEgDk3WKKAfWk+D0XMTI9yElE/VK9bXeMjxEBPye2l9WhAwhSvg4zdNGI5FVGCaIJLsHWtevQfRDyqMgUBFGd0JE+zqeL8ToVv+im0W7U9QVVCGSqT3zxPNobYE4U8XqL/OvAFfAKY1DT5bUxhynvwFoH8ev33qO4NJ1PVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbvkmyUh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbvkmyUh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6AEC4CEEF;
	Thu, 24 Apr 2025 14:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745503792;
	bh=D7ipQXaPZPVQ56z02GSTMik5QndMagrlvw4As1ozQMQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TbvkmyUhVXjqAAyyPLu2gVncXq7zuSCW+1aUYj3BldO6GjC3DP0xf7uZvwE0DxxMi
	 YOjjJulULTTFmojv4YXe94NASSqomvfEMe13ZPSFAyITwzIU3AYxj2hXdbyXWR9Lev
	 4qjhpxqjZUs/TtmoF47HnSkWvurbtuZDA8I5kzwgCqxtIUiHTjF2yi4xmCc7R0dawa
	 u+xkbIcUQ2vyQEEKG31dr0G/xR9bUffV+nrNC6U5OQAWBCsk960LgTQvLWprTKZtAK
	 wsShB2ZsZxSmf10GZpyR7Y+8V7VE4BUv45g2vlQE7itSZwHcFZcfN2zD2PWekrp45E
	 8fXf96oBFx2kA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BAA380CFD9;
	Thu, 24 Apr 2025 14:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: Dump debug registers on error
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174550383099.3366851.4687730364645490022.git-patchwork-notify@kernel.org>
Date: Thu, 24 Apr 2025 14:10:30 +0000
References: <20250424023147.257095-1-kiran.k@intel.com>
In-Reply-To: <20250424023147.257095-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 vijay.satija@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 24 Apr 2025 08:01:47 +0530 you wrote:
> From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> 
> Dumping debug registers on GP1 MSIx and error conditions, such as TX
> completion timeout, aiding in understanding the controller's state
> during errors. The register dump includes:
> - Boot stage
> - IPC control
> - IPC status
> - Mailbox registers
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btintel_pcie: Dump debug registers on error
    https://git.kernel.org/bluetooth/bluetooth-next/c/dd2f5449a622

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


