Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5BC4AB1A0
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065679; cv=none; b=EkLGiDyboqeUJH1ovTrVDlMan9k5DOH8GFL8ChXJVz5wc0siO7t1CpsjhqAqSHWtfgQ3rfH44CscKNmZHHmqRRToW8qIf9F90/kRKBNHVUZU0yIpsZUOFUC/mYLWCCkBxm9rG11773eNFerFvG836V+TqaHDErPwdB8uCdpVsuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065679; c=relaxed/simple;
	bh=kqdTmglIfJZViH8SVVro2nd4ZxnH6H9uNzWiZZD1hoU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CyHF0bZypCx1pbxLQWCa8dfwsPLjY6olYg2HOERNIuE22bAVFY569LpRNGGJP6BCxOkdkhlftO6wvps4ArkF0wfBkF8/BKGu8i3p/+uxXIxMsiHm4l/7QB5sYX5c44lO54foqV9Qp+1j3vfHxwODxgBc+5HQP8Lmq/NOnsu0eF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ts19xVxu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ts19xVxu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35CE1F0089A;
	Thu, 10 Sep 2026 18:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789065674;
	bh=CbaPXZ2d4AKobR9cmYlZRC2tqmPoTDin26XEb8yCVYE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ts19xVxuQYD6MEyQeW8NZHmd8s9L03N4qBneDf4HwU0sHdFVmaC58weZ8WC+95pSH
	 vXwT1R6t1Btx2/xLFVK/dh/1+inVz3NYDBuMDjevF0yqVHPjaLRVHlQ9ZqK/YgQqdT
	 Y201bRaubnh1AAXFd7+B8FaWQk/i0ewYvSON8ZI3akiYRlUmVmvms1om6hdt0Yg1fg
	 fTHncmOIa+8/ewxsiP5UnOwD8jE20owriKiR/O7MHSppIPZwj26TOZZf15JGaYvIJM
	 Hgcgm7VII8m0cFi1bV9AzQATEkqUtXiqMHOC8V5U4OPTLxU5hTfh5yZ6N28TwUeRCK
	 M75J9kWzqpGWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569B6380CEC6;
	Thu, 10 Sep 2026 18:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] media: fix wrong argument to lp_get_uid() in
 avrcp-player
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178906561212.2027917.7890033207836807475.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 18:40:12 +0000
References: 
 <f2c2db83dbe2a47623828db3e5f4baf476336d9e.1786827817.git.pav@iki.fi>
In-Reply-To: 
 <f2c2db83dbe2a47623828db3e5f4baf476336d9e.1786827817.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 16 Aug 2026 00:04:48 +0300 you wrote:
> In track_changed(), lp_get_uid() is passed struct local_player although
> player_link is expected, which is ASAN crash.  It takes void * since
> it's avrcp_player_cb callback function, so wasn't caught by compiler.
> 
> Pass the right object. Fixes AddressSanitizer: heap-buffer-overflow
> ---
>  profiles/audio/avrcp-player.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] media: fix wrong argument to lp_get_uid() in avrcp-player
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7ac7aa092096

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


