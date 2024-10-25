Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F81D21A4CE
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872633; cv=none; b=HwSYPULHCHS74BZPobRFdPf6GRbtL5Ro8l4tuGJSfeTYQO+RPcICKDnAhKaQMNpyjpCih/xotfJOyn5M7gIjLFlm0TcFjP5IjGbL4CZTNoGamFIMup9dVl3ceYI2Y0RGU9RSAWEHNLkDO6zoejlGcArPkSeUf2CGNGkyTwvV3Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872633; c=relaxed/simple;
	bh=vmFMAyv/YwZTYyGUbEBHg4evXMOYvtq56EGd5zefPxY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mYZ2BodrGiv15BkREfkynNzV7CiQlo8Z5R1dUv6inuGgAmwimr9Alocihj+rp4zxCfWUSmdIvmGcFLsP7hMglM/CwbOfC0tE/JS4YxVHMVXWPi3OklxYE1cJ1mm6PRUBfjTZUE/4trkoBav0mgu7oekUgfaEpIHYO4n3jf/hY8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ag5vLE5W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ag5vLE5W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8398C4CEC3;
	Fri, 25 Oct 2024 16:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729872632;
	bh=vmFMAyv/YwZTYyGUbEBHg4evXMOYvtq56EGd5zefPxY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ag5vLE5WjYbIK/D14JZ5Xvh8CPGPNGuS9q3pKbmS26ozBVzXBwDchY2I/xDB5svY9
	 mgwy5yVXXMR7OlabSbFQbNanvtwqj7BmeP9LIxC3h8i2XMT76WqUoniTnbc0aiyaRK
	 ssfPt3DwgQ5iTtoBiGk0hwjetECr/k3F76DjMyk70BUmeRUNdqHeISNzmGxyVtvcyH
	 Dp0j6SwELgZV+0R0SfSHDZoiU88gb1B1/sNf/4rq80tUMndGUMVIrI9U2mLUNi+DuQ
	 k4VlwTW8EHgF2O7Fv05A0dy2tTKOJd+pSxrOjJ+Bqds/31NWAm0RZixvHghJptfQjS
	 1zL9vLY8YUrMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0003809A8A;
	Fri, 25 Oct 2024 16:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 00/14] bap: Add support for Broadcast Sink AC 13
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172987263976.2957803.15543247228402011442.git-patchwork-notify@kernel.org>
Date: Fri, 25 Oct 2024 16:10:39 +0000
References: <20241025122146.17925-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20241025122146.17925-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com,
 luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 25 Oct 2024 15:21:32 +0300 you wrote:
> This patch adds support for Audio Configuration 13 for a
> Broadcast Sink: A Broadcast Sink can synchronize to
> multiple BISes transmitted by a Source.
> 
> Broadcast Sink streams are selected linked together.
> 
> The bluetoothctl log below shows a Broadcast Sink detecting
> 2 streams from a source and selecting both of them. After the
> first transport is acquired, the link is created and the first
> transport goes active.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,01/14] shared/bap: Allow multiple links per stream
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7ff51d684956
  - [BlueZ,v2,02/14] shared/bap: Add support for handling broadcast links
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=85bee521c737
  - [BlueZ,v2,03/14] shared/bap: Fix broadcast set state
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=71d19c6c8416
  - [BlueZ,v2,04/14] shared/bap: Use enabling state for bcast sink streams
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=eaff473cd263
  - [BlueZ,v2,05/14] bap: Add support for syncing to multiple BISes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0b5cfc1badf0
  - [BlueZ,v2,06/14] shared/bap: Handle multiple bcast sink streams
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b92b857f2fb0
  - [BlueZ,v2,07/14] transport: Unset transport owner before owner free
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=47da1efdc584
  - [BlueZ,v2,08/14] transport: Add Links property for broadcast transports
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e0e3c922f715
  - [BlueZ,v2,09/14] doc/media: Document Links property for broadcast
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5b1dfd2721e2
  - [BlueZ,v2,10/14] transport: Set bap_update_links as transport op
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3bafab446636
  - [BlueZ,v2,11/14] transport: Make transport_bap_set_state part of BAP_OPS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2ec04e02601f
  - [BlueZ,v2,12/14] client/player: Handle acquiring broadcast links
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7b63fe6bd4d0
  - [BlueZ,v2,13/14] client/player: Add support to select multiple transports
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3075a9c17d16
  - [BlueZ,v2,14/14] transport: Unlink broadcast transport at release
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=06c94f0ac055

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


