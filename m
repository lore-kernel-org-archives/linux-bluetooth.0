Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF0E267B00
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506985; cv=none; b=Sp0acuqcO0k+iRG3vsWj/hJQ9Yuak/6FyQYE6IHvu5jMk5CUZZhNjgoXnvgs03StlsMvfABg3YI+fLaHCuZ4SDrUvwCLDKPtqLShyZQWtHESOmy0VGaHvQY9WfPwd0jLiaHOoE6lzv2oudjEN3Gcs/MPPiTRgbMrtDrtHc5DQPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506985; c=relaxed/simple;
	bh=3Zjkh4k7F+QirDPYiqQYAcclHVE4nknNheLqr8wS7Ik=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LuWlriDWWY3OV0rdulsZzQvKPBLbUBMmHBbob7gdIekyTcfktAw4lD47cW3CpXC6XD1uEQDoOddw/Qwngbalsn4iJo8L0kaV3geqedp2k+kqfVtA+/dui0vf8JImOWRsL3e5zkjU4refbYXmzNMNkYQUVFLjsK9DmOFN1CFfwUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaLT2FTQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaLT2FTQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0619BC4CEED;
	Mon, 14 Jul 2025 15:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506985;
	bh=3Zjkh4k7F+QirDPYiqQYAcclHVE4nknNheLqr8wS7Ik=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HaLT2FTQgyX2Zgen2F4aDjzw/j2lkjzoAdPlWEpvd5BoqrUdn5oMW/rjPo5uytPa/
	 3ODQeEyklbvWcxWTVrvywItLXWASTxCD6TnTR+Y1822UySky36gynlj2DMXP9jWvXf
	 Ru0DgCj8mkFHTjMZEVsf0I28/eyb+1XwzeE5vPDyS196H4Oh/+s9uH1GYeK7bIfVi8
	 4mSnHsTjJ/2W7+m72GKv7ZzoAqoAojZfPhYhVMJghTYs7U0MKEbsB1CP+/Ivysk+P6
	 l4mBq9jEKYFVxSmPgD8dHhDk2fXhVoEZHa/0WYUOBbIUszZktIB5dezbsezxFeDClC
	 7O0QddhK6X4fw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C98383B276;
	Mon, 14 Jul 2025 15:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btintel: Define a macro for Intel Reset
 vendor
 command
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175250700601.3894116.15910683547125707575.git-patchwork-notify@kernel.org>
Date: Mon, 14 Jul 2025 15:30:06 +0000
References: <20250711100725.956159-1-kiran.k@intel.com>
In-Reply-To: <20250711100725.956159-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chandrashekar.devegowda@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 11 Jul 2025 15:37:25 +0530 you wrote:
> Use macro for Intel Reset command (0xfc01) instead of hard coded value.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c      |  4 ++--
>  drivers/bluetooth/btintel.h      |  2 ++
>  drivers/bluetooth/btintel_pcie.c | 12 ++++++------
>  drivers/bluetooth/btusb.c        |  8 ++++----
>  drivers/bluetooth/hci_intel.c    | 10 +++++-----
>  5 files changed, 19 insertions(+), 17 deletions(-)

Here is the summary with links:
  - [v1] Bluetooth: btintel: Define a macro for Intel Reset vendor command
    https://git.kernel.org/bluetooth/bluetooth-next/c/5578eec92cbb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


