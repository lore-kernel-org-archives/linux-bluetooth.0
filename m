Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1465B3AFCE5
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220049; cv=none; b=rCMWlIHowk/7TUpVla+aiYn0mv+6t7EaPys0hVHOGJfAo5Pd2WJrmQDsMp0ha/mdwpkEMOGC2aolIw9HI0artwQvPACnWpeTVjiybkzxfLIJa2IU8yzBT++jztORD5zeVYu4JgGknv3kEzrbtnI1VGuBKFIDWgbidhfD7mauz5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220049; c=relaxed/simple;
	bh=YqgZFmCeP8BUxAHtzrdnJVtTWzYIHYUUlOOVB1HUi0M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HH0YSjTRlNzaWl98On8c1KcRyXV9HkUWkX1XJZWMPsysXJrr/baWvOpW0Jcv7XF/3qUJiR7G/X7ix8ivEyElIJvrpPzd0UoUawsjRIOBcESx6p0Qqp1HK5FJCoikyoFToHwdNMaLrvzSWd+Ul4OEvMOMc01gOy/KGPFHU5tFscg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRk3fVPo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRk3fVPo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0FE1F00A3D;
	Thu, 16 Jul 2026 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784220037;
	bh=mABxNfCx4b/OobOAcl8w8NVjGEgIpvBrWlANKefqvf0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DRk3fVPo5KR87w9d9rxaZQ7PHcV0NTtkzO02H6ny4htgw46Cl8GWa2pbLged6beGH
	 ORO0lipvZNhLyNBlpq8v8Rh1N7FJ/TmiTGED2v6IV2K0+XRnKbQehv1KsU2isn/H6Q
	 u/NpmdZubd/fj5GXPrsBoFZu2dHCqaJg/cCnkeerhCGYfpzrNqu1JZBirOuyul5DSl
	 S0bsbziP3xkL1veuKr/YPKnT5+G6YJ3JyHMb2rWVpwRGCdCPQyh+VCN8jVI6M22kte
	 1OCzfi1tG0ZEsxlGKuAc2Yu0GKvveZgDqbxTgul4rP9Gl6SYwzyshqMml7C+le6ewV
	 JHI5odqD79VhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568123809A29;
	Thu, 16 Jul 2026 16:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 0/2] Channel Sounding reflector GATT registration
 and
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178422000988.1338131.13104507118778130998.git-patchwork-notify@kernel.org>
Date: Thu, 16 Jul 2026 16:40:09 +0000
References: <20260710070820.3793624-1-naga.akella@oss.qualcomm.com>
In-Reply-To: <20260710070820.3793624-1-naga.akella@oss.qualcomm.com>
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 10 Jul 2026 12:38:18 +0530 you wrote:
> This series adds the initial plumbing required for Channel Sounding
> reflector support and RAP-side management of CS configuration parameters.
> 
> The first patch registers Channel Sounding GATT profiles on reflector
> devices before GATT client discovery checks, ensuring
> org.bluez.ChannelSounding1 interface is available
> when discovery is skipped.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] rap: Add Channel Sounding parameter types and APIs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=befde3661e03
  - [BlueZ,v1,2/2] src: Register GATT profiles for Channel Sounding reflector
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


