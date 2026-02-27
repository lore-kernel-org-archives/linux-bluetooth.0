Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C2941C2E4
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205601; cv=none; b=rOSeQwq7stBV1QPKmNjmYjOkBHZ3oB2/jEi9knXFfRsB307YDYy8I+UbAERMAyqneX7ol6Kub3ixGZcu2KTwCLpeCaQwdb50Fw8yQNGPIBGJUPltpLGxQSQRVXQ7DlED1krZjaAW00II9FPQB/GbcWpUCBrjG/RNpVRZqIAznn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205601; c=relaxed/simple;
	bh=TFsEJlLv1y/cSN2/NAbTAHyh8fnTPLPvo64zDcV1Vp4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PJubXnI+eDFkszqW1N5JfuP2GvRKnJWwwiFZd5Nw1dr7jEp/rJzzMKn1oQrNr6WnXoGqJ/5Zh1fr+kD4/hyYwlwBh9K8Km6WBhj0eCsZ9V8BLWcGejT7nEZUaMZuTqXnPOHjXrzR7lwpdPimBvKvBqRapk3j/1pqdJ5lQ9k0K6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWW5bu1O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWW5bu1O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAAAC116C6;
	Fri, 27 Feb 2026 15:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772205601;
	bh=TFsEJlLv1y/cSN2/NAbTAHyh8fnTPLPvo64zDcV1Vp4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NWW5bu1OzXOye4dxAyO9JvLqVmGbVh0rZKS4vjSh2kB8s68u2sZnT0O9I1S0wVo8E
	 Z+e1IPUGFX1zRCi9bj2SIsiMfS6S9YnQp7HMvPhTxm8W0aXdK3QAtiBq9Kz41EdNDG
	 Tgmepvkqd6WJnBtwVZDm2Kq6XVMMyfeB+E5egqf8M4CGV8ZgrwstVK1f+0C+oGi8oB
	 FanbbpmOtDDTpNeZABg6GBNXtStvdedvPz3XnBKQdR88DQzXejKjmGAM7MJQq04wi4
	 +8rjTyES0WPfClxEua6MpeXU9U5z1YMFAB7MybWTR4IUPGKDC5fk+lXGUn5OGvtpav
	 qozO+FK07Vi7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E8539D6540;
	Fri, 27 Feb 2026 15:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/2] Fix bluetoothctl no output
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177220560479.2588496.7908037575666693555.git-patchwork-notify@kernel.org>
Date: Fri, 27 Feb 2026 15:20:04 +0000
References: <20260227112900.1946851-1-hadess@hadess.net>
In-Reply-To: <20260227112900.1946851-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 27 Feb 2026 12:27:16 +0100 you wrote:
> This fixes a regression in 5.86, and works around a problem specific to
> btmgmt.
> 
> Both commits can be tested independently using the regression test in
> the meson port:
> https://github.com/hadess/bluez/commits/wip/hadess/add-integration-tests/
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] Revert "shared/shell: Don't init input for non-interactive shells"
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b33e923b55e4
  - [BlueZ,2/2] tools: Work-around broken stdin handling in home-made mainloop
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=21e13976f2e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


