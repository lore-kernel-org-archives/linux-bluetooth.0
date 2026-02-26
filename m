Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CB639282E
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137200; cv=none; b=U0nA3cmOsVr8b13W6NesDJQlEoMSSd8FB+XSRyx1DylvthPjiXeFostPWgVsHvAHb7B4TVfKMPIPjGqdbDN1OpFl88KfTOSVwGTh+TCsEvnHV7zbbRU2m37jU+TMxzs79flL3IOQmLc2SEd8Z9E3Dx3I/VQfTsghNFlZ+EVA8fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137200; c=relaxed/simple;
	bh=ztfaNIxoxYGUsrIHYk7iUcfgdwRQMIksVy+2ZHB7Qsc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h1ldVuPVPJB0JA+BFcrvrYKrZLT8sPiHiJNo/oqp6a6lhRvdJgtDrK/gyNCk/mDStZvmm04+4jUAZhVs4SFg3zmC12KmYnNhRp0bt+Yx55H4QPDEsNW0sQiiV+tpvQFCsAVaHObhkdCBdbuvGXt6xEZn8QGMINW303NUixub7VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgjmyjuW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgjmyjuW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1038BC116C6;
	Thu, 26 Feb 2026 20:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772137200;
	bh=ztfaNIxoxYGUsrIHYk7iUcfgdwRQMIksVy+2ZHB7Qsc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kgjmyjuWp4eI15PJmI+R/LFGxRXXFQpQP/f1DQ3mOT4TrcY1Xt39uGGzzSxBK4UTR
	 ggS6O40nwHcP+EdbhyWoaMrQpBT+GJUhvbG16DkxMcaTEkOfwlDftDPpVSjNSwVEO3
	 oJ37FWYUXR4c/4zMliF0SWUYj6huQp1jKqId4ybsX27CcjsYf3szSXPuoTN22yse6C
	 Da1VP8s45dI3v3O6SV4CZeYKqObkVKaHNmqhl/xA7gBDyJrD4VjZsLh7Gd1q7QZq2u
	 LXEgfI10m37fcXPiW5/zA+6jS/VvvA3+7sOG/kwlrbnu/sGwwOj1M9PnCAatQ+dAZj
	 Dj1TJ3DUHsK7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEF73931091;
	Thu, 26 Feb 2026 20:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] shared/bap: Fix endpoint configuration
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177213720429.1831177.7725009376083649159.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 20:20:04 +0000
References: <20260223120142.205159-1-frederic.danis@collabora.com>
In-Reply-To: <20260223120142.205159-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 23 Feb 2026 13:01:42 +0100 you wrote:
> When a first local endpoint is created after connection to a remote
> device this doesn't trigger the SelectProperties request because
> bt_bap_bac ops are not yet set when bt_bap_select() is called.
> Creating a second local endpoint allows to trigger SelectProperties
> request for the first endpoint.
> 
> This commit fixes this behavior by setting the ops during bt_bap_pac
> creation.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] shared/bap: Fix endpoint configuration
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=21459ac269ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


