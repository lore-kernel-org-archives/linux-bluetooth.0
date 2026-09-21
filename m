Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508F54AC15A
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999878; cv=none; b=ZwE880lofpqBLlxl1M6mCMQkPHU9OFAVWXsgw+bWCiwI6+pTustNo9J+gEeoA94cwBlxC4gE9LlQkV6brbutWtwNgVIRynK87qk2uVdtQDsyZPwvQezpBOg52wqPMBEyA1dFivCj6xiank1jxERsxqAIzywpKsVEjwuun3PviGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999878; c=relaxed/simple;
	bh=FG1JERJBiVrCyVIZ23/Ff53d+3wyMHwOn2SMbnql+wU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mVrIl+NtMGa+X8cuDEeHAGhuLwkk3tXSCpvayVOrtb5fn9zhCeMJ0BmEPH5PtQCF9c1nkrGFV2oJM4ReMTpVPCB+r67rT1jdhagEktexROuAYhSSe4oempCLJHNZYzK5DQgpas5IHp1cYz0fLULsstxJM8SUZZBBskl3RaJep/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLVYdui4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLVYdui4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357621F000FF;
	Mon, 21 Sep 2026 14:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789999877;
	bh=NxbJ2tH1ywWihwm6MD4WfOUPZohMgqeLPXnTS35zjWU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GLVYdui4jWdwkkxdq91mmmPytM73ClHPadtjYhFyvEw5OZL9nVZ4VyPq1JybDu0nV
	 mD8enOavjUGK2LtvwVWggl/Y9AGfmqdDR8dOa0CoEPJWhjvhsLv5aHLTcM5dCIIdAR
	 yft11i3oenP2BdvpqQwrsiCdb7z4Nfi/yaw/f8+N72xYfpOXA0roRzRF7rbhxGHIo0
	 FD5c9fYuj5eVJIBQlBptid97prZ/zcXuFpIoqASe2rGG0JSk94CrWuluhykIqoibL2
	 ETaPCR05GldYVLihNt3SuXGd05mNHUW+b3sS6m0OaEg37NUrKIkahnMxvMhyWIkSaj
	 CxFm9xMCAmtUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 196E93926659;
	Mon, 21 Sep 2026 14:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: btintel: read ROM debug registers on FW
 download failure
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178999980864.3047822.15306584107639595745.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 14:10:08 +0000
References: <20260921131047.2780402-1-ravindra@intel.com>
In-Reply-To: <20260921131047.2780402-1-ravindra@intel.com>
To: Ravindra <ravindra@intel.com>
Cc: linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com,
 kiran.k@intel.com, pmenzel@molgen.mpg.de

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 21 Sep 2026 18:40:47 +0530 you wrote:
> The bootloader records init sequence progress and debug info in four
> core debug registers, useful for debugging FW download failures.
> 
> Add btintel_get_rom_debug_info() to issue BTINTEL_GET_ROM_DEBUG_INFO
> (0xfcde) and log these registers, and invoke it from every FW download
> failure and timeout path: btintel_download_fw() (legacy .sfi flow) and
> btintel_prepare_fw_download_tlv() (TLV flow), before resetting to the
> bootloader.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: btintel: read ROM debug registers on FW download failure
    https://git.kernel.org/bluetooth/bluetooth-next/c/06d991977eef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


