Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FFA1E231E
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Nov 2025 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764175243; cv=none; b=ei2Y2MN6tv/KWS35lnXUAPRsc5PQ+bjc/WNycKZQ9HViWYiC6SS/ZJzM5j+BTHBpG/f8KubZgGd5zNLzxbZyyvctszTbvC4AUiL88syIx/o35gqGYiFgiFZ25Fi9hnhLjhbhtCGu5RHN4kIhC/Ai/UHjtz7tDYKob+rELg9bsPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764175243; c=relaxed/simple;
	bh=UF4gvhY7JQ3gGFoIXuMD16EYxaw2Ihhlm/oy/Crve9s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HbgAaBMdtQ2+dXO7r4po7P/rmBqa5Lon0IjS0C4roK22mZxKy9nOeShBpEcD3sMnm1ixl2eSpXJCvYOEBgqmA/HHnOm4zi0V0BeiuhjLZxdWJL2az8P+tr1z3grsClkwP/fvQXVsF3EPqcknqKkdPyhnxazKtoqyZV6bmLJc4cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVCVFleg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVCVFleg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECA1C4CEF7;
	Wed, 26 Nov 2025 16:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764175243;
	bh=UF4gvhY7JQ3gGFoIXuMD16EYxaw2Ihhlm/oy/Crve9s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KVCVFlegCpAmzXx4Vp3XEBddfH2mWUbAfONP4dTn2HGn5BPsCdUpXCE+fma4zfccf
	 1VNdUv72uq9uNmKIPczP0FpanNkxM8s/JnxMlgfB/Br6Asq090ZDSLw5DZucuZdFzd
	 0atKWJGh0bvbi5SZq1uxlfF9V+A4LA+PH0NqWn6lPv5fkYgafqPvWooIvBwKqVhR0n
	 xANgOJ131wp+wXcwk5fBdiz8bbu6ARE7hMzSebt+ZE5Suhj7SapiHS9ZSIj+lcB9Yd
	 N1uu3UCyL7NqfWZMorCdLqBa0J/SO4j3NP/XeeRSjpawwDXEPqvx1HXwTI09Znc9PN
	 6pGqrwp2Guf+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEBE380CEED;
	Wed, 26 Nov 2025 16:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] obexd: Fix transfer status change
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176417520550.1757232.14120803150904739540.git-patchwork-notify@kernel.org>
Date: Wed, 26 Nov 2025 16:40:05 +0000
References: <20251125093835.17472-1-k.samburskiy@omp.ru>
In-Reply-To: <20251125093835.17472-1-k.samburskiy@omp.ru>
To: Kirill Samburskiy <k.samburskiy@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 25 Nov 2025 12:38:34 +0300 you wrote:
> See the issue for details: https://github.com/bluez/bluez/issues/1683
> 
> Kirill Samburskiy (1):
>   obexd: Always flush tranfser status changes. Set status to queued
>     before starting
> 
>  obexd/plugins/opp.c | 2 ++
>  obexd/src/manager.c | 9 ++++++++-
>  obexd/src/manager.h | 1 +
>  3 files changed, 11 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,1/1] obexd: Always flush tranfser status changes. Set status to queued before starting
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d4218235678c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


