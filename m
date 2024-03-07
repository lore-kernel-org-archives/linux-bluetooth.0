Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E170012D202
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823028; cv=none; b=IHWdDNQ9L1QgeRtkfbh0i5W78U/LnSJvcsHer9okdtk65nHZ8jVTAGirtFOpWMv+7jDFz30hpCrqFXcWl435F6Z0I/I7vVnB3+tNHS6PW9ImmzVENB+xQ46XOKuO56vu7S14vWUWwQ7WnK2k0xI6dJDy3eRX9xVv4hiUGP0S5LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823028; c=relaxed/simple;
	bh=dodLTi9AmFQICbdl+VQjk5tpqDr+I9nirimRVHcnV7s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p1//MrGvwh4yqnrwG5QOKfum3E2ETYdktCm0SxOlWD1NmwPWSrJf3TedbG97+5fW2Bt6NlKzRwhPl2cREQ4piYvRzfUEeAVvAcnLEOqds1/Htiqyxu3zjZ78P+LtaDqQgMJvK4t3+WoxbAw0OdcHAZ6eLZPv78kKAWUF5Zn7PwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHDsBYpL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHDsBYpL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5994C43394;
	Thu,  7 Mar 2024 14:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709823027;
	bh=dodLTi9AmFQICbdl+VQjk5tpqDr+I9nirimRVHcnV7s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pHDsBYpL30VHI4e/ba2kBpxndOtorNdf2QYegcNkge/OnMYD8u1w8VmOv4Vl8djjt
	 wqdlLdV4xXnLxGXttiZWD0LRQnJShWum3mpAJG1zAIILgAR3qcqBu6sfPbaF++1Mhi
	 Fku1aHwMFP/6DjUruPGEithD1XReEUrbDyDzndAlkmlHb4gMRv6UAZ4DkMbGnxMsVf
	 HQSIA7WTrNgokqWE6lnr95DibFCc5rKdyJQMO6fiGeUnNaLimplm1HgQaTUV9m0Qwa
	 hUCeQkJYXTqxc7DATJpyPKKZoEmQJVoNy8k/c1yYl41GOrgcT9RFcVRNxG1unaDUVu
	 Q9GWpTBQqtTvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 922E9D84BB7;
	Thu,  7 Mar 2024 14:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] shared/lc3: Add definitions for Audio
 Configurations
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170982302759.12145.10573223275807416999.git-patchwork-notify@kernel.org>
Date: Thu, 07 Mar 2024 14:50:27 +0000
References: <20240306230440.3983598-1-luiz.dentz@gmail.com>
In-Reply-To: <20240306230440.3983598-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  6 Mar 2024 18:04:39 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds defines for Audio Configurations so it can be used for
> upcoming tests.
> ---
>  src/shared/lc3.h | 482 +++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 401 insertions(+), 81 deletions(-)

Here is the summary with links:
  - [BlueZ,v2,1/2] shared/lc3: Add definitions for Audio Configurations
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a070ceac6ba8
  - [BlueZ,v2,2/2] test-bap: Add STR sink tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2da45fc7e2d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


