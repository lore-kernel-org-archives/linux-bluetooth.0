Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503D016A395
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324631; cv=none; b=iD2qyZ/mMEdqtbSZbAKB+5+SU1TZXwCmStq+vcuYZOK1CGp6b/jvaMpMv+Cx2R0G2Vy7NEjaUmtozejejSmUlcvCSLy1de7kWfwWSb8DOWUZ5rL4hYX/GtL3xS7ipCkjZFNq52mogUhgPzg9OSMkGKCDswYTIR29rSnDQh3RLKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324631; c=relaxed/simple;
	bh=Nbq4zOm0Wv7YeZwN8cPJFwJ10NZWBhG42EFLNe25PEE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BW0i+cXz6yjumCGEP5QzeTtCfohk9XX3gzNDk+1b1+dRfBOaacmQrmjiGagrHyMf0Ndl0pfcym5KF4aGWtfyTnbMc7gkPlLuJTgqnQQzwf4eKLuofoWS3pK6y/HUvgqNpBjhUq2S2ZbS/r3/aXkkzQ3kXl8aLIkA6yBCVxGOtwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSLWgxuf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSLWgxuf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D75CFC4AF0D;
	Tue, 25 Jun 2024 14:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719324630;
	bh=Nbq4zOm0Wv7YeZwN8cPJFwJ10NZWBhG42EFLNe25PEE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JSLWgxufZ7XR3pTETPWIg5MyF4MagBjztmqUUKKulZXSe+yg1hFbAE7lN9sY9UDWC
	 AHJiylet3IQHpnx9ft9bokjC700/iQriufoyMvfaXb2RjI1DAbQYtnlBNuGdgHGyxT
	 kD327IP4rskFW54o8+8SCxgmxvSkVRVhjk/O2+klsimDGzWy9GVwppc7KJhpRKSYx0
	 CzGwoYZ4+xVk8KqOJDhnzJKgJN+XeklnR6D4lH6oW/JPVYJ2KCIJbuEsrYX+iBxiuU
	 spGKuqjjvWfehmLCp6uM7RaJ1kMwVUSQh1L1q8tnd+EHrw6lpCuGNvPIyMdQVYJake
	 acS/tanHv1Yjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8253CF3B92;
	Tue, 25 Jun 2024 14:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/1] Fix null pointer dereference in util_ltv_foreach
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171932463081.10330.9812126766830035655.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jun 2024 14:10:30 +0000
References: <20240621075517.22576-1-sarveshwar.bajaj@nxp.com>
In-Reply-To: <20240621075517.22576-1-sarveshwar.bajaj@nxp.com>
To: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com,
 vinit.mehta@nxp.com, mahesh.talewad@nxp.com, devyani.godbole@nxp.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 21 Jun 2024 13:25:16 +0530 you wrote:
> In the existing code, iov structure is initialized with iov.iov_base = (void *)
> data. If data is NULL,casting (void *) NULL to iov_base results in a null
> pointer dereference.Inside the loop of util_ltv_foreach,
> util_iov_pull_u8(&iov, &l) is called to pull uint8_t values from iov.
> If iov.iov_base (derived from data) is NULL,attempting to dereference it in
> util_iov_pull_u8 will cause a segmentation fault.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/1] shared/util: Fix null pointer dereference in util_ltv_foreach()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e453627223db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


