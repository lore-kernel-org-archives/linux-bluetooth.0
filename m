Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030213;
	b=P8hEB3N6N1LfPNXvX50fiwcPqQ35ONQcCVXbJ4MtGbEJH2GWq9h5AxIzJ8ej22fA1j53
	 lMthEPSY6VNhr/VRCUWibZnPyzylCiMCiakHlsD1l+Kgi0TJ+HHfsO+pN1NbSDiJdjZJW
	 IjqNwpnJNdECdP8hYYYXXXxgAFSb9vkA9SeynbHiYC7awp/akRO11YShL+mot8g9HJp61
	 Cv77cp1SWMDDP3nOlL27xm+EQ8ZhJPCmCcdmnyrXRS0OlVyIXgY24j6yh5DOmDwN0Xmrm
	 u3dscWo7y98kiFf4aiNId5TgRP4yaOfDS1k/6lSXyjv77Qk/QI1Qotyu65JSOAwok6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030213;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=i6X8Y+1AfXQxlQRqS8rjdze/54CDvNtEmLZo3CXW/7Y=;
	b=ZXuuO3Zs0cBOAWbsujqOoQhM+H8vJ/FjgpBIksQVOFuQBh7S0eMj4KeeQg/dtBzHWXcD
	 tQQ8AsdU/yaCg1j+5zIbKBDD+fMiGOPFMRIitfE7IEkWZl5+Mfsgsp+he01MezmSKYnEd
	 TSAfJ9lBZ+82vGuBWrlAFKZ86qyNue377wiKKfh2jS0vMwIhFZtxgHzfYmbCJHB5WbzzW
	 50tnXDtbHz3qLRH48xJLeYQR/NSBqMG3U02a7lhtikp8I8aAQqdRjAzLCBm2qnDrolRSy
	 NEYEaAzwUJZcyFHoMRDE2aouSok7pGvhpwmjNK4WDl9ZT8PWTYR7ibyCr3SHOX0sO1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mIRP3S/i";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51C8606D375
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIRP3S/i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426771F000C4;
	Wed, 18 Nov 2026 19:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030213;
	bh=i6X8Y+1AfXQxlQRqS8rjdze/54CDvNtEmLZo3CXW/7Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mIRP3S/iA5aKKX8oGBR+WyEJvJAN8DbIrSuxAS4/Deiq8w9D4jcWZ3O0C/VCziw5k
	 aGJ4qMHa68TYO4cqglqnVlNZz6S4BPtVVL9w8pIYpT/KIPzTLvmxFcqoN7JI/3HpaV
	 Boc20daOOHm3HFS0wg6gN5lhOrD9l+u6vlazF71ZyM5NCtvtW0HmoEsHs4OUrGJVQr
	 szGDnwPs9hgoF/tRJVvG1hdfNYjohUXSdCAP+xyVSDkTGKKUa08OI06CP1BZtPYWky
	 WQXnTispsS/1k18yAjRn/0NYJhMHKqRQ5EMzmIj3S4lVNJ+vxS++lSEuoHc0QtsymX
	 wnFAJWnWJChVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A27D3808210;
	Wed, 18 Nov 2026 19:30:13 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v5 0/4] Bearer.LE1: Add ReadRSSI
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179503021177.2495657.14816040877169529381.git-patchwork-notify@kernel.org>
Date: Wed, 18 Nov 2026 19:30:11 +0000
References: <20261117182151.73722-1-kevin@simpleble.org>
In-Reply-To: <20261117182151.73722-1-kevin@simpleble.org>
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 17 Nov 2026 10:21:47 -0800 you wrote:
> This adds ReadRSSI to Bearer.LE1 as a testing method, for diagnostics
> and production testing, as discussed on v1 [1]. It is only available
> when D-Bus testing interfaces are enabled, with bluetoothd -T or
> Testing = true in main.conf.
> 
> Each call sends Get Connection Information, which the kernel answers
> from the controller or with the value it read in the last 1 to 3
> seconds. A call made right after Connect returns fails with NotReady
> until the kernel has read the remote features.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v5,1/4] org.bluez.Bearer: Add ReadRSSI method
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c4a9482b39c8
  - [BlueZ,v5,2/4] adapter: Add btd_adapter_get_conn_info
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c8db894219ee
  - [BlueZ,v5,3/4] bearer: Add ReadRSSI method
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8df73d029518
  - [BlueZ,v5,4/4] test: functional: add bearer ReadRSSI test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=653321e1afe2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


