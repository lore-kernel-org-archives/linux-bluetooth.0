Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17BB18EFDC
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720621835; cv=none; b=NBxJKHXw+7P1UtZQfsMyPQymacRaZBBIbPHJ/qbJFShmZrbg/g58A5JeL4/N4KBSGQoMe3NBwx/0r/GoiRzDpzqD+YO0RVjT1yhU6yBYdo7e5mHT/7uGnpZchNHbUpRISmvAyGrpjfweB98YshJa2pfM0UMKxvNfDmNggKjzrXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720621835; c=relaxed/simple;
	bh=4V69Oz/kOmZJAUxd6rKJqorLkRkLOlAkh3xmJxrSHnE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b1pzSobk9FMeXWcTbotscByn/selUNca7YVODNS0CHr7cGBd508vbc9UM6DS4e9fm/3m6+yPXGT8/Vz4hUXiRwZHjbpVBGhViZIbBg1OCGTFpLf1l6Ayd6KZOHNeJbA2qygqsKd5h5vWLw45m4EB/fwI5iXfVqmhhoFemRQMDBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbauUlz4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbauUlz4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 672B7C4AF0E;
	Wed, 10 Jul 2024 14:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720621835;
	bh=4V69Oz/kOmZJAUxd6rKJqorLkRkLOlAkh3xmJxrSHnE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nbauUlz4tPgy3g9onUsex2qMgbvSuyIi9R0BUZdFdGYxMrTn45/pGNSSUMpYLwjnm
	 Bsfpc1KnR2nhrlFG3g141iJYj9i6FthOh0rzpqN1p2SZGWOzEilXy4FKbc13naNTBu
	 MvPBn954QhhOZg5fCQ4swBzmNUkKLoEHAH1sYpwKQMeN8mRWy1tzJeie3JxBKXW+jf
	 nox1n/HG1R1EGPe6EbiKqcQx5LQrqhVkd4rB9XzhAX3FiBEer0pCcMBtGzof1LQs0C
	 dUswh8uHqULcWRgU/ZIviV8TClX0duMfBKV8Tio4PwLPXrqYdCgZOOg0KBZvMY/0nG
	 zEifBa2XivKTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BC16C4332E;
	Wed, 10 Jul 2024 14:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] client/player: add error code handling to
 transport_recv()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172062183537.19459.14293112648794174623.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jul 2024 14:30:35 +0000
References: <20240704104928.43336-1-r.smirnov@omp.ru>
In-Reply-To: <20240704104928.43336-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 4 Jul 2024 13:49:26 +0300 you wrote:
> It is necessary to add return value check as in sock_send().
> 
> Found with the SVACE static analysis tool.
> ---
>  V1 -> V2: the name of the patch has been shortened
>  client/player.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v2] client/player: add error code handling to transport_recv()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=12525371ef08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


