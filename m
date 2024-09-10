Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5CE192D6C
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Sep 2024 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725996639; cv=none; b=OJd7Jd4+02pipB+VRhp8a1cxJll+2PPA4IVOy0e6PJc8RSyLCFYpbwWgz+YIP6a9q15aHtXOr2Kb0lsI3rMYK5n/f7FuKR+Ggd+qfKikD76lvmNK0RqxySZHsBHMlBaMIavplSeBn9OMfZ+sr2rqsAroeRn9NgKV4AMy3he8CCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725996639; c=relaxed/simple;
	bh=ozB1SVeX0x4csfCLs7lzS5/v5GTfilmlUl3i9ieA7Gc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eN8ztSTgJVIZAdt/wkZkZclZS6aOkJzYft687ck01phn3bKY47G6fXcFzNc9B6euWAUQYg4KaAw28x4TN6Zv9jrGk1EHsKDB4yJ+mj7Wele6OIblhnuZQZEtalOCQqASrSVA3c0I9ma0LjXU0wxwXetdgElKMJccik8EY4QsJl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAl5sz2+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAl5sz2+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC02C4CEC3;
	Tue, 10 Sep 2024 19:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725996638;
	bh=ozB1SVeX0x4csfCLs7lzS5/v5GTfilmlUl3i9ieA7Gc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kAl5sz2+0m35v1ecgq6MbAGPD2Y4sZ6+w9vIBhFAC/VNeTkvo1ywJ6Rv7ZA5cWY1v
	 bK0STqcFUPkhKF+sPx+o/N3JTGsVHBu8SiSNoe/YkFD2ftVfnELamGU9s4V/nTNGJo
	 tKkx8n3H6OCiLbM/M27QtnMcHF0Hmhcek+A97X/SufDajvD8CY94a+awkQJoxKNdBe
	 YGzxcCJ3IxrSVS9EF4IeIijNBIJqfMXd02SNAPH+KVlOOr7kruh+VO8qk/yLrRv+Lr
	 7glwQIqAiwaWs7gWmNVWEoePRKS29ZHaECZPcdSWTBthWsnU/aSqZXe+c1TbFzxOdr
	 YpXMeNXQCFS4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713543804CAB;
	Tue, 10 Sep 2024 19:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 BlueZ] Provide GNU basename compatible implementation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172599663901.370850.15452739101514293274.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 19:30:39 +0000
References: <20240828060926.3710535-1-raj.khem@gmail.com>
In-Reply-To: <20240828060926.3710535-1-raj.khem@gmail.com>
To: Khem Raj <raj.khem@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 Aug 2024 23:09:26 -0700 you wrote:
> Call to basename() relies on a GNU extension
> to take a const char * vs a char *. Let's define
> a trivial helper function to ensure compatibility
> with musl.
> 
> Fixes Issue: https://github.com/bluez/bluez/issues/843
> 
> [...]

Here is the summary with links:
  - [v6,BlueZ] Provide GNU basename compatible implementation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=690eccbe8562

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


