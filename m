Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17101428487
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777557051; cv=none; b=SmVStflw3k4EYb/j03sgejQTxbqhfR6o/8KfeaVynv5UQS0zZgXYb3K0wgAGUGrHEnvdR4JkVJvBj7Qa0qCn5bdJfYN171K2Tbd0Zy0KKfq8S+XgtQgy3Do0zJpEI5zTQzQ+s2i7CInav6yeiEY9mgJ8cEYAQD0XCSPkg1LH2k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777557051; c=relaxed/simple;
	bh=0Iftk02be3KZFkxleeyVN3cziFdfQhm2oksy528efus=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d01BJeTF38CsIIpor9lJj0J1KnfMWxpvH60442kGHioVQOFLLvOEk0ZpKbgy9BTBLD0SY13qsskt9ns7QQYqsnzOL25sul6q84HFjJofSFdCG6NUuDtMF4C0gaM8qAWw8ZLJQbOBZEUPeph2xXs1XMvJEEujCs48Ewni0YLEM+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUxmBulD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUxmBulD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2482C2BCB3;
	Thu, 30 Apr 2026 13:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777557050;
	bh=0Iftk02be3KZFkxleeyVN3cziFdfQhm2oksy528efus=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IUxmBulDsPSlCs98LiL1M2l2zKjiNZmBCwQ6aCW6BldaTzdERY8dHhvAbeKShsRRN
	 0W2eJEzGUlij3H1e0n1Pu9zY/RVNZw4gtvSfkJpQhHBV4XQL1qLs1y5Z/ywI6jtPIG
	 ZWIEsQlHesSp94PUEmR9gO3p/hOJ9+RDGLhhtm7mxjCu7GdS4WyCT/bI73V2EK2lpz
	 v13GISO6X3U8QgE+BJlt1vkhWVxuuMyLLY2E4RtkZI21Xzd2adFaCriEKa930Q8Vct
	 xi1ahVxD0GOkN6QZ9iFygA0kqW3W1TthK62fDBdsy/9qCBsaMzvUEeLzSKeAJ+xQAG
	 2l+uEseh4mxTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDC1380AA58;
	Thu, 30 Apr 2026 13:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/3] Add ability to desynchronized transports for
 PTS
 tests
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177755700530.3016640.1398071455851267228.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 13:50:05 +0000
References: <20260428080314.180777-1-frederic.danis@collabora.com>
In-Reply-To: <20260428080314.180777-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 28 Apr 2026 10:03:11 +0200 you wrote:
> If bluetoothd is started in testing mode a new Desynchronized property
> is added to org.bluez.MediaTransport1, allowing to prevent automatic
> acquire of linked transport objects.
> 
> When desynchronized, each transports needs to be acquired separately.
> 
> This allows to pass PTS tests BAP/UCL/STR/BV-543-C and BV-546-C which
> requires to connect the ISO streams with one ASE in "Enable" state
> while the other is in "Config QoS" state.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/3] audio: Add ability to desynchronized linked transport
    (no matching commit)
  - [BlueZ,v2,2/3] doc: Add documentation for CIS transport Desynchronized property
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f8a2e6124b36
  - [BlueZ,v2,3/3] client/player: Add support to desynchronize linked transports
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=304bc5b78a3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


