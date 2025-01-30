Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A008E26289
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2025 17:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258209; cv=none; b=qA9OT6tbP0FSv63IOgBcnwltfVDnhdqJpmVuA1xca3Pg8HaH54YRqVZRWTihqCN3OcjwevtagIOmGQzBKTgSknv2JhlPJCYQZxA2Meb+soHzfMaAA0U6AAX1CQNbJdTYnenburdbT3n/DROUVrxYypKsSVfwhC6jPkwBkuISA1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258209; c=relaxed/simple;
	bh=uOBc8kvEazesDsscvx/9X0gL81m8ZmNNZSAE8+KlUQE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Iff0p50gCBkB0DA5IwGZ+58g1JKJOSXt2Pq3aOCH1YTXdXgC/DwSKS8pX9HL2az9EEcEG71GAftV5DJY6HvZ4f0gQDMdNmZYA7DlfM7NcAoTUTX8bQi4veNjobsXYV0jVK5SCqYOhA9331DD2dSXmZ19zUNjMcPVT99S2ImOzcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eppWZYGD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eppWZYGD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734FEC4CEE0;
	Thu, 30 Jan 2025 17:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738258209;
	bh=uOBc8kvEazesDsscvx/9X0gL81m8ZmNNZSAE8+KlUQE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eppWZYGDhtQyKPxHoh8tFFaxAk+zFYYCmfh1gPm/QMyHtDCLwM0g9h2J6wVoVRF8x
	 ObnVRwsfpROwn6WFhe5jO/6pQk7v/3h3xitaBKXWWwhY1RZVKaq/sVq77rNtQaQopm
	 6No3sUpLVCRXRhWW178p4mKIcClFdP1luF5nS93DfxO5nblh8fLtuTUY5A9UVeiOJ1
	 jVWxqUJNBWrvJGN90YhNGM5XNOAPKQyJ6qcvzxQVVQXyIHTHNIQ90iTOr9HTXfEl+D
	 wjdt42WSXZqZY5HsLJyh74yBwZGTDXQY6w5gMeH/9z6TtOXIeqwypMe/ZybDVjB+mD
	 IloCC+fpwNAKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB01F380AA66;
	Thu, 30 Jan 2025 17:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] adapter: Fix the pending changing flags check
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173825823574.1027237.7527692382563822043.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jan 2025 17:30:35 +0000
References: <20250129172316.329330-1-ludovico.denittis@collabora.com>
In-Reply-To: <20250129172316.329330-1-ludovico.denittis@collabora.com>
To: Ludovico de Nittis <ludovico.denittis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 29 Jan 2025 18:23:16 +0100 you wrote:
> When checking if the new desired device flags are already pending, we
> should compare them against the XOR of current flags and desired flags,
> i.e. the flags that are going to change.
> 
> For example, let's assume the following situation:
> - We have a device with `current_flags == DEVICE_FLAG_REMOTE_WAKEUP`
> (i.e. 1)
> - We want to disable the `wake_allowed` property
> - `device_set_wake_allowed()` will call `adapter_set_device_flags()`
> with `flags == 0`
> - When in `adapter_set_device_flags()`, we'll have:
>   - current == 1
>   - pending == 0
>   - flags == 0
> In this situation `flags == (flags & pending)` would not return what
> we'd expect.
> 
> [...]

Here is the summary with links:
  - [BlueZ] adapter: Fix the pending changing flags check
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0acdf186fcde

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


