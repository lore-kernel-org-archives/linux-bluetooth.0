Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744BB4DD3BE
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 20:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231610; cv=none; b=OWcWWgUn2rRZ5DjQZ1gqHi3Q3H/lY3oWTUoeHJ0YxjcvUa6XjNKp59GUo+MF0zo7eUre/bs4spvReg50+rGyUSYcLQ5nJRd00UeBD61mY3ep77yDZpdT7gzvOy6twliU2CKCU1xLCtWPHlBxC48CWEYpvj0/TzYpmWRXK6v7g+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231610; c=relaxed/simple;
	bh=AGzo3/8ZWCn0XkFZGjM95DUWbWM9JBrghqRtLdxqPoU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pIyAF4zoUf97HttcQjFTt87lBRrpnjyvhhxDaVRIAd52TAEZ3glSOpy/8mta2cNWcs7mKC1QAK7NVj71v5QaUwziHB1AimihxDWbL69SCrH5MzAmUIO87i/eTg27KXF5qG80xR8mDVQDC2dacxCCTPUDRSpAvhXoGgwltjLg0kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dubKwBnv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dubKwBnv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E541F000FF;
	Mon,  5 Oct 2026 20:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791231608;
	bh=5qDz7iHKcX1khSPiMlDZaAtGjpSSuGqT9tNoFmAhTt4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dubKwBnvaT+4/AuK+1ZD7/pZ/u8QFoSm/hlwA9BgZ80Q7BGRwMtiqT7Dcwi3U/wyd
	 Hv1zJfkagt+DBGRHLE3rMhIzcLr8yO0g09+pDw9tWVYGe0JWqlHgsKvYzdHja8ZGeL
	 p2eQm5tG7nudoSAteh9THW5oXvhfC6KksqfcfLYgOLKpecYqvLj+un0s8lvkGHtb+M
	 bgMinQioi/8xGp6RcyWlvKwbk77UdqHFc7ktwUwb7Hs5ontFiJPOV7jOJGu093e2HT
	 1840poMScDI9b/S97yqUUZ7UZbiyXauvXA4Y1UGH0dnghlnFRs09M/uMCxr3cheDS7
	 lA8p1h+HD8B6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A34B392665B;
	Mon,  5 Oct 2026 20:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 00/12] hfp-hf: Enhance HFP Hands-Free profile
 support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179123160703.1879401.13552645753482333474.git-patchwork-notify@kernel.org>
Date: Mon, 05 Oct 2026 20:20:07 +0000
References: <20261001211036.1760396-1-frederic.danis@collabora.com>
In-Reply-To: <20261001211036.1760396-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  1 Oct 2026 23:10:24 +0200 you wrote:
> This series enhanced the HFP Hands-Free (HF) role support in BlueZ:
> 
>  - Registration:
>    - Register the HFP HF profile with an SDP record so BlueZ is
>      discoverable/connectable as a Hands-Free device.
> 
>  - Audio path:
>    - Register a MediaEndpoint1 per supported HFP codec and wire up
>      MediaTransport creation/configuration so SCO audio is exposed
>      through the standard Media API instead of a bespoke interface.
>    - Extend bluetoothctl (client/player) with matching menu entries
>      to select/manage the HFP HF MediaEndpoints.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,01/12] audio/hfp-hf: Add HFP HF server and SDP record
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7878ae60a2e2
  - [BlueZ,v2,02/12] audio/hfp-hf: Add MediaEndpoint for HFP codecs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=89b91a4806fb
  - [BlueZ,v2,03/12] client/player: Add MediaEndpoints for HFP HF codecs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9e2a7ddbb178
  - [BlueZ,v2,04/12] shared/hfp: Add hangup all calls support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f7fd0acef7ee
  - [BlueZ,v2,05/12] audio/hfp-hf: Add hangup all calls support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0a8dfeff2f79
  - [BlueZ,v2,06/12] shared/hfp: Add send tones support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=67883db59611
  - [BlueZ,v2,07/12] audio/hfp-hf: Add Send Tones support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e9046f3fb78d
  - [BlueZ,v2,08/12] client/telephony: Add Send Tones menu entry
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a9b8a5ef6ec7
  - [BlueZ,v2,09/12] audio/hfp-hf: Add multi calls support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2a4adbb2a717
  - [BlueZ,v2,10/12] client/telephony: Add multi calls support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=45384edcd1c7
  - [BlueZ,v2,11/12] shared/hfp: Add codecs support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=003db6420008
  - [BlueZ,v2,12/12] audio/hfp-hf: Add codecs support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7edaa6140339

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


