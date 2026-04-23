Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB2438229F
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962446; cv=none; b=bYs/ExRRH1KOlBCvvqc29f9oL61YXmJEId0wyTGR0drY+HQgj05fH1yWAy+omQ+N9DG1JGkx3+fJYrJD2QWpJBRpKRfkbNBS1QfS1Z4bFzG8HwxShZCrgLNOcqWU7MwWd4NkXYnYamcQ5Al+bxIEUsWtjPBchXBOmeTFHfEIHfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962446; c=relaxed/simple;
	bh=+RQu6Sym1fnvD5kgLHOYc39S27C7iDOLbKsPZjs2yIk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VeVfHdVagEDUCXvL7A0PdNANovIVrXPaHGcWKY4NSJeRizcbFTKYTVf5hc0x60a7hIMwa5lOUz7YQgMyy5bkB4nsVxsI2i6FAsQvt8Z7ezRbtRd6pF7s6RcM83/cm9ObQSKRfrQcz6K2veO/hE9VS4PDdAk/zfVQxO6ae6qK3uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcMXeL3h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcMXeL3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3BDC2BCB3;
	Thu, 23 Apr 2026 16:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776962446;
	bh=+RQu6Sym1fnvD5kgLHOYc39S27C7iDOLbKsPZjs2yIk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XcMXeL3hn/1UG/J3RxzekQ4p1lEojJJDMEGzZFSWCLZpfyRE7pT9uyKE2SSu0YW9b
	 6bWLnLHGuRTfaYdZcQLWbcNFZw1eJLHGz+Utm1VgotfeC4NB4XXei77snzLW+Oda65
	 ybVcTC2DM1Yc8BOineBoLMVM7tuMcUYvqMtLVgq6y6u8J9UKN110od9RYrIrRij1fv
	 2nvWljzHCqgPhWWMe/Ng3KPiLEub7SjFEtz1Ul+3QZRtrn9OHDQgW3zZ0TvdjuGOsx
	 AUDyHYJVKOXJ3rI48+OedqcJZsvcrpO9+sL8I8it+3ItkqIZEtx+jYkglDBuxbb7hR
	 F6SjFnWgo1img==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C0B38111CE;
	Thu, 23 Apr 2026 16:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] input: Fix checking LE bonding on HIDP
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177696240753.664628.8964479664218032417.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 16:40:07 +0000
References: <20260422150328.2062359-1-luiz.dentz@gmail.com>
In-Reply-To: <20260422150328.2062359-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 22 Apr 2026 11:03:28 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> HIDP is classic only, LE uses HOG, so there is no point in checking the
> bonding with the address type which in case the device supports
> dual-mode will map to LE random/public address.
> 
> Fixes: https://github.com/bluez/bluez/issues/2034
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] input: Fix checking LE bonding on HIDP
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=928f2b28c1c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


