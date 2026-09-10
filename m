Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD99E390999
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073477; cv=none; b=G/tcGWASvgYfv3hPywnZ9FlYag311CHTmHOxPMHUOqR8h64SV37lZ1Q7436TZ00JkQgH/7PZWOvd0oOwdU1NhoVfi9umZHlt9xPS2uTnKBsZxxAjUdQuzfgJkGxbRUfw0Lxp/bF20V17CHnoVJOFiLnmnSf6I14dG7bgHQMq1ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073477; c=relaxed/simple;
	bh=vQmnZQ3/rGpVKg1I1XCk1Vdx4dsYa4xYqHHp5Iv6isM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=POiFRWw30+RNA3KrNQHhmV+MkykbES/48VZti6EcEVJXWturtC65Z0c21IR4MqmbdYxps0wP+OeLCiM++PyMcVNlxw0+UwK5y1ESDikqL8RO3ZHI8O/LU3QAt4r69+2+XE3U/CB45Ryod8aKbZSCgdaqkXN32ptfKi5LfZddv84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o17UKvkN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o17UKvkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858AE1F000FF;
	Thu, 10 Sep 2026 20:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789073475;
	bh=tnkZL98K3y8oXmQk2w1wlCzeNWTlULsg8JUVttIkIBc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=o17UKvkNpRSfIHFEF7Qsu6DB2HwCNvneauCcXlmc/AWO3aUqY+dLpnK/P1A/TxRtO
	 JbeZwJk9ruCOHS1F5bbGUavmyOiwII3b/sbJ2ZBZ3SO1/eWHx3uSHXvrMl2X+Vrz31
	 4EMp+zCOOKr1I3bryYjEXz/+h2TLqT+0171UgQJ7P6Prkx24ANlddRi9uK+cvZGYX3
	 lIdFS5vtzqFrbJw0H/ZIwFh1ZCiEQx4ta7ei2H8uX/VKH1Vh3uZNLl10nuuVk5NMV3
	 rhtVIGVoLoOuaCHpxoswZ7rREWa0luztzRi7Y3Sb+0+iidKpo8FwclXJguv+BH3RK4
	 Fk5RH/vmqU+dQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19870380DBDC;
	Thu, 10 Sep 2026 20:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 00/12] Add functional tests for A2DP and BAP
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178907341262.2075844.17541117108756556262.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 20:50:12 +0000
References: <20260909192308.1306567-1-luiz.dentz@gmail.com>
In-Reply-To: <20260909192308.1306567-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  9 Sep 2026 15:22:56 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds functional tests for A2DP and BAP, driven through
> bluetoothctl, together with the endpoint registration scripts they use
> and the documentation describing what each of them does.
> 
> The test documentation is reworked to describe every case as setup,
> steps, expected outcome and notes, so a test can be reproduced and
> reviewed without reading its source, and the reason behind the way it
> is written is not lost. The setup of each case includes a topology
> diagram showing how many hosts are used and the role each of them
> takes. Tests of a profile need more context than the core ones, so they
> are documented separately, in doc/functional-<profile>.rst.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,01/12] build: add doc/test-functional.rst to EXTRA_DIST
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8df6386b97c8
  - [BlueZ,v1,02/12] doc: describe the functional test cases
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fb3457bcd1e5
  - [BlueZ,v1,03/12] client: do not prompt for LE Audio settings on A2DP endpoints
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=45b123f3a9c2
  - [BlueZ,v1,04/12] client: add A2DP endpoint registration scripts
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=23fac1a310c0
  - [BlueZ,v1,05/12] test: functional: add A2DP tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a888c89ead5a
  - [BlueZ,v1,06/12] client: rename media endpoint scripts to include the codec
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d6d9a13775af
  - [BlueZ,v1,07/12] client: add BAP endpoint registration scripts
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=304e388070f5
  - [BlueZ,v1,08/12] doc: bluetoothctl: document init script option and scripts
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2fccbd5040e9
  - [BlueZ,v1,09/12] test: functional: add BAP unicast tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a60d81439eab
  - [BlueZ,v1,10/12] test: functional: add BAP broadcast tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8c99eaa01d53
  - [BlueZ,v1,11/12] test: functional: add BAP broadcast assistant test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4f77841df4ac
  - [BlueZ,v1,12/12] bap: reuse the PA sync established to discover a Broadcast Source
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=61a2b3d93897

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


