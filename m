Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717A513D52E;
	Wed,  8 Jan 2025 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736352613; cv=none; b=s1qUoMgLWP1KDkMdRQpNxiihbIN2VFjI/VW9BQw24ZShfKQK71Na+1p6p9oTsifWzG+/ObLkMXsV/i6KUxHf2aYFHVN+JgHUybdWFEv4PghJWOI09s1Y1qP7Y4KCoR/QI53sHieh1lmkJ5XTlDIUg+Qjli6KXTv5x3ZkUoMI8DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736352613; c=relaxed/simple;
	bh=vibiuSBXQh+mtyZYIquCFY2Yb1OeKm3U8NsD4AEMBM4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q1F18SpLrphPVC3c36In888gtumbo6Jh/kniRIlrsJRlHHcOK28zH5xWIdqQUFciq0aLJ/lI1fiWbqMHVnSQF9VdV8Icb0uTi8S7JTfGLMBuqDTowLbOPpyyWZUYrFLdS7Hqw77GZ8u1NlDYHTHHfHRI/p3DeUmjL5HGwXkhLhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehCwwWEs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehCwwWEs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0395AC4CED3;
	Wed,  8 Jan 2025 16:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736352613;
	bh=vibiuSBXQh+mtyZYIquCFY2Yb1OeKm3U8NsD4AEMBM4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ehCwwWEslvVclQdLSn5B7Mp9emZn8Qz7gkjRIBvuz5P+143SVB3Ja/i2n4Hhn9rQg
	 QMO+HrZwJhXpU32wMUSqYgkBjZcaHRPt2AFfK4mEHIH3ZA7frcSr4nJZ1fUrhAeRpO
	 8d8aHop72dqIlDElBTN47Hm9sX46JxFINw9RaKHYlD61SCEv17PZQ6tsfESQQcJ725
	 /CWI27x1Zm3WTRcJ3KT58UZLoA3Cf49WpbmWgva9eC1HscfhLwP61RG37DSHt+Evcd
	 ZubJLvrM/tScxzheLoEuxy4FHVok6hqGagdcJPYWZKmDDh4/Q127pQKA8IDkZ4gYwt
	 6UPV6xgp3tImQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE98380A965;
	Wed,  8 Jan 2025 16:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btnxpuart: Fix driver sending truncated data
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173635263453.697160.15946263371531689963.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 16:10:34 +0000
References: <20241220130252.1903536-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20241220130252.1903536-1-neeraj.sanjaykale@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, ilpo.jarvinen@linux.intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 amitkumar.karwar@nxp.com, sherry.sun@nxp.com, ziniu.wang_1@nxp.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 20 Dec 2024 18:32:52 +0530 you wrote:
> This fixes the apparent controller hang issue seen during stress test
> where the host sends a truncated payload, followed by HCI commands. The
> controller treats these HCI commands as a part of previously truncated
> payload, leading to command timeouts.
> 
> Adding a serdev_device_wait_until_sent() call after
> serdev_device_write_buf() fixed the issue.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btnxpuart: Fix driver sending truncated data
    https://git.kernel.org/bluetooth/bluetooth-next/c/fb966c19be55

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


