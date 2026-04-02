Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29013F075D;
	Thu,  2 Apr 2026 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151626; cv=none; b=hjVQuBQU/hR/tMxsGR+bS3dwE1JeQBhPRXxnjVSoYJv+lHpVPxtY4B+OJ9MMwCRbmooIqiAxgzBgj0vWUKu5sny83JwShPSUs5s7r1Rhh0BeBS0Z9Y0v7qRxqwRyph3B/zS/7mRT3OwZFwJZojsi6p2CrNmjVt8GjmSQNMGg4C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151626; c=relaxed/simple;
	bh=YcixH2BvmAOf8OOf+4kOaHQ1GMq51oC/TB+8lPyEDEQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sUDAlqAoTu5QumR/oaKUvIb7w/dS++fmgtBrV6vCxcg/sHsRuyM0xWoZHQArLOcUw5nC9zQcqk9jSh33jJJjpbajrlqMurnau2eeWYi426vybX/AdMnolucCf11nWbXRub92THCFqNdLpLLSYwsUWV07jdcugDCcdIsOgZtFsVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtMPmxV5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtMPmxV5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A913EC116C6;
	Thu,  2 Apr 2026 17:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775151625;
	bh=YcixH2BvmAOf8OOf+4kOaHQ1GMq51oC/TB+8lPyEDEQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TtMPmxV5dbE0E2ebpGvdViEeW9cG3C+1AWqmi9bP0Wlze+nm35mKb+fwO3HwyW+kA
	 p4FkC7f9QfLWwbZrR5iT6qaOLovW8sYpIWP7cQVBDupp+QjbroThm+Tb5PaPsIvK/A
	 xcgaUYxhwqj4PAG+rIs/fFyuPMQ88ZqKcbhCXUHSIeJxk22BaCzI92hp+eIren8T1P
	 +h+hKvTKF0saAATsaza1vOttFAcTO5Zg7z0OrGIaYu/FQpTd3D89r64zlFaIGsgu/y
	 0s9q68Xyvasb8eN/QBTQeijcKRBKQRsrOfHY345JJTpWdlSChkt6SiRwnVTovrzsoY
	 DVunNSixyd6Vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDA13809A08;
	Thu,  2 Apr 2026 17:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btmtk: hide unused  btmtk_mt6639_devs[] array
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177515160778.548768.5779863589943755468.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 17:40:07 +0000
References: <20260402141119.2732591-1-arnd@kernel.org>
In-Reply-To: <20260402141119.2732591-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, floss@jetm.me, arnd@arndb.de,
 chris.lu@mediatek.com, kees@kernel.org, johan@kernel.org,
 sean.wang@mediatek.com, jiande.lu@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  2 Apr 2026 16:11:15 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When USB support is disabled, the array is not referenced anywhere,
> causing a warning:
> 
> drivers/bluetooth/btmtk.c:35:3: error: 'btmtk_mt6639_devs' defined but not used [-Werror=unused-const-variable=]
>    35 | } btmtk_mt6639_devs[] = {
>       |   ^~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - Bluetooth: btmtk: hide unused btmtk_mt6639_devs[] array
    https://git.kernel.org/bluetooth/bluetooth-next/c/a6e00a811c87

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


