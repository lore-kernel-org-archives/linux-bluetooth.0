Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F5B52F29E
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789666275; cv=none; b=X1usDXSLV73Hypyk4ug4jYw+8mEHSKTHzYqRLNp9h6vr+3NZ4MbFdS/jDbACRhkFoWCAGhPWQyyYn67d4rXMoA6os/6dV2j5azpe0Bv0KhahAhfdftmEHSJQ7sBseAwnxVcngR3CJF9GGtSef7ryFJIJ1VxMl94oVmDRPYL1oak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789666275; c=relaxed/simple;
	bh=jYsgdwwc+ebQqdowvW50UpLf/W/rr5+IUNHmk4DKKJw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JoyK8b+3DXO69XG3f1csI0mvBR4cjod7MNcdlGvlbcROuwjqn5bR3C5OvglvZG6eY44P2dKdXDvz+0c15D2CC5Gq2SjzpReRf0eOYsRl8QqU+suN/bsqAaq1Y4YWL61C6gtNjz79ZtbIQYHzetfrUicCbOV4Th0RoLz4zq3XxNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKHTy3DK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKHTy3DK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4CB1F00898;
	Thu, 17 Sep 2026 17:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789666273;
	bh=svlcI+yeIkajF1kTSSVRNThqv2Yg4y45zUvg1cKDh+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kKHTy3DKKCyZrmkgfmQNB85SppHHedfDik2b3CK3BV7Pd2/a7Omg2omoXEdjw/u9K
	 Uyb9n/gjMkplz6yKCTtAyUpPG3aM1fqflW/tlBGgSaU+v8heG9GjyuYMhjpioj3Zld
	 kWfYGtL5a69qhE6dpgLpiDFkd0Y59XIHKvUmJsVRosz4n05YzTjdJaAXeCf7zcvW0N
	 7DM+X4lAImjlkoLtlKZRjRTaETulSGj85cixKO3il1kREcjNAksbJcbJBPEBUdeASV
	 blp34ByLHB/BuJbi5jnw3riLFqcUsXaTIDHF3wAjRxP6io4BZWZQimmrRaKKqOtcTr
	 M3NAGan4fSYZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A28381197E;
	Thu, 17 Sep 2026 17:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3] tools/l2cap-tester: test closing sockets with
 ECRED
 defer
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178966620712.3782583.17931029681010994590.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 17:30:07 +0000
References: 
 <eb21dbe69ad000c457f63d0de3caf2aa68dbebd8.1788296637.git.pav@iki.fi>
In-Reply-To: 
 <eb21dbe69ad000c457f63d0de3caf2aa68dbebd8.1788296637.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  2 Sep 2026 00:05:06 +0300 you wrote:
> Add test that does defer accept with ECRED with 2 SCIDs, and
> accepts + closes the first before accepting the second. This triggers
> deadlock on some kernel versions.
> 
> L2CAP Ext-Flowctl Server - Accept 2 Close 1
> ---
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3] tools/l2cap-tester: test closing sockets with ECRED defer
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e9b6ee3808ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


