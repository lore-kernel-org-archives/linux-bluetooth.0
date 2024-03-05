Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390B412CDB3
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Mar 2024 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709679028; cv=none; b=K21C+/9BZKqU5dcQE5SRSiQtp4qZhkvbejKeJ3PUL9DNfgq8Vtsy8DkqSwZ386i94xwBI2UecLukBxIed4WgGmk2vf+DtOuwtmC82Ynb4tmYrhvbUdBdqR1S6evXxakoA7WpFx+vQjlxPPFGC9sZ+B9rtVuy295IG53SjwM5Quo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709679028; c=relaxed/simple;
	bh=tLJSZUQ1e0VMA38nG+Qz3I43fuoPdYp66ta94PY6f6w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sn0NIfe5xcFQFlTRsWiFNtDILO4t7PALyKShzS1gjZCtdvJ3h0RS5OG9MGHh67bOUwucxWobz83IQtLQvFnDLisaws+3rA7otflb6pvouIRuJC+0sHzRy1UkRQTL3b4LFJCRHXfSqHHmV9V0ZWTe00RGGfPPUvHcPreh4NRzdXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJv6Uqcg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJv6Uqcg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14CAAC433C7;
	Tue,  5 Mar 2024 22:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709679028;
	bh=tLJSZUQ1e0VMA38nG+Qz3I43fuoPdYp66ta94PY6f6w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DJv6Uqcglr6CVnGgo2KA7NIx05bMzF6EP24lltV+qpvwZ4Qd5wkQPNVc7uxm8cfrq
	 3pMGby36ZFHoee1FpnrFFkmj9QzLkpNmsnceI350cxKQaDQOChuRPfkFt9i0n1D89E
	 HgJBcrCw6gNsLP6dz9QdKL6CrImqZxeIAxECbyWTUnZwKkbNmoFXVwWym6a1Q1gToa
	 udeJ40qHhpSGxPQxAiGTD8c2nME4TgGnBAFrhdKLtWiP4AnYiZHrLBWs/uxoQqBuds
	 fj9lj4kgjBgnCW1TfGbBO0v3X4LjfKZMEoaYZtAY1lMZxblsTH9WUzze9H4CSzLcw+
	 lS8lGlaJJfAJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF54FD9A4BB;
	Tue,  5 Mar 2024 22:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] Fix crash in bluetoothctl exit
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170967902797.19239.8824307444348412616.git-patchwork-notify@kernel.org>
Date: Tue, 05 Mar 2024 22:50:27 +0000
References: <20240305141521.132865-1-andrei.istodorescu@nxp.com>
In-Reply-To: <20240305141521.132865-1-andrei.istodorescu@nxp.com>
To: Andrei Istodorescu <andrei.istodorescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
 vlad.pruteanu@nxp.com, iulia.tanasescu@nxp.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  5 Mar 2024 16:15:20 +0200 you wrote:
> This patch sets the data.inputs and ata.queue to NULL after being freed.
> This is needed so that further use of these queues won't access already
> freed memory.
> 
> Andrei Istodorescu (1):
>   shared/shell: Fix heap use after free on exit
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] shared/shell: Fix heap use after free on exit
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0bf9e6453ed5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


