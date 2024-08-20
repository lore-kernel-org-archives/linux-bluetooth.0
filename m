Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B352218E37F
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166636; cv=none; b=MjeudPns1wcU9acPhNfD/Ky74NsLGbZVOY0XpdVs/zQ/SzUTHXQuTK33oflb89bjteWXDF6S8nBtef/FiZao3Bw5lXB1obvP7olhlxETmrUVBXQTMeivr8Hl/UFBnJlA68g1MmE9IuAsltALaFuUgEYIWKGMRvKkbXuGmMtfd/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166636; c=relaxed/simple;
	bh=Cg8q5QlP+zvTHJxvbcXGzhuygyQP3bGbJPWBEQg2W2c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XdeZYywOegmeQmSOpgws/3/3nn1IpJ6EaVyKfM9PgvsnPvYT56usqMZOCWgDJl5tWyM86HrMOvEHSVxjuLDvumk4tzaGj9G0e+syTA7Kj7pwUIsZK3gYPs72W9H+kN9WaVjdypJJAnbNdEOvChJQAEUw0YxwT5MC/X7+Es9UAWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dM3dN7q1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dM3dN7q1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32361C4AF0B;
	Tue, 20 Aug 2024 15:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724166636;
	bh=Cg8q5QlP+zvTHJxvbcXGzhuygyQP3bGbJPWBEQg2W2c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dM3dN7q1nVtgCZ9TvWwtmGBf15jBCW3a3svWDQeFj537LL+5WkBrjFThyfB8DWBHI
	 QZAeiOx6a2jeIWGdah7Qv9EuylYr7lgF/Ivq3gLzSfIOzVqZNy1wG4E087Kr+dmLL0
	 kc+08sD4/4vf6tOqDodYTHGU5C+XMJM4VxsNtQTcNNNIQufUM0PdMBdvI/BIxpNZz0
	 xdXLtEDnPTI4ADiK986D3tpY5D9c1OUeKfp9RLdx2sbZwFp6jlU7AD4ldUSQWORO3N
	 s1dlm3+172rNFaXfdIo+QExMM9HsBMx5SMBLpumWdDTaAzD9y/cqmIeC1jHiuzJ2ZF
	 mJ9wVGwe2zjbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADE93804CA6;
	Tue, 20 Aug 2024 15:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/4] client/player: Add support for entering metadata
 via endpoint.presets
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172416663549.1167792.3666969719288050760.git-patchwork-notify@kernel.org>
Date: Tue, 20 Aug 2024 15:10:35 +0000
References: <20240819195102.37393-1-luiz.dentz@gmail.com>
In-Reply-To: <20240819195102.37393-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 19 Aug 2024 15:50:59 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> ---
>  client/player.c | 46 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 38 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [BlueZ,v1,1/4] client/player: Add support for entering metadata via endpoint.presets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b35d0a45baf2
  - [BlueZ,v1,2/4] client/player: Make endpoint.presets accept endpoint object
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a59529d3bac6
  - [BlueZ,v1,3/4] client/player: Make endpoint.show print local preset
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c909433ed23b
  - [BlueZ,v1,4/4] client/player: Print endpoint preset with endpoint.presets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=168ea3078066

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


