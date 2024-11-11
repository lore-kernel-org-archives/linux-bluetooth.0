Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603591BC58
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338426; cv=none; b=ZQrICPnLMTM5ZLoWOVG2qIT8cCgzMiaKYh/zqKdhYqXXexpay40oT8DnaPnKe4ukR3YTRlvWPGsyYiA4SJVBCFXvSDhzKw3/+0Ew5o/WMQt8ArYFFAw2/6GPvKboQluZ5KS/j3mak8SFtxmtf751uC3LhzKx7Au5Elsyzv1JYtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338426; c=relaxed/simple;
	bh=rMkjEQfOpRfhb+WEbTgS5lUk2lPZDm5NGScSdZtfmqI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YstAb26E+X/jjzjyIItQi6U9UUr9oBEIHddK4EYI5IaWEemggJ/2gvGcGBQpT2w6XF3Ky/cq7rtgOUpTov4E1YxVLd8StLl9gniQrJFfJJkadwdPuKTGd8lKhdxQEq/J62LVbm/kYRMnbWyy12v8aIPgfUYpuYGhpqMbke8GE9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntmcVJTc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntmcVJTc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FF8C4CECF;
	Mon, 11 Nov 2024 15:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731338426;
	bh=rMkjEQfOpRfhb+WEbTgS5lUk2lPZDm5NGScSdZtfmqI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ntmcVJTcksh2oERscQPXTYKyhGNiNiveaoz5EHHQIyaks1usQTGyqk2gseXmfQToO
	 nY+yRhEXhfDfSbxKz3dTQHACSH4DEV8iHejC7pCd9oX/USwe9Ap9UUaCTYC60LX4ZY
	 ajE7o+nHtnszwO0/y60Myn3/spIfvX096FMhqEQduSDfk4EbQ8dArGgVrpXy0Xk7TT
	 V/nMzBixtdZ/yb1PgkvYxXrdhEnezKmNp779egAzQ9WVmx2dRr6xgaJOwDmvxXgXbl
	 tmInrQcj/ZJcUWfaaUvxNPwP91y2/ORCB/68a0QNRbFaIEg099PUMvL7Ah/y102pzb
	 WWNiKaroY4sRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CA43809A80;
	Mon, 11 Nov 2024 15:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] obex: Check for supported features bit value for legacy
 server
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173133843599.4067431.4374578134474437529.git-patchwork-notify@kernel.org>
Date: Mon, 11 Nov 2024 15:20:35 +0000
References: <20241111123125.2034898-1-quic_amisjain@quicinc.com>
In-Reply-To: <20241111123125.2034898-1-quic_amisjain@quicinc.com>
To: Amisha Jain <quic_amisjain@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com,
 quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 11 Nov 2024 18:01:25 +0530 you wrote:
> This fix is required for below PTS testcase:
> 
> 1. PBAP/PCE/SSM/BV-10-C
> Description - Verify that the PCE does not share its
> PbapSupportedFeatures bits with a legacy server.
> 
> Incase of legacy server, check for 'supported features bit'
> uint_32_t value instead of directly checking the pointer
> holding the attribute.
> As pointer 'data' won't be null as PbapSupportedFeatures
> attribute is present in SDP record but it's value is zero.
> 
> [...]

Here is the summary with links:
  - [v1] obex: Check for supported features bit value for legacy server
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=486aeafd87bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


