Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380C426E14D;
	Tue, 18 Feb 2025 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893205; cv=none; b=lNCd7dnvHj6eq1H+/FuZUiF6d8yWgWLS8vH9TPnrCkjAycgCUI1Jf75cwVWq4xiMsvzWbeDXZsqA6P3Truc469mPhKf+pi8oQlStD+wwTrzf6h4RPG9HGYGpaDP7Tkg9GjLF5jTR8vMut9oN0GArf0JlLL07wmC2BUsMu4goXpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893205; c=relaxed/simple;
	bh=YcrQzYfnM+HrI4229z20fNVGm0xUtl3pRYA2vTYv4tY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O2CNhYfGBlJTo2dft5HZZua/BDtydX1bgI84CeeF5ClAPxAmzuJj1M6t6GunYEytGBzJG7xxqlr0AthdI7sZYkOtiq15q1SE3VgkNa2qO53FzV6cIeRCmo5KFKS/MnUSlmzioNJ39FT6Y77Bn6UFTLPn7w9Beiyzd3ijB7mPeuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1grd7k4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1grd7k4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E3DC4CEE2;
	Tue, 18 Feb 2025 15:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893204;
	bh=YcrQzYfnM+HrI4229z20fNVGm0xUtl3pRYA2vTYv4tY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M1grd7k4TzVvXHiXjD6VclfFUlEsLG8rtiyjAa8jFtn6ap4jdytUEHsVnTQrXpSUh
	 M4N2JMvKXEmQfSiWexoGqcT0x83Rm8wahq2xbvV/ObfQOcXzKWIJTz9iF+vMQ2j5rl
	 c/6hLJ7r74kl0qa5RGE+lxn5lFNlzYDGuL27DUOT3/UFOYjWhFLubCrsrHP/K014X9
	 owkg0FtVFkQs3BATLSaeuT4IFAI7QKOQ9IWRRJ9cF/fT1ydLAt+Ma+xyxdLAVlhvwA
	 5X2Di76W80PNv2CAnsocIzTJFwRdtMT5XuV0yBsB31NZhsrLCr/g1mnvK6FgJD/AQN
	 P75+Fj+97HElg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 35257380AAE9;
	Tue, 18 Feb 2025 15:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Always allow SCO packets for user channel
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173989323501.4126041.17802676659471701319.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 15:40:35 +0000
References: <20250214191709.1.I6e9e94dcded65e4a9ed42ad23ca8a5d81f680382@changeid>
In-Reply-To: <20250214191709.1.I6e9e94dcded65e4a9ed42ad23ca8a5d81f680382@changeid>
To: Hsin-chen Chuang <chharry@google.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 chromeos-bluetooth-upstreaming@chromium.org, chharry@chromium.org,
 marcel@holtmann.org, yinghsu@chromium.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 14 Feb 2025 19:17:09 +0800 you wrote:
> From: Hsin-chen Chuang <chharry@chromium.org>
> 
> The SCO packets from Bluetooth raw socket are now rejected because
> hci_conn_num is left 0. This patch allows such the usecase to enable
> the userspace SCO support.
> 
> Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")
> Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> 
> [...]

Here is the summary with links:
  - Bluetooth: Always allow SCO packets for user channel
    https://git.kernel.org/bluetooth/bluetooth-next/c/eafcfcfca97d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


