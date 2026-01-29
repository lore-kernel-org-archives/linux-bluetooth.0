Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC855343D76
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769704215; cv=none; b=W2xYsLgoshvJpnISxzPhEVXWuEesa5THoo5FEz/M5HjmrTI/s0kRgCr3UQTDSqZSSeqnwyjR5pH33xYBLkHzuPo0ctm5oSInkYMPeYtztNAN9zFWEMvBCJMv3FUpPlRsxN3AP05ohK7P1Y/3xDDjhEVn9z94SJDN83PnQogTtBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769704215; c=relaxed/simple;
	bh=A0iOCKQ/LZ2PEAdA52eHKP+ZK18XjdCGLios2gtOxfI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a4ZzdIRGgmkMaN0tDH2Ex5CPCYy9qJ64DFwrOKBVIaLjTE6yE/RbEEA1UJ51Lbzy9GBxv9hXR87UpWYNW378m+1JNkpI+76effuwtv4eguQqwphNYx3af2vyTThchDmKLkI2WSz1hDHKHI9WilIVDdquh4uH9EBiLntW7U2zhxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZEMM/q1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZEMM/q1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22F5C116D0;
	Thu, 29 Jan 2026 16:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769704215;
	bh=A0iOCKQ/LZ2PEAdA52eHKP+ZK18XjdCGLios2gtOxfI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bZEMM/q1wNS7p71aj7hALDgNku58mi4kvDFdAy+pPmFUDP9BepWhZqzXucIBq0Xb0
	 tY+5Bhsb1LapKTepUN3plw1r99fPEfX2DjZIsiwJBMKGpuy3cWFjbE1/huqHQ7nXmD
	 0EiClauZ6gpNzdEj2L83NjVpsvhXRw9LVzbAkeuozLiOTEqqooe5tpFvUQymxFDHx/
	 8ocfQ6/CAhWJuxGiwbp7V5U2IyAXhfVacRvyrYOBs5ZZLFP2tK0NgJJQfVa+I8+LdR
	 Ix3Ey6cR/Mv4z9uTWQGlD1oigCjVAjzEBmU6ujYMjWS7YL/0mTfjNgkCR8+TSpXYnT
	 8kLR3lO+9U8oQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8B09380CECB;
	Thu, 29 Jan 2026 16:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] doc/qualification: Fix typos
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176970420859.2563498.154813540931646475.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jan 2026 16:30:08 +0000
References: <20260128115359.222251-1-frederic.danis@collabora.com>
In-Reply-To: <20260128115359.222251-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 28 Jan 2026 12:53:59 +0100 you wrote:
> This fix the errors and warnings found during HTML generation.
> ---
>  doc/qualification/avrcp-pics.rst |  2 +-
>  doc/qualification/gap-pics.rst   | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [BlueZ] doc/qualification: Fix typos
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9bd859ea4a4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


