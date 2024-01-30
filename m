Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B9B78B55
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jan 2024 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640027; cv=none; b=YkMSfRgIreXPyXSCCJuXYH5Mh7aF9+ivWhNEBVi7NQr4/eaf0XhEB9x6ktM31O7o+NZnrsTaHIPLybg2HCmCz8Gp5I6yOGjFcsXeYtRdTTYbE/rrS+iFYsaZ70j+1awHIg7MyaVN/GMK4InpM3mjW304T7OwqMxUbestM9YAWA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640027; c=relaxed/simple;
	bh=UZ9HkEPtGs3qnEZ9zfOMEdgP9xiSONjOkEryrsxD5p4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ui3VfiYMiZOQjgV9wQRoCRkGp3n5cZmA4cGcJxj5QvaF+6Ws+4GjX4phpavFXFiFt8BkZFlrTYS5K1cqv02AfAYgPa0AqOiN4mgONYK6c9x5nyNbdp5zBJhFiKqFMren9XFtCglti4OAq/tgAFvVJSsfUVa31TZbnTZ+xzsW0/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3uv+cD7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3uv+cD7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C481C43399;
	Tue, 30 Jan 2024 18:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706640026;
	bh=UZ9HkEPtGs3qnEZ9zfOMEdgP9xiSONjOkEryrsxD5p4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u3uv+cD7Ofkm3o857Jf8nf2tBg2MXwXQ7Sm8wPdPwkaFd672/8zX9MPxbxcKms4g0
	 fOdKTy/sEOmtVwhy6fHXBl7pPaxOqWpo6J2/rpxehJc5qfV4JVaATVVnrKIPoaDPDh
	 rfoGnlvQNIhConIAbHcMqbLa8+OBqayDxD3qP2h6+ecw+BAx1a7T2FpRI2BRTDr02M
	 /SHovZZk5ujY/97ZgprZh5M4aC1r563hqcEfkbDafD9W+x9Mo1ys91QU2oUiMekIQV
	 qLOSItxc/kqeLV6WujszT/H3d4k7JJgfwhumItrcuHrISuaeDMOlu07sqQUoJCpkxW
	 qhoclBqEMa49w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83A3FDC99E4;
	Tue, 30 Jan 2024 18:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Bluez PATCH v2 1/2] Monitor: Remove handle before assigning
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170664002653.26337.12062276527654167832.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 18:40:26 +0000
References: <20240130182459.Bluez.v2.1.If74ccbca4d541c5f576765a3a78cb8923b5f85b1@changeid>
In-Reply-To: <20240130182459.Bluez.v2.1.If74ccbca4d541c5f576765a3a78cb8923b5f85b1@changeid>
To: Archie Pusaka <apusaka@google.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 johan.hedberg@gmail.com, marcel@holtmann.org,
 chromeos-bluetooth-upstreaming@chromium.org, apusaka@chromium.org,
 jiangzp@google.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 30 Jan 2024 18:24:59 +0800 you wrote:
> From: Archie Pusaka <apusaka@chromium.org>
> 
> It is possible to have some handles not removed, for example the host
> may decide not to wait for disconnection complete event when it is
> suspending. In this case, when the peer device reconnected, we might
> have two of the some handle assigned and create problem down the road.
> 
> [...]

Here is the summary with links:
  - [Bluez,v2,1/2] Monitor: Remove handle before assigning
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=12ccf5ea0fa5
  - [Bluez,v2,2/2] Monitor: Avoid printing stale address on connection event
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e98bbe3f1cb2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


