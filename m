Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394E45A987E
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895277; cv=none; b=dnK2+CntdG/taFR+ZkKuwNVoBqjn0HSlGHQmxQr0Pl50NgmbdvGvIyksepdMM4C9rIV/Dw+WouxyzZ8bUpeEIOn+8lAFaE9cyECZL64EPICF2qr8gr9yBBQM2uisERUNP2s6sXw6YUW2p/3ux5yPZKwPOqmVZs8P27yHD/+FZNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895277; c=relaxed/simple;
	bh=Ww8PI/mtveYKgAS4TjvXNWP/u40WV2PEkUEY5C2w4p0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UOfaACdYBiRnzPM5zfgMabRjc/aRois/ljMsyFUeT7R7SGNP1l2un2t0l/FCk28RPsBGCEXw+IMuHpcubQKWb5DyIOTSRP/hpXOGKvYo5F2WnHtt3VPbY6vg3/4rsMCR4+p1bxz1Ek67rUL8cDEer62RUYbuAgxY8NVy3cTP8dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lobtr2UO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lobtr2UO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533E31F00AC4;
	Tue,  8 Sep 2026 19:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788895271;
	bh=U4uBJI2zEXsd7Zfnk6sVTRBySWO4ol7JQtiVtTXFyJs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lobtr2UOcfWP/6gU/IwMxKq8ZPlG8Ync+T6f91K/YH3+tsrhahTYkDXrglgwTluJr
	 KHLupSURx6SG0Cl7AlywPOrXU2BDxkIWsTN6y5lm0v7SlYqwDn/MhTTyuvehbvqGAH
	 HT0Alfrf2ov3tE8ID2LibSgeu5LgGEPO1T/wsECEkoSwQq2sRGtB/YJzFz9DjP665e
	 O4/0hpWnEor3sn8juti5LQB9Fvxhe1rXy4/elyBIm6ej1OXicyYPWcDP1fTyYl2YBe
	 KhfbJPraDCv/BC8np7pGN1Qd+U8n7w5lLCKz8OQR2TMZpRlvq3NmtvbC2P4LVBfK0H
	 QygDXa/ikbt3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A40380820D;
	Tue,  8 Sep 2026 19:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v7 0/9] Functional/integration testing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178889520963.3704993.9911217550470009790.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 19:20:09 +0000
References: <cover.1788712996.git.pav@iki.fi>
In-Reply-To: <cover.1788712996.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  6 Sep 2026 19:49:42 +0300 you wrote:
> Add framework for writing tests simulating "real" environments where
> BlueZ and other parts of the stack run on different virtual machine
> hosts that communicate with each other.
> 
> *** v7 ***
> 
> * Bump to pytest-bluezenv==0.1.9 (better core dump / oops reporting)
> 
> [...]

Here is the summary with links:
  - [BlueZ,v7,1/9] doc: add functional/integration testing documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=19a5bbd7eee2
  - [BlueZ,v7,2/9] test: add functional/integration testing framework
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fa9390b5cee3
  - [BlueZ,v7,3/9] build: add functional testing target
    (no matching commit)
  - [BlueZ,v7,4/9] test: functional: impose Python code formatting
    (no matching commit)
  - [BlueZ,v7,5/9] test: functional: add some Agent1 interface tests
    (no matching commit)
  - [BlueZ,v7,6/9] test: functional: add basic obex file transfer tests
    (no matching commit)
  - [BlueZ,v7,7/9] test: functional: add tests running the various kernel testers
    (no matching commit)
  - [BlueZ,v7,8/9] test: functional: add test for adv_monitor crash
    (no matching commit)
  - [BlueZ,v7,9/9] test: functional: add test for AVRCP crash
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


