Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D6E331EB8
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 19:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782243017; cv=none; b=O2dzGqBuztyovlpF0GRmEwfCpzQQUesCrmg3MogIcVBM6Gi5bNBs257mcBAqt9G1bQA5hv19Qx37+pWITTJtRmmCBI9ZDYH113zq3A9iQSimQQZ3U5YF19gu6CgUJeHI3FxKCG45N7KNevFiHr1qXKQHxgadJzZYzk31Poek4pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782243017; c=relaxed/simple;
	bh=p+i6aRAzusAMZ2LD+uzSLGQLvsdICH8rW8lkIFs/VIc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hl3fr8CotylUUbu/VhLprc0mRvcFqY0zxoQn5mYfDCeRfWae62Dz0AYsWciSOnSMnEaM5KoJDjgn9IdgxKUhSNMYmhfV3x2D6MqOJqw/mgup3c7GxhZ90nDdmW/0jDHRjcelYHATUlzSMJUI9rkY5Dbgud3UEzMq0PVhJQphFmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZI/4RVqw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZI/4RVqw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F251F000E9;
	Tue, 23 Jun 2026 19:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782243016;
	bh=DJoJXDzUOpFwBrGuABLORckq2V1V4S9C+vRl6xArElk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZI/4RVqweZ5CHBlX/dZ5S1koM3mcovIRzFne2vCVZWAue+ZlGJNsKDdwmNlCpmQQc
	 Z4nCn0HAFzRynAUiRzfLYcP2doHhlgJfAjHNmZ6FmP40MOV1vTCKsDrZqVcvR6LOEU
	 Zb2dyGIQVSgBIAStS407q7T9xzrCHoSlmoA44SEXgm+CqZY/4987rr55nxy19Ocb6F
	 Zo/Iv6RKc8gICGiKuQfPfHQ/iQqNBXs9JPa+rbvol35+t7cnTCwPus0Q9PZUNpaKTc
	 igkU2fg5YJFFnF0a8Q9hH5hqiYNAs0PfG7kiphuTJJIRGCuxfrDgfH8y5WM52lQLQ3
	 +/V4ibDkOSWMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569273930FBE;
	Tue, 23 Jun 2026 19:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] a2dp: Fix handling of codec capability storage
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178224300576.2383519.15444926184926920967.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 19:30:05 +0000
References: <20260622155621.675255-1-luiz.dentz@gmail.com>
In-Reply-To: <20260622155621.675255-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 22 Jun 2026 11:56:21 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Codec capability is one byte long (max 255) the storage format is
> 02hhx which means each byte ends up as 2 characters so the buffer
> needs to be doubled in order to handle capabilities of that size.
> 
> Reported-by:  p0her (_@p0her_) in TeamH4C working with TrendAI Zero Day Initiative
> Reported-by: Michael Bommarito <michael.bommarito@gmail.com>
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] a2dp: Fix handling of codec capability storage
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=912f5efb0dd9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


