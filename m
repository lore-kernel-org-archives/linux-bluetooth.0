Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F4F1CB30A
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Oct 2024 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799030; cv=none; b=RbqPPt7wZuEfsuPNR6x//IBbG8tkEhLV+COXUv2gpupXNOsaKKAwGYveHurZZzxnw2NIiytFnWIN4Nc2r9M1ouAPZ9qbvicPmbAIGeH/Ip4iFKGUMNSnAF6wq4rE4mMF1z7IuAJOLpGNMVsvc7ocGVDhBNbXwATmo7U/RHO8uDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799030; c=relaxed/simple;
	bh=yQYpmxxo0MmetTwpCeFGutn+/YumZkTQpBwOTD6DdFM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T0GJliqeppi9Fq9wQEZ7hzHFd/L/30tQdxcqnw+TS+cslQXFPsIM5Zjr6x4AVN0cVXAJDeUhkeyrx9MKy660BBdwP9xZqKogRG8tjBZKlbZiIOkXkKg+c80ZjcNM/X4yoXYXBpXcptit1QEGWoPFdUU0tRgwFYJdYHTyL3Mrt08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSnUtzoV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSnUtzoV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906E7C4CEC6;
	Tue,  1 Oct 2024 16:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727799029;
	bh=yQYpmxxo0MmetTwpCeFGutn+/YumZkTQpBwOTD6DdFM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XSnUtzoVi0Ayd9f7huJoI9p4/airRkmVWkIJ9ItJ9TadQIe3B1VFUhUV7ccL030mS
	 Uh1KCl/qUE9rW9hNhS9I6bRzu0uh9TcJXxtrGEHodF5aKyIxZYM4f98DjUtmReSDqm
	 s6WJSOdXh3e5El4+xcbI7OjWeIf8ElgBC6f6BZZgfcs58l/NkJRyJA1wWRhqzyS2xD
	 0ouvvHsmpm3FCPY+nREMSrAybPOluv3j5VbvrXGP/Bj5RsgsGFewo/SU9W1+kK3q+V
	 1TgTak1WKRKzSan9lF6nfWEC1LYs0Lm9/BclvCq+h6B6SwNGQ6dscO9InpdK4Vr0l7
	 VgvfdI21v792Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB316380DBF7;
	Tue,  1 Oct 2024 16:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: RFCOMM: FIX possible deadlock in
 rfcomm_sk_state_change
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172779903266.441512.13566037177072323367.git-patchwork-notify@kernel.org>
Date: Tue, 01 Oct 2024 16:10:32 +0000
References: <20240930193044.2907716-1-luiz.dentz@gmail.com>
In-Reply-To: <20240930193044.2907716-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 30 Sep 2024 15:30:44 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> rfcomm_sk_state_change attempts to use sock_lock so it must never be
> called with it locked but rfcomm_sock_ioctl always attempt to lock it
> causing the following trace:
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk_state_change
    https://git.kernel.org/bluetooth/bluetooth-next/c/ffb3f98d4dae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


