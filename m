Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD26021348
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Oct 2025 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966427; cv=none; b=C+HSkBivTqlq7QYBqTrlCLC68HkcyvLnqMI8qMtWd4t701CkRkMWfNMCV++pHeb1Og3ZFVg2nE1FnJ7gME7BKELkqGb6MyGWodTSkKMsz0tqIh62svoTCa92/jG0rowgKT1wg/QVxKhZLzmET53xEfJF0zADl+o6fi6jlhdUvRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966427; c=relaxed/simple;
	bh=3YJEtXGDZwYBZ5TNQsq67VH3fmE1WEOfVttuHmMfhFk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NVmuhWD8nf1UX0u3/Qqbb5O7lrZ0N/wL/RhrazJ3m2zBPniyl7rE0//uxQ7GxLBVJp+8dz1wFuio7Ak6NRM0l3dQ6lo3x0FUyAq1kpKa6HcVSOSlbB/rBjSLKA//X91kSxUPJ0evXVqv2gCWaEuTfyrkiZyvH4f2ul880nE++yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jY4P2TmR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jY4P2TmR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECC5C113D0;
	Mon, 20 Oct 2025 13:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760966427;
	bh=3YJEtXGDZwYBZ5TNQsq67VH3fmE1WEOfVttuHmMfhFk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jY4P2TmRArpDsUoM5lUAdfdRdBmfJtRdqT1BCTA8M3AB5kB7m9xrT7hMC0B2odZdc
	 YuevdWvjhDqlfs9V2IeuWWzRm4Gl/t3UY0y5ct4OatrUkp3n8amoWK63pK9mCmr3tB
	 vnEaEORNgvM+QjOc3jafP1GR2vvNNTmj9lyD6H62V+ZOs1XlpfCP+Igou7iwOxSJ0z
	 1ryN0DmQ/HAWX9q0xe6hBPAE5bnwPI0kPP6hFjM7QGet+KU74qE/M3SFl14tpsT5SG
	 0A/CyROrTKA3W/PbQ/LBvN6LUz1QtToGL+6INVY6WQt5LCBCL5188DnMt7WYnvtb3m
	 iFtJtc7IzSG+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE863A40FF4;
	Mon, 20 Oct 2025 13:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] hostname: Remove unneeded include
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176096640924.201781.5007991144240317817.git-patchwork-notify@kernel.org>
Date: Mon, 20 Oct 2025 13:20:09 +0000
References: <20251007083626.1956499-1-hadess@hadess.net>
In-Reply-To: <20251007083626.1956499-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  7 Oct 2025 10:36:14 +0200 you wrote:
> ---
>  plugins/hostname.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [BlueZ] hostname: Remove unneeded include
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=39b541edb273

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


