Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7423093A6
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053823; cv=none; b=lt3qi/14V3UiCcQdnzqLHTqEI84rMmb61nXZzUCRr4GjvB0k2OgF2fv7fWnOmzfQLymx+x1WhKYkBah4MTAHKB1fb2jArr7Zfg1MvPwz24O+lzB4lUqbPp3M6QnerV6QX0ar/G/fePRhVrzzbWBv5ya4LD/8dcsA/5wFQbBYSmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053823; c=relaxed/simple;
	bh=piaaPJnwB49ASNgHvLhjzJjhs0UPZrBI7C3Gu7Mu8+A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oOLn5rgqfjoYFNPRqC8KPxObENcvqnhhCjjFvu3q7YGz/WANxPmx84ZTfbCO3Yd+i+YKqFrVEPYTEDwUuhzotW8ulG47RAQ298vK1uN9fXNgty+Ty4xZSVIpAmIqkJYn1mccl+FhIM+MSxWxzxSce5LfJWEp8SZ7klcM/sZKmb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbYF2e0l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbYF2e0l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF626C4CEF7;
	Wed,  1 Apr 2026 14:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775053822;
	bh=piaaPJnwB49ASNgHvLhjzJjhs0UPZrBI7C3Gu7Mu8+A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BbYF2e0lXEEg8/vCF/dyNlQSiTzuowd7uO876cEZIXdmswX7Srs9DDmWW/rKGHClF
	 +/mLeFjV1s2xP3Qw8y59wGptVueIYwSqOPCh2jFbf0sbEzwr8SVc+bE3s5tLganj3a
	 q5pXhdkVL42NeUlIjM/fAJOk47xLgMY52/OeOz9iv52KabOD5UupQhctNH0OPSawdI
	 MlxL2INTWVWvsQ3sXviU/jtV09m/5jPDWw2Vy+9KE2GMCg+PYUERF1IzJBEAJZlXV5
	 vcM+A3E9e03neuHaFlC+L098VtvW5uItXdejEPRx9SbZbs6m5dwBqslaMkWpBGQn7P
	 puo26/Fm4Y49Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DD43808203;
	Wed,  1 Apr 2026 14:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] src/device: Fix stored gatt cache DB Hash value not
 update
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177505380578.3303791.15895652640205896491.git-patchwork-notify@kernel.org>
Date: Wed, 01 Apr 2026 14:30:05 +0000
References: <20260401113930.1430598-1-mengshi.wu@oss.qualcomm.com>
In-Reply-To: <20260401113930.1430598-1-mengshi.wu@oss.qualcomm.com>
To: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com,
 cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com,
 wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com,
 jinwang.li@oss.qualcomm.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  1 Apr 2026 19:39:30 +0800 you wrote:
> There is an asymmetry in behavior: when services are added during
> the same connection (via Service Changed indication), the persistent
> storage (disk) is not updated with the new DB hash, but when services
> are removed, it is updated.
> 
> During the same connection, We check DB hash value stored at
> /var/lib/bluetooth/<adaptor addr>/cache/<remote addr>.
> When established connection, the stored DB Hash value is A.Then we
> add new services, the stored DB Hash value is still A which should
> change to B. However, if we remove the existing services, the stored
> DB Hash value changed to C.
> 
> [...]

Here is the summary with links:
  - [v1] src/device: Fix stored gatt cache DB Hash value not update
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0fd01e98cf94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


