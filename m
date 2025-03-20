Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F380229B23;
	Thu, 20 Mar 2025 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497211; cv=none; b=Rn92A65UkpcFqDuPIAscZgdPAJ5GF0OJmryuUSo3GrAtL+arjygPQJoV2QVOuYQEzV6XA3et9Q70G45v2pgBcPKokXndgBgiu2Wv5KygF0q3w8QfLFnM0+q8VwlUBtMguuOsxmzLHN7gNsaTyjjNPwkMM8Jc00npPf/4+RkkmjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497211; c=relaxed/simple;
	bh=0xn17N6DJYWebRRn/jGVYxuRuDM3bLIVEkKZ0yC1gSk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Uj/AEi6VEsSDpgkYlHliSvpuHK6k+ZgzV7Q6nAb7do1upC7psC03eGL0/tF3uDSmYy9bsK3qbfK4ERaKN2F5m2ZAJAwv7es2sgfovKolNKkieJjePFTuMSHpgxCWsWvC3c5ue9vthPQCRdhAy9GqjlI21uYVroD+77ecA/Maxy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dK/8lUE0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dK/8lUE0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D753C4CEF2;
	Thu, 20 Mar 2025 19:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742497210;
	bh=0xn17N6DJYWebRRn/jGVYxuRuDM3bLIVEkKZ0yC1gSk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dK/8lUE0pIBRM1oes/UzSveRKsx48zKR1OhoGrXEP3EEJKy9VHS7LkDGnWDtT6BIn
	 6OWtqTer6kGgr2tvFa/++YgwhlhpWZFS6Ca79XLgujVJv4jzncCKiafILc2+ITPaEd
	 +sOxjn7YswZEpbI7mujcnPW6w33q30lqgrPhAIJBk8JpGrCrb9WMKN9fm+32h/kHi8
	 r9izj9p1agWYw8AwcEyVCqECw2iqkQQh4ZqotAUUg4MeT3WrOwfBG2E5opO9mMV4Dn
	 OKwIE3YTomr3l7XmUBUgOK599Lrqjn+pbWAI25xMp7ej9AovcYNpo5IvT7cmEbqL5I
	 3dOdf5ZypjPcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF0683806654;
	Thu, 20 Mar 2025 19:00:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btmtk: Remove the resetting step before
 downloading the fw
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174249724626.1878155.10663828087577774363.git-patchwork-notify@kernel.org>
Date: Thu, 20 Mar 2025 19:00:46 +0000
References: <20250315022730.11071-1-hao.qin@mediatek.com>
In-Reply-To: <20250315022730.11071-1-hao.qin@mediatek.com>
To: Hao Qin <hao.qin@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, deren.Wu@mediatek.com, aaron.hou@mediatek.com,
 chris.lu@mediatek.com, steve.lee@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 15 Mar 2025 10:27:30 +0800 you wrote:
> Remove the resetting step before downloading the fw, as it may cause
> other usb devices to fail to initialise when connected during boot
> on kernels 6.11 and newer.
> 
> Signed-off-by: Hao Qin <hao.qin@mediatek.com>
> ---
>  drivers/bluetooth/btmtk.c | 10 ----------
>  1 file changed, 10 deletions(-)

Here is the summary with links:
  - Bluetooth: btmtk: Remove the resetting step before downloading the fw
    https://git.kernel.org/bluetooth/bluetooth-next/c/aca3e8a5c46f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


