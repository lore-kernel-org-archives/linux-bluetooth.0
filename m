Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAE14B0C98
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791472809; cv=none; b=HrB6OIkalQW7pq8GjXV0dDgDRLPRoc5lPzcTctOmLARtMldZXoVGb54TXjzUtDCATxSTdhGXYOB36Q6x0pCdCqOJ/rMaIN5LJQaZkDorkNU1exSdtl+N+e/KKlQ1dyEp6N9y2o5XlmtbRg7yM22kiO4ccYSaOoC/MDy+uGavvSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791472809; c=relaxed/simple;
	bh=BfzFf73AkG/QMhrvaJOSXxf7aMByuVstc2gVezYPOrw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tqd32oSvOl1f7Zmc81AQkzPm7IIi079X0JOdJMf+RoE5B/O6SrCgBxMsMfRB7Ad/IuBJ/KlKbIvagnon6mT2Xe/7LRneMC0l9bEu1qFLIYpA0/Y6onXNZiAfjhlBvGlWmJSfpizCLhaGctUORklPH1KCXb5TVgweYWiF+N69Q6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHfcofzJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHfcofzJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077BA1F00893;
	Thu,  8 Oct 2026 15:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791472806;
	bh=85G2tToiVVHtl8DCmgwYsrb9sNYsJU35VFS3pUvRqMc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EHfcofzJvx2rL67lJQ0a2uTnb6DIldjg1zsWylqzjJCYMYyM8neD2bb0AbvJr4g48
	 y6asNp6nE2RRG7KBOoj0bu3fNp6p1fVTrs1OXXjy4rybKFSSKz+QJQGBJgdeAMFI+Z
	 T5NN4fIUVrinyd0VSjGWg1GgwO/D7wzETQXlD/WIFEInxnhSSxhzMAgVHKhwRdgI32
	 FnoJmjuTndxxh3+GuTc3cTjED2UEaYE3jvMannr1/6doHxVPlX86H71jeL7cBo7Cxj
	 CiTpmtXVTaCoIyZLCN1NOUNnZR8sxH6IcPTBZlYXetgV6gwlXIC84taZaB3ZmoRQKc
	 oqqiqtGuu/XaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1575380AA75;
	Thu,  8 Oct 2026 15:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] shared/mgmt: Fix notify leak in
 mgmt_unregister()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179147280477.313948.6286426737429078397.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 15:20:04 +0000
References: <20261008034102.707451-1-yaroslav.voytovych@gmail.com>
In-Reply-To: <20261008034102.707451-1-yaroslav.voytovych@gmail.com>
To: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  8 Oct 2026 05:41:01 +0200 you wrote:
> mgmt_unregister() called from a notification callback takes the entry
> off notify_list and marks it removed instead of freeing it.
> process_notify() frees the removed entries still on notify_list once
> the walk is done, so this one is never freed and its destroy callback
> never runs.
> 
> If the callback unregisters the next entry rather than its own, this
> is also a use-after-free: queue_foreach() has already saved that
> entry's queue node, and queue_remove_if() frees it. That is the crash
> fixed for mgmt_unregister_index() by commit 872729a91632
> ("shared/mgmt: Fix crash when removing index"), still present in
> mgmt_unregister().
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] shared/mgmt: Fix notify leak in mgmt_unregister()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ae23df052290
  - [BlueZ,2/2] unit/test-mgmt: Test unregistering from callbacks
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6f5eeb402d3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


