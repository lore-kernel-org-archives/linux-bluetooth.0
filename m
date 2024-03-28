Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD11A80C13
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636829; cv=none; b=rDmfKLsaXUByv18lrfDM9NhPiixZZBqRzN3AEN5BR1aeihU/h/ZUJK/4zXvmfTW0vj48CHb/dxCNyPhndV1Q/wu+0Ug13VpYMVDjpoFrIbzwwHUbANJculKZlW1+8UxBA3zJbqryrscXcc9GoGtvnHrRb5Ive3wn9N/bTGHzltY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636829; c=relaxed/simple;
	bh=L9+FF0vZzP7YNcslsSH/D8k/kgynFsk5bBemF6MG55Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OSX8eJ9DIo2+7AUu4H2yAcTpPIy0qexJarz4aCUNZckT4U/dIhb/WaO05xEcKIFvk7QZVvTMptYRA/jaGWc1Lz0vQjvXXASgyeNgCvPkL4ZHfQyENAcZA+LpWL9lP/9kVb15aeSMS+RvMVJ/O2IKSGfmASgn1wWCKKBQIxxpymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sibVY/c1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sibVY/c1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74D4BC433C7;
	Thu, 28 Mar 2024 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711636829;
	bh=L9+FF0vZzP7YNcslsSH/D8k/kgynFsk5bBemF6MG55Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sibVY/c11uSpgB6DkbuXd/2+D1nCTjum0DDkt0CPS21hZB0HNrOsvaecelLEs6SD3
	 7YOBBUeXJ8NhxdgrDAO7QH5WoVszJ3OkkiFojZXGb4bB7W65BrEPJnD/jS3P1/AvkF
	 dsF32vzAqWHQA3fsGE5z9emFP+wJRClbe+cqEQMtlX2eznSHdJshGXChsBHlgO/erb
	 M1f+e2LiZFRu+ThxKfZmXWCYhLlv4nfaRrcBRtARna3t3KznIl+KJdbDgo3FLJuftF
	 8ftBVwyW6U22i4YtgaHsS5uAREJqQ0EZwJLyuqgRGQwGvKVFJmj/voN79FJptaXVaZ
	 dw+/5xS70uWjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E87CD2D0EB;
	Thu, 28 Mar 2024 14:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/2] Remove POLLOUT check before bcast defer accept
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171163682938.3770.16731484454847220972.git-patchwork-notify@kernel.org>
Date: Thu, 28 Mar 2024 14:40:29 +0000
References: <20240327161019.3078-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240327161019.3078-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 27 Mar 2024 18:10:17 +0200 you wrote:
> This patch removes the POLLOUT check on a broadcast child socket before
> calling "read" to accept defer setup. The check was inherited from
> unicast, but it is unnecessary for broadcast, since the POLLOUT event
> is never generated on a broadcast child socket.
> 
> Iulia Tanasescu (2):
>   btio: Remove POLLOUT check from bt_io_bcast_accept
>   iso-tester: Separate iso_defer_accept into dedicated functions
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] btio: Remove POLLOUT check from bt_io_bcast_accept
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f4c40dc4107e
  - [BlueZ,2/2] iso-tester: Separate iso_defer_accept into dedicated functions
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3403f65e266a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


