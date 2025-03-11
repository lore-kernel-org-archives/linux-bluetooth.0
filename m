Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D5C25E818
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708202; cv=none; b=E8zWekbAMF8j3zXoD5deTjymxvXE8YmYD7+KuixnpWlu5P5+05LHHI+tuGU1Db19CZRn+2mwWfIA+jk+ko/1/LOEpfiTNvxFyVAzo/SFmgq1tL28LhiwWeQw/xweHWvHWSJKUSNPTQvcf2nxpKjtJOiNBIfQXN4EZLIVBqW9hbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708202; c=relaxed/simple;
	bh=UFS6bd2vbVatlFV10dVxHBzSUhlsdX0+POsc/kvfyZQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qXyuDYicn6wIx8qv0u/qPunaogozpGZaTW/oe7+KlnZbN/KffZFWq5xIETbWDsSLtlV3ailcT3CqB7eUgyNs3f80ffkq/0hkA5MQIZhB6CtT0527s8gZEIkYMhkHp4dt632gdhv9Nf2YDytO9LNc8hKzU5qxY3ehf//CaCYV1Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBExXS9w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBExXS9w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE498C4CEEC;
	Tue, 11 Mar 2025 15:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741708202;
	bh=UFS6bd2vbVatlFV10dVxHBzSUhlsdX0+POsc/kvfyZQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gBExXS9wUlrDiB0LzIGgyUJNjiMa25YMJlOGs0ZANXy5E0vB4Fr0L4ZSx8+S1UImU
	 9dfMbPBUBU0fQkdDCe08SurBjhcqJHmIWDoyd0hKUuNjS/JUuFwF2sTwbwPyFS4JJu
	 Bus8qXsfEinOsC+gVMI4us2GwIPNpmSHg7fX5yisJKfmyLjCxSPTJTySm2xMqHrAey
	 60QKTMUazJk/RtKQUutT8HM/himSGOIUOxJbfg5DAYyy/gybi09OjvC1Nc06YUeIAu
	 ZetEzYo7mDwJ9/hclxNByhF9opvFfeE8U1Rq8lEyUg/brmJITxmcPLCpeO8dLFfves
	 B8bPylY8+nC1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEB3380AC1C;
	Tue, 11 Mar 2025 15:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/6] bap: Remove interface
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174170823548.132061.4202500634317388282.git-patchwork-notify@kernel.org>
Date: Tue, 11 Mar 2025 15:50:35 +0000
References: <20250307154457.85751-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20250307154457.85751-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com,
 luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  7 Mar 2025 17:44:51 +0200 you wrote:
> This patch removes the BAP plugin interface and moves the required
> APIs and data structures inside shared/bap, to avoid making calls
> between plugins.
> 
> Iulia Tanasescu (6):
>   shared/bap: Make bap_get_session public
>   bap: Remove bap_get_session
>   bap: Move default qos to shared/bap
>   shared/bap: Add APIs to convert iso_qos to bap_qos
>   bap: Remove interface
>   bass: Free stream path
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/6] shared/bap: Make bap_get_session public
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8f280aadbbae
  - [BlueZ,2/6] bap: Remove bap_get_session
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fd622a5bb2e3
  - [BlueZ,3/6] bap: Move default qos to shared/bap
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5204f17cb9d3
  - [BlueZ,4/6] shared/bap: Add APIs to convert iso_qos to bap_qos
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6a03579d170e
  - [BlueZ,5/6] bap: Remove interface
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8850bad1e027
  - [BlueZ,6/6] bass: Free stream path
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=debc77530f24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


