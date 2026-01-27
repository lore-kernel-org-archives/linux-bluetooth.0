Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD94192B75
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769538627; cv=none; b=GZojXLQq00Tvqna+C84NzOsbUN56jt5Xctur06DoaIHVQFwQngGKdwp3mv0wuLZqVWNdpmaaQ5g2FBYI73Teof6IO6VucDFudZ83R6hQoenW07tRXTnDAVKRqag8K2kfuuHP3zvjKRS9WtaYioG074WQWRXLgNRx0W/mW8ATLFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769538627; c=relaxed/simple;
	bh=GyXHSdLfzV6AiykM4f5FdUXrlyJi4bWindaaUipfKgU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dcUQkkOosQhbPagshA9OpWRmDkZSD79hEP57aHPob3a9LxhWAUJ3JjyUcGTjKcyBAMCWvyjTkVk+F+nZSBVvb2zeKtZeMPV17nErTHBeQVjcVSsfx3VOuRNh7yPOOIQ89RVmKvjb6S4j1sqTBqvAjp2veEe3cDi9gen7NlOE9YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5ixGZzv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5ixGZzv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F47C116C6;
	Tue, 27 Jan 2026 18:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769538626;
	bh=GyXHSdLfzV6AiykM4f5FdUXrlyJi4bWindaaUipfKgU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J5ixGZzvJeC2EjO4j8wyCweuXu+Va+NTclScmcOPRA8Z/sufdDTonOa+qVjXrRGPa
	 SAmfo5dOGEtAfIKmEImlxVUyzCDcDcm0EkSWNyjuF6YCUOaVU5SuN+LNVwhfyol9Bz
	 FlnO7Pva3kBaG5S1J5Gb/DTtTPRAkgG1kaqHppgPjeEHszZzkhj67lp9g/BH+U4chT
	 rQhwGZrqcUk5RvxjU/DdDkdW++CwczYFBJVv9G+tfOvMBvA2jxyHebe5ibmFlkIAq9
	 4aK925N759U+3v/WT10cDOBYCDIg3/Kof407upQwSsU7sMQk2a7/RoSQ3FkxveKJDO
	 pDBxMhY8/HIww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 119F7380AA58;
	Tue, 27 Jan 2026 18:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] doc/qualification: Add PICS and howto for the HID
 qualification
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176953862084.1352702.7144867031499137784.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 18:30:20 +0000
References: <20260127171208.151197-1-frederic.danis@collabora.com>
In-Reply-To: <20260127171208.151197-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 Jan 2026 18:12:08 +0100 you wrote:
> ---
>  doc/qualification/hid-pics.rst | 385 +++++++++++++++++++++++++++++++++
>  doc/qualification/hid-pts.rst  |  61 ++++++
>  2 files changed, 446 insertions(+)
>  create mode 100644 doc/qualification/hid-pics.rst
>  create mode 100644 doc/qualification/hid-pts.rst

Here is the summary with links:
  - [BlueZ] doc/qualification: Add PICS and howto for the HID qualification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d4a8e19cf911

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


