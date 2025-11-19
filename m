Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B3B27F16C
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763564448; cv=none; b=XOv38uei+FZd8fXU/Tp3G6UE04dpna5Qxg3qtWom49Nm8FKGt6nwck0hhiMIG2kHQTJP4thFyOzTZ6ePi1pLFrEp1ion3Uo4FSdqc0rPSMjkWvF3H6JUsp4kJ1S2QeHEsw8zjfrx7N49BhGLZC9I4VxnZ5uMqmXmUajOa6X4n9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763564448; c=relaxed/simple;
	bh=Tl98+mNi4GtCijLqMX/7CpYQN0Tc1FEIAJ/T/bJFbEg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LsyZGOxf3lGl3CqOLn+xTP3aBarhFHako8SVOuzqAe9ve/mg0j/PLBBVhV2bTCAmmquT+RCeEW2pxV40/aiRvWE6E7YDaMiz6IrmRy3BcmEDTjaHNsL017D29/4cfMuPU8a82pVUzhH2S0MhIGa2BMeZZMKWvSSKtlAsA3J6CDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOsL9aRz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOsL9aRz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4BDC19421;
	Wed, 19 Nov 2025 15:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763564447;
	bh=Tl98+mNi4GtCijLqMX/7CpYQN0Tc1FEIAJ/T/bJFbEg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oOsL9aRzOwxTQ1kuMwFtaL51ZA6YCkvVmb2DyJXUHgu6A/K4R63TxvukaIoNvmFPX
	 KdSpdQMsV8NSdMmza+UqEmIXJl0vFTJDKYm1hxY3Lcs2sXypv07QsABonHHRrEmtlc
	 NcThGJ0uzUDWcEfaJP3ygnQCJIP2rRJx9JqDg2wFiLcBcSkiD9pj3PcTPgl/+FsuL5
	 YqfUIZ3WMV5ssxPp4qODdwt7n0ddtNcC7um+SoocLNext/9wMZYkQQdUTqb8AlXIPg
	 1qKwuh/DDGDmoZumHDGVXkEDM7BC+kwTZCealNL+wAdnjQYxboPWAIhIcybbZFDCZE
	 +OiOss08/b0bA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71CB2380AA4B;
	Wed, 19 Nov 2025 15:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: Introduce HCI Driver protocol
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176356441218.825790.16161382275682521114.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 15:00:12 +0000
References: <20251107054011.219938-1-chethan.tumkur.narayan@intel.com>
In-Reply-To: <20251107054011.219938-1-chethan.tumkur.narayan@intel.com>
To: Chethan T N <chethan.tumkur.narayan@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chandrashekar.devegowda@intel.com, kiran.k@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  7 Nov 2025 11:10:11 +0530 you wrote:
> This patch adds the infrastructure that allow the user space program to
> talk to intel pcie driver directly for fetching basic driver details.
> 
> The changes introduced are referred form
> commit 04425292a62c15 ("Bluetooth: Introduce HCI Driver protocol")
> 
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btintel_pcie: Introduce HCI Driver protocol
    https://git.kernel.org/bluetooth/bluetooth-next/c/395be82a59e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


