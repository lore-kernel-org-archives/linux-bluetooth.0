Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B141DDC0F
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589790; cv=none; b=uza4zSCvEWuDocKRxqTVmabPwdY0Gdu01UcC6Uyvfy9OOozSGnBIxQuR6DWs8AZqvtBcIei7EQzJjIu3nwbLb127CGzlsoL2+v0rlZExEYt4Z0nBSDjrtlPYMo/UMlpUUCJnlQfVflf8TftuDerRn9XBf1CZRYrut1mqR9xWi9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589790; c=relaxed/simple;
	bh=8S1DXmRZyebXh22yAQr6hIs129khhvdOfCOZnLuVq6w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bjme8ZifQKx4edyeTbzlN3a8NvdfI9RJsYFWHKW5Bg69d39FX7Va8s5w5idr4N5p7VdS/K7t5nBWcrC1UrB6wkE0kXZU6gRfBi5ia8heFkgBw9awS0y4BKOoIDpy2V6CmvBFErvXNnlFLtKKiUCwlKo5PxPC8bqfOQVk8kpT4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJlGpcMy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJlGpcMy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124E0C4CEE3;
	Tue, 15 Jul 2025 14:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752589790;
	bh=8S1DXmRZyebXh22yAQr6hIs129khhvdOfCOZnLuVq6w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KJlGpcMyISibtG8bLHW5StIzR1Q8+ZvgNZTE0nQa71uT2QpAjHQEf4Ni08wHzq7L3
	 TYmpJEc03IJqfdFV6sHIqUwEgIMiVNyp8e0kOJHnytLOEMH0A/3pQUlGOJNdeSIgY1
	 1tb1UgSR+ZzRIsd7PauHapI+II8s6sTesE2Eqq1J3oXuQg0ZYovXRpJ9VXMfTDyosv
	 hxbaqU4pW7il2QPN4gzPIPbBFArAJGmNDqHM/zbgYvHZIfgsPB7plGyf7AGzzoPpat
	 Oe3goe3+zqEZ5/m69vc+Xs29L17fTSpfy2ZhZ/u3PdsvpJ8Us4BSOpGWf8+k6670yH
	 895UyJXnsICUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0B6383BA03;
	Tue, 15 Jul 2025 14:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH Bluez v2 0/9] mesh: cleanups and a bugfix for relay
 packets
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175258981065.461397.15820775551050380963.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 14:30:10 +0000
References: <20250711220035.10065-1-ceggers@arri.de>
In-Reply-To: <20250711220035.10065-1-ceggers@arri.de>
To: Christian Eggers <ceggers@arri.de>
Cc: brian.gix@gmail.com, inga.stotland@gmail.com,
 linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 11 Jul 2025 23:57:12 +0200 you wrote:
> The first 3 patches replace further magic numbers by preprocessor
> defines (no functional changes). Patch 4 tries to improve readabilty,
> while 5 and 6 are only cleanups (these patches have already been
> submitted in my previous series, but were not merged without any
> notice).
> 
> Patch 7 and 8 are further simplifications/cleanups, while the last patch
> fixes a serious bug which causes corruption in all relayed packets. Maybe
> this NEVER worked correctly, although this is a major feature of
> Bluetooth Mesh. At leat this one should get reviewied by a Mesh expert.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/9] mesh: net-keys: more uses of BEACON_LEN_SNB and BEACON_LEN_MPB
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=009cfb5188f8
  - [BlueZ,v2,2/9] mesh: introduce MESH_AD_MAX_LEN and MESH_NET_MAX_PDU_LEN
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=646cbe922792
  - [BlueZ,v2,3/9] mesh: replace MESH internal defines by shared ones
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cd651d8e21d7
  - [BlueZ,v2,4/9] mesh: net: constify tx path
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b692d72b15b3
  - [BlueZ,v2,5/9] mesh: net: remove unused stuff
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0e586df2d0ae
  - [BlueZ,v2,6/9] mesh: net: update comment
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cb4b20c71fd3
  - [BlueZ,v2,7/9] mesh: crypto: mesh_crypto_aes_ccm_encrypt(): remove unused parameter
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9a32ff5aa7ed
  - [BlueZ,v2,8/9] mesh: crypto: simplify mesh_crypto_packet_parse()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=159101c7bc38
  - [BlueZ,v2,9/9] mesh: fix corrupted relay packets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2b0a6fa08407

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


