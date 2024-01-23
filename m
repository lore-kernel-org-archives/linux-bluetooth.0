Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7026381AD4
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035285; cv=none; b=gGmR8NQxjVkrOlWQSKAKjXGaaeMGCYNA10gCNOP4aM4yv90Afq/LaCOY4aOP1ffKGe3BKKDt5710grra4g1YSR61c92ZFr5sy0aBlUCsE4AFmAWojiozeAIaYSEEeB9fqmFFAgo7dZg9ggJrSamvL2tDgf/0STg8W9JM2EVHqG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035285; c=relaxed/simple;
	bh=P8uot9WeFPoxnUoPgKThpziTLN/p9+iRnEoom1AphqM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tJXct+SyCzKbKbmuEZ+dI96h2mO+oMyuIKPr17UgzL+v1dyLUfdSR0EVZBDJlDfAJWgq/Cy9ny7SmGytfwEm2jrf8xJvFN1ko85wJFmDLdZ4WDpIXqiuD9LMLjW94AVOpddmICHplT6KFsKNvs/p2j2TQJ73QxLZY0zZPG3R8T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUKlI8VN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUKlI8VN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1B77C43390;
	Tue, 23 Jan 2024 18:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706035284;
	bh=P8uot9WeFPoxnUoPgKThpziTLN/p9+iRnEoom1AphqM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZUKlI8VNpvxj+OshlzgDMVbf0VK/xCWBV3Cj+SRYpN1mRCGhBsKyPlzRJe5Qj6cFw
	 mzdGcE5yDtdNqBbNvWy9Fuv+upR70nO22N84tuhgTS/0eSMUi1pUXCYQQzDPsIuUce
	 o0DewAqn245XounFv0U31PlNJju9rOxiSV8dlFEl0hOGtQvFCRxfbwjPMSDiRSBidr
	 2dutaVrWWu8AM2OPtsI6srvM6qeJ3WDxlHzSabFM8F2pQzTizB8o3bCLWbT/ujMWlD
	 8ZVXd22A/TG++27Kfg67f3Wa6qU2wwvgwiH3uq6x3RrfoPkAtAuGtkGohLagBo4t8r
	 oslv+JWzVgbhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CDC02DFF760;
	Tue, 23 Jan 2024 18:41:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] isotest: Fix not handling 0 length packets
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170603528483.29536.9189704288517270449.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jan 2024 18:41:24 +0000
References: <20240123152850.2880226-1-luiz.dentz@gmail.com>
In-Reply-To: <20240123152850.2880226-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 23 Jan 2024 10:28:50 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> It is in fact possible to receive 0 length packets since that probably
> means their status is not sucess.
> ---
>  tools/isotest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] isotest: Fix not handling 0 length packets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=eb057846cf03

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


