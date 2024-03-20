Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222243C060
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927033; cv=none; b=gh6C5M3kqTg+aSqy9OHH/y8eNqhJmRtOh5W+1imMAuOGC0zu7uWlwsEHkbnSvoE7/88QElTM4Y2WlehX2WQ+mezlFjeDeW1OTBRfQqo+uji8z29ttcPiHH2s0plSEACxhR7z6vVpHoKNAewxUiXF1m2SxPdqY108QA8rkJV03xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927033; c=relaxed/simple;
	bh=GB23MQ2UfyCz+i4q8RnCH2lv/FMN5NSXLaOALq+kMVA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dL2BFkfbv152hw1ptFv6agG8+NyBSyRspz0jOfsz3OSLiRUH/0h+fwgD7bfvcBxu7lZzyXxiXAa4H++AvAqBmKiTd6B6XlYznTb1p6uyI7RRUw1pZvz1zPyE5wNtWdHwz+qDJwCsXJHYiX2J/1OvbAj3Sosdk/fR7uCb3sZ9D54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8b0jlZG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8b0jlZG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF4FBC43394;
	Wed, 20 Mar 2024 09:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710927032;
	bh=GB23MQ2UfyCz+i4q8RnCH2lv/FMN5NSXLaOALq+kMVA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c8b0jlZGxpdQG9gevpLRPyxY2kX92lgODBXcHhJqgyiIC3CeZXhulOeifv5lHv5FZ
	 Mzsf+zd9jqWS77+DCSJtrx+wuJvHvGBsUxB6sHZhnNnYjW13e0eL90q90hvJZ7ZT7D
	 qecbbuZXQMzPu0INPSARW981zAC2pXvS8+eEN8JHvOJchq6WUkQxMpTXvedePRAIKm
	 qIdhWYHQON68FDnQQ+yMSV/3/kyOLmaft+oaE4Rjly+jmuh3mj5bMLBsNRytMGaHgc
	 ZujH/TVooNqHRz9DgrV2Wy5slKTcUfGRnS+JT0p0ktZ5O0e+c7/D/tQN9Hti6eCaaZ
	 VXfWgbnqOgnFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2A7ED982E0;
	Wed, 20 Mar 2024 09:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/3] shared/util: Add util_iov_append function
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171092703272.20558.17141447352072346740.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 09:30:32 +0000
References: <20240319151917.834974-1-vlad.pruteanu@nxp.com>
In-Reply-To: <20240319151917.834974-1-vlad.pruteanu@nxp.com>
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com,
 silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
 andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 19 Mar 2024 17:19:14 +0200 you wrote:
> Currently iov_append is defined in 2 places, client/player.c and
> src/shared/bap.c. The player.c implementation is faulty as it
> does not allocate additional memory for the data that it appends
> to the original iovec. This can cause buffer overflows such as
> the one attached at the end of this message, which was discovered
> while running an Unicast setup. Therefore, the implementation from
> src/shared/bap.c was used to create util_iov_append as it allocates
> new memory appropriately. The existing calls to iov_append from
> src/shared/bap.c and client/player.c were replaced with the new
> util_iov_append.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] shared/util: Add util_iov_append function
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9fc5f9e05d84
  - [BlueZ,2/3] shared/bap: Use util_iov_append instead of iov_append
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=060e3dd69ed3
  - [BlueZ,3/3] client/player: Use util_iov_append instead of iov_append
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e96a7fdd697b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


