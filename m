Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6B62253A9
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 21:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604206; cv=none; b=ScrcC9ZyEmOq6eAUVzmIeI2oxbLXb8GQgRSOqzXaHSkjurn5QfuaocE+zV4K6iXESVOXg507gmTmcXFBx3FtUTCN7jedvZUqx6RkrQCrZFANFp+QQ8eIkQ83t4yrNVHg464gqdGDAXRwOdtQpidZ6UjYwaVQKgwBVHRTiKDsudw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604206; c=relaxed/simple;
	bh=QKrWZ0jp+Cp5ZZHmD55kSs00+VWXc7b1pI1slrG8e2s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jmMJG8gl31KkdeX5SkVZ32YKhbTPMGIt12Bhh35G+u3cw2wd1HInq2hUWosr+XwAQ5Q99xuiZTWln97kXuwr39uiV1vGgtmFHhCs1lSglc74LUApurtWicdD0XuhlXkbqTcRBEvzdM2etzI8tBvfo45P7HiqUrPexG+ShJvKAL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jELWhAHo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jELWhAHo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C838C4CEE7;
	Wed, 26 Feb 2025 21:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740604205;
	bh=QKrWZ0jp+Cp5ZZHmD55kSs00+VWXc7b1pI1slrG8e2s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jELWhAHoko5li4hYcLJzoT9EFRNLRobRaI1uykfhKdD9baX+ptc3+xt4Cj7YSYd8L
	 RoJ6VzQrY72gJYL0OdQI0+j+S0ckOYQf0b8D9OgJ4ylx0M1egrj7qEbz3LKZZejls5
	 V6m9ogHaGmk8Vf849jGQVZnajklsjdzln2BDJRxJQarH87M2uLAr+/nn8TCi1pOpxf
	 zIVVaNFwx6OyEI800r9D8X6hj733gT+uIbuHkuVaPyMAs9v3TZZ9yia96z8darsNxz
	 B0GNdhILJ1ygZXYDydkOhHetfULY/YfXSBBCAq00Sr20WKHc8YPDZl+z0Jgx+gq2WV
	 t5i2Yt2dpxZbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D8A380CFE5;
	Wed, 26 Feb 2025 21:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/2] Bluetooth: btintel_pcie: Setup buffers for firmware
 traces
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174060423723.846473.4528221555018431128.git-patchwork-notify@kernel.org>
Date: Wed, 26 Feb 2025 21:10:37 +0000
References: <20250225114311.9514-1-kiran.k@intel.com>
In-Reply-To: <20250225114311.9514-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 vijay.satija@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 25 Feb 2025 17:13:10 +0530 you wrote:
> This patch allocates the host memory which is used by controller to dump
> the firmware traces. The memory needs to be shared with controller via
> context information.
> 
> Co-developed-by: Vijay Satija <vijay.satija@intel.com>
> Signed-off-by: Vijay Satija <vijay.satija@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> 
> [...]

Here is the summary with links:
  - [v3,1/2] Bluetooth: btintel_pcie: Setup buffers for firmware traces
    https://git.kernel.org/bluetooth/bluetooth-next/c/3104ae5ad1b7
  - [v3,2/2] Bluetooth: btintel_pcie: Read hardware exception data
    https://git.kernel.org/bluetooth/bluetooth-next/c/978777bfa2d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


