Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBA3193062
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726587629; cv=none; b=f8sVw+90JJI1AuIIwomQxpyGZpo/vCqZtvS6GSZOrvhAcbZXmIuldzAyv3YwqMraeFdj4meFXjvHwi0xk4MAl7uv/BpyKN3vU8Aqy428sjl8/kOLNFY2SAcOJbpIc1wMxzhpztIlm9xCG+6JYRU5M3bLs6wZ9NgSo7WuaGV2A00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726587629; c=relaxed/simple;
	bh=06Hb+Zodevy4hLkk8MN8jQISv6HbKWhXbb1jFFhp/vM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W8LkSa5XH9kJdqC68Y5Wf9G69NVcR/d/vETyx1p9PZ5WcKVrJHCkHJzqjEYv5ETAD2b/SKEBZT5Rk/MirLDBHRovNDAyQmIKbYMTjEfCVHwtZkCtLYk+HM4eSS+MThXZmQz9dAUk6C2TdQglfSfnou2eRSgQnpIhIVwhenURY/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFQIZs/7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFQIZs/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10972C4CEC5;
	Tue, 17 Sep 2024 15:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726587629;
	bh=06Hb+Zodevy4hLkk8MN8jQISv6HbKWhXbb1jFFhp/vM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UFQIZs/78tR5eqDbspue/Y8oyYMFcq5QMfXhdV7FmoimGr76cHhdxdnFVc2sxuqac
	 TFStKTjwUqPW2XQ/YsRW8No/GhArKPCmniPS7mzO3rNgsCSgZ+h/YSJMxAbnKuWc0D
	 CszDfgWVmJUp5ZW5B9ujL1aH4ZEc4K46SgRRb62AVBfNmkSWCMMo2F43AgNiYTkH7v
	 /a1Se/Rwr+YpBL3VK2lk2ngkSgLekGNZLANrD8XrdAhezrzOs1rLFUVl6PoHedE5v6
	 zqqe+SKyHbOgioN81IGp2MYDphfjkzmVou0L14gMO5JJCwtOtH0HiUCqIyvJOjBInz
	 rLYSdeNjT6nGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC0EF3809A80;
	Tue, 17 Sep 2024 15:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v4 0/5] Add BIP for AVRCP covert art OBEX client
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172658763076.200979.8228243670020356567.git-patchwork-notify@kernel.org>
Date: Tue, 17 Sep 2024 15:40:30 +0000
References: <20240917074217.231677-1-frederic.danis@collabora.com>
In-Reply-To: <20240917074217.231677-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 17 Sep 2024 09:42:12 +0200 you wrote:
> If AVRCP Target supports Cover Art download its SDP record contains an
> additional access protocol for OBEX with an LCAP PSM on which the OBEX
> client session should connect to, with the specific OBEX target header
> 7163DD54-4A7E-11E2-B47C-0050C2490048.
> 
> Once the OBEX session is connected, the AVRCP track metadata will contain
> an Image Handle which can be used to get the associated image using
> GetImageThumbnail or GetImage with one of the description property found
> with GetImageProperties.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v4,1/5] obexd: Add BIP client for AVRCP cover art download
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1a681aa0143e
  - [BlueZ,v4,2/5] obexd: Add Properties to org.bluez.obex.Image
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3ecf9b3398ac
  - [BlueZ,v4,3/5] obexd: Add Get to org.bluez.obex.Image
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=088594d5299a
  - [BlueZ,v4,4/5] avrcp: Update controller SDP record with cover art support
    (no matching commit)
  - [BlueZ,v4,5/5] doc: Add description of org.bluez.obex.Image
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


