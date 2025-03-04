Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E08276039
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100397; cv=none; b=ByxjRhKEzFnjYn/oF9wvqB5sN/A49gHjjaD+V/sgpxeGG+oN8GwHYmRvG5Y22SdaFjxjHNSyGsjFflpS/kORWrADx27gTU6lbQVFmZLFXVSl3+JUtuZsdrrtvl5nBIYHwTBsh/x7udwQjqCJG1Pjro6+OJ7acBAvlujcpzWbJbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100397; c=relaxed/simple;
	bh=/VPCsNJKk71LFSq/aeX9F2AbFor7UVpNLa7RTtlX1N8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dB9SS49rMfJFmCwDNJI/IgABHbyBhcL1ZMLJWbyVHSRaqE3rVb2ISpNRmnBqC0jIOT23/y5Wpxrz5xyRmNO8dvRg+jjTSaRbN2CBWV8q/ThypQrpyqNiKXqalxCCmKVClRguBTuU/NVv18FkN2Srx1B8JU6iPHUV/mVIa3xIzVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oc/E9N4Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oc/E9N4Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53455C4CEE7;
	Tue,  4 Mar 2025 14:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741100397;
	bh=/VPCsNJKk71LFSq/aeX9F2AbFor7UVpNLa7RTtlX1N8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Oc/E9N4Q8r8+LyeX7M/hTD1t4vaxYX24WCFE3crtKQwE1kR3lG3X6WebtXNr4Lhgm
	 6B2bcKyqqwex34tPOyi3W8FsvBA+kPDhfzKGGdCbxM/6QiR0P/OC37kZ8Fhq1VVeOE
	 shzFxJy7Zf/ZBQuizBvki4BgQCSwDElcw8OzTKzcAFACF9/BdAjDLWLMi7UUUP+fNg
	 OPJTjcX403J80W+zZCxiqIFTokpX5/66Is5EyQT+2a0EGD6I7ckgdAB6guWx5V4qz+
	 H5BiKJiLXzjJz+uxGJkkRAz1IpN5rdIM4WaixYybgQYiaFZI44UH59ymvsEXbgrkUw
	 MwoU4IzdsBqsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D90380AA7F;
	Tue,  4 Mar 2025 15:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V4 0/4] Bluetooth: btusb: Fix regression in the initialization
 of fake Bluetooth controllers
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174110043025.174904.10526442488904996490.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 15:00:30 +0000
References: <20250301062301.18029-1-nishiyama.pedro@gmail.com>
In-Reply-To: <20250301062301.18029-1-nishiyama.pedro@gmail.com>
To: Pedro Nishiyama <nishiyama.pedro@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  1 Mar 2025 03:22:57 -0300 you wrote:
> These fake controllers cannot be initialized because they return a smaller
> report than expected for READ_VOICE_SETTING and READ_PAGE_SCAN_TYPE.
> 
> This affects fake controllers reusing the 0A12:0001 VID/PID.
> 
> Fixes: c8992cffbe74 ("Bluetooth: hci_event: Use of a function table to handle Command Complete")
> Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
> 
> [...]

Here is the summary with links:
  - [V4,1/4] Bluetooth: Add quirk for broken READ_VOICE_SETTING
    https://git.kernel.org/bluetooth/bluetooth-next/c/173b1b3e9d6c
  - [V4,2/4] Bluetooth: Add quirk for broken READ_PAGE_SCAN_TYPE
    https://git.kernel.org/bluetooth/bluetooth-next/c/700ef3e1674a
  - [V4,3/4] Bluetooth: Disable SCO support if READ_VOICE_SETTING is unsupported/broken
    https://git.kernel.org/bluetooth/bluetooth-next/c/d8cba796e61f
  - [V4,4/4] Bluetooth: btusb: Fix regression in the initialization of fake Bluetooth controllers
    https://git.kernel.org/bluetooth/bluetooth-next/c/c2fe96fc96f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


