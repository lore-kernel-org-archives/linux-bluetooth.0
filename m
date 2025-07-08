Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C781E49F
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752001183; cv=none; b=UEANVW9RmEpkQoy8y9aoOp9PD2StGJ5wHneU4RNmUsBqYdTbq4NReg1b3OXFo1tLFfIdZkeem6XJ+NQle5p4NmNT4+G4B2lXCgBMELK7Xa1iNXEAfynuuf2xHsZ7bGQ7oOuOVb8wEYZsRpimL6tkoPtkIymWTZ5SReaZKncqUhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752001183; c=relaxed/simple;
	bh=62EVR04xos5mEQBgwSXVsY435meS8ktRTmJbhkTrc9o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ocb495f7VXZuTUVaqqpzfpDoE4zsreG1eKJaM2QBz6PxYiwywlBnFMy2i4t+wVeSArIPfuyT3VBQM7/zBSOdR2kpXEP8TePWtXKVsvowjJLKDCFzqsGLY24T+K0PJ+rGRakNdn/AxJpiQ4fzuWG3P5R3TjSVzNOtHN4lOtdr7G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D51XcCLf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D51XcCLf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994ECC4CEED;
	Tue,  8 Jul 2025 18:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752001182;
	bh=62EVR04xos5mEQBgwSXVsY435meS8ktRTmJbhkTrc9o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D51XcCLfwkm8lb6Z6NpiS2dmnggTdNv6PHjNBXO41oqKf6hcW42WQQkwWn/Wd9/Ch
	 wAIYR3jsm/GISimykA30A60d0Sj4qwgN9JVFAlmOY0zvcLo0PT0GIrKOT+csGWuHZs
	 fQwj1i6qCq6qYlS3xswPVwh5yv4Ic78egj8HnQ2OVwy4J5N/VDPQ+au+8oOsQDWV61
	 aN9D4/4tl7qV3bNXbO5pRGgopWjJnJDju6ijXbC7NuD2+5hKLA5JTf5gW8+aoisMrV
	 /AbCvST+fL3qLcD2B7Do9K9WIAoZfaDO2ti7r2cElj9iyRyIAJJnYFSzrsgAy0Cg+W
	 y7CTx3yGu4U0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A50D7380DBEE;
	Tue,  8 Jul 2025 19:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] shared/shell: Fix not running pre_run on
 MODE_NON_INTERACTIVE
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175200120562.4173389.119619224395979926.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 19:00:05 +0000
References: <20250707142350.2404116-1-luiz.dentz@gmail.com>
In-Reply-To: <20250707142350.2404116-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  7 Jul 2025 10:23:50 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If a command is given to be run in non-interactive mode the code would
> not attempt to execute .pre_run first since some (sub)menus requires that
> in order to properly initialize things.
> 
> Fixes: https://github.com/bluez/bluez/issues/1394
> Fixes: https://github.com/bluez/bluez/issues/1317
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] shared/shell: Fix not running pre_run on MODE_NON_INTERACTIVE
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9ed79eedc075

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


