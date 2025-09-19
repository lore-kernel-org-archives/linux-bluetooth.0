Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA59F265CA8
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 19:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758309007; cv=none; b=RFsgawFDaAMJsnCJILEVRKZZGEOQekf8E3R8vC6m+/NEDLe/7KqevLy9ACueYQwP0aTSyZ5Fr4KK7eC2OOjTufl6KnAFoGwYyUgSb+3JaiAv0hZdffdp+rd4OUGTtsrgagxCgtkSlAwM9datR1F7X+hItRspLNfzSQ5ZvNfF/E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758309007; c=relaxed/simple;
	bh=FJoaR6ZTublyn5JvFogUc214q86p13oDjHbROtHw1Ww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gNbZaop9IaUxIx9GemOO6ZBWx/Sc47qc8xfEDq2EFPviddniFZpPzaKBgkZa3OUpUePHXl7+8CPwg9mFExVC1ZhtDGZ56KfVC7TkE+5JAqnqET28lnALrC5n3K1olHMCQhdWBzTH7R6Ll2IUwiu5gHFefS29iQlO0jO69UaTRxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgIKxzgN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgIKxzgN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F73DC4CEF0;
	Fri, 19 Sep 2025 19:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758309007;
	bh=FJoaR6ZTublyn5JvFogUc214q86p13oDjHbROtHw1Ww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HgIKxzgNYLSC1q2B9C9EyhS8hPYf5Oe9P9yXANuKvlMEsZnJUadrj75SubyhJlhfg
	 8840UwoXBaDPVrznUI3sg67sclPwB6ZTJvs8LAZEpV2r8FdvvidXifL3hnow7MLdWW
	 WshIQiHmG/I0+kVwPx+oFTthD6cYVYuHgIhg644WFcd7N/tJ3UxWyV8Fi3EbS1bZQd
	 g0El/n7Ft4h4TkdlOjJQyHa+4JQEMmWdHsUY5l8+37QUzHM3E1JlG800CoPYCU+qER
	 slexSzwsHa6oYOgO59Gn9xcwrvnID9gfo4iRhRv4xlRmTKTDVy66IQtG9EWPnSSW4s
	 qEteFqb+DFpSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB15639D0C20;
	Fri, 19 Sep 2025 19:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] media: fix pac_config_cb() error code return
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175830900675.3668548.3358858369461816193.git-patchwork-notify@kernel.org>
Date: Fri, 19 Sep 2025 19:10:06 +0000
References: 
 <a9a2cc5fe58b706247b74adeaa5f0b774432f837.1758215957.git.pav@iki.fi>
In-Reply-To: 
 <a9a2cc5fe58b706247b74adeaa5f0b774432f837.1758215957.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 18 Sep 2025 20:19:35 +0300 you wrote:
> Fixes: a887b1a1b91f ("audio: Add support for specific error codes for A2DP configuration")
> ---
>  profiles/audio/media.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] media: fix pac_config_cb() error code return
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6b0a08776ae4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


