Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C919919CD1D
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785426042; cv=none; b=h0vp3aaVF1DHilVqFimenC8Kt2UrbiqGCvnCP25tHJXZKJbmCq4HKXxCvWf+kW7ZzGQWcOc4Fu/WO4cbokeYu5a9dhxrcxbvMV8RRCF3NSjxvNUJS8qunzPTzyRBotS2tb8OpkrGv7LpIeCX9QHf7dQ73L5F5u900U1Yi6eOjaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785426042; c=relaxed/simple;
	bh=+E8jxnoe7LHpB9H8Ew2T8iO8Gv2a0A+3nWv42BKN0Nc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RP9xDBuDQAGW+wsnbbGurk/GVMlv6QTQ/IFiSn0znF0GRkyqK4rjDbXnwz+GcGU1NYh6+7OWNgTnIzV1Lf5pSUbM6+oFZYp0w2MgQWXla672gTPXDphEwcaS46gSF4OzAgR/LzInYaTtY+rYYT229PkFInAsEKBXt0or+yT6p/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mv8Huj4V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mv8Huj4V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEBB1F000E9;
	Thu, 30 Jul 2026 15:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785426041;
	bh=souhhDZzoO/99Of/3tsQal7MuU/ZQEzlMGeiHhDF6Gc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mv8Huj4VaZdmiD+tCt51Dq3b+7e8zfeXBKlnmUxkvJhf9p1DUTPI6iuIVoUVgONe+
	 tJYs1t2/8ZGNmgtuOz4b2pZy6Hn59WW0xbQtisk5fnauN1hWWWF4VIES0Pg/73Y/Nf
	 //Uzd2YU2az5N4ujQBP1IyhJIpRTin6liOekpLWP4QyOx2x+KB07M5eoHNe5/0LKGd
	 2dMYZu/NIld9fhq/B3hiLpk9yLlI2/1x69Z3NyMPMJm+oDivsWTgsZEHPixjLEIvIL
	 Fax327F1PHSC0OIVNQ8N+1b6/H3yYx4/uqHOHfndHDSvFuxfU6U3g6b4td/uVqXVRl
	 P2hJi5Ulg7GhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569CD38119E4;
	Thu, 30 Jul 2026 15:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 0/3] Add CS procedure data aggregation and D-Bus
 export
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178542600500.4054893.17804747751609690022.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 15:40:05 +0000
References: <20260730064007.1229304-1-naga.akella@oss.qualcomm.com>
In-Reply-To: <20260730064007.1229304-1-naga.akella@oss.qualcomm.com>
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 30 Jul 2026 12:10:04 +0530 you wrote:
> This series adds support for collecting, aggregating, and exporting
> Channel Sounding procedure data to userspace.
> 
> The first patch introduces a new procedure-data aggregation layer in
> shared/rap. It tracks local initiator and remote reflector results for
> each procedure, combines them once both sides are complete, and provides
> a callback-based API for consumers.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/3] shared: Add bcs_procedure_data aggregation and procedure data API
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2f94d65b8c80
  - [BlueZ,v3,2/3] profiles/ranging: Emit CS ProcedureData signal over D-Bus
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6b74b0bb1f00
  - [BlueZ,v3,3/3] doc: Update ProcedureData signal doc for byte-blob format
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1896d365decb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


