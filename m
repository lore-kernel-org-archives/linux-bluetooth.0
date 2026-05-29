Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089D8342CB3
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069202; cv=none; b=qf/pFLSgmB0XCDaHuA4ZLxkGHsLWs82HzOqoEGAdkbqz64ePzLwhhos/H6lvHNlDs9H+VYHmEXx5vXQYw2jr84pA7tC3QzJZQkYSgbNFnZZbFI++1C5pyyN1x0loDkrh6gAj3qA8aZF7pIxEnTwq4B8+j4vHT72mCq1GrmQDSzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069202; c=relaxed/simple;
	bh=dgwdVtIpk5M0jvcWyMicR1iF7+28lAD+3Q4sioEs780=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j3pqKDHMwqU93gQs86ObE3C1sEDGZS3pHR/8etSsnd3bhPQOgA4PCiRF2q458WUq6WwIzWCOApDqfRmy9MnGq2eqsVAQJn7PlAyYyN10dyhg2OsZADEKB8eusefKOJ2XGsScJsKJRBLEarqmRFroapE0KjtZpsOKb/JYz1HGU44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOcoadEz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOcoadEz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39A31F00893;
	Fri, 29 May 2026 15:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780069201;
	bh=jMblSMbAcoEnOWAnEDUG+/e+2Ri0mPerI/oRb3H5TV8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UOcoadEzcTMnOAxIV1ZAmb46Wy/WrR6jiRafu3nriilF5/hrKNT4qlU1xPUBG8Phw
	 JSikdtPIfA4/KZXIkrjIeyGKGB8nKIC+gNtmIo3rUWXkNPgTOZ/Gu93wFqiN2POfbV
	 ga4eulu4lvCogF7RJwT2zgq1HyXbRFQmSvC0B5af5AHiMxTbb3355VZaMpxJvSrPKn
	 8vUCQ+tDobz/I7/qtOflWbdAPNs6R8Im6Ew0x7H7jF41ftwKwubTZsFvYXq26t0gTw
	 UjNBlX5P/1VltFX+w0SAMxzokLHqVCJar66ZVZt4LsCGYbXfMeHSZW12PaUVmAhe2T
	 xg4AA/2txjgoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939563930193;
	Fri, 29 May 2026 15:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] mgmt: Remove mgmt_ev[] strings of undefined MGMT
 events
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178006920515.1860060.15343105151373911701.git-patchwork-notify@kernel.org>
Date: Fri, 29 May 2026 15:40:05 +0000
References: <20260528074938.385847-1-frederic.danis@collabora.com>
In-Reply-To: <20260528074938.385847-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 28 May 2026 09:49:38 +0200 you wrote:
> Remove event strings introduced in mgmt_ev[] but for which the MGMT
> events has not been defined.
> 
> Those events are already part of the events_le_table[] in
> monitor/packet.c
> 
> Fixes: f9557931ad36 ("monitor: Add decoding support for Sync Receiver events")
> 
> [...]

Here is the summary with links:
  - [BlueZ] mgmt: Remove mgmt_ev[] strings of undefined MGMT events
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=17fbb48d8f7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


