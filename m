Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1901A2F658D;
	Fri,  7 Nov 2025 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762542639; cv=none; b=C0doSt85Tt4Rxp8nj1udrAbkYKZp0M/T1HkWFRSLwB0s/mQ3RPF/508hhqY57PuVY+L8/scB6OfXRCSr//3VxTiIOfUNMB2EJCpI0Bc2tywfrAeFpBrm/30+DXARUFyInlcQN0T8spymkQFDA5pU6ZmbjpoVSo5gAeAMDEnsLlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762542639; c=relaxed/simple;
	bh=jsvtojKHC70pzd/PwY0huHPPGZn/UlmB64cgS2Ou5Ww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=plCmWOVlILenrHXicG4vs0VHsy8dP8rs+3uB2KB8pS/r2qQiWveCihxa95hZ/opQUJea0Cj6PcYiNO+zwerC6AunPD0RjHptyZXSbkhRXwml4er6ol9sU1JqaCEtmun9RjRSPYt4sofpV7m8yrQgcsAzykp+Svrico6YspGTKRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taJ52/QS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taJ52/QS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A581DC4CEF8;
	Fri,  7 Nov 2025 19:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762542638;
	bh=jsvtojKHC70pzd/PwY0huHPPGZn/UlmB64cgS2Ou5Ww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=taJ52/QSxncs1yEimhj5qxrr1m7uUWD4a8kLHXI12rOxEW2irKnI3F9lfGcqfH1E1
	 Z+S53vyhczcVO85R+76gDKcCwCBsPcthfW4P5DIkgCzz8OWIi9SApXQfI2tvNGd6DM
	 JenweTgwwuJdDkpRak4Tl5T7Nc6upQOjI0+fKrQx7isWg6QGXfS3f9Pcfxd3qk/dN4
	 wB0gGgMHhBM6849ET5QeTya2g/lhXVdZOTVvLGQq/zImLsVmlHo9e7DK24OP01DCHw
	 Zn5Y3XqsO0oLyUOkwoKDNYn95SuWWzalnxEmPV1N6JmUmeHRlUteE0fQhNgfL4gXDJ
	 Gq80WPYUkhr6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BDA39FEB7D;
	Fri,  7 Nov 2025 19:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] Bluetooth: btusb: Add new VID/PID for RTL8852BE-VT
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176254261098.1132280.13623781765700879277.git-patchwork-notify@kernel.org>
Date: Fri, 07 Nov 2025 19:10:10 +0000
References: <20251105055041.456142-1-max.chou@realtek.com>
In-Reply-To: <20251105055041.456142-1-max.chou@realtek.com>
To: Max Chou <max.chou@realtek.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 hildawu@realtek.com, alex_lu@realsil.com.cn, niall_ni@realsil.com.cn,
 kidman@realtek.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 5 Nov 2025 13:50:38 +0800 you wrote:
> This patch series adds new VID/PID support for RTL8852BE-VT.
> 
> Max Chou (3):
>   Bluetooth: btusb: Add new VID/PID 0x0489/0xE12F for RTL8852BE-VT
>   Bluetooth: btusb: Add new VID/PID 0x13d3/0x3618 for RTL8852BE-VT
>   Bluetooth: btusb: Add new VID/PID 0x13d3/0x3619 for RTL8852BE-VT
> 
> [...]

Here is the summary with links:
  - [1/3] Bluetooth: btusb: Add new VID/PID 0x0489/0xE12F for RTL8852BE-VT
    https://git.kernel.org/bluetooth/bluetooth-next/c/234c42bfac07
  - [2/3] Bluetooth: btusb: Add new VID/PID 0x13d3/0x3618 for RTL8852BE-VT
    https://git.kernel.org/bluetooth/bluetooth-next/c/121a21fd7599
  - [3/3] Bluetooth: btusb: Add new VID/PID 0x13d3/0x3619 for RTL8852BE-VT
    https://git.kernel.org/bluetooth/bluetooth-next/c/92f51644e1cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


