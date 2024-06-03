Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF578839EA
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jun 2024 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422631; cv=none; b=CT5zcZC38HhPa/zoamVfLbOzEmVxsBaN6iBMUBQlnXCSoSpFy2fsFU/vgTj6tH8tTeCPQJxM0t8IsteTpYyKJba7YT2xivE/Yisxr18PGQBxbCxkogHMGpAS5uyctWf8DD85bjJbVT2QqjOwJjm0/e+9VScALWST2Nm6CEgG8Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422631; c=relaxed/simple;
	bh=cEMbxv3P8QLhzwA9m9nrLV2ks1tP6hqk8nlJGBy4YkI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=utwW82GPUZSGcjvLTvVXudTj5gl5FEzXVldJGg14UDeq+uPhX+48whKN1ASn8qLfaxjalLZCv/Tr4j/JBYA86rztXjji1Tx2vZXU7+tb/gkuQ7ia9e5Gq9YP45FNasnZUTkQZNKanqt3ofyqDOQMW8RTCSWctvFlDcif7Fy955w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dU7ATwe8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dU7ATwe8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 760BFC32781;
	Mon,  3 Jun 2024 13:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717422630;
	bh=cEMbxv3P8QLhzwA9m9nrLV2ks1tP6hqk8nlJGBy4YkI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dU7ATwe8Hz5+YZ9oUuFncRUv6vaSYOy7hw7fZN1q2L0Xek8HJ3+faSjsHDUFyF+w7
	 zu4KE4ENEAQs4TIWCHfw5vB4SgvnLlAHnvR76bc5y5fEBAnyUkANaNOpZsLqxdIUGw
	 5M0I2InOb/6RrweIvaBfBPz7v4v8iYbJawP9OHBcti8NKKhwPjvu2WuEOiSOzU20/3
	 kjPq/JXuijb76yzD1c+BkYtggE23hBSdRmneZema5YcaDvk47e0su8omcdn2nL6yGc
	 1jVeuqafahTSFr9NFNlZH0sxXpX3FBxFHHrnvniP6ynl9jaY9mbU9CCPjCmVyAJTLu
	 JB0tUSp3yrhpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65D08CF21F9;
	Mon,  3 Jun 2024 13:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/2] doc: Add initial L2CAP(7) documentation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171742263041.17260.14819007011835483970.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jun 2024 13:50:30 +0000
References: <20240524144709.2274991-1-luiz.dentz@gmail.com>
In-Reply-To: <20240524144709.2274991-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 24 May 2024 10:47:08 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds initial documentation for L2CAP sockets.
> ---
>  Makefile.am   |   7 ++
>  doc/l2cap.rst | 258 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 265 insertions(+)
>  create mode 100644 doc/l2cap.rst

Here is the summary with links:
  - [BlueZ,v3,1/2] doc: Add initial L2CAP(7) documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f5e59893e634
  - [BlueZ,v3,2/2] doc: Add initial RFCOMM(7) documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=098ff00dea08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


