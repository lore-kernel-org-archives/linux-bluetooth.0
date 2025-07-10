Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71672F0C72;
	Thu, 10 Jul 2025 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752168744; cv=none; b=MLbK29XUAt++K+JZMZwZd8sVDuBXkJTgVITYyHvnUc65St/dHkR04A+RXJNgXOhy9kqovOpqxyaARuf7fGad/Ft1J0IYoub/yiN7J/0BjbiNn6ba/BIRRXE72RQ8bka/dKyACVPZbJRwkwd1RHQUW+ACje1rCa4KzKcH6F6naM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752168744; c=relaxed/simple;
	bh=K3Z6O7zz8kSM0ooJFX7ix080xS5Zz99Utlyrpo5zYMI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ohjLKTKsQPlAI8jXU8AnZKsPFzgiapjrVI5Kt211UO9h+gDkMxW87gkyVkJ6PTt9ECBFlbjqfqfxReDe1MKEs0lNQ897PtN4zPxcl/UXOtmKiFZFtrXPVAIdI9QWXrNlzcNJcwBWjwmnndfhmdbHr18ouJHZpVan4IdGNDOx6ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKA1gBpL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKA1gBpL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FABC4CEE3;
	Thu, 10 Jul 2025 17:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752168744;
	bh=K3Z6O7zz8kSM0ooJFX7ix080xS5Zz99Utlyrpo5zYMI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EKA1gBpL2UajeyXACNtx+Ux2AGzuS7rDljMe9bLg3/dZsdKCYn6+lV92XdR7SnwUQ
	 nb75+gYJvBm+fdix/3zHIr7ZYccKUss5vwK570QJ/sqgYxD7srbyeB2gyOA5nd9zIk
	 cHichAxvoMWtbdHUPSYmJzrjoW2rNphD7dHGrauO6ERr1DdQuhayCK1UvYZ4k9Jujr
	 dm6a6QHE/mhV0I0rfh8YMLf6zYTlNVgbiJJnKERTh0zIee2uzeM4ktROsK/JlbADAB
	 cVBwulKSnWLoGE8tDdRJtn1rvMDaHuarMOcf9rd9upjN4Imseia0av0ywLr8+2hBQL
	 awQ5sL2E6vBEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC93383B266;
	Thu, 10 Jul 2025 17:32:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Fix potential NULL dereference on
 kmalloc
 failure
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175216876624.1607762.15975000995964161404.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 17:32:46 +0000
References: <20250705105246.1383084-1-quic_zhonhan@quicinc.com>
In-Reply-To: <20250705105246.1383084-1-quic_zhonhan@quicinc.com>
To: Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, chharry@chromium.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 5 Jul 2025 18:52:46 +0800 you wrote:
> Avoid potential NULL pointer dereference by checking the return value of
> kmalloc and handling allocation failure properly.
> 
> Fixes: 7d70989fcea7 ("Bluetooth: btusb: Add HCI Drv commands for configuring altsetting")
> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
> ---
>  drivers/bluetooth/btusb.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - Bluetooth: btusb: Fix potential NULL dereference on kmalloc failure
    https://git.kernel.org/bluetooth/bluetooth-next/c/982ac6d394db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


