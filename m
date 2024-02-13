Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D7E612F7
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857429; cv=none; b=mrbamIybK02tomlPfoOB6881Xh5StJ1hNvKUURj+CGaR3QeankEpwX3252S1/KoO8TxqT2dcfb4CZfxR3WMD9h8RWlvjbWYAo4TUV5gNxpbPBCGfsQHhfgEJtX4EJav9360EIggenD4rLThouk9P7LfuXBRXXlLgZDeaC0x1shY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857429; c=relaxed/simple;
	bh=WbomFWQLKs2JFX5nQNkrAGeznMrDOdyN8lJjaG/hR3g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TQ/GVVLjHfycKJZ7bypKV0xjHn5c68vUiQyuhY1FIgYYDESI8zhrdOdF/IfuFbW9VJaz8eT7ELDTCmrtya1wGIXADwrylQv5NsCGjgGGn31A2bcM1MlQPRFPr4/whpvn+zk7jp2aDx7fzkET3SLOFbQ3XPH5oVhCEUlZlwmPPg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gud5nGCF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gud5nGCF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22C70C433B2;
	Tue, 13 Feb 2024 20:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707857429;
	bh=WbomFWQLKs2JFX5nQNkrAGeznMrDOdyN8lJjaG/hR3g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gud5nGCFiWVi9Bia16d7z9SdR66JIlGjKcv8l0w573vdHjUpn4FekC3whMfk0TDL6
	 WGju0olw3z1XA4qo+FHlYzUt4fzLZ9FB37MHtFjmnuuotGcGZuyT1tzN4+4NoKtt+n
	 QkTXFiaX+yZZ360DUJL3WUmhPuogP0jTqGkBSxZCJqU8pOJM2CJWQZqrE9gRVbX4Vi
	 LI3rKwUB+CtM1yn/S/+2LWrjndiRfE8tViOmYlXyzMC3ovpoV0xJ7HED5HxC+A426x
	 Bs5F/WoxGvazDKHOKp1PXfK9DwrhCxWSFokY7G6lRsdIqZZWEDEG1CCuX2bWKg6HDo
	 jDg8gTerqzKVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 055CCDC99FF;
	Tue, 13 Feb 2024 20:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 2/3] lib/uuid: Add GTBS UUIDs for Call Control Profile
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170785742901.22526.3965587945275155347.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 20:50:29 +0000
References: <20240213215703.21507-5-ajay.k.v@intel.com>
In-Reply-To: <20240213215703.21507-5-ajay.k.v@intel.com>
To: Ajay KV <ajay.k.v@intel.com>
Cc: linux-bluetooth@vger.kernel.org, kiran.k@intel.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 13 Feb 2024 23:57:02 +0200 you wrote:
> ---
>  lib/uuid.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Here is the summary with links:
  - [v2,2/3] lib/uuid: Add GTBS UUIDs for Call Control Profile
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=24d97e35fcde

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


