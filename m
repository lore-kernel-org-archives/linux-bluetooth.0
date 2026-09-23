Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDEC53A39F
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191877; cv=none; b=T0jTf7pnLFBXRg2aO7XUNRZCueVvp0r9ZCntylvb9QrMTtV1aySVMn7akSSnIgwEHYsrsnDHZysrDlSZFQBdF84Jw1Nl1oKzqS/tUftg+NrSrMDCzJUB8mUbnMkDq85CM8o9T9uImv47PKDaERUsm3i0UyZziruaIoi2ch+9+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191877; c=relaxed/simple;
	bh=t8pobxFZM1bQVijvUUszXYG1rw7oGFBCbijC1BgFUbU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i9cbM3gqJfsRuPOK6aDhQReHpmAVNGjBgDFULf9uHUGB7NntKuIKM0ppBnf4roPx3e/DYpfz3FKi6pxAvz6m2K5/e3dQLqEamD9kMMLyOnwk3OcAwsQG2n2IPpAiGWKKOGp822XI2p+wbCqVmi1aniEGDxwwotl33VKB+Ic1Um8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktNBtrMM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktNBtrMM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2AF1F000FF;
	Wed, 23 Sep 2026 19:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790191876;
	bh=nktP2zMF75u4OEAu0gLs6WjcP7sGd7quCbFvPAPZeA0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ktNBtrMMLzs6d3rUC5A1cNkRx65yWKoXITiez0T/n89l55LvqSmjL3UZaipc0BuMw
	 AI9NAY/pNMYWvBgCtdJJBQLEQ/Nf4vLzpD1o9OQ4jYTaena+JWSclGFwarUa0k/NC5
	 PLTUktnJzxJ1079HUDTvOu7RunUpA3fJsexlBSwIc1irFhXnInD1P8fMO23IHBMStW
	 /30rYItB35bZ/3Scrtc+0NAZuneQM9Gp8wTlcFCJN3JPuH9IsgNngLzGXP9PUKR/Jy
	 FbLtFzFYL/aoP+OiEtaGtRO8S/d5aVhVcrJ1AdIjUZsgMniWFilpwxoxFoeIaxOmwY
	 OoZOeS9FIxSzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567E939E8A64;
	Wed, 23 Sep 2026 19:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] client/btpclient: Improve GATT read
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179019180615.664822.12734945245369501857.git-patchwork-notify@kernel.org>
Date: Wed, 23 Sep 2026 19:30:06 +0000
References: <20260901125440.355578-1-frederic.danis@collabora.com>
In-Reply-To: <20260901125440.355578-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  1 Sep 2026 14:54:40 +0200 you wrote:
> BAP/UCL/CGITT/* tests request to read the different Sink/Source
> Audio Stream Endpoint characteristics.
> The first ReadValue call triggers read of the other characteristics
> and PTS, which tracks the read requests, may disconnect before the
> following explicit ReadValue has been replied.
> 
> First try to read the characteristic value from the proxy cache
> before calling ReadValue explicitly.
> 
> [...]

Here is the summary with links:
  - [BlueZ] client/btpclient: Improve GATT read
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=97431abc432f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


