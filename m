Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1B117BEAC
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Sep 2024 19:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727378429; cv=none; b=JRRlQ/OF1QFD8b62mPmGjKG0HVuTRciF7o1QErDT4QF1e6W5sE0HXliZ7fd/YDtT6NEMhXW3aObwvw9t8XSjjvjsAD5LrRMY1s68BGuEiZ9H0UFo/i6m9VdSFGh2B3CXkYqg9it5dedJ3e3d3frjz9c3A9bXyC3Knv9csZGiZQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727378429; c=relaxed/simple;
	bh=goPtPrh2esptFetwrWd3r11J8Hho1yRiT7HAE4G9e6s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iZXSEFZwyYX6kvyHnx9U9wkbzmCEhhpnqXPFCyOsHDwazNtJFJb1jETBwmCpUpVU1KYiDfdbTXvrFf2FbNCrNIf11SxQ9ZnUMFDB+20ZK3tTREUnFDh6eb+OaRJUoISmaDgocPvarrobLt1e/SJBMpDMb7vXUAUAnliOd8EcC28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaPb9u5q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaPb9u5q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84F7C4CEC5;
	Thu, 26 Sep 2024 19:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727378428;
	bh=goPtPrh2esptFetwrWd3r11J8Hho1yRiT7HAE4G9e6s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eaPb9u5qgPWKF7IS7md6C2cdzfp2103HORDFpdL49UTeO8lyEmMPmwLCmrFj83Rff
	 8s5dz42YyDjOP0k0qtAsNozbleJ+qsrHOneeJoCkiEvGY0WKp1AleymsFtwlICePNe
	 s+6QbRB32x+k9RzRooayRb/2a3JEZhF/zaR0+Xafe5rZ2bLEkLudAxvG1oBIVS5lvc
	 RqMdzoOEVE1OUn4NRl/yLkbrPkOzk93szCN+xbxkjFrCjLjjLo21fG9bfINFIMTIhD
	 W+k/qny8AXGmO/haV3AncCjzUE2bnaWkas8qOcToV2MdVOo02gIQhXoTFv1AvHwnc6
	 lWZDOnTG1GMmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711203809A8F;
	Thu, 26 Sep 2024 19:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/shell: Allow script command to be used within
 scripts
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172737843127.1368369.6326758001996081397.git-patchwork-notify@kernel.org>
Date: Thu, 26 Sep 2024 19:20:31 +0000
References: <20240925182730.2035299-1-luiz.dentz@gmail.com>
In-Reply-To: <20240925182730.2035299-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 25 Sep 2024 14:27:30 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes script command to allow the usage of script within the
> script file by saving existing execute queue and then replacing the
> line with script command with the lines of the input file.
> ---
>  src/shared/shell.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] shared/shell: Allow script command to be used within scripts
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9a9dc3d456c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


