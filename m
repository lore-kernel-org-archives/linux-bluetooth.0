Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851436;
	b=LrmvJ1D8gXARoSX0VoLJVnyGsV6qCsD8QsdlfE8ePxF3iyyWhhkOERhWUhiq/YsG68xi
	 TjnzdS3EMAQzr/YqVA9MJLYnBi00fS6o8uGY7DcE5R4EXV0QBsElWhBkg4grMtNevrWkE
	 y7nd6mbiqvpFvUrFrLnEqXHh5E1L/eCS1q/1CSTxsEijxfgq7oYQwig0WEuRqbuaJ5XzC
	 svlJRmocwyJhSi10m0sYauM/RiW2xzo9Zgcj44zVb1jh1fOPyG7eua9KzqrubxJI1YQj6
	 Lv7xSgOGUgMCytfhmLWt2MuwCvTz7RcFR32ve5RFG61tuzNyxCdWf7QgXLbHpljcUVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851436;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=U8PXLgpkL6fMeZziBR+Bcp7MyC5TugqYNebrsudVXag=;
	b=xlqrsSOVgC2exHlUSmqUmqTzEakBMHpwsXTqr8FXDS4BOK3aV81V0+ZtgCL+2UHVN/7X
	 OB9N84gK804VxzVl85bwquzWRHR4IplSzv1m0Hc40Ha5wHcRBTEvK7NykC/nv83uvgaRp
	 7gaFgC4h5AnFO+TbIvLnKiomO8JtSPS6NNlMO9+20sf9QWKARAdCWggThUxAJLOxqV5O0
	 vRVZs0GLz/SpZVIh3qu2AE2csq5ZJOZn7n8xAPt20arw5K770HapWUVNZuNZE5ZZHJ8pV
	 dA+NHj2iXMLnXfhk6Z3GiBCSiMrOxN3WhXi0W/4dP7v2fTy/ywi+uSAdvJAxEpOjtWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NNVuZ63/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15ED606A891
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NNVuZ63/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9751F000C9;
	Mon, 16 Nov 2026 17:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851436;
	bh=U8PXLgpkL6fMeZziBR+Bcp7MyC5TugqYNebrsudVXag=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NNVuZ63/kxLsaW/QFh14WrQA9PVzt1BGago7QhCXhX+8Rvlbd/iz2Cg62l6xrTD54
	 kDvCG+xQibCxM1HCViD1b8sskerqueBOnKFPZ2wgBeqVJOtbSumNiEN+krCk5pwlmc
	 z2AYM3Le5aKIpuy+a6POIE8wQZFEogQfyXbAK2J7PSPgPoXLJSEIbLB8Ti6tx61vN1
	 pcRBU0+8uWEUQkcbU+AW6OZhiXPYrji3mYqk0JiOBnmV+OCFCwFC6aBuq5oY9lFus/
	 YyW71NAWmC3ahLGwRIezQT5WZffdyQClCPgP8CYjXEF+IMfHeh/ZUxp8dZkjll1kR8
	 685v5mc75LLKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 772A2391AFAF;
	Mon, 16 Nov 2026 17:50:36 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v3 6/8] test: functional: Cover disabling one ASE of
 a
 shared owner
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179485143502.3796096.4796840542484239274.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 17:50:35 +0000
References: 
 <40720115137c05aad4cdcb4c596c66516a97b963.1794428234.git.luiz.von.dentz@intel.com>
In-Reply-To: 
 <40720115137c05aad4cdcb4c596c66516a97b963.1794428234.git.luiz.von.dentz@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Nov 2026 15:37:40 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Have the initiator acquire the transport of the Source ASE without
> desynchronizing, so both ASEs are enabled together and bluetoothctl on
> the acceptor acquires one transport, as an audio server would, its link
> sharing the owner. Then desynchronize and release the transport to
> disable the Source ASE alone, as when a microphone is closed while media
> keeps playing, and check that the transport of the Sink ASE stays
> active, as its ASE keeps streaming.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,6/8] test: functional: Cover disabling one ASE of a shared owner
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3a5c95ea2e63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


