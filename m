Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C4E3D9666
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942808; cv=none; b=ExZypymhRdhU4mftlyE+4hf/dhPtqun2Kyq1c468ab/gVkO6M0EYmY3/hsrENun8xvsGBgA7ALlinUQBOqGubix3FkzWdTxLf+zLx3+blxtUtLMAoQXbQ8RtVxv8mHvpKnYPGt/DTy/2O+OxSvcYXq3F1MIoYYskLcMd+00VJng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942808; c=relaxed/simple;
	bh=idrzhgOwA3ykTyBBFvWNf+4Q8beUGmBtw7IBvkSObkA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=stoMClM0TJ869stT9RiBVr9kxieFkM8dcc9WyrSePsIrDbjn/mIBHfNiXiTd1B6mCBUukcpWpw3qskDmxYspa2g21XLPSaL7p3ta1FUiHN7NdsjMUJtPfnYqW5CcWzl1f0UFikr6QNUVwEp723rzEKmOrBGJfu7dQDlDifELRB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKqKKMcj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKqKKMcj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE511F00893;
	Mon,  8 Jun 2026 18:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780942807;
	bh=hzwyDMT0i5UyREAVupdUC9tq1+EpdjcZqkk/sp4tfpY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mKqKKMcjsHy7hoGmiYgbvvbsw/2i2Mfcd90eL7ifwjsGmkQuBno+NUXfhzNIoP97k
	 c7zBkCVrsPZ7bjNQxdDEaEcLPkh2PKoDwvbh6HFltvLZCaetVwE3iFdR1uVl6w2EW+
	 kN5l9eclXiklToj09SNlRS4Zk2+PRSwdmy0lNh7UXZoXfLbHmwaZ1hY+m7AzpL4GhT
	 39fSMT3876dYHFQJFBC+gtSWPV5qJ3ibSWgPz7ceVHDqAWxLrZ2vG9P5yNgAP4DBdR
	 i009tmR53SKlE8AbWuspe/pWADJXB+BcmEqX+UQGb3OR83/i1zajhKVKSiiRH9GCBe
	 h4hhfXgsFnH4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5688D3811A71;
	Mon,  8 Jun 2026 18:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/3] device: Refactor device_discover_services
 function
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178094280590.1611786.9656752932765017197.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jun 2026 18:20:05 +0000
References: <20260608110743.3683728-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20260608110743.3683728-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  8 Jun 2026 13:07:41 +0200 you wrote:
> After refactoring we can reuse function once more in function
> void device_bonding_complete(...)
> ---
>  profiles/input/server.c |  2 +-
>  src/adapter.c           |  2 +-
>  src/device.c            | 26 ++++++++------------------
>  src/device.h            |  3 ++-
>  4 files changed, 12 insertions(+), 21 deletions(-)

Here is the summary with links:
  - [BlueZ,v3,1/3] device: Refactor device_discover_services function
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=56835e9061de
  - [BlueZ,v3,2/3] device: Rename start_discovery function
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=415955bb70ba
  - [BlueZ,v3,3/3] device: Fix returning discovery error for Device.Pair
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


