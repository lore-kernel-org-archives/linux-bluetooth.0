Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B5C388E77
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 20:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776802244; cv=none; b=EtER38uGzzejsB6XhkncyFZA55dJuy1i+WF9rDxUXbcck1pCaJTkoBVjEVCkplb+0izgTiKVX6KjqGsObL2oSsp3G7Ul8hMGPFCNtUesggp9rLjDRYQBy830uldkpz8WcYxVmHq0w4hWxQhRBXQINkvQcf0CtQka9Q9VVNhc3eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776802244; c=relaxed/simple;
	bh=FQL8TbfxKD86KeVwWFpLszhhUG3ghasLJNdSisO+LyM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t4R9aLniMedcjMhbBmw6Zj8Ssn8/EOtzBdnc9RmaN9oEx90jbxUBKlUY1UQljFxQLrNUxVzJpkUN08sV/+kxW5q0ZdAGaggu2Tjfg3KjjHDtjWi2k/CMHha8xuKKS8YWFcEHPVsZwmyR5qh5WXAL/omiO5VKd2f1OX1H/Tf4kQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5GOdy16; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5GOdy16"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B141DC2BCB0;
	Tue, 21 Apr 2026 20:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776802243;
	bh=FQL8TbfxKD86KeVwWFpLszhhUG3ghasLJNdSisO+LyM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c5GOdy161FeyXPGPZ2wf65pNY8KTdAEvIrJNmbtdM6tX0EB8923pG7/4rXzZWmpYg
	 DZQJs7GiFC1vVoY2TQ9VdRunKFrKqHB7t0tWh8vbPAU+XsZECJREXByUAa1QfDZbL8
	 hZ9t9raYBFjm3F3VVaEZsPGUIyqOk8kMzSvcf8+TrPXjnneoSTzYTeAtQ2MhEA1fjP
	 zGOa8h0Ox6CJgElMjFs35Q/LpmlWMaqIDz9gZ8sk3raeDtxzKbHN1o2OfVQo/5nYw7
	 XIBitryLaywHXquLR142X9blr3F3x12HpfvMkLIhmZKLoJEuIAiDH6XXwMlSNAys8t
	 CzljOBp4mbG+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FBFF3930207;
	Tue, 21 Apr 2026 20:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] Add permissions for btsnoop-analyzer workflow
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177680220679.2983905.1962802386067281882.git-patchwork-notify@kernel.org>
Date: Tue, 21 Apr 2026 20:10:06 +0000
References: <20260421195544.1950548-1-luiz.dentz@gmail.com>
In-Reply-To: <20260421195544.1950548-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 21 Apr 2026 15:55:44 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Grant issues:write, contents:read, and models:read so the reusable
> workflow can post comments and access the GitHub Models API.
> ---
>  .github/workflows/btsnoop-analyze.yml | 5 +++++
>  1 file changed, 5 insertions(+)

Here is the summary with links:
  - [BlueZ,v1] Add permissions for btsnoop-analyzer workflow
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2c3961e3b0fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


