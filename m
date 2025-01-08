Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4B5202F8F
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jan 2025 19:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736364614; cv=none; b=B+UrO89+LljWIO5+2NWSIDOj4QIxH1DTJuiNPrtwkJ7PifrFWlJVEWjsNr3sCWchxZ461pQH/lIAkq/mSa5C4eIdiOZXAxgrOiCsbCabRjXIPpMJtlxOb18VSSaBWzMEs75zBH+7AAATF0YQVzMkzt5qG+MpIvUv5uXCB5xb/2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736364614; c=relaxed/simple;
	bh=crpKHDBXad1HU/UzRBXwe5SUcuCcgMVnvmhho68XyCM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZDt+002dQ9c1fuu4FVPZBUWcjp7pf4IJj/RdxBH5WSZ1yr9bicZHakZ8v4SZekNkJzsXhFJcikU9al+mrZ8igmby9eBo4TIOLZbx7Kdcgki0BroBYFVGkMNIZRW+wUL57VzbMB8BXOhUSsEeeSOEG+drc05pIWQ5hFMb1Kx61lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDUzYr3u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDUzYr3u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17D1C4CED3;
	Wed,  8 Jan 2025 19:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736364613;
	bh=crpKHDBXad1HU/UzRBXwe5SUcuCcgMVnvmhho68XyCM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FDUzYr3uToxplf4HGuP8DyaGXaYPmXwUIfo+y5GKsX89xFVkjBoeIBaJUtVr3LzQt
	 yK8sCBYfXy57l3rMExg/faUjtl476pk2zP8yvS+6RjnyJmvGfWFGsStRWPKcmfyuaX
	 r8iPJei1Q5NVMp3VUeADE1iBHSbhBdXitOdNeGLxmhR9sExMe+UYwZbE0a+Ljl06Bn
	 3sp51zVgZRjpzIn+WmgIH57QraoyiEvC0+yDMNlLuIgkaH1niLZyN02HWWZprh0irU
	 2D3x8/wmZwtg/o7czypopvpQL1FKJO/KBRvo6BoA2aDg8sZ1y1fRUu4dunxVRFbZKr
	 UdzhWp8xW9uPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB39380A965;
	Wed,  8 Jan 2025 19:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] monitor: Make BTSNOOP_PRIORITY_DEBUG the default
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173636463548.754812.480434901029471908.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 19:30:35 +0000
References: <20250107173542.1449444-1-luiz.dentz@gmail.com>
In-Reply-To: <20250107173542.1449444-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  7 Jan 2025 12:35:42 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes BTSNOOP_PRIORITY_DEBUG the default so it captures debug logs
> from the likes of bluetoothd which is very handy when debugging problems
> as otherwise the logs have to entered separately making it hard to
> figure out the ordering of the messages.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] monitor: Make BTSNOOP_PRIORITY_DEBUG the default
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4fa24e6583a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


