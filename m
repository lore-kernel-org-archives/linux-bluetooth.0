Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A824A185B7B
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 18:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726080630; cv=none; b=puF9SHe5KvT5eahJ2oicfDVe4LFACyB+010G5AOsU2AyZzCKqUeC5SZ7Y000a7RIWdgJwyNuClff7kkNfFMeaUXgrK1HY+6bi/x7+3OrIUg+as6KD0EB99UWVPZjUdA0IFYC9NACqhsmBlbDxSlWqCUMhH3ZR+Mfu9DFWSUZmmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726080630; c=relaxed/simple;
	bh=LQd1Skg4zM1ghKcTXpQnJ+XUsVQsj7YDrHI6tS4GjFY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XCaATrGwRSrCQdbuwTP8+H2cmR4XHN7HIvkhD3GaIUPVtNUNakEqYTSw94NuQ0AJbU1LiZeYq+sXE8zWRxVriG2a/8TdgYj4j7TrkRG9q+wGzlxYtPjz++UmHEHex9aPq9MWpKJE5t6vTaNQ5fDpP0D+QfCekPjhIQ4WYWWwfWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CK0g1hp/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CK0g1hp/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED19C4CEC0;
	Wed, 11 Sep 2024 18:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726080630;
	bh=LQd1Skg4zM1ghKcTXpQnJ+XUsVQsj7YDrHI6tS4GjFY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CK0g1hp/ApTkXzIwBb2MpbED0yQyUjJScm+aIXXOath31v1fyp+qaDYSI2BWfaLUF
	 DMZkV89JDAC1WbccfTIeuZdFv94lpSQsUTPbhyywsn+GDyndJhyknbCW0uO/+vRDJY
	 MVVQ1w00KgBXoutvmzNel9HNXUUBYMo5362iDi628rbM/vsWYOsu/yZKh4/oO7zJLx
	 rCdMsheG7pme3lmACkGxEOfBGj9NvVIA+lLxcdvn5uqyq291eQynNY2luaa5IyJJnH
	 /+8aJCLnHCf8JgUY1iOoxIkYuvqzlxJYz37oinykGkF3YRzgesjFbUZPuuBJ//O8wl
	 xqxumFejIA3tA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DDD3806656;
	Wed, 11 Sep 2024 18:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] build: Fix distcheck
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172608063127.1016039.13346469714196845843.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 18:50:31 +0000
References: <20240911172055.2862355-1-luiz.dentz@gmail.com>
In-Reply-To: <20240911172055.2862355-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Sep 2024 13:20:55 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following errors like the following:
> 
> ../../mesh/mesh-config-json.c:31:10: fatal error: mesh/missing.h: No such file or directory
>    31 | #include "mesh/missing.h"
>       |          ^~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] build: Fix distcheck
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d8a4b126c1d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


