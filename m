Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A162E266B
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992186; cv=none; b=bcvpgKa4yMbXO/vWHTcjy7rrUMfFNFFWs8utMVoFmYhgQ3IDxVVEcWpTge6DzLx/KugZXVB57c5huD4jzjtaym74djmb4dMRHfwCfxKTb0GtIl1wPSCvQ2C4Ga64eN6Sk3E3KXfxV7eIyeWBdFEiUAj5PDBrl74xpVlNPiWVz/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992186; c=relaxed/simple;
	bh=+oqzdzNZeP9Tb2vG+XmvHlsDxmKHE5+4umfaSo7Cg5M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KETZwg1yjwE4/w3Ejj197La87LfFWGiaxJf5wicIkvmuV5j3oUQ/VBV2GqWjGuVWFn4wBVUXqA7Y30BAoLJ1Gh1bstQz/B+Ak6TCsfllD/62BL2pDKjfkkifPIKTLVJcInSwmPwYTtoKGQKDSabni+YGCvRBP4JoQU5hM0Cz4bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EU9s5Isg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EU9s5Isg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF60C4CEED;
	Tue,  8 Jul 2025 16:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751992185;
	bh=+oqzdzNZeP9Tb2vG+XmvHlsDxmKHE5+4umfaSo7Cg5M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EU9s5IsgOykHMW2Ox9wVN8hDY4zEBFjr2rvYhE5nNngqxzQiIYJxVBH3uPILyoZUs
	 NfBOYTNLfiaCksbTGIjZQIa/ffGuOWdiSGqi7GuWArYXp+kuFHu48hXRdLZFjbdR9y
	 PcLVU7X7n7OMrQzxXGX/vG07OXXo+af9+4qhr5WEbbsPfC7TCnqz723IDJw6+H/xi5
	 He8cC/ynt0v8Su7dIv02xiS8jgGIHju1Fo/q7jqytfPzbSBCeQhCpky3B+qzJzxR0Y
	 ZthaISrfyq/4JiRoDoESeIla+5W/M1WRF5IChJcZhkyOZq1yP/WKGz1VzSS8HUUYXu
	 YAa8G5p3p1GDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE094380DBEE;
	Tue,  8 Jul 2025 16:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 0/7] audio/avrcp: Fix crash with invalid UTF-8
 item
 name
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175199220831.4128987.12077387745459517982.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 16:30:08 +0000
References: <20250708154308.238963-1-frederic.danis@collabora.com>
In-Reply-To: <20250708154308.238963-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  8 Jul 2025 17:43:00 +0200 you wrote:
> As stated in AVRCP 1.6.2 chapter 6.10.2.3 Media element item, for the
> Displayable Name Length property, the target device may truncate the
> item name:
> 
>   Length of Displayable Name in octets. The name shall be limited such
>   that a response to a GetFolderItems containing one media player item
>   fits within the maximum size of PDU which can be received by the CT.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/7] shared/util: Add strtoutf8 function
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0440ca68a8c4
  - [BlueZ,v3,2/7] audio/avrcp: Fix crash with invalid UTF-8 item name
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=89079f2ca635
  - [BlueZ,v3,3/7] audio/mcp: Use strtoutf8 for player name and track title
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a8f59849253d
  - [BlueZ,v3,4/7] audio/gap: Use strtoutf8 for GAP device name
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a0387d66372b
  - [BlueZ,v3,5/7] eir: Use strtoutf8 for device names
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=218db700f493
  - [BlueZ,v3,6/7] shared/ad: Use strtoutf8 for name
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4cedd8d19ad5
  - [BlueZ,v3,7/7] unit/test-eir: Add name encoding tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=004518d061d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


