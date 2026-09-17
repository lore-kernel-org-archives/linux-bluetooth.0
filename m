Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6663DD521
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667473; cv=none; b=SKE2Az4EsiNNPp8ROgcg3J0oFz7aRl48FQM+MVX3mEz2UEsAftpkwAuf9sUQGirj2QXKiOycBGiu/+hE279jk0zu+ZinnWBR2sBEUHRNOyQ710kAH/Z9c4B/zR/a6r8wyAbjqYIU2+mphDO9Qi+c/NWj5hkZA7HOtpyzNhCMCpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667473; c=relaxed/simple;
	bh=pCPW1ar9njagOpktgAf4kwywDzc+c9BmJcRtq9kllZ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kgKk5snyxlm3zSdU6MqsFkZ6tm85hW3PBBsx46Scm4ZTZa5OXQpjT2J+8nYrAP3mp5vN9PL/Z2I7nK5SQACniLKSECdgEKg8+W+UC+WRmAzIloXHQ8qyVSLNtWQlhoh8CLU5JlcFuj3IAVdkg6wTpSSgibr0/0zo4nkiL8XrL0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6ajwydY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6ajwydY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A9B1F00893;
	Thu, 17 Sep 2026 17:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789667471;
	bh=qq0vjF0xknXs48fpkd+shAJxL7KlUZSq0JWAdeT0uCc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=m6ajwydYel3pCvaDByEL/69SfdGyhauUEL45VzKoEvaClVdUNTly2pxbZ44vucFzy
	 qwIRB3SYGKNpyHfUHC7nl3ahS+a7jl7QURfSuD76EoXAyUAbiMJaGEqN0n715NBcja
	 1t+7Vas5c+r83rXm4sWuXS5UNeCGfnXhlJwNftIBSxr7EdhRZTwFR89NeI/Lmk3ZBx
	 m+rhets37VzjHxhBLi6PC+w4r1fTf3HkITze3uUbTtsEnc0FkZ+qHNslf0Hpb2aMrh
	 0nsLTetsL4kB7YhsmFU6W1AUJSjnkNs25UcP18HoDwAlG1nQIl8fMxJ+2jyMGVoh1v
	 4QEJksU9DjECg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93DAD381197E;
	Thu, 17 Sep 2026 17:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 00/10] monitor: Reference request frames on
 responses
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178966740538.3795449.1357487433014753768.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 17:50:05 +0000
References: <20260909182840.1289776-1-luiz.dentz@gmail.com>
In-Reply-To: <20260909182840.1289776-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  9 Sep 2026 14:28:30 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> A trace shows every request and every response, but nothing ties the two
> together. Finding the request a response belongs to means scrolling back
> through the trace matching identifiers by eye, and the time the other side
> took to answer is only visible by comparing timestamps by hand.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,01/10] monitor: Reference the request frame on command responses
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5a8df006aee2
  - [BlueZ,v1,02/10] doc/btmon: Document the request reference on command responses
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f3b1d4d69834
  - [BlueZ,v1,03/10] monitor: Resolve commands completed by a later event
    (no matching commit)
  - [BlueZ,v1,04/10] doc/btmon: Document the deferred command references
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0c926ea1a432
  - [BlueZ,v1,05/10] monitor: Report command latency in analyze mode
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0f726ab43454
  - [BlueZ,v1,06/10] doc/btmon: Document the command latency statistics
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d70374128764
  - [BlueZ,v1,07/10] monitor: Add request tracking for the protocols above HCI
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7b0f38544cd1
  - [BlueZ,v1,08/10] monitor/att: Reference the request frame on responses
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a565e23cce68
  - [BlueZ,v1,09/10] monitor: Reference the request frame on SDP, AVDTP and AVCTP responses
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c2840bd827af
  - [BlueZ,v1,10/10] doc/btmon: Document the protocol request references
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2401054ca67a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


