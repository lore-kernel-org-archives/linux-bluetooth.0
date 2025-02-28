Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAB823F36A
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 20:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740775202; cv=none; b=n6s1EggSq5dS5WsoGepiEwOz3Hy/fBVcT0L3Yl26qpTvB4bWE4VOwvki9/VRIKzXvmipHTfm327OxIajDcQ0kDR+i51mcEJp4uYwt1VSBitQjV8QSFL0fbLJdRFLwZ7ZCbnnLd/BeOqvurwC2nbh2V8Eq9pLTM1LBMr7NupWDyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740775202; c=relaxed/simple;
	bh=bAQLADk7KUiCDf+CTC1NyFcS0ECdZd0FDGmcCQM2x/s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AxMOd8q16HvD2tcq+o04xiikn+41SVoYuEpu2ROe2/5FljZIoBitYE5dnPnfjLucEikuRLKY1YLUMxLRIJn0CLg2Bxxveu2y9mVKN0GteHgkerAck3B4Wjhoh5mX6+dopHM9UDlIgf3eZqV4tRpSntNGXDHuGbg9GJqiRMV4KBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJkXNRHS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJkXNRHS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778DDC4CED6;
	Fri, 28 Feb 2025 20:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740775201;
	bh=bAQLADk7KUiCDf+CTC1NyFcS0ECdZd0FDGmcCQM2x/s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MJkXNRHSt6PkLica1T0Shi2cEqK1wZbwvbBb7K6TmDL3bKtUqbQvef2YIaMzFXOl4
	 XLmes9BytDnH1Z1J2V8IVEJmskJ4RaOpLXYiShbczi1lSBBSQptGVRMREIDlZ4PldY
	 b4Rsxzfm7bxRIpBDBRWMkyrLO21fJpBZYHnlE9D/72gWvo+cgtIiBI5SFD2nLMk/Dh
	 rL4AYargc+2Oo5PbNq9nE8CrDcd8I9dNW8tfTT664R7fIi6jerBLZ+t7VL8/LrUDiw
	 CrSa36kxsBcu8TlnSdsSdB2nQ+ScceL0rq7zI2djKDVIkJx76iFo8+qyKDA9phDG5U
	 VmWT8hsG/3BKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF40380CFF1;
	Fri, 28 Feb 2025 20:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: SCO: fix sco_conn refcounting on sco_conn_ready
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174077523375.2271257.6674253170524702347.git-patchwork-notify@kernel.org>
Date: Fri, 28 Feb 2025 20:40:33 +0000
References: <24279b4ca58e92b96fbe8f8214bf95d485ab73f5.1740691671.git.pav@iki.fi>
In-Reply-To: <24279b4ca58e92b96fbe8f8214bf95d485ab73f5.1740691671.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, eadavis@qq.com, luiz.von.dentz@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 27 Feb 2025 23:28:15 +0200 you wrote:
> sco_conn refcount shall not be incremented a second time if the sk
> already owns the refcount, so hold only when adding new chan.
> 
> Add sco_conn_hold() for clarity, as refcnt is never zero here due to the
> sco_conn_add().
> 
> Fixes SCO socket shutdown not actually closing the SCO connection.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: SCO: fix sco_conn refcounting on sco_conn_ready
    https://git.kernel.org/bluetooth/bluetooth-next/c/ebbeaffb5622

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


