Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A6A1AC8B8
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Aug 2024 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737635; cv=none; b=aEem+dTEKWyx9dRyByWfuhG/P9BNL/3Ip+Ayg+63Yry63rIEyhN2iRmN+V4auzAxWTCFZDFBr3OGtf48yIWgYVTwUGxDf9vzfRvg8zv5rXEnyaL00bxJ6LXZdSybEK1lY1hz5lP0f9um0Yw2vRsV/T25TFCfexOIYXsyotxj7C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737635; c=relaxed/simple;
	bh=RrisE5fJgRSCYhreOunMkD4OesirR/1aeKnGw+eY0u8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gqGXM2471QpXfATBIL5oyfoZ2YNmogOGVX5KFZegefZkH+vSJDoVfmYlesVI6fPJGlO3Knh49+jby8hWIOlwyDtlRJGkYPYA3JnzcWQBpOXlmj3/GgD65Hx/5NK7waMmSFAdVNNUB7SkOaZ9c8YR/929HbFATsQB44A9m1Sx17Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoTR3VdS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoTR3VdS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE9CC4AF09;
	Thu, 15 Aug 2024 16:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723737634;
	bh=RrisE5fJgRSCYhreOunMkD4OesirR/1aeKnGw+eY0u8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LoTR3VdSswuoLelQDiARcfVyo8v6VxrKi2vYw5LOOE8ZqxzaZn1yYoSN1w5NKbEKx
	 4NfT1tJcoU58HxoobzgrDzWX0LhREjNlOLbTdgoYpg3/S9cmHHoJtRajad6k5M/Y3Z
	 OA68cuX7yap+RBr8RqZxqmw7LFcvzP4Tv/8N3UoPeTsEbfXl1smVuaw8jwssgh+ysK
	 zASMLK63w5vZnMAClgXSBDSoEBLQqGHOGKB01y4LFvE5FvPeect3jkM1CbFEziRugZ
	 9btHfX6PLcYeM3fBnMjVgpg3d2mbtONh7ILH+jE65adXOGbCgJ7H2copLY450C0pNJ
	 HDFLDACml7dYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4A6382327A;
	Thu, 15 Aug 2024 16:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND v2] Bluetooth: SMP: Fix assumption of Central always being
 Initiator
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172373763376.2896787.13638051156512693130.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 16:00:33 +0000
References: <20240813144559.529786-1-luiz.dentz@gmail.com>
In-Reply-To: <20240813144559.529786-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 13 Aug 2024 10:45:59 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> SMP initiator role shall be considered the one that initiates the
> pairing procedure with SMP_CMD_PAIRING_REQ:
> 
> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 3, Part H
> page 1557:
> 
> [...]

Here is the summary with links:
  - [RESEND,v2] Bluetooth: SMP: Fix assumption of Central always being Initiator
    https://git.kernel.org/bluetooth/bluetooth-next/c/a7e36fd74c87

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


