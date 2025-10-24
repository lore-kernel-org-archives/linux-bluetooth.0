Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8992F4A04
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337827; cv=none; b=XgmLilcNdV2DeHduRC/Dxu41OcDG47sUlJqiJh1T6sLX/J89QgfUXhUESh+5CQ49w/O8gDJLAQn4rDow14ga4L2kj464FydUq6/pXVsCGphv4I7s1FSV8l6HtvJvKqqUphYkzxqij7i9brkPdkTb34pU+RZLxbSTJDCJWhIFiws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337827; c=relaxed/simple;
	bh=m7p63WjSZNB8N8VJ6H9RXclYKUDunvP47c8S02jwaY4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uxdQpUbZkGXkiDBdEoWDZBAts9yTyW+m6e/MC0Kz7rwJ3/dYMzwiHpKjsDs5ZCufN3fE65xwA3OiUyI/GVCBEWrwyMwxxNNZiLfCycxIwXaYscYlC5NY8YS9NZ/PP3I7qJ7z7A2nRCIwryPRl3VEuRiRxJ/UajbjqQjNaFeKhF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsqFOaP+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsqFOaP+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD94C4CEF1;
	Fri, 24 Oct 2025 20:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761337826;
	bh=m7p63WjSZNB8N8VJ6H9RXclYKUDunvP47c8S02jwaY4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TsqFOaP+IhUxFjVOOrQrnjKPZ4msL/DhM8I7sANKtLUklyFzyiCuH7ZfrG4Ah/5gv
	 15ih345L6jr0L3elWn0AnDgM9qb9T///lssjnGZQEH893RTFMfxIEEUY0yvOmy4u+B
	 S/6f3uxza2C5GB6Uup3tvnlf3u1/3h5C2PAFELOGPT7yHUSGFsIxRzGvUh7bmvrdq7
	 0Ge5XrpBxLMM9vXruHU1BHGSc3XhCtARCWSqBPAX6sbup5Ep6jrFDDp61nBD+fkI7P
	 KduoI7axutccETC/hXLQLlr0lW4SdaClQxWvmSuQpyh9FqHVzJ5uPcRVbAUxm38kJo
	 chjqgjJ9Ludzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE235380AA4F;
	Fri, 24 Oct 2025 20:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] bass: Fix handling of BT_BASS_MOD_SRC
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176133780650.4052182.1526099593126012566.git-patchwork-notify@kernel.org>
Date: Fri, 24 Oct 2025 20:30:06 +0000
References: <20251024162553.469037-1-luiz.dentz@gmail.com>
In-Reply-To: <20251024162553.469037-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 24 Oct 2025 12:25:53 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If BT_BASS_MOD_SRC is received and the sync_state is set to
> BT_BASS_SYNCHRONIZED_TO_PA it doesn't necessarily mean that the device
> shall be removed, specially in case the assistant and broadcast source
> are the same device.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] bass: Fix handling of BT_BASS_MOD_SRC
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=81a995932768

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


