Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DD11C84A1
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 20:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747427392; cv=none; b=tNksOAHgl2sQ+hsLrpo6iVYLHZRc9AMUWkU8CRjXPOfJPnbu9BqgKz3VgqhcJVqD5OKDvv2Hc8w9iF4uR77JlCQjy3v0o7oogcXneLQnBdb5rRNsuGSNF+4VcSWFnoKfMQVpuFh84Deubx/4xDZRS7fwdPNgWdmiSpK52CqtcPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747427392; c=relaxed/simple;
	bh=EAxBSasROL+JDmOEdEtww9X+YAVfNikqOhvuV6p33nY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bZfeQ2U1oiOylCow49cihVoSR51EU1IHUmPYfkZSM1LcMkeZ/U4gqiSdUV8aCPQTrIGtYDZP+2blD0AzTaMb2E7D0pWnr95nlKa0jZSnz4ne5avAQkvMwjYTEjqAjSnSy0J5l7wEIZAGCNPI3J7+jHskImnC86GMFsh0FYKjtuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixooOjKE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixooOjKE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7717C4CEE4;
	Fri, 16 May 2025 20:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747427391;
	bh=EAxBSasROL+JDmOEdEtww9X+YAVfNikqOhvuV6p33nY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ixooOjKERcOxAta3l1iKVhICfjhb2LaLqKV1pnOSrYjGl+Uxoj6L1voPdRTZEtZi2
	 wjVk//UVDinDq5j19n7dA8XhQcmdimL9/nHOe5G8YK0yH3F+HZLMZSHOlNLz+Rhvj8
	 hWPpf1MiD0MNNuqRcIz5tRdDreI+w4W82HLISgTPDfeUoEkeo++QWondaHR4eSJEhb
	 Y09kSwDlOT3XqODweHTI/nvAOQQ9Ht5sX+hsGwNqPawX571rR9X4u2Fnai8xDZRfip
	 x/+hhWiICHQn227hecPaOwvwZB67tah7FLocMdcUe6rgXg0xb0VC2vlmnR3WnIdwqP
	 H6d9ZmpC+cQ1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0A43806659;
	Fri, 16 May 2025 20:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v4 1/2] avdtp: Fix setting in_use flag for local seps
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174742742875.4055232.16367742755061860958.git-patchwork-notify@kernel.org>
Date: Fri, 16 May 2025 20:30:28 +0000
References: <20250516191039.1975460-1-luiz.dentz@gmail.com>
In-Reply-To: <20250516191039.1975460-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 16 May 2025 15:10:38 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This removes the assumption that only 1 stream can be configured per
> local sep which prevents multipoint setups where different devices can
> be using the same local endpoint.
> ---
>  profiles/audio/a2dp.c  |  18 +--
>  profiles/audio/avdtp.c | 254 +++++++++++++++++++++++------------------
>  profiles/audio/avdtp.h |   2 +-
>  3 files changed, 149 insertions(+), 125 deletions(-)

Here is the summary with links:
  - [BlueZ,v4,1/2] avdtp: Fix setting in_use flag for local seps
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=665f35180ff2
  - [BlueZ,v4,2/2] a2dp: Fix a2dp_sep mapping to a single stream
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=05f8bd489fd1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


