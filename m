Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5041816A397
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324631; cv=none; b=Ew+ci1N/DNyPLyRtSXgoRoCPbanlEhn/FeosFEYC9JT+flrR9RppvkdSgBtQLBJw9FuzENz2qvBSP7vUl9dE+mUKlYdDdPK0C31dlvWtTJI8jxnJF4BB2+UXoe0Z4woNhRqcGNEJoh/x95LO5XDr25h80NHRn5VvZzz8UpW2z+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324631; c=relaxed/simple;
	bh=mMHPy3MAtSst6yS2fVshb+eiFDEqkdqS/6Wb3L0QlBc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eKwNT8JuWfBL4NSiusU3sqbdVccDh4EShIjz/BnRQi3++7RL56oUELFowT3oxFY2tcT8b5rSwOmSqFYYEaGR5+IySPuhFS0cvvFqIcG+jbO/JibisdSX43NOOX3pxUsloF53fDeHkawi+xTpUQ+cnTtuJacjztuXqx+VDQz94js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJ5AL/Fp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJ5AL/Fp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE9E9C4AF0B;
	Tue, 25 Jun 2024 14:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719324630;
	bh=mMHPy3MAtSst6yS2fVshb+eiFDEqkdqS/6Wb3L0QlBc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CJ5AL/Fpi7/LWBO2DwAWPlBpWoQ+RUdgmi/hT3cvmaiQuTqgVukvlp+JDyj4stEKv
	 +GolhtFQkUeG6MrB+dAluMA2YJPTMjbyNNG8nWoZx6kwiCgub55+kUku2BGu3+/Xwe
	 lWvV2ih0jmfQYBhnTCW9pVMwnUUeLrnxy47CelhsvHcf21uZmi1w031RxVWt4tc1AG
	 PYaxt43A0WXh2O/AylK42xRPwtVApPSqVgCTVNi0TdANQ71xruFlouyEpEoSLsV7Lk
	 qYESOqofZnuKghvDF3r2NUXdVGY0uLdmCsJL1eza1wpPaubqgQLkrez7KkPPpnl1un
	 iZBYCUt2oMdag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BFA8DC43638;
	Tue, 25 Jun 2024 14:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 0/1] shared/util: Fix null pointer dereference in
 util_ltv_foreach()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171932463078.10330.4298308814133606571.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jun 2024 14:10:30 +0000
References: <20240621053404.13984-1-sarveshwar.bajaj@nxp.com>
In-Reply-To: <20240621053404.13984-1-sarveshwar.bajaj@nxp.com>
To: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com,
 vinit.mehta@nxp.com, mahesh.talewad@nxp.com, devyani.godbole@nxp.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 21 Jun 2024 11:04:03 +0530 you wrote:
> In the existing code, iov structure is initialized with iov.iov_base = (void *) data.
> If data is NULL,casting (void *) NULL to iov_base results in a null pointer dereference.
> Inside the loop of util_ltv_foreach, util_iov_pull_u8(&iov, &l) is called to pull uint8_t
> values from iov. If iov.iov_base (derived from data) is NULL,attempting to dereference
> it in util_iov_pull_u8 will cause a segmentation fault.
> 
> Added NULL pointer check for data so it will presvent null pointer dereferncing
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/1] shared/util: Fix null pointer dereference in util_ltv_foreach()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e453627223db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


