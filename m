Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB1B153581
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 May 2024 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714660833; cv=none; b=hPfaC3LRZlKtoJRDfB2ngDnxNKuTfHOAAEs2/SygGm+r8wC9xS08c/BtHHmm5QGaF3PFExoVQJ4DH5u5fKJLZP21ljBqPNOJhedNRiZNTRECiVNfOfD7O20J3sPzDyiHbpOc9HXis8VHOL/jOkwIQuQq8VDFAXMn23wQ+J0r5g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714660833; c=relaxed/simple;
	bh=ZGFzxC6hjtTT6db/n1ne8d2mh6fV6A3b+2jbb5e999Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oY8a/sxw6JH8URmYJgtMgQpFKn5mjT5ogK2yUS20cE/VVdhq0YqGhhIzwoTh/BcITCpmyrslSmT2HC7DjPZ9rHxjKRj2o7B9qbNiGkeM9R2sRDCRXwLdSK0rxt7025zjUMg62hHg4sM2Ie59PS83xFK2s6p8i9LeHdu6d4cPEYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1po0jio; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1po0jio"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 243C5C4AF14;
	Thu,  2 May 2024 14:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714660833;
	bh=ZGFzxC6hjtTT6db/n1ne8d2mh6fV6A3b+2jbb5e999Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a1po0jioXaqMu/PtXRiodYHAjxBStAdPlVzOvdNyVY/20otTK3qdkbbsHiDKC1wu7
	 pn/BL8G6P8r8DGnNHcuknjQCEilYefwNVZq2D/CTOHEfEbm57ZmjqmqxDBE4HdcuDP
	 2aD1IIYxHlAtCg4VSkDCV/kszxOmwrG/brHhj47g1jaBGw6X2IdHoqz2d/siQdK10Z
	 DHfpczC1AVokqnmqnE5Cl0v19/zHW5+eZ7SwxIo2z5Z/bI1a2gJRNeweim8FKTNEvP
	 OsRPfMjKhUZoUvMIrv+W20hWrSaoVREy5Cn7q1MnrKb2XYc/RcYexe+BefRnN4xy+I
	 YCNRvMCDFn3Lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14196C4333B;
	Thu,  2 May 2024 14:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] src/shared: Make default length handle EA
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171466083307.8921.9306955257652559541.git-patchwork-notify@kernel.org>
Date: Thu, 02 May 2024 14:40:33 +0000
References: <20240501192812.3421949-1-luiz.dentz@gmail.com>
In-Reply-To: <20240501192812.3421949-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  1 May 2024 15:28:12 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> By default bt_ad was setting just BT_AD_MAX_DATA_LEN (31) which is not
> enough to handle devices advertising using EA, so this switches the
> default to be BT_EA_MAX_DATA_LEN (251) since EA is much more common
> nowadays and for those case where the it is not supported (e.g. for
> advertisers without EA support) then shall be using bt_ad_set_max_len
> to adjust the maximum length.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] src/shared: Make default length handle EA
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f40c5857d70a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


