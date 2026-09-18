Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B923514774
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752079; cv=none; b=aGn/FDFu1ZakkM6cPIdiKhh0xx+HGPhyJkA9IrHT6Rvc2iSZ+K1OhUFP18DFz0C1rY+qKRSRblxvGA2znDK5QrDybUgviGIiPnIY6rKftEAtMC1WGglLRXtOePdRwVuBLwFslLEhHYsZccloy2qJpV8a+CdhWQBYuaQjGfMiq28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752079; c=relaxed/simple;
	bh=j3/ZofzXDMd+DoO6WZH+7e1SPwCfJVtOnwNcoIoIURQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JYo08eUE43wWa/uFhUCfgywPAG5lS5b0H0MLLIKSgN804UI2YaRRzvFGDYMco6JPdmn7CnSTUUCrn3cS+rHXU8X07Cx3L9Hf49c1hFBRU1SYxyPdSRXDvSDkeRILafMvV3vuPr3xRbJ97/oSHZgzR/PpO/+WvVoIdjV0rOES6SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiewW3Cu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiewW3Cu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1941F00898;
	Fri, 18 Sep 2026 17:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789752074;
	bh=vEIarjZRHbVsu3+q7bx0uQrhPc4gLlPqaPSVy5GU/RE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fiewW3CuvpXsSEUxI+JiQ7gD5wqJBbyFNkRfvujrKEjPj6ABdLu+ZViZnNx4Dcz/R
	 fGmslChRbDGYryO5YLOdJCs7OfOv7IfjdLwgDjTo18gCzv7hmg/esyvBfbj1PQv0UU
	 OrRNvX2PTPhm2bcleuaKmK2Tlyqf1NRWVesFs3cv80uHNSutYmD1XmLoHnwKJNN5Yq
	 lshK5CY0m1bjM4r3ujL6jWO5AZKr9Jt1KigF2XIqt7AmL8jkUjjlO9iVACsPiNbmky
	 tv5jGDUw0gkDxJf4M47ak70oIiQCC5eJlVQdo0AF/Yc7JsnAXfUAY7jg/lDdmzKPH+
	 milHBtTW32zUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9397C380DBD7;
	Fri, 18 Sep 2026 17:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v5 1/3] shared/bap: Skip local metadata Config
 callbacks
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178975200713.1061421.865108747218478058.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 17:20:07 +0000
References: 
 <ys4-B1PGqhV2wgPjUFnZLGOi_QkoCs1ZyOZl679pGV8nNJLfR28E4wDuGQti0eyGwIYHgFGa4GqfTi5Vg_nvOqQBqEhRaTlA_D9MxgEblZo=@proton.me>
In-Reply-To: 
 <ys4-B1PGqhV2wgPjUFnZLGOi_QkoCs1ZyOZl679pGV8nNJLfR28E4wDuGQti0eyGwIYHgFGa4GqfTi5Vg_nvOqQBqEhRaTlA_D9MxgEblZo=@proton.me>
To: dt <derektern@proton.me>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 17 Sep 2026 19:12:04 +0000 you wrote:
> From: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
> 
> When reconfiguring a client stream that is already Codec Configured,
> setup_config() queues Codec Configuration and then caches metadata.
> stream_metadata() emits a same-state CONFIG notification for that local
> update. The profile callback treats it as the peer's configuration
> completion and clears config_pending before the peer has responded.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v5,1/3] shared/bap: Skip local metadata Config callbacks
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=11bf67364e55
  - [BlueZ,v5,2/3] client: Pass unicast preset metadata to config
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=72a5ce497f34
  - [BlueZ,v5,3/3] test-functional: Cover BAP metadata reconfiguration
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


