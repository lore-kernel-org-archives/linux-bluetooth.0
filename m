Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452271E495
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327436; cv=none; b=EnIbbwW8/weEJa8wEx3tTAUuYTYYb38gykzb18TWZyGrVLUsamycaAyISG8NuXxo+8N7fefcutsKQXQC42uW/xWe1X+38AsR0PA0UUyP5OG6s5DYPs9rx6ChDFJFPNgHk9GjNObBJU1QcXsrVgAkQ/IsGQ+gaV23hGZ1UeVsL/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327436; c=relaxed/simple;
	bh=uZfrYaD4xGv2rfKX1x83skfajyCZKYNwv3i3jCOf8qQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fsat0hzuFzFuS3OlALWd821aCEds/REZVsbR9d4C3e2MlFlZQYpjUVkYxkd9ZXi05elLcuxkZbSzQPGcTql2qBJLmxLc8c0tg9xZmjDx40kSl6IvSWdVa/hx13z/ikv1DoVD0xRCpmN7Dz9OnItztxTiLd9x1mc9SSFDqdtbU04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jf/o3krk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jf/o3krk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9135C4AF0E;
	Thu, 18 Jul 2024 18:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721327435;
	bh=uZfrYaD4xGv2rfKX1x83skfajyCZKYNwv3i3jCOf8qQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jf/o3krk6YYo4msAZ9lX3g3qGJOufl233t+jXQK+xNlSwXDzPZQ6maMWWyR8USN5B
	 EScRmQXIVDnXK9EcPoG6li9OV4TCfHDm1eL/UEeZ+km1gpJliZj2KA3v6b53xYW12N
	 V+WR/KM1+YliGYVh7luzN1elj+PHJju1PtrOkdcZfuK7nN6endnj1gdT1ySHxBe/m6
	 GzfrHAmGJKZwgFP0tKqwRDYAd50qQ/5Yj00y/4PORU3Xqh8l7UQKGQG5b+SN2/WV5r
	 1eNhndyxzCF3PJ2ckszUeYj7zjCuAd41GUIfsNenjsMY38+cUBhsqvKfw6LD05R72m
	 7EAzWGGta9p1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6EAAC4332F;
	Thu, 18 Jul 2024 18:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] client/player: Fix printing errors when
 transport->filename is not set
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172132743581.20188.10635080064564115676.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jul 2024 18:30:35 +0000
References: <20240718180059.1159551-2-luiz.dentz@gmail.com>
In-Reply-To: <20240718180059.1159551-2-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 18 Jul 2024 14:00:59 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If transport->filename is not set don't attempt to write to the
> transport->fd.
> ---
>  client/player.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] client/player: Fix printing errors when transport->filename is not set
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=957c956112cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


