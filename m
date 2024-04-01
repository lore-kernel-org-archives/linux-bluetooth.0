Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0075541744
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980630; cv=none; b=Vm6EW5qjJSTxmYZGh+thsT1b+gawZUH9P3lHBVXZk4bVjymUAlbeRO6uCZTMZ7ffgHClgl9/Ll18gKy9Xb8+VKtu3g1DyhnX5wneJMBS8j84yHp7MEMuAz0ghkfY+dx/ddRAXya1e3V/gRtMa+edqvYGGWJ+kDwW+pd7ibCqgCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980630; c=relaxed/simple;
	bh=tfNElKl0tG0nuaw7xwgl8DtVDHOE8apcAJxPxn8TyI0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GnVGQXSxEuWYVmdwS1SBvzvjB6LZaBCpszI9FY/QSgLt1smY47RwZpZ/AZHode+vMOxsqWI+OxQA2rDR1aBm1pMmUu63osEShKpWKLfCGJpLQmTAPt183anX63A/+8ZPIFPAuyqNeiqhRnwRmuEBQwdd5gHDlUOOI+hynGoAVHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1piVNtq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1piVNtq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B0C9C433F1;
	Mon,  1 Apr 2024 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980629;
	bh=tfNElKl0tG0nuaw7xwgl8DtVDHOE8apcAJxPxn8TyI0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m1piVNtqO9kRTyvSN8JosMhjJL2R3JibukoPG//0VlxSthJaEnCI7jJJZWVRQDG/O
	 W0KrsSoxxt8XavcHrBxJF/4o1Bq1skzjLmvBBQ1rEN5Kt5Oj8zLZsz9pOU1x74sno2
	 SLZXik+BuAJRALfPajUXVvTeU5gSX1qUmZ0+y8XKuK6DS2NyRiumOsP3zd+aE4LRsJ
	 SXhJbSleeeGLIj7Gxn0njtNRqiYWsAwottelZbx6K+SYX2xqOrQRWjYrJqS0vYQhMB
	 tngRzep6h/5MNk2AATJxBHZos91bT6jw1mKVLqoRaAGlQIWTEN7t9opFgttn1y8XK9
	 bwqfNxx7vp1PA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C235C395F6;
	Mon,  1 Apr 2024 14:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/2] Bluetooth: Add proper definitions for scan interval
 and window
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171198062957.26711.17394152526175013459.git-patchwork-notify@kernel.org>
Date: Mon, 01 Apr 2024 14:10:29 +0000
References: <20240328201554.1791904-1-luiz.dentz@gmail.com>
In-Reply-To: <20240328201554.1791904-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 28 Mar 2024 16:15:53 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds proper definitions for scan interval and window and then make
> use of them instead their values.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1,1/2] Bluetooth: Add proper definitions for scan interval and window
    https://git.kernel.org/bluetooth/bluetooth-next/c/3fa47b12cd09
  - [v1,2/2] Bluetooth: hci_sync: Fix using the same interval and window for Coded PHY
    https://git.kernel.org/bluetooth/bluetooth-next/c/0d5395c0c5b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


