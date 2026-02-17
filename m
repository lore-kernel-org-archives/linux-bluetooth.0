Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB2A32E122
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771339814; cv=none; b=pkKp+Kn6/2qRNMMVccfqZnTS1M2URUMpSL+B61ZLtMEOSH9BpcOJ9qBBMkLcDunQXBVlN2qEllSQbu9Mv2ncga20scKtW4GAXoKxQ+2nT0xI0QazHutNDcOZHVCRF+Z/EyG02iY22KT6Dgp1NJuPiubwXT/QGjRjjagaIF7sizE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771339814; c=relaxed/simple;
	bh=HmCzGUbgFmaGwqrzwzIV+vZe6GZ2tuc39tcRG9ElpnE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UA238QFdQLueIXd42iNEPpc/nij3aZS2NexhqLm9iBDjA5mpS9JXI2Uk0HdI/VSt2GKUUJQFdl/fIGkuLt0dHa2dBHvx1j5qns05IE1Xxolorb0TJJomZGTOyr1y0DRdknoFXbYZjFvMAuKQLt2UlwNkKsNweHLqmxoYqXzv6S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ergRCmXK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ergRCmXK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8BDC4CEF7;
	Tue, 17 Feb 2026 14:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771339814;
	bh=HmCzGUbgFmaGwqrzwzIV+vZe6GZ2tuc39tcRG9ElpnE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ergRCmXK9Jch8je81/XYVHxgWpH1PuYNPgu2FFQC9aFZbQSNvluaI65KN60q/wYof
	 nPuFDwhpu9SbkGEKzKukc3Mkk/z3aAqDppsW11bVt8zLKfWg+Yx8t+e3+Y/kjpn7DK
	 4NEkMHL0F0jZmm9kwWtVEA+kmxqmFm0aAocFuCTvM0j4hlRoI1GEGQC/VvM6MzW+SS
	 447HHa3Y18GVmxXD1j2IY5srxm8PGT3NCuf38oIW5ps2Uva9gHuN48PzNlKZTW92Gp
	 ZJk1GcpRJ06jHk8Kf9725QIHLEink2yw3GMqzLV6bhDDchIOvwKNoxmW4C5hUWiTSz
	 VgW+IZ7Z7PBqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 851F8380AAE0;
	Tue, 17 Feb 2026 14:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/1] Fix use-after-free in BAP broadcast cleanup
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177133980631.109268.5480162574757779566.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 14:50:06 +0000
References: <20260214153616.655-1-sarveshwar.bajaj@nxp.com>
In-Reply-To: <20260214153616.655-1-sarveshwar.bajaj@nxp.com>
To: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 vinit.mehta@nxp.com, devyani.godbole@nxp.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 14 Feb 2026 21:06:14 +0530 you wrote:
> This fixes a use-after-free crash when broadcast audio sources
> disconnect or undergo RPA rotation as reported in issue #1866.
> 
> The crash occurs because bap_data_free() was freeing streams before
> destroying the broadcast sink setups that still held references to them.
> 
> Tested with AddressSanitizer on latest 6.19 kernel with NXPs
> controller as broadcast sink and Samsung S23 broadcast source.
> No crashes observed with disconnect or RPA rotation after fix.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/1] bap: Fix use-after-free in broadcast sink cleanup
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=feb4ee9dcd4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


