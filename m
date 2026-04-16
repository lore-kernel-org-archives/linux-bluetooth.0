Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC8A3A16A6
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776356439; cv=none; b=p7XAC5iNIIItBgSIl8udKlSyGYI7sryPP8AOi0W5VUu7F+fEZn1Fi1D9OnIhOvviQ1MOQNOeYSARo/qcOUYKkaTQDC8TSPmVmlt0djj3aBw4J7EbHbF6ohx6Y57+eGFjZidiKq4Havbmfc2g+NFk/GUq8rsPlpypTEKNuTVmB4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776356439; c=relaxed/simple;
	bh=hZ/yqX3RRBLGEo1EAJbjQd0eE3PoLWcICRsTDev96Yc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l2K+wlhhgmRNrmtSUyeKqhB+PAceWuyhaUo1Nh4aypKEscyaIePis5EUMC7nhXeAgkbbxm2mRw6ptoWRRJwJNKl5fiZH5R8UwSrNRVukusdt2uBdEB/EV+YaPasdfgWXzdHVws2LL2H1sd4YGWvWmM85UfI+yMKFTEH8NSyJ+6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgffAAAj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgffAAAj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D18AC2BCAF;
	Thu, 16 Apr 2026 16:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776356439;
	bh=hZ/yqX3RRBLGEo1EAJbjQd0eE3PoLWcICRsTDev96Yc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bgffAAAjB1uG08qknoHEbh5oKxT3aDlb53nKRnodBzjS2uvEHp2Kaipl8d1+/h3SW
	 N0rUvX6/ouq2GMp2Ee0BZYLe+ksxph5Cpzfff1NAoV7gkOomw/NX45Ff3KhBEqfo3K
	 3rXBOGbv+NutkIFAaSn4jVhgSc5v9pM1rf53OtXN7NuyfJSn5LndK9SudJOHi7ygW5
	 qAz1vAOMhyyYIyl1PiFPUBGgEO63gEITUzQe3uucPzKH3tS4FYbdPNxi/7i4RgJ4VS
	 hDmb3mN6cmsI9pjNs0oTuUwR5/bMF8Z9VUikZgdzSjCCxFZfkHxdxDT3iFhNMj5g4N
	 9Hg8CAlMCLmxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCFD380AA67;
	Thu, 16 Apr 2026 16:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Fix null-ptr-deref in
 l2cap_sock_get_sndtimeo_cb()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177635640779.3303094.5370541470219166904.git-patchwork-notify@kernel.org>
Date: Thu, 16 Apr 2026 16:20:07 +0000
References: <20260415205344.2368172-1-oss@fourdim.xyz>
In-Reply-To: <20260415205344.2368172-1-oss@fourdim.xyz>
To: Siwei Zhang <oss@fourdim.xyz>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 Apr 2026 16:53:36 -0400 you wrote:
> Add the same NULL guard already present in
> l2cap_sock_resume_cb() and l2cap_sock_ready_cb().
> 
> Fixes: 8d836d71e222 ("Bluetooth: Access sk_sndtimeo indirectly in l2cap_core.c")
> Cc: stable@kernel.org
> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()
    https://git.kernel.org/bluetooth/bluetooth-next/c/4ccc9d270c61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


