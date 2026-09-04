Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2304C39184C
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 20:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553273; cv=none; b=bdUXxF8zofiZb6/sSofiFQnM/wr8BaDvb9KgSuYxtV4IwKqY/1i2TxW4g5pekvKvoWKkzEaIB+I3l+2vJxvHByheUxzJtXhI9QT0GnPjlP6Y9uhUXHr97jz6myW2eFJfApEIVNGBlUnQHEYb9Jt0DozeUiIYBhPHGnrbz0gPCro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553273; c=relaxed/simple;
	bh=2nmRHb028uXtF7NGcTEsurresH/aJ98CQj04BkaG1zU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jiQtNebDSnjVWgySrTD79omCBRoaZZmjeg1xsSiWmNZU4640SFg9g4/PPTpEQF5s0AWU+VnAvFR73osYZaCWnqP5WuEFTibsTIX3pI1Cp1Hf1pn0+HwJpg+YoULnjRIumuBb7uBO2z3mvo0ek8Esii3bPPHBlxyBk/OhdPxdczA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcgSIbq8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcgSIbq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2D11F00A3E;
	Fri,  4 Sep 2026 20:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553269;
	bh=Ca/GAGRYtPOvSVNeRe3nMDSdxfAc8qlfG+7+0zOyKsw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bcgSIbq81Rja30R/hIdL9pbpr7firycZn2dBafLdTEaESEjQmW7QMj9MJqdmX0yDl
	 7W1+yos9eFf+0FdjOGkx8X/vu/sLC/98tQax5kaqqWdlcBW7OWpu4Di5x+Hba8phe6
	 pcpIxnHwntWMUeAmMhiQhdZJqxDQNu6kMB6xs+aXIDAukpCyjwhxJmYdsLyOLhNnRR
	 STBIF7pDCYdAjb4kRl2FT6nWREbvluwDbBPqY2OTir79fMd5WgJebCBhvHHUAXa938
	 yYTr0noWeYBCRYDXfjTiG4H6jfxzq0429tzNTivfuJwN1KLQcsk+w8uPL28wysbOlt
	 MrTQdDrUJDpBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A193924A6E;
	Fri,  4 Sep 2026 20:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] adapter: clear discovery_found list before
 discovery_cleanup()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178855320963.954520.13487698152670558162.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 20:20:09 +0000
References: 
 <3a496bd2c05e7e7f9f8285d155837208485b7a0b.1788471489.git.pav@iki.fi>
In-Reply-To: 
 <3a496bd2c05e7e7f9f8285d155837208485b7a0b.1788471489.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  4 Sep 2026 00:50:33 +0300 you wrote:
> discovery_cleanup() tries to reset RSSI of devices in
> adapter->discovery_found list.  When called from adapter_remove(), the
> list contains only stale pointers as devices have been already freed,
> leading to UAF.
> 
> Fix by freeing the discovery_found list in adapter_remove().
> 
> [...]

Here is the summary with links:
  - [BlueZ] adapter: clear discovery_found list before discovery_cleanup()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7e3212fa233e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


