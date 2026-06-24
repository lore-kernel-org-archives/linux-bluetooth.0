Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DE0223DCE
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 19:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782329527; cv=none; b=W52ewcGmwPDe34v++0SkO1lqNoe6QoBCWEo8TyWx5o2CIwXfBOXb1m2S7SLoHQR/3mDEjfa27QgjBnbBkavoUo+LA/YH72x4mUugpDkJ1iUCNOw+6Mo/zkDE8agcmJPOldDj28vHvvxvy/DRcqpHJHWX6QWZtMFC7xzduWE1Q2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782329527; c=relaxed/simple;
	bh=AE3VzSUZfyeuqr6UutKf7U1Y433+e2Zy05AX111uYs8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HxN58VEeLwQRUTYUQJcit702QgpEtkmif6HjvgY+B0BgLOTpRU24/H583tMUF7T2W/TerzBEFgoiXknpHcL/OsehzaaKmOTRS9qN6ozON+RW0A12s7rVaoxjiL2FMvAmcyqf7bLS9TrJ0KJyTxTN1I6BwmPZqvm8kQDy8jZVXK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcQkbVHJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcQkbVHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522601F000E9;
	Wed, 24 Jun 2026 19:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782329526;
	bh=GDMkoBkxOjL/meBeb7nmNI297M3VNJxZbiMZESd1uOs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AcQkbVHJbtWL6cup711DRtdXt0j/SDf1Cxms4xVyxA7IKjKsKPMrjwlptQ7Cy9gwq
	 XvEtnu7vXbFFrB8Pway1OHpf7r3uuquiNgvYY1fxrNFbcMzVMCMaDhWKFI3wTY4pGm
	 F2CdBoRqUa0Wu4q2aV5E/FML0xNYPswKLMOZ899uV8OW8RvCz9mbLVAeffEXQ0SRs8
	 /BfOcs05R1UMvuobraQSUvd+sFY4x1uumuzuAxtJnmQeNANu2Lq+H8CS3LvbuegNPR
	 j67bVgLp93jVbjwjmhUOVFVvepkFv0ijHLJqET6YBDFCvOs/6vInuic+E6ZmPsyQyn
	 VQptf1QHC5Tsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199253AA6A68;
	Wed, 24 Jun 2026 19:31:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/rap: Fix step payload pointer in
 parse_step
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178232951461.2888927.283917655207284804.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jun 2026 19:31:54 +0000
References: <20260623111112.1332742-1-prathm@qti.qualcomm.com>
In-Reply-To: <20260623111112.1332742-1-prathm@qti.qualcomm.com>
To: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 23 Jun 2026 16:41:12 +0530 you wrote:
> From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
> 
> util_iov_pull advances iov_base before returning the new pointer, so
> mode_iov.iov_base was set to the start of the *next* step's data.
> Every step was therefore parsed using its successor's bytes.
> 
> Switch to util_iov_pull_mem which saves the original base, advances
> iov, and returns the pre-advance pointer — correctly pointing to the
> current step's payload.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] shared/rap: Fix step payload pointer in parse_step
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=40a58272a58f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


