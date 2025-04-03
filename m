Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E081D7E42;
	Thu,  3 Apr 2025 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743711600; cv=none; b=f7iHyTXavYWZ2l/ykztG/l5og4JIV9w8MKYuQYg8o3DVqPSG/YwEt09Nf9vERlq4WGQApB5zFwwAUyFEyYiWASUQxyzJkHhArHi+L0tXFRtBffVisMDXo6N+QBXvQE/dL8X8aB0Rj3XNqNLbdEOF2thIyHzapfOXvnKZnVcHRYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743711600; c=relaxed/simple;
	bh=zwXCdlA9Fa2xKX5DBoN1Pyt9MhsxTdnQV1GxjDSPdzw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DyLeDREDAV+ZwKz808NlgBv9h8aTpRxmwVw/DDImMxKtzmQvRDN1D9h0QzbuLUgNzP7uOPdoPPh/u7mJQGo/2W5dxRSRVafdl5/ADRLsM3wRpUpqepp9atgO4jb0IO7SrZNGsNLiPVfNupfB0sPXwZLLypfNyhUC88L02Ahxsa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0t9lkFv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0t9lkFv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FFBC4CEE3;
	Thu,  3 Apr 2025 20:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743711600;
	bh=zwXCdlA9Fa2xKX5DBoN1Pyt9MhsxTdnQV1GxjDSPdzw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X0t9lkFvx1z9hFvn6ZsKP9Bxvj0OBsf7mw//LBHpKKxIn7OpylhIuEZ2eFC2nK4ba
	 yvk1lB8K05eF2HXc0kAJwkYvInm2530EHFIKhOuUyavKWk65AEL0jnCDMNqgoHY8Sg
	 yK1rN+J8mEWCPyU0UtHKIVn6zGTyZ3nunKKbf/W62m7slmIOSJfIMHX67ML7mBEAmP
	 vwx3LHBajn8MWny7l4JeWR1VKkRCKbVoKUIVLwVMbhcUD13b2FqaBI1VKbFx4RuXTx
	 Kxu9xL3F3FwtpUuk76esw7XcYAr3oYHdxJaQD74lovhe02XNz4yCavhNaoRtwBckDt
	 b2ynGbdLb7euA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E343822D19;
	Thu,  3 Apr 2025 20:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btnxpuart: Add an error message if FW dump
 trigger fails
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174371163699.2672071.674464820758034396.git-patchwork-notify@kernel.org>
Date: Thu, 03 Apr 2025 20:20:36 +0000
References: <20250403150223.4136-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20250403150223.4136-1-neeraj.sanjaykale@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 amitkumar.karwar@nxp.com, sherry.sun@nxp.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  3 Apr 2025 20:32:22 +0530 you wrote:
> This prints an error message if the FW Dump trigger command fails. This
> scenario is mainly observed in legacy chipsets 8987 and 8997 and also
> IW416, where this feature is unavailable due to memory constraints.
> 
> Fixes: 998e447f443f ("Bluetooth: btnxpuart: Add support for HCI coredump feature")
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btnxpuart: Add an error message if FW dump trigger fails
    https://git.kernel.org/bluetooth/bluetooth-next/c/061e4972c48c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


