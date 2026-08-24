Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A1936F434
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584862; cv=none; b=KGmqgP2sfzZZCRCYDpmMLGNNN7jiPmS8txVowXHl4NOrNykM+Ejoui54SJq25tjV2EPZ7OwuWuoWNzbwc/+H0OVSqY0wDvcReR/jaPPeMTYZ1irRagqaeiVLu2svMyIq0+hYB0WLcm4DmXxyIKkhMd/xUkeD0Ijjg/DqeEYolVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584862; c=relaxed/simple;
	bh=OrJ9hXBxFf1T64NYBJpGc5KQxcSRt0mFpHm1w+0w6VY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aR+8xO7jV28enXxPKxCaj2BM06BmkquRUZLdvHbct9jBUmOuJIki5movAIpZQ4ex2OfAnQIZwBt6G87xhEmmzqmO/lDr/A3//zgjYsKZDlCHDZ+5rOkY9aHh5s5vEAsnaNQNFAari0zKezv/cnK4UXi7o2lxGC0EOiVucqTndCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3xo3YKg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3xo3YKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0DE1F000E9;
	Mon, 24 Aug 2026 15:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787584860;
	bh=UDTGz5eq0Xw5/PPvtsYzdH+XYFmOxhZPrbU/UXWObS0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=a3xo3YKgA4u5Q69xVw3pjhLZlaRfysII6XmidwkCT8a3J4QkSFaJZ7OtzO1sSXlOX
	 1sIhQA3+2zlxLR4vBFuFhghzYwEW3EkoRyTxE0xXwv/pODvduLSbDYF2s1oybjdrI+
	 wZaAYG4th+cYnl5mAWsdNHrWkDoDntRvAvUPGUhrhMwI64FCG09zFdxTsRRKC0mVe0
	 FuAkmYl1iKy2L2DSGYgZNzqFAV2mpdpH4EVxm/aJFoiNoDZzYo3RFQfLlhB093WySp
	 zU4qL0g+aOKjB++lOhRzDdzIwHklZB0uKnl5OdC2SxEovdDDex6Nx5sm6/m/dhamnw
	 135C7lkvnPyNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9393A392445F;
	Mon, 24 Aug 2026 15:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 00/10] Replace the name2utf8 copies with str2utf8
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178758480814.2968570.14468593902711921.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 15:20:08 +0000
References: <20260820183037.2713973-1-luiz.dentz@gmail.com>
In-Reply-To: <20260820183037.2713973-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 20 Aug 2026 14:30:27 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> There are five near copies of the same helper turning a remote name into
> a UTF-8 string, in monitor/att.c, profiles/audio/mcp.c,
> profiles/gap/gas.c, src/eir.c and src/shared/ad.c, and none of them
> agree with each other.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,01/10] eir: Fix stack buffer overflow when parsing the remote name
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=381b5d0d2089
  - [BlueZ,v2,02/10] shared/ad: Fix reading past the name that was copied
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=784203160e2f
  - [BlueZ,v2,03/10] unit/test-eir: Add tests for the longest local names
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=debd432ef13c
  - [BlueZ,v2,04/10] shared/util: Make strnlenutf8 reject ill-formed sequences
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3ad832a3c2a9
  - [BlueZ,v2,05/10] shared/util: Add str2utf8
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=11081f60d95f
  - [BlueZ,v2,06/10] unit/test-util: Add str2utf8 tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=74c56dff2aa5
  - [BlueZ,v2,07/10] Replace the name2utf8 copies with str2utf8
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8c81ab108b09
  - [BlueZ,v2,08/10] device: Fix the name truncation splitting UTF-8 sequences
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2bf8286c4ebe
  - [BlueZ,v2,09/10] device: Rename btd_device_device_set_name to btd_device_set_name
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bef0faa312ee
  - [BlueZ,v2,10/10] unit/test-util: Cover strtoutf8 with the str2utf8 tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f0e40c5b3e6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


