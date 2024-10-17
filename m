Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D444C1DE2C8
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185624; cv=none; b=e4gic3ETG71mTRI6eZwU0R5i1NCaWwnEbSLNd40s+ytMhlUKJmx9WbVDAvzKpZ56F3W8QgHRzvD5gS6y7F4N0w5J6rrzdKVBVEMX35Vg/Dhcmj00nn+WL2kp6KfOQTS+IpdYNUHJ0dN2mgO3g0Yjoi7qVH3WBK/IgUHBKQLJ8Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185624; c=relaxed/simple;
	bh=xpsXqLAwEYN81z8zaSKJeA9m4dO30BUk+3fDDTOpybA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eOcv1MA67MlGPOCFh796WH9Iy0dmFRhE+lu7vhU7FZcvcF6gSecOZkOmSPPt/Cx6NtmjvOShsurHslBZ93c2J8y+p6Dx7LpECnVCtsgq6JtPGjJDlMHeN+sQ4DgmzX8io4GPu1iwcY9sjoyyCn6yhXPBfMDXs5LBwkVxkwLa80I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDhGpm5G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDhGpm5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2FDC4CECD;
	Thu, 17 Oct 2024 17:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729185624;
	bh=xpsXqLAwEYN81z8zaSKJeA9m4dO30BUk+3fDDTOpybA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LDhGpm5Ghe5thPnwY1Mt190XIQXuDFkWF3V3w0HtEpA+Q68NDMqa8fMLTgXj2ehNM
	 Qh/5Igt+VcyDBJRbllV3SFhBtXf6i64Pgr6lWVp4U3puxWIgSVGuBMdLrGkxl0fNEh
	 ZpQFPepi+mpZbkKsX8hh5eBCASY6yNizq+UmxW08HzsEo4e4Z9wMMrg2abUG1No+EQ
	 OVx1YLaxc6hHibNn5KeR2ammv5m9XGqzTXjSrbMgFPov6PdG5btDoMwv+MttZyNU9d
	 yVnQQYP9wOuv+V0u1O4VuIpB8mIhgKIVJcDCVGm/fual4uijoyEEXayruOJhUhlFG5
	 lPbGd9Z+bBAbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3428B3809A8B;
	Thu, 17 Oct 2024 17:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: btintel: Do no pass vendor events to stack
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172918562998.2545868.8483231145810354244.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 17:20:29 +0000
References: <20241017115156.733062-1-kiran.k@intel.com>
In-Reply-To: <20241017115156.733062-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 17 Oct 2024 17:21:56 +0530 you wrote:
> During firmware download, vendor specific events like boot up and
> secure send result are generated. These events can be safely processed at
> the driver level. Passing on these events to stack prints unnecessary
> log as below.
> 
>     Bluetooth: hci0: Malformed MSFT vendor event: 0x02
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: btintel: Do no pass vendor events to stack
    https://git.kernel.org/bluetooth/bluetooth-next/c/4d67eb2b5444

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


