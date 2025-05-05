Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C40E6DCE1
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 20:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746476990; cv=none; b=uIdv1lZj2I8lB7+NMra1CxydvkQSoFxwxdIeCC4AHkQpqtWawglu4QL0f+4mS3lKxqB3BzyfWA4R2KstolLe8WB3BCaofTXjxKt/6QeMn+bf68L4HUpN37m2EfmPlCscU//DeETFmYLj0UK6ehlawPPF67ARSayqvjLkgJgcDiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746476990; c=relaxed/simple;
	bh=yfDVD6Sq/eT4mlotFEPRaPBsEEq37f5sgskoK95EcAs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UwiywTM9x8VS2AqKKFLea7wd2AiNsVMUM4Wya5g/R8vclzkvPovTr00N9Fs22zWMjW4m9y9lODJaXnXX0LeKSOIOpIJWNYPZ4EpXnEli5EUfRjBDWsJFq1QN2n8avgGvbMkmY5UqUo1QCEhDe0rduy6c4/J0g0c+mKOAeNQoWfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aB7QFFO3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aB7QFFO3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F147BC4CEE4;
	Mon,  5 May 2025 20:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746476990;
	bh=yfDVD6Sq/eT4mlotFEPRaPBsEEq37f5sgskoK95EcAs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aB7QFFO3uKmbL9sDhURIKVhFg98n71bCvA1TLtJd2wffEPirlopdojKDu5sAfLS7P
	 uycO5DE0/o/W1qjD8m0hYxr11Y+mU97R+7CQXoDZZ0i2U0UkVqzjuHsaB0HUPu+0bE
	 iQ8XRE77zrOgKnhmSqFF+ng8UKHVob8AQt2NxDYseh/mLzcYABng1851ppSpVVOnnT
	 FQej8JJkLUvqAO5h/ZTojmiWhlgXm6ZWI9se2ZuPooCCR9Xo/+cHcDtwwsd0RuIxPX
	 PmBhgM9Jo3C5952rmdFfYXwKrmHrWGJ5G03SpS5sUE1efZ32RhC/9L6zqNfvquZDct
	 eUQOOtfhzLy/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7135339D60BC;
	Mon,  5 May 2025 20:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/vcp: use iov_pull in input parsing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174647702925.879670.6088950755143285415.git-patchwork-notify@kernel.org>
Date: Mon, 05 May 2025 20:30:29 +0000
References: <a401b67e1969c6987641108d353ff4cce3281d1b.1746284567.git.pav@iki.fi>
In-Reply-To: <a401b67e1969c6987641108d353ff4cce3281d1b.1746284567.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  3 May 2025 18:06:41 +0300 you wrote:
> Check input is right size by using iov_pull* when parsing.
> 
> Also replace custom iov_pull_mem by equivalent util_iov_pull_mem, and
> add iov_pull_string.
> 
> Fixes handling of zero-length string-valued descriptors, !value is not
> error.
> 
> [...]

Here is the summary with links:
  - [BlueZ] shared/vcp: use iov_pull in input parsing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6b9dff8fe396

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


