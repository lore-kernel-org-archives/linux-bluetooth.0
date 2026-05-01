Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984702C030E
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2026 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777644651; cv=none; b=kc4PIuSu84VfeuspDCaZ/WeqruqXrk03weiEaEoGlLSrwcdSnRwrZYZ2MtqjhzAqcXRdoWRPdPCr3JYJlBfdEeGJEFzkqRDmoz7ceeYfwd8pNdq11f24SGdcIaZ1rPd3zv8iIylpzo2GDAhj0WjlYvTYy0KDQzk8kjNr0ZDkTlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777644651; c=relaxed/simple;
	bh=EL1Sualnhz1fF+nkObvI7bRfswHCNhvdN+kJKcayR58=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D0YDzoMg4tzqtr40uJ+/GI3LjkmaSsglWw1QUR9gHAu34PnGY0fgDetgw3NGJQe5+Tn7tdUa/t8po+uBCYwOLLMNA4LgFh7NLPOWz62ozo3gonRqT4NbevJJ9OqtwcjbYY6iShdyD5NT5IBi6/gulCYKxn7hfVht/9Jz5HW+ZYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksDxmK9y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksDxmK9y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DD1C2BCB4;
	Fri,  1 May 2026 14:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777644651;
	bh=EL1Sualnhz1fF+nkObvI7bRfswHCNhvdN+kJKcayR58=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ksDxmK9yG3gWxG4iXUJ747PIjVkJwUNxx/FIS0bN4HF0Zn3+DT0fz96RuRl8VHeqF
	 vPDKbOpYv+C2dcdaHpSDVaQS1ylPL7Cu89oTrYtiQ96D1LqRIOfw2hTTzClfQy1c6B
	 uX8ZEmKPjxLo5n8aiX5B1MfZ+QGGgpMK0fCxF4k6Rs5MYHC3XDXlgHcTURNvD9GFRf
	 ckShshpMyIiSBJPsBkjrRpBT+vbjUzB5UI5kU8I52W9gEDRgfxkTugKF43Rr9N6Ihn
	 +fjXgrXb8AZd/ENlh1C0lbqfZ1e9Bz2cpz00yhjlafNQK7/iuc+nMARNinmCNP5CDA
	 zPiXtvmKbn2AA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D25380CECC;
	Fri,  1 May 2026 14:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] shared/util: Add decoding support for HIDS
 1.1
 UUIDs
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177764460455.3493702.9637050673745875718.git-patchwork-notify@kernel.org>
Date: Fri, 01 May 2026 14:10:04 +0000
References: <20260430195114.608794-1-luiz.dentz@gmail.com>
In-Reply-To: <20260430195114.608794-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 30 Apr 2026 15:51:13 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds support for HIDS 1.1 SCI UUIDs:
> 
> HID SCI Mode(0x2c39)
> HID SCI Information(0x2c3a)
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] shared/util: Add decoding support for HIDS 1.1 UUIDs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2128e1c73ff0
  - [BlueZ,v1,2/2] monitor: Add decoding support for HIDS 1.1 flags and attributes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=31e4fb1498f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


