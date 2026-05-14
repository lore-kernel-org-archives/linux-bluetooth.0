Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA07388E6E
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778781063; cv=none; b=fH1x1iZ7DSISwZBnb7fbrKBBedWLh/Y01nPQlwRaEfD2OOHYhGYTcEyVFyn3LpD79Vz04yTDMmWaB9a8rEMf2+PC/U2w86waAEky/xr9vmCy8eTSwEmUuAfmD8RuV1KPLUtmxbhgokkr2UXSery+CXsK6CUMtsdKTkCTTVy9F2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778781063; c=relaxed/simple;
	bh=JFsR7NxzTm6DeN/mUdPqh2u+dXSCuYjPFocQzURCkus=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F/NuM4pBNInHgX9zQvWmptq8SaDWp6VjVTebPOVVSojcdU10+qgN2gp7Uw+kVP8Xe0Z4Q9UMWrXw6oOzFktl4NIAOvBFhRspoUp5ZSvWPqs0YL6jDcjogoM3/HEOn4r3xeDMWnVKLWnYSJuVJ62q8rbtS+uOTtFBXg6ywiSg10c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKCDULDX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKCDULDX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC581C2BCB3;
	Thu, 14 May 2026 17:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778781062;
	bh=JFsR7NxzTm6DeN/mUdPqh2u+dXSCuYjPFocQzURCkus=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eKCDULDXNX8cNh2nxyceNmjMeZtvLRDFD9BIxV7FrABP7PrEnVRb70Wnd/YqTJ8nc
	 43uQTmyaZ7+Q56bNWDsjgI0R3/bZaT/peuIqcN2T6yfSauuOL6SudoCx+KhyM9mtRI
	 LXM5NxBWMPrqGh51fl7dQ0vIWy7wtthWzUhEJBA6xS80Wk3mCHi8/7Yf04b2Ul3Zrv
	 BiB+soa7KgAAeZdfKemkyhMGT6w53oXuEUDL9Y6KennlWIl/OQbeKsJp9KBEUqpCKK
	 2IRKsTlGrcK7isnhZz8+xXDuUAakMfjYFpYQ+isLyMCLnJ609g43M25CTTkIDAaHay
	 j11vmMzYpfsug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F3C39D657C;
	Thu, 14 May 2026 17:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v5 00/16] Functional/integration testing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177878100755.31561.18184220318055008237.git-patchwork-notify@kernel.org>
Date: Thu, 14 May 2026 17:50:07 +0000
References: <cover.1778688966.git.pav@iki.fi>
In-Reply-To: <cover.1778688966.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 13 May 2026 19:17:17 +0300 you wrote:
> Add framework for writing tests simulating "real" environments where
> BlueZ and other parts of the stack run on different virtual machine
> hosts that communicate with each other.
> 
> *** v5 ***
> 
> https://github.com/pv/bluez/compare/func-test-v4-r..func-test-v5
> 
> [...]

Here is the summary with links:
  - [BlueZ,v5,01/16] emulator: btvirt: check pkt lengths, don't get stuck on malformed
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e19c771841e9
  - [BlueZ,v5,02/16] emulator: btvirt: allow specifying where server unix sockets are made
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5ee43f9993dd
  - [BlueZ,v5,03/16] emulator: btvirt: support SCO data packets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cc077e4a12dd
  - [BlueZ,v5,04/16] emulator: btdev: clear more state on Reset
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f1a303e1d07a
  - [BlueZ,v5,05/16] test-runner: enable path argument for --unix
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ff2ecb82e4c3
  - [BlueZ,v5,06/16] test-runner: Add -o/--option option
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=82c635c879bf
  - [BlueZ,v5,07/16] test-runner: allow source tree root for -k
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1929b3a99d2f
  - [BlueZ,v5,08/16] test-runner: use virtio-serial for implementing -u device forwarding
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=908c14fc3abb
  - [BlueZ,v5,09/16] doc: enable CONFIG_VIRTIO_CONSOLE in tester config
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7856de4d69d6
  - [BlueZ,v5,10/16] doc: enable KVM paravirtualization & clock support in tester kernel config
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=48cb22a572c7
  - [BlueZ,v5,11/16] doc: add functional/integration testing documentation
    (no matching commit)
  - [BlueZ,v5,12/16] test: add functional/integration testing framework
    (no matching commit)
  - [BlueZ,v5,13/16] build: add functional testing target
    (no matching commit)
  - [BlueZ,v5,14/16] test: functional: impose Python code formatting
    (no matching commit)
  - [BlueZ,v5,15/16] test: functional: add some Agent1 interface tests
    (no matching commit)
  - [BlueZ,v5,16/16] test: functional: add basic obex file transfer tests
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


