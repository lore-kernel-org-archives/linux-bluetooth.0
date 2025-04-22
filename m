Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C03324469C
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 20:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745354398; cv=none; b=qoGKZJFSE1SmsfN+1NK9aOIblSElgkAIEOE+eftS9kLiZFxCABnG9P1ZmiKBPLIYFtaDRpSdDWjaqdeoXt4xZdh/2w1ARM+kP0OdUznHNmPmyIj9eNwmvMPo8rBbt86f3V/b32meOFOxangY9bBXdHMsO9JrVYsh+pXySEzgnO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745354398; c=relaxed/simple;
	bh=naeLYXtZ1VIjodqotBfIMLdQiCvmP5kYeWByiRixWIw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qmt3vgOEadAfCQrqT1C4iCwkKebf4AwNOtYEkzqG1awFb2CylCvIYsMIVgtZSegz8+G4k9Hd4TV/8BU3p9Oe9EaEeRjl+ibsd16J1uI1aguAXxB3DI9Fjec3xIfj8YsDYIf72ECaUeRWpn3mxgPGx9LyPGdxSwSvYs1zboiV4+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7BJejQL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7BJejQL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03597C4CEE9;
	Tue, 22 Apr 2025 20:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745354398;
	bh=naeLYXtZ1VIjodqotBfIMLdQiCvmP5kYeWByiRixWIw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D7BJejQLJlmKhs18o03EwKS2m2BS6CCdHNk2El5+ZJTMB4RgXm5xipmeCQWlq0uw9
	 Gpvszq3bVea8TAfNPhjdqvC+vpLhhKSEgcUlQgws4mvfgaP92sr5S5e3UIjNU1FmAs
	 8/RmdxEDamv9Zr7So874uK53is5poIWRTU1AahT7M8hZ12nsin33UPHEe7b6oitgrh
	 IIklaMODebWfm8wymUSMEi78laoP/1S9q7UbZJYmaKQ3oJgLn3AtNu6i8aCQHSCG0K
	 tTh8dc/RqZwzGRfJglIBryud/JrGti6q5O9S9uMVq7s1+cteKbVkiyQb5jn2f58Db9
	 ikqLBHaGUKhzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE16380CEF4;
	Tue, 22 Apr 2025 20:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v5] workflows: Add CI action
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174535443652.2042058.17421256668036948806.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 20:40:36 +0000
References: <20250422203243.980887-1-luiz.dentz@gmail.com>
In-Reply-To: <20250422203243.980887-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 22 Apr 2025 16:32:43 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds CI action which was previously under BlueZTestBot.
> ---
>  .github/workflows/ci.yml | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 .github/workflows/ci.yml

Here is the summary with links:
  - [BlueZ,v5] workflows: Add CI action
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3616d514fadd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


