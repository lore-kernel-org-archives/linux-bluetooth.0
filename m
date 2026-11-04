Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819409;
	b=g+KSOlLTEl/+HjcPvtCHlqqso/ADnwGi3FVtItO73tolSXp3+t1J9ryCTNZ4YX3/bI1a
	 wboVMehz4gvOiTgkFX3gX/NiHmdmTs9o2jsGqfH1RSa4nygI6RUKMF/iVNA79Cb4W602S
	 p5o4WIwM8LciRhZvQTnhZST9OvjkwoS4G4kLgXAHBdNPaChLEGqPOd+AB5oE6JKawaBgd
	 HQTkUIr916J6B4S5He6V3NteVvrXOvALbHA3sCUIHxAjpKMiOiOOUJ9n/MyQ7wkudqdyz
	 7R3bKG8EZkgYxsIzj9j26BinQ/yQnvM67fOLwBOt1GWUwRVS5kggCAMWDpPZltK52zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819409;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=JvuXunZn3QovBJi3WpoLQRsQlRW4vIrskvY8NFwp+kE=;
	b=MalfDwLdw1vjAZyXQz0EdBKqTWmabXNKsNnL0UXHWmlsRhVPxCLeO2ALehPdYAYWLIsu
	 l59k13by7Sz3aY3fq5p38yI59BqDy0oUr6n80kjAaUAKxEH7+ACifE0qgU1KzSkWuzwMS
	 0p5TW91U9Wg1vt+VXBb202zfNckvXexg1Eib4hE+5/eU8wjeyVyTQbmMQuJ/WpT9R1Vp6
	 akQACWU38WQyMRpC6fi0KDAdYMCTrZIqIGFjuazB8nff6ORuTspt5nqZt0Z7Kk65C78HY
	 qbUinB/NoyNjFYtOlVnvL0dnjUXhIhZ/wRHgR1uZ80aI5/vJodpe/YGWQ660mSZuxgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZKkjcehq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9AE606A32C
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 19:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZKkjcehq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FEC1F0093A;
	Wed,  4 Nov 2026 19:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793819408;
	bh=JvuXunZn3QovBJi3WpoLQRsQlRW4vIrskvY8NFwp+kE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZKkjcehqH41vRNAXxWygZimPsvjsen/n8J2tBkYzu8X3lpYiE0k64Ei92uSDjWv0X
	 o76zqDOSWr11cOnJ0b7JQXsh7Fb6BK91KIBKyyO8reJasQUbbIQL8fbS9NMDEY0yIT
	 jNPUOdyY6kUBNED8HV4OW8ehsbXBU1z4lYdXre0dl0MaRBpKiNRIge9YqIW/cS9xtu
	 xCGVKhNEU11tPhJyAPToNqpX5OYntU2yZOeIw4ZC1PvDn4wqBb5YMWxVaDcA7qTQyo
	 NhaB1F7byZCsLK2g0Zt/cSkDBRWjpXqMWe1TnGQcsVHA0EKxvcv8nQdDHvyKA2Ur/y
	 RcSY6a+/Fbj/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D1B9380045E;
	Wed,  4 Nov 2026 19:10:08 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v1 0/7] BAP ASE state handling enhancements
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179381940730.3059479.12239804796316659769.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 19:10:07 +0000
References: <20261103203011.3904290-1-luiz.dentz@gmail.com>
In-Reply-To: <20261103203011.3904290-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  3 Nov 2026 15:30:02 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The ASCS server deferred the ASE state notifications by 10 ms after the
> ASE Control Point notification, while the client completed requests on
> the CP notification alone, so it could act on a stale ASE state, e.g.
> failing MediaTransport1.Acquire right after Release, whenever the
> notifications were not received together.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/7] shared/bap: Defer ASE state notifications until idle
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=93c2fcff3f3d
  - [BlueZ,v1,2/7] shared/bap: Wait for ASE state before completing requests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0828488099b3
  - [BlueZ,v1,3/7] unit/test-bap: Add tests for cancelling grouped Enable
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c45e032c9ad3
  - [BlueZ,v1,4/7] unit/test-bap: Add Notify Multiple test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=43054838bed7
  - [BlueZ,v1,5/7] shared/tester: Add support for alternative PDUs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ff30bb4a893f
  - [BlueZ,v1,6/7] unit/test-bap: Expect the ASE state following Releasing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1947529d6bb9
  - [BlueZ,v1,7/7] unit/test-bap: Run unicast tests with Notify Multiple
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=121dabd8be93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


