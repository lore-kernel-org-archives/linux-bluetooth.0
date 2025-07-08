Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880822DECB7
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984388; cv=none; b=ZE1swDEE6kaC/+8z3K7gn3z6W/ozVoZ2LTh9hIUPhYnesOd3zim4rgwKiPJv2oH4EyQaj9YM1+xmcrINQ8dYYZmWEvnNRpjNNAfPQzDa3hTS5V2DdgvL//7a2i313hohL4Vc+hEpgNGXpHJ3V/uBJjY9CVjDutkYFNOX4x4q0C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984388; c=relaxed/simple;
	bh=Z8SHbd4XEKi1wUjnk/vaTfgBYoBpjKUNgMFYffdqs7o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kShS4qx/RhWujUCdQichLONudKo4FRgc2lb1Tk1iVHdxTYiF05j2BXZ9FSBazHXrpJLkVfCLV2ttf1lUQ/P5bLr3JbezJX4F5eaA/umM4E9h3cqY4cc5k1cUMKZ9YoLMQ3nvmcSqqehFZD5Pb/d3d3R8F0xSsoxlIvBTjfGSwGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBIbuyt7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBIbuyt7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1F1C4CEED;
	Tue,  8 Jul 2025 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751984388;
	bh=Z8SHbd4XEKi1wUjnk/vaTfgBYoBpjKUNgMFYffdqs7o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VBIbuyt7pqiW6zZBG0vdwh0mYGo1KqluML1ikFk2g9DR2Ri/8wWq7JQD8KXJ+KFg3
	 nj7l5ZrdhgujdZhGPnsI2/ET0+LxZI78dvjE8KCY5SGxaiE9a2zX1A1Uz9cL523EZW
	 IzayiKxqa+9hoPYd4YLyFtKlaLcYJill5Qc3tXYpuuoHtdWDJVgmwVygTPxXLiP/eb
	 ifZqZpzswMczWT6zZmaZW05KCRdlUmmHYkIiylyg1n+cpjLB272nOBF1Ta3iv5OvTv
	 j15k9aktuzbnfhVJg2CKgyMrW+3/OVT0H9vsfNZs9J1ximIlx+wKP59O+E0emBTcgG
	 2SYNzxg+9zfzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B9A380DBEE;
	Tue,  8 Jul 2025 14:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] build: Remove deleted configure option
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175198441098.4082479.4678660420488184479.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 14:20:10 +0000
References: <20250708102418.1863891-1-hadess@hadess.net>
In-Reply-To: <20250708102418.1863891-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  8 Jul 2025 12:24:08 +0200 you wrote:
> Remove this option now that that the supporting code has been
> removed, fixes a configure warning:
> configure: WARNING: unrecognized options: --enable-android
> 
> Fixes: f0512114aacf ("Remove android support")
> ---
>  bootstrap-configure | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [BlueZ,1/2] build: Remove deleted configure option
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f3db585b5f6f
  - [BlueZ,2/2] build: Remove deleted files from .gitignore
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a5d517dd4134

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


