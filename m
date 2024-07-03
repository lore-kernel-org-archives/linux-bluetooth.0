Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBBF17E46A
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019433; cv=none; b=F2BKymt6BQWud61sR/WU/79tKF6Yh/Q80Q6Ml4H9KnPm0YwN2l1k/1nbRrgpp1Lvjti+Liw4xw3/+kWvVi4sE5NnFEfPAA8bhXQdzCX51Ko6ua6sXHX/8UiuNKk1TWW/Vokk/+Kh9V0yoZO589TmVjfWZL6dJoNRkM9IY6ptur8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019433; c=relaxed/simple;
	bh=/YU5+9Opv0lGVNA032sQruMzZpHclybpuEuCIvwA2nk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L10uqWN8os/TZAnSAVNi8qlDpCr6iRkt6oLLrJYwi5i69zCKRwoF8fBqml3WaEG8lVl1u7Q4aYaCPblmbLUK0GHhmoAeTTlA3M0kFVaMKiVGgZJfCwHFfiAPp3wXc71MawNIYzEirBaoEd0BS3kIaztweTiB+FIJR34njbcQBqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRSGteqr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRSGteqr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F279C4AF0C;
	Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720019433;
	bh=/YU5+9Opv0lGVNA032sQruMzZpHclybpuEuCIvwA2nk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oRSGteqrScjQWdyf5jVZ1IvdceHw70xMO46ticSTJOEjfIu69IBTLo+1YOIO34POD
	 cXEjnWl9Ka0JI/DsgD170eItXn4uVsRW0HwiR8Iq5tuX+otR1Bb54mKUMmtfuClhDq
	 OPFMaUAuKNrBX3i5WKva6BVN+wrE+qJZn2R4KwSh1PgOlFHKFxdUf4c4HBLX5yH9Cx
	 hEP7Pdmg6l5UQsdeaOMCu+m6hH2Ks+OY9w6p8DwJHdXZnxC6cIMRaAQHbUZwjZEBY7
	 Ix7Hs+OoNnBj9siXnkndw0kd8nkMD4st+AohhLp2xhBcyu5fjaR+kiolvtkCm+3Ugz
	 yv1696mfVDnOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23858C43616;
	Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/bap: move checks for NULL before
 dereferencing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172001943314.18626.10137594433341371325.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jul 2024 15:10:33 +0000
References: <20240703092322.16659-1-r.smirnov@omp.ru>
In-Reply-To: <20240703092322.16659-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 3 Jul 2024 12:23:22 +0300 you wrote:
> It is necessary to prevent dereferencing of NULL pointers.
> 
> Found with the SVACE static analysis tool.
> ---
>  src/shared/bap.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] shared/bap: move checks for NULL before dereferencing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1b961b9e15c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


