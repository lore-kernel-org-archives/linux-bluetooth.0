Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CC72063F0
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748018995; cv=none; b=CdbricIZIIzA6fk7uQwFkp7CY/R6RZ7Zov6hGixk9nkBtZ52kEvLrTQb4zPQOmxcmBklj8zP6kZhuuHIk+H1CvKBYwEqtz54GxI/GrmjPSJA8RzCIlYm4xyF3lJgojhWM9T8h+pJNBo9W0IeCkfUjQNATCQuKNjPTX1AnEM1iig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748018995; c=relaxed/simple;
	bh=hcfWJXgy0gsRlhBV/3ydinUi0n3D7G1xRMokJBmgonA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VbDNjWmzI9vGEj15+V36ambOjNmWUZfO47JJR2lifwXZ/1lZU7+2Gf87L0POa5hkGFI6zySin/sGIA9yG8qE6y+3lHIJA3oSNIAObwODrjt/fyeCxCOF4t9bcJ4COfaSMpQgUb0B2cgynrSbwR0AZd/NsQsQ1SokSLrNcKrdBI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ay/y2Ptp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ay/y2Ptp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3714BC4CEE9;
	Fri, 23 May 2025 16:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748018995;
	bh=hcfWJXgy0gsRlhBV/3ydinUi0n3D7G1xRMokJBmgonA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ay/y2PtpEDO8kwSMXWVOU3bELWMTf6Hrw2hDhuLVyady97XkE7DSxhB9iyTTZ99BM
	 qVBZ/r7IzJALeW8H2ZWnKa81NwJDYbOy+CpnIXM1aIVuEE6875qeSOEk6j1f1IRynY
	 Tcc3ZravnKMEO6ZrPzkdX8FljIgMdlAx6xZYAvd0JbPd7w5qDF8Owlsry6v372ouE5
	 75KfMnxHusJdjFeduXVvtAL25txL1ApFhKYDfEoxsxKVlufZd3cg/brlQAvPsFT+re
	 +1JTFcIWKsr6G/UhZc9Bz3KFYrRLn3RZHrXE67EHRSVLyMr5A+WEpKHde3iEFnitM6
	 blMKAdrznu+2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDEE380DBEB;
	Fri, 23 May 2025 16:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/4] org.bluez.Adapter: Add AutoConnect to
 SetDiscoveryFilter
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174801903050.3661880.14825413416870727369.git-patchwork-notify@kernel.org>
Date: Fri, 23 May 2025 16:50:30 +0000
References: <20250523142505.3476436-1-luiz.dentz@gmail.com>
In-Reply-To: <20250523142505.3476436-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 23 May 2025 10:25:02 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds AutoConnect filter option to SetDiscoveryFilter which can be
> used by application to automatically connect devices found matching a
> pattern.
> ---
>  doc/org.bluez.Adapter.rst | 42 ++++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 18 deletions(-)

Here is the summary with links:
  - [BlueZ,v2,1/4] org.bluez.Adapter: Add AutoConnect to SetDiscoveryFilter
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3a8d778b0a9a
  - [BlueZ,v2,2/4] adapter: Implement SetFilterPolicy AutoConnect filter
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=af7d5dc61154
  - [BlueZ,v2,3/4] client: Add scan.auto-connect command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=aba81b553348
  - [BlueZ,v2,4/4] bluetoothctl-scan: Add documentation for auto-connect command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c888c682fbd4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


