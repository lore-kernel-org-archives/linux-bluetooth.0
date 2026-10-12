Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145EC4F30E5
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791841819; cv=none; b=hWm+LCv8nQ4q2S8yfhduPbMuWbiiNTcCxIHLRdw/TLYu1+By+CJNwQQzEPJddnXIVVQ6RvZRveD+PAa3BlPm3QGswOc/IqEuLt2jSd1tn0bH9Hzz9UmAjQVkW45PXowwWLIn/0dtoRKfbIDsea3FRKWmuYX3m4htf5XKrGmCtiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791841819; c=relaxed/simple;
	bh=8gv1p6Qb66Z90fQ639wua9aZ9MNT8aolrqBKct9YlYg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RUpeNuRyKXMclEV9G1j1b9ndEDXfhVmSrTTPeh8PZCVghLw/257RXRaum4ecdsI/CR3xb8sm9qIXJ9NWGeJZAqHGg8eJ24Vs7yGuN8KtJDYJVNb8fo7uVwMzxU8/RLvsjNVwLgfq7hU6DcZo4vG4S3LnaCStZlpC4OKnCw2uLp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlvVmrlF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlvVmrlF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439561F0089B;
	Mon, 12 Oct 2026 21:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791841811;
	bh=+7dKLWTHmCcaJVu5pund3FTCF+SreFAXWt36ksj2FtQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SlvVmrlFU3doy+3LOQ6UUjIXNBnMpR6t4HluPpVakUITzALfihz5+3BKZlomXhbeH
	 TTE8ZqaLyCNsBd37Pd0jbkDp20fgaOqJblVGi31HkskbhDhbV0sg2tIi/qHAmYhVjk
	 lrvx22vAfQ5ovV3F8RaTcpvf5dWLyCn3ekiAjiVmgoXRXU80l9khUSGDoy/JShqVkN
	 ovz30foI61VY1ICMU5+oAC8t7oHwm0DgZuRIGdqzUmWlnbdNHr6Q1W1Jso3s0pLute
	 Ktiho/LyUmKjRZ/ork5sGXX/KyLM2B6z2G/6qk4oZMFTd62S9J3TN9BGTa+k4vcPYk
	 H/6JTJkkxJ9Hg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A30639253C8;
	Mon, 12 Oct 2026 21:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bluez] bearer: Cancel disconn_timer upon
 btd_bearer_disconnected
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179184180976.4115061.1271298320262675481.git-patchwork-notify@kernel.org>
Date: Mon, 12 Oct 2026 21:50:09 +0000
References: <20261010-bearer-disconn-timer-v1-1-12461fee99f1@amlogic.com>
In-Reply-To: <20261010-bearer-disconn-timer-v1-1-12461fee99f1@amlogic.com>
To: Ye He <ye.he@amlogic.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 10 Oct 2026 15:11:51 +0800 you wrote:
> If a fast reconnect occurs after a rapid disconnect,
> the 2-seconds bearer->disconn_timer may still fire and
> tear down the newly established link.
> 
> Fix this by cancelling the disconn_timer inside
> btd_bearer_disconnected().
> 
> [...]

Here is the summary with links:
  - [bluez] bearer: Cancel disconn_timer upon btd_bearer_disconnected
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1b52ab98e6c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


