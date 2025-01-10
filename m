Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548092066E5
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736523616; cv=none; b=QTanQanOKQ35UREVVsDnCqcGCghzYnuB0TRZxrDJuCd0KG22EwJTw07Sp4FjS5qewsyxvdMgfPM9WLqfrWRtlYGt5QCy5uYkpL0fKYnx/8EtD0QuoZ4rCZ8kvsarSjErAm7K+v6lw7kNfDGEJRu79YiL9t8jSc6KU8oXHr/+IK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736523616; c=relaxed/simple;
	bh=Ltzn3wo2rbcBAk1uR9fzZWw0xAPXkSy2bh+3AIJ+xzY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CESRd5m2Qq3gRNpxYWvgu6FLmyCYPOrcRg2vvafiagwqCzI/A495R75NfhVNLGXPXcGx+CXQDtWNWlLCOK9YWkjNv6sXhpMtcM4et0YfbB21yn+heBy0NY7f0Tfp2+MpCT617EnJAqxFIdsEBi4JD/A+c9/TUqLX058kMp+J8IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4sih5d/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4sih5d/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB73C4CED6;
	Fri, 10 Jan 2025 15:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736523615;
	bh=Ltzn3wo2rbcBAk1uR9fzZWw0xAPXkSy2bh+3AIJ+xzY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m4sih5d/aBBerUcdp+EgKY1UPr8nyn8qKhKyOQ9RpbwZkqwxq9y7hsjwLNaBTj8pm
	 2yoIVpbyE9iPggBCCNeIZewCkrtoNFw9wZHs9u0ZT7BP9T7okE5izoK6wWG74Sd7FO
	 O8xMx+1pc3soGxhaSIfqcCdnBtTvD5ehsDrL+BYDU5kesUSG6sqKcwNiIB8U6u1yDd
	 qwS5gBksIBrtGYQjKx5Gilv0l7a30/820tZYd4aGn7yAcQWcsVsu7y2coNAF8oHGdM
	 45IDSgDI/IaNsMZsqqgomvqaY0b9JrM8F4CZ7E/udWB0LDwVO86MFaw7iPRAzST8Uk
	 vnN1tVF/n6inw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB98B380AA53;
	Fri, 10 Jan 2025 15:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] build: Fix --disable-avrcp
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173652363777.2106346.6113301150872891393.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jan 2025 15:40:37 +0000
References: <20250109210500.2324501-1-luiz.dentz@gmail.com>
In-Reply-To: <20250109210500.2324501-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  9 Jan 2025 16:04:59 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes --disable-avrcp causing build errors.
> 
> Fixes: https://github.com/bluez/bluez/issues/1061
> ---
>  Makefile.plugins           |  9 +++++----
>  configure.ac               |  3 +++
>  profiles/audio/media.c     | 38 +++++++++++++++++++++++++++++++++++++-
>  profiles/audio/transport.c | 10 ++++++++++
>  4 files changed, 55 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [BlueZ,v1,1/2] build: Fix --disable-avrcp
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1e1c311243b1
  - [BlueZ,v1,2/2] build: Fix --disable-a2dp
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4f288bd961fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


