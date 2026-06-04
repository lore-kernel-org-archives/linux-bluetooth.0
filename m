Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1C13A59BA
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602005; cv=none; b=t4ZS8dk1zmGkcXJ3DrVd1wT1uzkgysCMgXuTbQ9iIWOghBXZx7K0p+3W2Llh3UNG6CLw4uEcOrhSC9SKqeK8J9T8URWQNoWGlTwsEEkQEGL8SmkR90lXZQofM7OrWlAxVSgDZPDfxYTqGvtOXX1HtxIx/hHZnlr7Jbm13Dgh69w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602005; c=relaxed/simple;
	bh=wzgC6kUQieTXw2NPmUsJhEC+oFkGOb7j51aQUYXRr2M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yvf9OST1CNnxB8Zh7jkp/GZj6apM8WCvDvfFdinw2aZXW9G5/gExAb7iG7JRtaKfPwKlW+2/vpysuFiwF/HKzBDaEOMMJapF7utsUV/4Fgdl2mhC/lrn2L424RzLWqaQ/r28PwHu0ooG2oSdvANyDNDyWZjUOG67hggpp/iz7xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLNLCnqc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLNLCnqc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349E41F00893;
	Thu,  4 Jun 2026 19:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780602004;
	bh=QhCHtoBY1Xgwoa2hoFOmHSi0qA16nAnQx0kSkflphY8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PLNLCnqcW45C4h3bEJkGpmQT60SDvLKLtxQlKH8BciToLobazal2gtCjd3oO3kzk9
	 f3lI9U5s5UZXjsWwiwdPORZpJGC4oL1RYiGikbpgU3x8+IuI5WHnVodYGd8xo7pNKt
	 gyOB9n9CaoPyR/8fGa64mzxBzm+ZPPX/pMzPx+AB07F8DFBpZWcM9CnRZJdNBLE56E
	 5OHWzNMN1GsRdofl6/vEoL+6wJ5+3ezAZKZ1cNsdM6jIuwCV0UElxKY1AnPb/k+ceH
	 UxbWogdPso9CsWcvR85aY196JdcQB25d5+9C9opswR7pu53Pe+7kjydINkU6ToSeVU
	 g7z4PRCCQzoSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A49C3930A1A;
	Thu,  4 Jun 2026 19:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/rap: Add client ranging registration and
 notification parsing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178060200515.2994037.6060072322845213765.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 19:40:05 +0000
References: <20260604085205.4135084-1-prathm@qti.qualcomm.com>
In-Reply-To: <20260604085205.4135084-1-prathm@qti.qualcomm.com>
To: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  4 Jun 2026 14:22:05 +0530 you wrote:
> From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
> 
> Read the RAS Features characteristic to determine whether the remote
> device supports real-time ranging. If supported, register for real-time
> characteristic notifications using the reqtracker for the CS initiator
> role.
> 
> [...]

Here is the summary with links:
  - [BlueZ] shared/rap: Add client ranging registration and notification parsing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bc5713d69e1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


