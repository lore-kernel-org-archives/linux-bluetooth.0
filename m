Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C9E3115A2;
	Wed,  1 Apr 2026 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775070622; cv=none; b=UnDA8mXspLUVfMlz+Ah609SbKcVLkNcZs2JJ/L9UCwp+rat+P2Yie6ecFIaLe41SgzTnf1r6DlFw/9g7L1VqC4oLO+VoM/oxXeGibqOek4wRAxCEnrYGQdEpkdOl/LcP3yizc+wmYrhVi4qDu0AzGoXwyM2ulY3vwPpyHhjhNP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775070622; c=relaxed/simple;
	bh=LUvSQ82o5JAp4Jq+/msQnCKo7ZTxfDSBpGjDCgY31VE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JGfDqQam5GgBAvL9vrlPMBLdLjJagOghGiw3dw7+7WnRucyLLO188fvfzfz2nNLpdydkeKr56FHJL4WPXk+49K+aBDp7zM2UANfRLgNvw6w63nXmAPa5j90k2JKqGUtKA582OcJ6DzAkcLX1AiJNx75BWJPPPENPYAyHgY/KF9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJFV3TKO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJFV3TKO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39F4C4CEF7;
	Wed,  1 Apr 2026 19:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775070621;
	bh=LUvSQ82o5JAp4Jq+/msQnCKo7ZTxfDSBpGjDCgY31VE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HJFV3TKOpqdRANDDGz9d4BRg3/svvgOkSVuiI3B8T7LqTphonPYf5xON7bktdfvJR
	 YS4ZnGLy1fSwFMY6ZOYjaAiwqruzXJUWi2Jow6ajAo/RrjAWZINn9Vq6k0ysDA/O9c
	 zZdZNElucp2h2Gods8MPEwaXX9fp0WVW7uc3dbqSMxTL+/JFwN7IL5bf0NI9/K7etn
	 hynEGeFeu/QXRfCvXMIslNI3FQZrhhIANitrHLoC8ZgNBx3E2t17wNIpuBnX+niOom
	 zdmK0SL6t68TyfM0L1ahHVCfR5uSrx28SjYaY7P/FGGy9X9HO5b/EHJ+0/TytwRcI6
	 qF3SLwmVRGmwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CD93808203;
	Wed,  1 Apr 2026 19:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] Bluetooth: SMP: honor local MITM requirements for
 legacy pairing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177507060479.3825986.13933762022782579575.git-patchwork-notify@kernel.org>
Date: Wed, 01 Apr 2026 19:10:04 +0000
References: <bt-smp-v4-ea63d24bfcd1416f9da279190fab15fc@1seal.org>
In-Reply-To: <bt-smp-v4-ea63d24bfcd1416f9da279190fab15fc@1seal.org>
To: Oleh Konko <security@1seal.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 31 Mar 2026 11:52:12 +0000 you wrote:
> hi,
> 
> this v4 series follows up on Luiz's latest review direction.
> 
> 1/2 moves the primary fix into smp_cmd_pairing_req(): when the local
> side requires BT_SECURITY_HIGH, the responder first verifies that MITM
> is achievable and then forces SMP_AUTH_MITM in the pairing response so
> the responder auth bits and later method selection stay aligned.
> 
> [...]

Here is the summary with links:
  - [v4,1/2] Bluetooth: SMP: force responder MITM requirements before building the pairing response
    (no matching commit)
  - [v4,2/2] Bluetooth: SMP: derive legacy responder STK authentication from MITM state
    https://git.kernel.org/bluetooth/bluetooth-next/c/3a0b100b337c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


