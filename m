Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BD13032A
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715794831; cv=none; b=XSR9ZUYknQE/wiQgCnZwQYaF8gIZRJ+LASFk8KacGactlIuLS9AqK1lyVl6Y3mm8CAMzEo0QfLgj299LwO55486Wq+yCgY/2B21d0SoB5n2kVxBLiowvzimLC6srKAcXSY2CnkG0aUMFKW/FXuduKsHghP6EECuwWRGqpWgDmqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715794831; c=relaxed/simple;
	bh=N/Om0lf+jiBpsdulqgwupy/AybYAo/FKzbJjKZxBi48=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CDrB1ZuUbhFy860F6d/xtOeRj6H9foiqCBR3RT7cTqHFvT+nM4rL3+J0wGBG65xxBNjVH+28T474Md33yzeyoopeIIywrjtbrItVruelvX74T1+rn3SXBkyRlH7NNzruXKW47rhrzhHsfIrWXkPekETVq5c8CEESyWzcs4AK+wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvYIgC8R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvYIgC8R"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2918EC4AF08;
	Wed, 15 May 2024 17:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715794831;
	bh=N/Om0lf+jiBpsdulqgwupy/AybYAo/FKzbJjKZxBi48=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AvYIgC8R1E3K5posFA4J3fuRARz/nI/hegwuJKOpi5645Vg7BF+gQTcma8KIr5Lja
	 OtYnT0TgqVohBxoeGtW4pVyBflpBlWp90sbq0J+j7DydC5MaMIBWmbh/U1/bbNGHpP
	 Cqe1HZMOHUc5n7o+omnvDa3fNag+00S2H6SVv5AMG6wj4kp/nT/YC5ji5nrTSOvDSU
	 wqCLYkq2fMU/XpuK0Z+ydpm6xq75K631VD1ekkTP3VQc3IvdkbDgyPJKQAuZA+sdgq
	 0sLlEj9oJmV+hq4h7qGRCbx5ryZO9wbLM1789HcVZOtX9q8SOxfCB1qqg6PczEXf69
	 kkgt5BMxsQvZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0FC2BC43332;
	Wed, 15 May 2024 17:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/3] shared/tester: add ability to skip tests unless
 explicitly selected
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171579483106.13625.1147783090330624729.git-patchwork-notify@kernel.org>
Date: Wed, 15 May 2024 17:40:31 +0000
References: <d832a406db3b7f8509fdc67d0e9f2775c6ea7b6d.1715719254.git.pav@iki.fi>
In-Reply-To: <d832a406db3b7f8509fdc67d0e9f2775c6ea7b6d.1715719254.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 14 May 2024 23:41:48 +0300 you wrote:
> Make it possible to skip running a test, and skip running if the test
> was not explicitly selected on command line.
> ---
> 
> Notes:
>     This series disables the TX timestamping related tests by default for
>     now. The TX timestamping itself should be OK, and the assumption is we'd
>     re-enable these tests again once the kernel feature is reworked.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] shared/tester: add ability to skip tests unless explicitly selected
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a9f80a8195b7
  - [BlueZ,2/3] tools: disable running TX timestamping tests for now
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=975d3b148694
  - [BlueZ,3/3] Revert "mgmt-tester: update for Poll Errqueue experimental fature"
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d9de306a28fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


