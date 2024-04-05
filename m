Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9F516EBF3
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329232; cv=none; b=O52QqK1EvgaEhjk0Hk5v6DnbwaLFVJHF8Be3UJKcxY2YB6Cuk9hp/NvpjAylePvi6tM/09PekGMkmrXfsu0pZ7XGXqfHTXggrpJpbCD+3tDN3RvHO5tW+iH+5KrvStzwy8AunWlSbxxeN4mGxdEzUdy1kE+5vkIQvOCI9l87Po8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329232; c=relaxed/simple;
	bh=OOPlWXrJZAWfOupYPmYzOUyAHGrHBCJ8GzgCuAsR7tI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eWFG9TLpAXn2a055NnAPz2Ksf/axuAiNhBM4Bm3edmiHT8HSdHoPFjfCFKRYuaNa+8XvbZM6oVnyororNoZLSw9q32uFAlFnI53wa5xGXF44+gVR5SpzsEGJiYglB8eUOc3XL3b+qSJEzKCLKJjg7yYBW74qiKIYLRQtPsu9QYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=effmkjJO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="effmkjJO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF9DBC433C7;
	Fri,  5 Apr 2024 15:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712329231;
	bh=OOPlWXrJZAWfOupYPmYzOUyAHGrHBCJ8GzgCuAsR7tI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=effmkjJO4d4PBeoHS9LqH4ZSttwgVpMmGwjEVcIkP+FaLNOgvtD3oedfazd7s5SXh
	 ho8INSrokatDy19ps8SgBN//mZYaVvfRiwS29IApKGFOxMCrFWCNo9V3JsvKPSwqJ+
	 qILxg8PP1K5eBnrUj8vi+33NREMlLEyljmP5zEXCVpzUSSAAKk7kq04TYxjjzAOX4j
	 kihkKC5ziqJ0Jrm/W7co+rJQmUCYVI7d3WrYre2RvlcLe4uuTEKG/pKItfI4aSuG60
	 KenJX3TvER09bbyyF08RKD6Z7DWGsVjPN3pJ1DLQEG9LVP+hJS+uI/ka+hL98DuwKU
	 itnwtOUCXAt0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99CDCD84BAC;
	Fri,  5 Apr 2024 15:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] device: Fix airpods pairing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171232923162.27859.6567008122074769824.git-patchwork-notify@kernel.org>
Date: Fri, 05 Apr 2024 15:00:31 +0000
References: <20240405090050.1477187-1-frederic.danis@collabora.com>
In-Reply-To: <20240405090050.1477187-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@ci.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  5 Apr 2024 11:00:50 +0200 you wrote:
> Apple Airpods are discoverable and pairable in BREDR mode, but also
> advertise in unconnectable mode in LE with the same Public address, at the
> same time. As the pairing process uses the latest seen address, sometimes
> it uses the LE Public address to pair, which fails.
> 
> This commit introduces the connectable state when selecting the bearer to
> use for a connection. The last_seen value is used only for connectable
> devices.
> 
> [...]

Here is the summary with links:
  - [BlueZ] device: Fix airpods pairing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=98bed16d254c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


