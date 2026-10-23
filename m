Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794013;
	b=Fo2R3r8UBGSumm78jl1o8ruxHXXX37C3pKMuJykeG0Bmh09HEOa3pA/MHqBQQAFlFoR6
	 qqtCYihG4BTVtBbvBCGd5Y+q46nUtUjJ4xsF8QdMM4Guyg4gr9RXLYRJL80h9L1hLtKP1
	 H6TdLMi4S/FrJB6x7LRup0LH/cewbhhddv88qabJww/er7pd9TwnvWCxmucG2QAtgMnHj
	 I49/yUeep+g22wVj4tAp4+m5VM3lPdbf6WGl90/578/ushXHqFkr57DQUlrNknv0PyISn
	 9uUSnyV4ON8lfhlfGfTfzaARNYcXfmXFMBR83soaQvG2HUgpg+yUDsF7gKcbC48iu5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794013;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=9fvb1p4QdZcmn5kwAfH0wGGj6lAeHNMgiZrDNenaii8=;
	b=mp2iplqg8G8Wg1rfEdVaTDMKbbapwv/4avWuEgWMEkzw/8YBn4853lK0TUb5+JO0W34d
	 t2lduUMPgVhzXfnQyl1Lgsb4CbfysXybMCc8BS6l2NwqAa8uIZb1FGKo448n8ViZbal+K
	 woQww67Qd6beJNT/EM0O07uPuYPFDHudGZhvts/KPM9aKCDcVHHZoeoCB5J0aXHDICxlz
	 Et3fbMhILgLwco7W0tTseLqxsq9YFyMuz+O9IzhbkCEz+HOA43S8rUUuj0mtnUN17h795
	 YtR+Udzl/+sPEb3lAKP+WRM2bQyyRJUX6CDSB+uY15ZISYRMwyaWAjLUpAF8RUyu1fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mojqbWzi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE006606A31A
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mojqbWzi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDE61F01825;
	Fri, 23 Oct 2026 22:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792794012;
	bh=9fvb1p4QdZcmn5kwAfH0wGGj6lAeHNMgiZrDNenaii8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mojqbWziT1hkwyXCEzrQsYKJ9Tmlg13XNf6CMe04Rz/e4JNJi0BWl5qvdTKf/LPVM
	 ZMpw2iPCkKGWZlQIx21POd8lRPMVOKUxqqtuDrNR9KpSvxFkVKIY5PeioF0xHay9h6
	 rk737u2pM4+3g6S0dEgV+iiOqZlryVJOZI8Sp6p7usn+CoWROb/ObI6Nrm0fqSPFar
	 SQDCfInD1nFlCH3/GN4V8M0psntIGfiUy/poWJvN48OI0K/mbyOrIaoNKJUuHY3AMg
	 /JXMD1OvTgnOI04yLnd5WTKMm5RQHzd/MitNNfcF96GKfVsp0FrosEizz7IjSR3RhI
	 ADJ42qBU5R7eA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4454D391B158;
	Fri, 23 Oct 2026 22:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] doc: Add CONFIG_RFKILL to the tester kernel
 config
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179279401107.1297354.6783483439385343291.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 22:20:11 +0000
References: <20261021072133.136948-1-tooangel@tooangel.de>
In-Reply-To: <20261021072133.136948-1-tooangel@tooangel.de>
To: Tobias Wilken <tooangel@tooangel.de>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 21 Oct 2026 09:21:32 +0200 you wrote:
> Needed by mgmt-tester to block a controller through /dev/rfkill.
> 
> Assisted-by: Claude:claude-opus-5-5
> ---
> 
> Notes:
>     As far as I understand, this is needed for the following mgmt-tester
>     patch: without CONFIG_RFKILL its new test is skipped instead of run.
>     Please correct me if I'm wrong.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] doc: Add CONFIG_RFKILL to the tester kernel config
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=48bb3b396980
  - [BlueZ,2/2] mgmt-tester: Add Set Powered test for rfkill block
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1445a64e6b99

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


