Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC3C17B518
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715698388; cv=none; b=sv8gYYhJltamaSG8wpySu18LmFvHuiEjLnGybcpxO3NZ1lgZQysJApJRIJGKJJbQ+60buWMbISD593ZaXAThsVW49I1xTJZM++01h56KRtT6VV2w8xYXaT9v+UMeTsFXZ559eVhIvs5QPRmaPg2othyr7Jx6BlMq8+o3+PFkPbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715698388; c=relaxed/simple;
	bh=fCyiRCjH8w2NAtPBbqrNCbIaGx8lR9umSKo717uATIs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jCXFSRNHmH2vopDOVpT9iECq2evcgdBDmGhl4zYhRVFfYDieUJt6AoazISnsaExWpPBwMMvtMyntbDFswz7tjPkuwgc6s6Y1Qag60iorpbWofYaUOA5QziUPWj3epD/htrGyneIOYrW2wLcy53VkuBb+hDAmfqoM3FyR6dd9R4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNGe611h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNGe611h"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B38FC32782;
	Tue, 14 May 2024 14:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715698388;
	bh=fCyiRCjH8w2NAtPBbqrNCbIaGx8lR9umSKo717uATIs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LNGe611hJOEXDeKzD8nrtJLLaHvtqgE6bCWpRr7RtaVlKEqxyiBJcskC3n5c3tVWF
	 ncuyaGwkQ8VbjmsopJDwKz8Px5Go01Ux+m5k907AB2JlOSofZy8QwbCY9fspTUkpY7
	 pShAcxyV8H82u4dYiPj2JCRvgJarb9Dvrxyh6zCdj0gCqm8wlMiu2kL65+maDpFFkw
	 Ow7Ui319imIPs3fVxH/j+Ol98kCeUzSNoYN+G5IB+Gh3kwnUndh34Vz44UBBDQ+d59
	 Hklmbn0wpz0e0Zqlo2hZmGPC/JtUfOyzs4gZJb1Wwjsmc/TeliX5a15Bfc9UCkHmMK
	 kJB+VTzHbw13A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED01FC3274D;
	Tue, 14 May 2024 14:53:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_core: Fix not handling
 hdev->le_num_of_adv_sets=1
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171569838796.3449.15186494222653472444.git-patchwork-notify@kernel.org>
Date: Tue, 14 May 2024 14:53:07 +0000
References: <20240513202607.369337-1-luiz.dentz@gmail.com>
In-Reply-To: <20240513202607.369337-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 13 May 2024 16:26:07 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If hdev->le_num_of_adv_sets is set to 1 it means that only handle 0x00
> can be used, but since the MGMT interface instances start from 1
> (instance 0 means all instances in case of MGMT_OP_REMOVE_ADVERTISING)
> the code needs to map the instance to handle otherwise users will not be
> able to advertise as instance 1 would attempt to use handle 0x01.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_core: Fix not handling hdev->le_num_of_adv_sets=1
    https://git.kernel.org/bluetooth/bluetooth-next/c/99d699310c39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


