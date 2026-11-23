Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456807;
	b=H058XMmRSFxO2sd8Zug9Hg4QFpL/apdXUwF42k6WrrBesHAnVoWxNuZ8KxVhkaO/iCQa
	 jz6qZmDZ+bsEznzCrtVhVdQRjFCVpvFLphpivIqIkLD6nwYT55RI7+4ecqZ8GSCFOnk9l
	 IfrzwBOAWa+hfebxj4Ie5KMJ026yAq+LQJfTdcwfCVyRa1JW5f9MbwU/V2oR+8Ntsh54C
	 7rXXElsLW0rtiheqmzITq2lhtuzIdR/trZz4U3Z3YWVOif9ubyEECof6at1yabl7vHEoF
	 rHyu2wq2b2/8XcBVJ8Vt/cP+xbECj6qo+54reVEE00TiNc/Y8pj181RSnRAr3UV4I0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=V2mtinEPspEk/j8PFkq/6aW2dt4ZdHjHFzCOLeVUy0M=;
	b=UWIjJqVrt9SMg4G9X8k7snEaPSu9yz53W1CEqaMvK0g50qCDwdiYVT3SQKzi1VUv35BP
	 JxcAXZfm84WID3E9nNAMIej64RRY0GkDsasmZnsH+jjfvuaf2MJ/UA0OnYXpBpHVXHugv
	 CKIScP72A9447/4on4mGMFJki51MFMJROGZCDLWSXwMCYbVCYlVrXcPpscByRamDpGok3
	 kkwjzPIW1HHrJMwKRg2ldaiMTLtCNE4tvODC56+j7nZjrkRxy0erTOQgOLPu71V5O3sgl
	 IsUrxAfIfHlr02dwaljzVeODICRFyLJLbIjwrlRyN89QGw/94pAUTAoIbrQh/jdD7Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KsSYRbtY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A820606A31A
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KsSYRbtY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3E61F000CA;
	Mon, 23 Nov 2026 18:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795456806;
	bh=V2mtinEPspEk/j8PFkq/6aW2dt4ZdHjHFzCOLeVUy0M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KsSYRbtYhjjwnAR6xxa6Vy60cUAvOQt1ofZEMbRwFfWbp4lQF8SIowZoM/4OxqbUP
	 ysvBVAP9rTrJbaNDAwQ6IE+pWnCJSYNcAAwcMWPDki6J9/ra13zShqKMTEIK1sDpos
	 cxpzQ0VRfOR2jHKtSU2nNFA9vLhdyqUWrm5RYoE4KbbEPG/1V2HrK5dZLOkn9SNlK8
	 R6rCp8P5QZI64iqiU/bLbwgA/LDd73XlsPoXiW2gwjOB9sXsNam2MTPcmKAEh+q7XW
	 3tObCe7qqyxIi5+u+syASeveM88SpEYge1nSwBjbXJH8RH9XlVVdeoFTobyse6jm7C
	 e0uhbmdxiPR+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4D4B392EE1A;
	Mon, 23 Nov 2026 18:00:06 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v2 1/2] adapter: Notify adapter drivers of settings
 changes
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179545680552.3023180.15660573361491200011.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 18:00:05 +0000
References: <20261122192955.2329174-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261122192955.2329174-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 22 Nov 2026 20:29:54 +0100 you wrote:
> Add a settings_changed callback to adapter drivers, called with the
> MGMT_SETTING_* bits that changed whenever the adapter's current
> settings change. The media driver needs it to follow the CIS and ISO
> broadcast settings, which the kernel only sets once the controller is
> up.
> 
> Assisted-by: Claude:claude-opus-5-5
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] adapter: Notify adapter drivers of settings changes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3a0998307834
  - [BlueZ,v2,2/2] media: Signal SupportedUUIDs when the ISO settings change
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1608f8361886

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


