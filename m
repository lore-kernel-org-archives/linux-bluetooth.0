Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8636028850B
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768839008; cv=none; b=VzEZr7XEfzdx+Yg3BBICCaRpwleYW9ofPrcTNpWdYraQmwe9yQIZQ4cz0IEJkQ8UXjdnlHQnF82IoWx/z3U8/pQHH98gLOGzvIIDdky88jHCZmhhPUAYVKazIomaI0T3XgLXKL2tpdNlfYh2tDOwuXjNaV7A2YEmomjigiWqz+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768839008; c=relaxed/simple;
	bh=rkE6tQOJDbUqGMdlKIkh07aqzl0ZqRdwNrq9P2nTC0k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ocCfo1wrPq2ye05hxoRraZc5y+7cGNDWCCI2KsmfSpuUXqTgIh1P99kPoxjmLJTRYIsX07GruM644UFOoW0JsoXviBGuzE6f32/ARQwGqjSe3R6fP64Te3N0N6+JaaVKlE+TQPtYZFq9lCuB2BhbKmGLH3Vf3L2gcPKDPO1lqTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ma1gUkEZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ma1gUkEZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13814C116C6;
	Mon, 19 Jan 2026 16:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768839008;
	bh=rkE6tQOJDbUqGMdlKIkh07aqzl0ZqRdwNrq9P2nTC0k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ma1gUkEZ/kJVrPQ8fiCtItwiC1W+cLhLgXM/R4/8Tor4El5C3Ia1hqmQYpT7/dmsT
	 LO0q3MtIKgE+/md8vcnIHwYc0vY+iuW6311TJVjJBEBFfgj4ls78PqSSqCnO8KzRXC
	 +En7nyeULSLsU41/fBdDFCIgxLb/xAfGICyYSW3z0LxmOkxEZdwwogIP0BrpNKvjHJ
	 Xb2h+2YO8sh1g7BLo553gNR6VLBtxVZ7XIuf2F8Jj2XjFedpnfbR3HV66HuWYBQS3e
	 F9b6xCJYJcUX56H9seSCXcPDZuZAycRTT3IGmVDUg46FCKa0F71J+o0yRklyjWyK7z
	 q9FrIwhQ6+8dQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3F00F3806904;
	Mon, 19 Jan 2026 16:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] monitor: Make eir and ad print hexdump
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176883900604.36627.13304177226454213873.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 16:10:06 +0000
References: <20260116202614.1781836-1-luiz.dentz@gmail.com>
In-Reply-To: <20260116202614.1781836-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 16 Jan 2026 15:26:14 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes eir and ad print an hexdump so user are able to identify
> if there is text encoded into them.
> ---
>  monitor/display.h | 51 ++++++++++++++++++++-----
>  monitor/packet.c  | 96 ++++++++++++++++-------------------------------
>  2 files changed, 75 insertions(+), 72 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] monitor: Make eir and ad print hexdump
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6a9117531e39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


