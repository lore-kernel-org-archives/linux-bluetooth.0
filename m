Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B0843E4AF;
	Wed, 21 Jan 2026 21:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032213; cv=none; b=dpPPJ+45D8sgprg5FAL7oE6I3zpu8Zawz4Ec2mV/+rSDbykadiGf3Pwg4ZF5LR2cDcvMtlrIJmWiD+4xCr/GHTnsgzuVsukVxpu8/rfoo2MqakfcEmszC7p3CTvFKna2XIpFX7RC5YX2ez5vOeaxNdWv79ePUb5GaSEedgHw8kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032213; c=relaxed/simple;
	bh=C0MEPSHcHzJjTxdr979mBDtDKRZVQl7VkWcJQlZ+Yfk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DI2aTmsWerJJTnFS15+HNzptjxIO/uJlPbAM18n9rzMbvSRQtwJQEOIeKW0hv5RTo+Ux+CckvGeDkxr9UB3mZ07NPmAAeocWtFmHG8wRw+C12oB55LK1QHDljKzvWi3eU2Mx0NlwF3qv7YW36MqVfP8bTezMBOhrZ1ZqSL0hKPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbQHV3jG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbQHV3jG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6B9C19422;
	Wed, 21 Jan 2026 21:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769032212;
	bh=C0MEPSHcHzJjTxdr979mBDtDKRZVQl7VkWcJQlZ+Yfk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SbQHV3jGL2/rK8901VaOBni8KVp/rCaS41dCwm2UI/hPPGQ4AzVHqYYU64Qz38BrW
	 ha2GtvwWXMBbGy2HtHzQ0giK7dzRPa6ReC6kj24dgtup2gcvOtrZBRHncVBKXsauFF
	 +xUJKZMaJ3TQH6yR3sC9Bihmj8Wuan7D+hfFE1hjIbFfBeHEaOkljcwH2skH4X3BbP
	 AFgSEZVf+AeJrOiGI7UITRhd75CpzPSmyOQecd0+CicCQbarxHkh/WUpDuyk/scUE4
	 MJWMjazZ1SwKbptwfcP+OyGNADLTy7BBxtR4hwziU25PsGrvhVBTGUSzYCnnes0a+X
	 8Q/nL6FSr5fug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8D5E3808200;
	Wed, 21 Jan 2026 21:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: MGMT: Fix memory leak in set_ssp_complete
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176903220934.1456135.3548661986981842662.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 21:50:09 +0000
References: <20260121052926.3539017-1-jianpeng.chang.cn@windriver.com>
In-Reply-To: <20260121052926.3539017-1-jianpeng.chang.cn@windriver.com>
To: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 21 Jan 2026 13:29:26 +0800 you wrote:
> Fix memory leak in set_ssp_complete() where mgmt_pending_cmd structures
> are not freed after being removed from the pending list.
> 
> Commit 302a1f674c00 ("Bluetooth: MGMT: Fix possible UAFs") replaced
> mgmt_pending_foreach() calls with individual command handling but missed
> adding mgmt_pending_free() calls in both error and success paths of
> set_ssp_complete(). Other completion functions like set_le_complete()
> were fixed correctly in the same commit.
> 
> [...]

Here is the summary with links:
  - Bluetooth: MGMT: Fix memory leak in set_ssp_complete
    https://git.kernel.org/bluetooth/bluetooth-next/c/efa3d7c22e98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


