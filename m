Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDF2226CE4
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126592; cv=none; b=NCm3dCMy2e3x+55L6FuboG+db7si7+SGe5pxfEai3TjhJKuJTQALO+KfkK0zzTGZMGctLyuhidgbIjNPX7djqlXuni7nrY2qZkYc4FLTVLrSTNqxHY0lndCLHlt1KWk841022IxLYLSzjWnMkzysXhpm3/GWgD1y8kvY9fyN2ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126592; c=relaxed/simple;
	bh=HC340vBXzu2QAKMP7Aa2WXUbWoAZm8lqQwaSPK8+9qo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=reiu0TMHgjuIWW2ouZ9E2T+SQIPSGfnv/rNqa4jsgE41SnDuNPrTB1BGWLyBNOEl7Cgj4uHpIKLSGErM3rFs9ilMHke20m5ka5YgX+/ak7ea58lxqKFVe/y5D8oDLBB6CiMttUD3Rvtr8rMoX7Asee2IlHvvbSGs8w8PIrtPX1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSkcSKnu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSkcSKnu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF98C4CEE3;
	Thu,  1 May 2025 19:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126592;
	bh=HC340vBXzu2QAKMP7Aa2WXUbWoAZm8lqQwaSPK8+9qo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NSkcSKnuPmEuWK0i4/SYShV0t3Yd27O9UUZrR+UB/bcElrsHNhI2k2Q/QuElNzdXx
	 5tnfqVP+HYwHYZG2ZPEy9Pc0TuifkkD9Enw1ofZmtmdWMxN2Z6ehHQi3JMvFpQMDok
	 j39K2HQ9d+kQahHXYILbrGL64S9Fiqatyfw+mQ0W+gy8i9pR/Ksww0YM8xXD10i2DI
	 cKfr45L2jKxnBWaTCC4U17Kv74CtWJKXuUnLemzivnjWFTf0CFgLWGt67slM0GA3iN
	 O+DOfREDsXwDVrXs1/4zbRGX31/uxODgGze8sQTgCivlzEqwpeqZd2iYBrbZ4w4b6D
	 oWhXPFQfuPSNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE3E3822D59;
	Thu,  1 May 2025 19:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/2] fix build error with --enable-hid and
 --enable-hog options
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174612663154.3052720.4219537316370232114.git-patchwork-notify@kernel.org>
Date: Thu, 01 May 2025 19:10:31 +0000
References: <20250501163536.1283827-1-thomas.perale@mind.be>
In-Reply-To: <20250501163536.1283827-1-thomas.perale@mind.be>
To: Thomas Perale <thomas.perale@mind.be>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  1 May 2025 18:35:34 +0200 you wrote:
> This patch series fixes build failures when --enable-hid and --enable-hog
> are not enabled together. The issue is documented in the following ticket:
> 
> https://github.com/bluez/bluez/issues/1228.
> 
> Compiling with the --enable-hid --disable-hog option would give an
> error because the HID plugin relied on functions defined in the HoG
> plugin:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] input: fix HID compilation w/o HoG
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b111b5e15eb7
  - [BlueZ,v2,2/2] input: fix HoG compilation w/o HID
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9c52188d7530

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


