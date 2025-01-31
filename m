Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D610B25760
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jan 2025 19:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738350607; cv=none; b=G+O4rttcG5THRdjSqEGkAJu0586OcQZyp8C+G7OpyfROBXDBBXzCugxhjMcgKnFc7u0pWBAWroPG9QSFETAPJFl6uOXAjLHxZ4UTNowdHao7oFM9XGNkIACbMewpUz9Eupy4WHceOq2T+gXcMKLKN5j4ZT0hwQ8YL55bQ//R6BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738350607; c=relaxed/simple;
	bh=wJSxwfxB0/Sazf/bBsn1fmUcw6kWnZnqjHL2eVnS/Fs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZF0JDlXKXot8aYRM0otXLM5bEbwo8oFzk9ByQm0w14U0PqEk8OzAPDxmOw/jDI43flKGq8Qf6squbyv3T+fvlhv2x4E4CNeYkiaA4DcP1N00UCJNzx8wq8OmIp5WH4czzM2shixGNs5tQokdP9KkSZuaD3U7/QXlZuPkXt76IgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1vg0WPh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1vg0WPh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCF8C4CED1;
	Fri, 31 Jan 2025 19:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738350607;
	bh=wJSxwfxB0/Sazf/bBsn1fmUcw6kWnZnqjHL2eVnS/Fs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c1vg0WPhUN5QSke1iufJX5BUGklKt8reuDG9GH2zvfy94Z6Mx7ENmj1xf1qeFqy6Z
	 I6kHSCfuUYU7/IdYtf8vX5QTIKuXIpUEkYKoC8J/flTTYpgHwtOY+CFIZweTOrUbSM
	 heMeYKDkUlSd4oVtnNsPj20O9D3bxnqkZdBgU9y8muZU1K7v2o82pHrEIa1DQR3EBI
	 khr0p1hKP5bHFjoMWl10jJcurRHpkt/MiNFSEfPQ3QTMF0zgzMOUUD+S56VBgRtE21
	 9T4OOpjlgJDTL9OxsEOKjuSbLc0CbUz+rUEJ0RhdUxQ0C5C0lmPO/0WZIEc4g4O2fw
	 hIHcOd/3s3oXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB7E7380AA7D;
	Fri, 31 Jan 2025 19:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] build: Remove AMP related functionality
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173835063375.1699357.17130505305402421984.git-patchwork-notify@kernel.org>
Date: Fri, 31 Jan 2025 19:10:33 +0000
References: <20250131171759.1642480-1-luiz.dentz@gmail.com>
In-Reply-To: <20250131171759.1642480-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 31 Jan 2025 12:17:59 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> High Speed, Alternate MAC and PHY (AMP) extension, has been removed from
> Bluetooth Core specification on 5.3:
> 
>     https://www.bluetooth.com/blog/new-core-specification-v5-3-feature-enhancements/
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] build: Remove AMP related functionality
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1474c11618bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


