Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC09926463A
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773774614; cv=none; b=VW9/gv0eouURy57nYixphUo5O16etPfFgVzDpP78zOQmLDIfZ1Gh6WP6UCkqJ1U7tnjRa5VxKZ9+0TovSFEGGPfbC4QyLRXwFgkqU7MGFN6S/CTNqfV1BLk6ccKWAatD/JDy3F6A0PnrVUmbFh6QcoMcWdtZKTJ20p9CM6ZvNJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773774614; c=relaxed/simple;
	bh=qRJJUAwn2nWJfhtca2w2kpn6mlT68D9A3eFeHFGObSs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F6PNh65i4nHh5BH0CkteGUV+Yq9fX00+UUdk/QxnAhUFmiEjMCeuxXLcD/NCSWoAXwN2B3AzG5Uv7tryu/chRso7ePqh67e/mr5F1FQjhemlN8pFnPED2GSTN+fcix13FK30ksvscLvGYOId1OXDewkmryQk1JAKXXmCyffLyCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIZxg6L/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIZxg6L/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA5AC4CEF7;
	Tue, 17 Mar 2026 19:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773774614;
	bh=qRJJUAwn2nWJfhtca2w2kpn6mlT68D9A3eFeHFGObSs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dIZxg6L/qUSPUGis5ifDJbRa+ECZQvrkF7qz8H/H4r732S2+ucfFUnxJVGhhEnZo4
	 lA3LNU6o1/e74aLeKbYdLMUm+culd2dAF4KHTrmTdA/fO6Q8CeY3WIOWqs04jA4R3t
	 GU5dZVWl+64Kl199xCOk4HZtI1Z5phwFf0f6wfuK25jITfE6HnM6HmzxIrmleuhlDB
	 N9aJYUXjVmp14uE1R6Mdo00KHwt0PRqMopJkoyoMkUFwLhjC4+f9lNCEIovnCIWzx4
	 nx8K3FMqD+cHo5aKcXrGTefC2Su0P7jcI5C2BxmPVijjydTrLM3/RosNNWkYoVkQfC
	 1GCEnVKbygkAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DFD3808200;
	Tue, 17 Mar 2026 19:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/2] Bluetooth: L2CAP: Fix printing wrong information
 if
 SDU length exceeds MTU
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177377460661.4165784.3650560546141444320.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 19:10:06 +0000
References: <20260316190957.8433-1-luiz.dentz@gmail.com>
In-Reply-To: <20260316190957.8433-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 16 Mar 2026 15:09:56 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The code was printing skb->len and sdu_len in the places where it should
> be sdu_len and chan->imtu respectively to match the if conditions.
> 
> Fixes: fa768fce4aae ("Bluetooth: LE L2CAP: Disconnect if received packet's SDU exceeds IMTU")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1,1/2] Bluetooth: L2CAP: Fix printing wrong information if SDU length exceeds MTU
    https://git.kernel.org/bluetooth/bluetooth-next/c/013598897448
  - [v1,2/2] Bluetooth: MGMT: Fix dangling pointer on mgmt_add_adv_patterns_monitor_complete
    https://git.kernel.org/bluetooth/bluetooth-next/c/3c2dbfa16ca6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


