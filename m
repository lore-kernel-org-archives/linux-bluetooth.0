Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D621C9ECF;
	Tue,  1 Oct 2024 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796034; cv=none; b=gYAMnRI2t+AeOgXwMVgGDW1JkxEJ7XqDF6crprfKGTe4f6x3XB1hbUz0PVRJL4ldZQu4WviahLgLbTyg9dKPo9JntWLaSV8KINzSntWWgkyS94JGdadBtvGo4Zq/q0vc/RqNF8HL4Yd2XrTlPdIh49DPDQoZv65nbkuDaSzLLnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796034; c=relaxed/simple;
	bh=3Xt8ZMBN8uGFszYqs3BwrsgLbYA2lJefo5xw5NkbDuk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=joOI4ZsJTYc/Nj6qu55POgrxRyYbW5TTrrvB/aTdTsiviGE/oTy1fS1zfVJ0Zt7qNUeDMCqJ8drQJu8+A7pcDwHnQEazp/8VsEQU7lAqXSaadY4+xQiBkztu89/BzpFi03m5Vpta7cDTu726UUnBoT9iiH8Q0+Lth1JbFDJURRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Roj+tqlq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Roj+tqlq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55159C4CEC7;
	Tue,  1 Oct 2024 15:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727796034;
	bh=3Xt8ZMBN8uGFszYqs3BwrsgLbYA2lJefo5xw5NkbDuk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Roj+tqlqFjCPkWbL41BJ+uENSLu9L6ttK5aSHatkUADi/JmJYPTkjuS7ng0FlgzV/
	 Z9T3wgBLxJeNr8e6ci70WOENWfBSJXd3n8+2gghHoOO9XMVPLSEuL6nuq1RzSkGw3R
	 X4jvAzME3UmAj6C4gGqPT9ie4ICejt7ywEkG05DZ3uv7Q1qH50xkaAlWY8ZBo6d4QK
	 2XwTYQyDZ0Edca0DHHY1OiuAofRtgiAj/WQ7cjE6RPRlQ3uYWPiPcW6cLb0hdx3exe
	 4Dc52JJzPfLiAoaWpcMv03gu0OSd/NuetljznHnTPjWtyf6zW5N4kcyGdVj221LJRS
	 FUgz9oRrZja/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE69A380DBF7;
	Tue,  1 Oct 2024 15:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btusb: Add USB HW IDs for MT7920/MT7925
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172779603724.424883.14753095343709805465.git-patchwork-notify@kernel.org>
Date: Tue, 01 Oct 2024 15:20:37 +0000
References: <20240930104750.18872-1-jiande.lu@mediatek.com>
In-Reply-To: <20240930104750.18872-1-jiande.lu@mediatek.com>
To: Jiande Lu <jiande.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, chris.lu@mediatek.com, deren.Wu@mediatek.com,
 aaron.hou@mediatek.com, steve.lee@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 30 Sep 2024 18:47:50 +0800 you wrote:
> Add HW IDs for wireless module. These HW IDs are extracted from
> Windows driver inf file and the test for card bring up successful.
> MT7920 HW IDs test with below patch.
> https://patchwork.kernel.org/project/bluetooth/
> patch/20240930081257.23975-1-chris.lu@mediatek.com/
> 
> Patch has been tested successfully and controller is recognized
> devices pair successfully.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btusb: Add USB HW IDs for MT7920/MT7925
    https://git.kernel.org/bluetooth/bluetooth-next/c/af0163688ab3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


