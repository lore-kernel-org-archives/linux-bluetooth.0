Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67882BB04
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653399; cv=none; b=b2HPGkOn2dtGan3dkkLKQYEUaeDfOTGOUthuxoYFraUCZXdtpajzW9CeuHuqOrEg3TCN7lIuftunfBxl8DAKCN4jjwycx+9maWJWYumMHnWael+2/GVysr9TzHFSLPTBEz4HLUVWhJ9nhiBPPgDMsiSOrK45rjxxtMACaywu/6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653399; c=relaxed/simple;
	bh=B7T51Nd5qVOfqCRJh7DV4ELDKyPCCZDAW84jMQ0+cvA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rt08M7jplkWeoP0UW9Jb3jX0ZznRcsgMVfx7JD0zCVC1w29atypa5BSYKkou1PxAmfJ9jODQ62Ps5EbkIxg0xdEGbsmuvgkCbiGYHPi3KxwS+b97cpNtPHjwNn+3QJo8GObLPuQ13eYrEVYfFvu0MvDR9GkPqi3Igq9RAUlq+JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JW0kVXIb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JW0kVXIb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846ACC4CEE3;
	Wed, 11 Jun 2025 14:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749653399;
	bh=B7T51Nd5qVOfqCRJh7DV4ELDKyPCCZDAW84jMQ0+cvA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JW0kVXIbO30LAe38LoFsKSW2bbhiC+Ah+48jvYCit8d89ftsfc007FB4xKXm/hxzC
	 wjYs+83e5ypdmbSeqgDGpLse8BpI1wByVcJ8qlSAPtqpkji43UFA06lcxoksBM6Oxn
	 +YJ6IbCmNR/rVbwEdIWos6xW12fT2vBWprp4am0Nk/2FAIUprUlHP8/8DpeXyogFe0
	 aCLpW+QIR8AtnpEyoCed2Xb/JVtYr3YzgBFDvWL7qEu9g56h1ePCCCAxIkcQs2AtIb
	 6V+u9WZoH0YgqKNrV2sAOvRl0f5fOo85QjQ+b3EEGixwnelfUtucob9zxKsKPnAl5O
	 yJ2qPkHJsZtSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEF739EFFC5;
	Wed, 11 Jun 2025 14:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] doc: sco.rst: BT_PHY is read-only
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174965342975.3352496.16651303180376881378.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 14:50:29 +0000
References: <20250611124917.1255095-1-iam@valdikss.org.ru>
In-Reply-To: <20250611124917.1255095-1-iam@valdikss.org.ru>
To: ValdikSS <iam@valdikss.org.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Jun 2025 15:48:18 +0300 you wrote:
> The kernel is missing BT_PHY setsockopt support, as of 6.16-rc1.
> ---
>  doc/sco.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] doc: sco.rst: BT_PHY is read-only
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b7dfccf0e52a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


