Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480E54AFE27
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791471622; cv=none; b=PiW55I1vbuOVBPI/xFQ6+oX3Q+DnPlm/un2AWyGG57x7MAP8b+ugECsNYuulYRQQqeDfVV3esEHMnw1smcx9na5Gmc3osBPL3GtBhj2H6tKHTuMk+pk1Bj96ubfUxqa1K7YG5UFCElMoLmJtJ0x0elYMaBXt2UI3bCS2pnw2Irc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791471622; c=relaxed/simple;
	bh=XD6rJ7ge6C/AllTf7032VcJh8t5nBisauJFa4cSqQ+I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qvZEWvyj2FfGXX3yI32N9krJFWd+v5HhNtFPg1fFXBzJ+Tp/n5MKMTYhjs7IsdEP1PI7rgv1Qpy80QWOnm0CoPtcaKBLNRQl87O/LpEW5qV2041DOQnaJpOoq5Jrw+E9h8QT0Kxn2BF0vkFpJMu5IrYwQOsD62lU60VOBx9D1e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVUpdH2n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVUpdH2n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121511F000FF;
	Thu,  8 Oct 2026 15:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791471607;
	bh=/88n1vpEFZi4XCQAHlSneisEkbSXMjsCRqHHNbzu8sw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bVUpdH2nBNrcNoNKy0z+cTNPuTqni4nN4x70IeQ+dUsOHxQF1d/wbhaLJmCYiJpdu
	 I+lQyCmEfaGkIXeNff5milra2f5MEPS5Efn25hsWlkkzUZOi+GrCtmgTzdr/hOdxuJ
	 v5uBphex7mwOngerfLZEwFBoWgyp+/lu2julA6q2Av1cj9FCaHnRSD3dITLWJ6yEk4
	 aHynYPta+B7lDZmDgUOhDSrY+3L9UWgAf1sejzOesd4zhQMrAieuDq16VH5FQej6eu
	 rK87/vDIzOBG6hk+PWOaIksDARuHZZVCaAeDjkAY/XvMjrQYsCPeIya4Vu1ffeR3Bh
	 6Z35OBhFR/JHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F13EC380AA75;
	Thu,  8 Oct 2026 15:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/3] a2dp: Fix UAF after rejected
 SetConfiguration
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179147160555.307075.10575654872907648485.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 15:00:05 +0000
References: <20261007195206.350586-1-luiz.dentz@gmail.com>
In-Reply-To: <20261007195206.350586-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  7 Oct 2026 15:52:04 -0400 you wrote:
> From: Eduardo Alves <eduardoalves8006@gmail.com>
> 
> When the MediaEndpoint1 rejects SetConfiguration, auto_config() calls
> setconf_cb() with an error and avdtp frees the avdtp_stream, but the
> a2dp_stream wrapping it is left on sep->streams with a dangling stream
> pointer. The next stream configured on the same session finds it in
> a2dp_config() and reads the freed avdtp_stream:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/3] a2dp: Fix UAF after rejected SetConfiguration
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ef54133c69e9
  - [BlueZ,v2,2/3] a2dp: Fix crash on NULL session in auto_config
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=79aedd33f8fa
  - [BlueZ,v2,3/3] test: Cover A2DP disconnection during SetConfiguration
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ab5df7ba3019

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


