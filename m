Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD5C2D3A66
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916594; cv=none; b=T0GgFBjaaJI3fXDfd500jlZAvALtqYpT0iFC0ILl1I4faGXf4FU+oVwFyn0FrwWdzgPEVRAya3ZPtv3Tq/aa7Mw+h+dczuImhDq1w/g/1VHSnYuhXYCaiSdzk/xJDuFNYhCx3/+zEJE2kM/0ISCVM5SMeSot3l4pif6XXzU5U5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916594; c=relaxed/simple;
	bh=ElbdzvNapyXXIcxzcnD/nDWxesCxX3uRMwfXlSSa0/g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f3OUWejXkUZbNj+G4q8kTy4MPv7eykd+VDkMdoNokhvomnWZkk2FRISkyWNMaRORuOKU/RxSJoy56NAnsopM+epYxBehg6sLgE+ypuu/b/74iqsO00whv9Uxz70xQWCC5DmHECWU7+dPGVs/O1MZ8lvKogjyn8V82LALHZFc3gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGVNPYH+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGVNPYH+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D332CC4CEF4;
	Mon, 11 Aug 2025 12:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754916593;
	bh=ElbdzvNapyXXIcxzcnD/nDWxesCxX3uRMwfXlSSa0/g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HGVNPYH+WdhSh5zVF+r01deE8lEroOy1q1CHkF6DKzemso84osVmqxFWPr+0qeHPf
	 vD4SLnOiSgxsqpggmPmxLihfWJZvKREsnZBi9UySZ4V0ewdqtbf4FwT3KF5077A7c4
	 UZHAi4Gpd2cINuyKKPys0YN1b1oZ/CJqDDRLrvEunL7BGdn9cePNHYn14YfAleN52i
	 egyrKlSpPB8fLUnKnhXnxfEmgh1ZSLHoSeRNvGUr9spwGkX2MC38A0n5v1ywb31kxJ
	 Y9zeEmaG0aHcKMzguL7FUM6MH7D6hTgFUWTp3vKHdfLvH0d3G/YGR6+OklyqF+9Fsf
	 5wEjwdzeSZJoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C4F383BF51;
	Mon, 11 Aug 2025 12:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/3] Prepare for meson build system
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175491660625.1660461.8158348809310127811.git-patchwork-notify@kernel.org>
Date: Mon, 11 Aug 2025 12:50:06 +0000
References: <20250807155115.1037982-1-hadess@hadess.net>
In-Reply-To: <20250807155115.1037982-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  7 Aug 2025 17:50:28 +0200 you wrote:
> Changes since v1:
> - Fixed make distcheck
> 
> Bastien Nocera (3):
>   build: Move library source to lib/bluetooth
>   client: Fix missing strdup/memset declarations
>   mesh: Fix 'buf’ may be used uninitialized warning
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/3] build: Move library source to lib/bluetooth
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ae29fcb2acc0
  - [BlueZ,v2,2/3] client: Fix missing strdup/memset declarations
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=eb40539c7e5a
  - [BlueZ,v2,3/3] mesh: Fix 'buf’ may be used uninitialized warning
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0cac149a4bdf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


