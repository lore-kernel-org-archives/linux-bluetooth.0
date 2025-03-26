Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B26A323D
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001803; cv=none; b=q6Chn01+JBEbnrGLXufW8VLW53PpYwl4+qxacR0r9wUZTm59son/eqUGXgGdW0Km0y0rFN9Dxp96J/GrkzJbihw+lPaxWcnBSzA4sXzUc/9t0Rn11pgRLWgHjMaa6YqYew2+xKybGvKUADgrwVy17VKkddbFbQyW+PaA2veJtxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001803; c=relaxed/simple;
	bh=FBVWBaxGcNkRuYB/ym/dLfxinC0bUjHnwTIWuobAoc4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YdNRnwUxM5Ss001+DFmtOwK2PG9Ig5mIKesHaR9o3bzlR88uVA5zOaGGoq56hrvhDNZ7ijWDl91tQf2eo5uj9X7n9JP0wBNIjqlHKVqaPq/vAlWdoxEqt89kcQ6urAEww8edaKDVscL4m9GUZUGJ9hKeZ/efdTp+UgA0yBcKvDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHhvcJlk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHhvcJlk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE11CC4CEE2;
	Wed, 26 Mar 2025 15:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743001802;
	bh=FBVWBaxGcNkRuYB/ym/dLfxinC0bUjHnwTIWuobAoc4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CHhvcJlk7kKgIThyRXI4/QxCc8oVlGYkoWMGDdjblcTkf3sgll9hkyz/7uJQZoW59
	 zGJdAnJD0tsJuQt1z/lMcHDM8VLKZy6FVFP2nKV51Zha1Y0cFr+MN2jLhIniORNy6o
	 zl9fxr7G+3vXjHKtl5ZMx42OwOAKTL40boBlC0uMjbWLDMCJE14Oef/R/+hBOld67b
	 etqr7UQQSuI5GJo9k52NCO4Ejqg7MM+o79VMCWBxtp19jaiAgkSYfeQF/eHmlCe5ui
	 63oblI1fECtGTuOiUBb1p0/wgOrfMaEC9VgNK2494u4suLrsi0xKtapg3QH8v8mdDx
	 2Ig8034gpvtHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7112D3810901;
	Wed, 26 Mar 2025 15:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] client/gatt: Fix pointer assigned with character
 literal
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174300183900.1347744.10500234051496007504.git-patchwork-notify@kernel.org>
Date: Wed, 26 Mar 2025 15:10:39 +0000
References: <20250325083546.31597-2-ziyao@disroot.org>
In-Reply-To: <20250325083546.31597-2-ziyao@disroot.org>
To: Yao Zi <ziyao@disroot.org>
Cc: linux-bluetooth@vger.kernel.org, ceggers@arri.de

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 25 Mar 2025 08:35:47 +0000 you wrote:
> A character literl, '\0', is assigned to the pointer. The corresponding
> comment doesn't make any sense, since '\0' represents zero and this
> statement does the same thing as assigning value with NULL.
> 
> Initializing value with NULL (or zero) is safe and correct here: the
> only case that the initial value of the pointer is passed to
> write_value() is that the if branch isn't executed, where len keeps its
> initial value, zero, as well. With src_len equal to zero, write_value()
> will bail out and src_val won't be dereferenced.
> 
> [...]

Here is the summary with links:
  - [BlueZ] client/gatt: Fix pointer assigned with character literal
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0f0039045088

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


