Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D55612F5
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857429; cv=none; b=f++PRdz3MjeQcwwH3tzJPJyGzcZ/7+u6huS17RhYZd9kkC27OCa2+DbhpVCEwRZK/qwzA6cYiLv51EIWhIw52Xre+dK3dr6fO+lrzKGpXNsTb/la/qiI9Nqy2LfJHWdAJZidKSlmt2Ng4XZ4iU847jiBILJg7sKcVWatnMwjbB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857429; c=relaxed/simple;
	bh=z1YO60rvO2MWHnV0BC9D40hErKnUYdWNKc3Bbmd3Zac=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BuP+LjWs/vJowmdeO+bjKA2C9ytC0HwD8Cun/GhWokWudHtnHBwyXK/kbtejCGZ8iPBowO/Y1WSL5wPWDBieD9XiZDjIBXPicUPeKNimFJBYxayZEGom3ivB0ucRSR1FZFVyUnUmkoKAwWmRNKOVgRggiPCRjPSBv7KSNx81JAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5ltO0l7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5ltO0l7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02A32C43394;
	Tue, 13 Feb 2024 20:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707857429;
	bh=z1YO60rvO2MWHnV0BC9D40hErKnUYdWNKc3Bbmd3Zac=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S5ltO0l7gVrD2EYnDP3jivjhd5eui6T9tAwMnbEr08wPSS1dN/L/1vGhR+Jkvb4Ff
	 8syZOCHhSMINhjxrolpTZErpMJJ/Gsk4RVq56helqDgAW8BLgrKXqE67plfdy3onVd
	 KQGm4ap9M++qovnDqt2VPWEilOw5ZqHaamGGdn0P4scyigsgo5dbcVvM43iNdudhRK
	 gev7eyFWomCuQ+pvA9MAcnuEEejy3fqJWgxfL2BGkABCnOVDpQPSAEMoyQzWzcB4KD
	 V+y4P16q+S58Ui4Deltfs790rry+fcEa/Iwkm81+fsR0LBSxy8ZLgstX94fd0fTcdX
	 4A5hc23sGaZ0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0287D84BC6;
	Tue, 13 Feb 2024 20:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 3/3] shared/ccp: Add initial code for Call Control Profile
 for Client Role
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170785742891.22526.14041035177976727990.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 20:50:28 +0000
References: <20240213215703.21507-6-ajay.k.v@intel.com>
In-Reply-To: <20240213215703.21507-6-ajay.k.v@intel.com>
To: Ajay KV <ajay.k.v@intel.com>
Cc: linux-bluetooth@vger.kernel.org, kiran.k@intel.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 13 Feb 2024 23:57:03 +0200 you wrote:
> ---
>  Makefile.am      |    1 +
>  src/shared/ccp.c | 1226 ++++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/ccp.h |   45 ++
>  3 files changed, 1272 insertions(+)
>  create mode 100644 src/shared/ccp.c
>  create mode 100644 src/shared/ccp.h

Here is the summary with links:
  - [v2,3/3] shared/ccp: Add initial code for Call Control Profile for Client Role
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5c89c54d2db1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


