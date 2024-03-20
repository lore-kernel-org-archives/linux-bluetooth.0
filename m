Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7283C068
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927033; cv=none; b=iNzTDhEi5iAWZigAflJEmzikFEwAUHm0yCA513c8EQXUMXJXYaSt6bJYbDN6yfel6fvpUjfi6MF0nj7UAcv9KjhJXUvw5qoFdWkqzV0NMriROO+brLXqSsJxRy60helaZhykcGI1mT1JzXiZEGVf2FeUlVBgRojEVlQD5LlE2ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927033; c=relaxed/simple;
	bh=lAVGXd989nU/QV8U2uoEJTgErF63RupFCXZ1eokGQuk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mqDjLXjtCDpd32Yd9UxRyJ2Zt5Rwy2ZsNTRkBlZpaZ/IEoMtwbILkI/12K5FeVm4SPKBjKEl8fj2hx8grz/Sh/1Vja7d1pEhDvHhEpmgVFXaqXgS2kRkkIXdISEj8jDqH2GfjuYT6eR4tFfxG+Jq4HPsq6rQoBJ8ji5r+Ft/SgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0MLInpM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0MLInpM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D127AC43390;
	Wed, 20 Mar 2024 09:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710927032;
	bh=lAVGXd989nU/QV8U2uoEJTgErF63RupFCXZ1eokGQuk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t0MLInpM7mjQZ3yZvMX//mE+bsAZ7e7g0DYXgnhtBrLIyzmE1nWgmDCPGvkaxkJgJ
	 9dSAFu8+at0J517W/03JfmitTvFFm4qbvcCbWHEY9rXSoOmAb1BjOJT/Z0zDyiMWUS
	 eA1IgB0+dpbMU6DUAA1oenxmxVuY/6W4Zz9tD10ha/ugl5VAhlte+kUICdMHhvJVAj
	 CjgOMZIXVruByLoRxN5y4I6WdGU669M9GImZtrm2+b+CfSRpZL40lqZCdRI+T226sa
	 lQoP57wn46YSmld8ZMMJK7wdExzKdb6ZRMS7UJ/ecS5w1cfZ6hikm/CWMudw+dEg1z
	 K25oPJO5C256w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4CDBD84BB1;
	Wed, 20 Mar 2024 09:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] a2dp: fix setup->err use-after-free
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171092703279.20558.12930550090274246801.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 09:30:32 +0000
References: <154e1a604eb8c3d924699489da72ea905915fb88.1710614196.git.pav@iki.fi>
In-Reply-To: <154e1a604eb8c3d924699489da72ea905915fb88.1710614196.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 16 Mar 2024 20:36:38 +0200 you wrote:
> setup->err is set to values that either are on stack of avdtp.c
> routines, obtained from callbacks, or allocated on heap. This is
> inconsistent, and use-after-free in some cases.
> 
> Fix by always allocating setup->err ourselves, copying any values
> obtained from callbacks.  Add setup_error_set/init and do all setup->err
> manipulation via them.
> 
> [...]

Here is the summary with links:
  - [BlueZ] a2dp: fix setup->err use-after-free
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c04b96dda5ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


