Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54881266569
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745435389; cv=none; b=T1v2i7DSgVnBSJWm2/daYpmOTPpWgpLx+DEHqkPRRp69aA7cVVJs13WIx09rybx2RaghFATbuj9K9+x+4H5SyQ+PPtB8CA2zBL8F5A2JzViwp++0KHKC0ly8a0/Et0tDK1cNRuY6BkxdNObrHOyHmgiUaqzIw4nsONn6tZGdV3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745435389; c=relaxed/simple;
	bh=gvU4KoC0GZJD2eDcQUrqHcZt28Gbz9ns+8IhuMSpCyU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mAhZAMP1gx0m04wI/ywmJjei4pwNxtBWqXCDY3iOzkB1789fxFZTFbJUn1qxMBJdy2LrAOvfFJH53Yn8pWn9uVnO6ZME0FHWw35oDNM6SsMA2ToXJ3bzCQak8sF0Fyc4gko57HPTCI42LMFtqM5MdZmYiZPHeo5MiJFhkPP4jjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/aj53e7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/aj53e7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AC6C4CEE2;
	Wed, 23 Apr 2025 19:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745435388;
	bh=gvU4KoC0GZJD2eDcQUrqHcZt28Gbz9ns+8IhuMSpCyU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c/aj53e7FLR2D4/Lopcw88jEIQHqZmi1ei7WaHrR7bOG3HhNLSNWI4n9NKS9gz9u1
	 JxScBR7uel/AQS6DH6QWnmqsoJR4Mu96FgGj+FlRrPGE7dwKHZEaPPndyPjZvzEr2m
	 bQItJY/PKhx/JKgjJR/RyIHdtlM9EKpwysbKjtUNKLDwyeeU5Zm0kzlYNz1xDnuKei
	 UyV9LqQckAeXaDXc8Ai6WvoZbqUcIfuBCEuCUfeTXT2XKICGbbpG8CR9FCxUusMjqh
	 tOkSiFcnFVOutgUmJePKiU5+XqoQnD5oQ7ZZRyjfs8BFgbKZKtyqgLhuh2vRR0+OiX
	 6lo9eoog4f/zA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BA7380CED9;
	Wed, 23 Apr 2025 19:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] workflows/sync: Add Cleanup PR and Sync Workflow
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174543542725.2741026.4025376279006650553.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 19:10:27 +0000
References: <20250423185951.1171350-1-luiz.dentz@gmail.com>
In-Reply-To: <20250423185951.1171350-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 23 Apr 2025 14:59:51 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds the missing tasks of Cleanup PR and Sync Workflow which are
> required in order to properly handle the PRs.
> ---
>  .github/workflows/sync.yml | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Here is the summary with links:
  - [BlueZ,v1] workflows/sync: Add Cleanup PR and Sync Workflow
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3e9827d3a672

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


