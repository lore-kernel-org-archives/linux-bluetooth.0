Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6726D1B9B37
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517232; cv=none; b=YZUV7lWiLmhoNeN9abQTUmED7Nt/c7w001jgjMEbMn6CGhsz0bpWtEyqQSEN3ZvIwFVFhLTGCxYNkqN/HFmZYhpnmDdLUgG9QOG9Z5+Ij1Gz+uoupdZcFcr/VXyQJkWeQjJEqWTPuP4ioMzLS3LAyC9qhAWqLq5txiBku0h8u38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517232; c=relaxed/simple;
	bh=aCYy+sHOT7vYsUTQsRUamawgAV7fDdJiuhEn5elrqws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q5vrLM3qZDhcX6xh3EOFJ/No1sxA0ZmIIlhLCt0SlSTXc2NpJHjv+BIrrgstVcDvs9/DSOOcq/ZPE0RrpyfEqNQQQ0WpDUthgVPHt9Uu6YhF33czUehRg7WBD3hSozvzQ03yDHsf1OOEMkD0cyRlCjT1KzFtV00KYEimtDaTS9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBYzfjd0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBYzfjd0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B31FC4AF0E;
	Thu,  1 Aug 2024 13:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517232;
	bh=aCYy+sHOT7vYsUTQsRUamawgAV7fDdJiuhEn5elrqws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RBYzfjd0619sFyjkwbpNd1E0z8MKxlRC9jASqTMjUmXQXxk0QtALVSPD7jVwb6HUr
	 Lzi6gYLZ3jW9K3rBN9JachAAjuKWAUvI0PMNQMXH5NzgBJ+ZjteU4O37zDvcnqUBYx
	 vX1aXUDRzkyyPhtr25C2hwwlChPsLjhSN7RmP7+hoIxjeFMSTtDExO1wUQ+xfQA2t2
	 4OMrNUrWVgQ1JfOC/O6/LvTWzSXDGgkWtN082T3w7hHmRlYBqDctheHDYwr0ow2DBF
	 e3+NfY7Dd9Ajq1BASV1QZUGOLPDv6rV7xQrQaC4iR1M4FBuU5By3u/OU8CLLYvD/Kk
	 O8Mj/jFHNpd9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A50DC43443;
	Thu,  1 Aug 2024 13:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/bap: Fix overwriting sink attribute
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172251723223.10617.6361943923347897080.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 13:00:32 +0000
References: <20240801093010.144495-1-luiz.dentz@gmail.com>
In-Reply-To: <20240801093010.144495-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  1 Aug 2024 05:30:10 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When allocating the sink and sink_ccc attribute they were being
> overwriten by source and source_ccc attributes.
> ---
>  src/shared/bap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] shared/bap: Fix overwriting sink attribute
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=100c845b2d20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


