Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDE834B437
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 18:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776104435; cv=none; b=qVUgAPUHUDkCJE7OL9Ag1MIWOz8ckDxsr5lJGMjjShk+f8aPg8UdoC2zzxuewNN21Sad/HPdOHIIgnxG/JeAQUI2d4+mBdaKXtArV21auPkO50Wxlm/v42VNZjrylZJtojWi9wf9tLowjd492GxJ4yqVQp5yc4QmS4FBXHu/Rno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776104435; c=relaxed/simple;
	bh=ZxYklCwx+f1U90VE5YDHYxgSHDg+9J2yt1l4nYR5sPE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d2E6VhBL0cokftj5v4sPR7hFEg+GGgnSQuylmLODNoVt152gEmRUPKuscXSuHFx/unmO8fp1uQgeCCuWOYJkAdWg+TGFYGZMiOFi9DmZMNv/qINAnTwa59X9fbl8ak6b3SJ9DMB29MhN4/4ijDi5U9U+nV1MsaChHXPMA5CX+gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQwm9hU6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQwm9hU6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DC6C2BCAF;
	Mon, 13 Apr 2026 18:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776104435;
	bh=ZxYklCwx+f1U90VE5YDHYxgSHDg+9J2yt1l4nYR5sPE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qQwm9hU6axOBF+OMumRHgRCHb6LPR7fNbRGshE/K6GHsIBwvdoJ6VNSizj+uaL9bJ
	 dQiNVaXauYAxi21p+9U32RClAsouMU1olujzGxOWanY8sVTvPAzJ1pPBx57b6t8hbB
	 FSMcrDOE3L7I3sZsc5sDd4rYsR2arOkpsYxsunWuP/S/YybIn2YP4FjHi+wfDlGCjE
	 0eRXWB2Hz1FuyXDlo3cUpuJJSpqUd4RmrOEsS7v3mwZ4jb/3Tw8LaVkgeap/r6H0cV
	 Ydq8zjaQL6tFhq9P6pJgVumNxXsluMI+MW/RzIl1IHW1IlLH33Yh+fRNvbfM7eyNVI
	 MJYe82c+HNFPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C6E380A954;
	Mon, 13 Apr 2026 18:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: SCO: fix sleeping under spinlock in
 sco_conn_ready
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177610440679.483249.9458207457157169828.git-patchwork-notify@kernel.org>
Date: Mon, 13 Apr 2026 18:20:06 +0000
References: 
 <9f333a79da3f0f552ca735d549ea3e8ae0784220.1776019593.git.pav@iki.fi>
In-Reply-To: 
 <9f333a79da3f0f552ca735d549ea3e8ae0784220.1776019593.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 12 Apr 2026 21:47:42 +0300 you wrote:
> sco_conn_ready calls sleeping functions under conn->lock spinlock.
> 
> The critical section can be reduced: conn->hcon is modified only with
> hdev->lock held. It is guaranteed to be held in sco_conn_ready, so
> conn->lock is not needed to guard it.
> 
> Move taking conn->lock after lock_sock(parent). This also follows the
> lock ordering lock_sock() > conn->lock elsewhere in the file.
> 
> [...]

Here is the summary with links:
  - Bluetooth: SCO: fix sleeping under spinlock in sco_conn_ready
    https://git.kernel.org/bluetooth/bluetooth-next/c/d87bd74aeb54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


