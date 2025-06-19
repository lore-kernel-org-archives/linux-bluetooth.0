Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C86230E820
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 18:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750356583; cv=none; b=Ggkdi0QiUeIYWsqmTV4scwumadC4oy13JbZUTt8o+xQO5NB172zQN4CJK62k4O32D+HoFh00X/QFzh2NA5ZAdgTBLkYQIgidaIyWsbBvKpoADFBRQXw9NNhPZMA1JMbHQR45iuRGn7ZBQfGteLqTO+CE6xL+6fR1ZK/Mnnj/Gi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750356583; c=relaxed/simple;
	bh=F/m5eCR/ToRZBYXti0lOJPJIi1JUn+oFPPSXDd4C2ZA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GW0Q49Cg46Lt49zjIEuwxWC0sH6wPjVz/2qZYSFC97dUam/yh0k8+0zs8fwkcAKuJYylPmnS1NNsusFKHmUcBnxRYaxZqM723VUajkEtA/p7LTnvlHn8ZoF7zokCejtqv8FKwg8ISEozbh4an5ecqXp+gBsRsKsgr2tRqeoCqA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SP3L6o1W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SP3L6o1W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220E9C4CEF3;
	Thu, 19 Jun 2025 18:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750356583;
	bh=F/m5eCR/ToRZBYXti0lOJPJIi1JUn+oFPPSXDd4C2ZA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SP3L6o1WIxU4tUpmMx7PBLROl065RJn5MOBJFOl6CxWXWSiUdiAP0pUTXGcZLHdwB
	 dA0h80Lht5lj1TeM6+QL0XAFUZutpnEp3o/+Ktskti9FDtD3qI1DTiJ3k1Uyw0NmEk
	 pT7r89QCjsEzZDozoQdQDWtyw4maIUNX4TILwfjOcHY62EU4bwnSUDLQPKGMmGaCzW
	 pIKUiQorOOqjlFM4x4rSt8noHMJ76v8S/iFtBQd2pcq8X8fWBFxBKF0tTUOVK97Cub
	 lIm7KLpBda67lRuoUpnDuHwJZMi07EqhtN04nOz29JLNSyIdILjBCp3uz3pObx6Q8k
	 k5oyD+iQ40U+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E3738111DD;
	Thu, 19 Jun 2025 18:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] device: Fix memory leak
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175035661098.946806.9850375467021760470.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 18:10:10 +0000
References: <20250618152918.220245-1-frederic.danis@collabora.com>
In-Reply-To: <20250618152918.220245-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 18 Jun 2025 17:29:18 +0200 you wrote:
> This frees the LastUsedBearer string to avoid memory leak:
> 
> Direct leak of 12 byte(s) in 2 object(s) allocated from:
>     #0 0x7ccf538fd9c7 in malloc ../../../../src/libsanitizer/asan/
> 						asan_malloc_linux.cpp:69
>     #1 0x7ccf53665b09 in g_malloc (/lib/x86_64-linux-gnu/
> 						libglib-2.0.so.0+0x62b09)
>     #2 0x7ccf53659b90  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x56b90)
>     #3 0x7ccf53659cd4 in g_key_file_get_string (/lib/x86_64-linux-gnu/
> 						libglib-2.0.so.0+0x56cd4)
>     #4 0x5c8c691f2811 in load_info src/device.c:4225
> 
> [...]

Here is the summary with links:
  - [BlueZ] device: Fix memory leak
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=941dbc5f3b56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


