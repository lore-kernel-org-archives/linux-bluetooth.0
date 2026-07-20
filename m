Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34103426687
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576438; cv=none; b=QY0J1L+MEQg0M4Sh89YR/i/GdjQ4iZVKhc7JO6gQf/2ujirTaSucf0cEdsgiKJ7P/sVCAn4HlvWOnGlmpJHoW9xfQiS8GSC7VQwU8piaTzvaL/XzpHK1o+07OqbR4zGpMTFWzATXYAGRbmgwegu/0Y8tO1XYrOegYqRxEEq/HMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576438; c=relaxed/simple;
	bh=8r4BIA6JMmQow9I1j2T+53CYNTgK6UwyhXpl1GmDvvM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VyvU6F49xCA2pEQsMkuIV0lVZmeNVUMVIUzoTF7xDH1sFP8xEepi9PWcJQBP4YGPowodVq06w3Qq97HwQptzmgV+uVKgWgwJ0ATAXQ3xCK+btjPNa4VWU4hfAzTkMEpVzOYijv6qfrMNBJ3VzFWoxabhCIxqb/ovgNCwNA6yadA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5wgyQkr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5wgyQkr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52C71F00A3A;
	Mon, 20 Jul 2026 19:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784576436;
	bh=msEuB3gPF6PwWlvejLR/2SiQn2qdF6cwOY83gkJxVms=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=X5wgyQkrjWAy/NGOF6ZIsJStfSRN9nzZHw7PdfUIrwmS6MSC5KvbUcTEkU8PtxgRl
	 c+PDUm2SIQJat0yaJHsmlX+4EQ/JJR9yMtYwVaaQA8ESj/FXqMKkeHuFE9z0JT9/TS
	 pyrQmoP83t7w/zEa2JDG0O7U+TJKx3O0jBGbr2C7ZifvTYO78N+7qRExfaVVSkir4y
	 EOSRRnVWFtgLaM6W40Jzvu0Hy4jEY9xlhPxI/sWeDgX6fbr0bMjU1pGnSf1E/I7Jun
	 1yKuGPSEd+ad1adQMync5UcnU1Tot/wNrJbKs/uLBy2rbj3dEj7+viUZLHWzWDKc+N
	 sWuINK1aCa2Pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569E039244CA;
	Mon, 20 Jul 2026 19:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] policy: Connect profiles for bonded inbound ACL
 connections
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178457640714.4136385.3590514668103148608.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jul 2026 19:40:07 +0000
References: <tencent_7E6A07CE6162892EDEFA29E082F2D2A8AE05@qq.com>
In-Reply-To: <tencent_7E6A07CE6162892EDEFA29E082F2D2A8AE05@qq.com>
To: Chengyi Zhao <chengyi.zhao@qq.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com,
 marcel@holtmann.org, zhaochengyi@uniontech.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 16 Jul 2026 18:55:03 +0800 you wrote:
> From: Chengyi Zhao <zhaochengyi@uniontech.com>
> 
> When a bonded device initiates an inbound ACL connection (e.g. after
> resume, the remote wins the page race), BlueZ accepts the ACL link
> but does not establish AVDTP/AVCTP profiles. The remote's subsequent
> L2CAP connect for PSM 25 fails with "security block" because the link
> is not yet encrypted, and the kernel does not retry. The ACL link
> stays up with no audio.
> 
> [...]

Here is the summary with links:
  - [BlueZ] policy: Connect profiles for bonded inbound ACL connections
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f3f03d728542

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


