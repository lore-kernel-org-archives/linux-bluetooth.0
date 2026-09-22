Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE6437646C;
	Tue, 22 Sep 2026 01:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040675; cv=none; b=IQuNncR5xIJvSqpHOPUYZSpyYP6f6c5Z4I+i0zDUKygs6jzJksSr+rsxjfxYS+nuerRw5KfW3/y8hDlCRzwV7J2b9BgvQ4g8tPMxYJlFEwss5bB02L9xzhr/5i5wQfgXPZDhBkzfAaBtcaeM5u3fF/FoT4GPTqjXfMq/v82+CJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040675; c=relaxed/simple;
	bh=ZxYfevV3KlHTGhGR34t0RPlzAjUiGWYIyKhqOwmpsiU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jvvU7TLvmAR8zVvqNRllrqx4+geRcYsqSFilKlKlMiGiIqnlzrA9ZWcaZs5Z/JEETAlPM2zlEopJcy9HcYcwzYz1PXFGe1YEO8oI8Dmz98xt2GqKNU8p7/5ds/92m5IJ/3BTfhtEpqmQZ8xE2tJf9ZdVCrggm5Cz2U1sduaWFtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBdknE7L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBdknE7L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF441F000FF;
	Tue, 22 Sep 2026 01:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790040673;
	bh=+VtQdW5QMCaUznLPdT+iLv0lhdMNYvON+bM1ce0YVtA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lBdknE7LGSsh0wKhcE3sNu18scdpi7qOiq0VvCjMMK1FnoBpCA4238SHdw8yC8Nr4
	 so3Zryi77UWhY3uwRTrsPTCdVf9w9v2m/zz8FLVA8JMbjUeqQQ+3RjKszt09/Ssz+y
	 Zf8y8eUZqN28vO/fKv0QA6pKLb/nRQJzIL1l9+8cz5B3zwaas3ZmsBprbwMQ+36srn
	 IUhE0tqRNgM4OLHPzUizJu+DPeLJQhpwnegQYuq574wfgJezdArY3GjNkjBCfevVfE
	 o5DFIPTR0EgRJwXuxrFx7drWTcrBncLIVyjWOsGL5hVJIhhkJHQPKVHuLGGg4uNF6/
	 Op6qTihQrkuDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568503930205;
	Tue, 22 Sep 2026 01:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-09-21
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179004060515.3325380.16089330936557887823.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 01:30:05 +0000
References: <20260921135807.3459373-1-luiz.dentz@gmail.com>
In-Reply-To: <20260921135807.3459373-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Sep 2026 09:58:07 -0400 you wrote:
> The following changes since commit 801fb950cae7048eb7d83b18857d1ca37b8cd5a4:
> 
>   Bluetooth: RFCOMM: avoid socket lock inversion in listener cleanup (2026-09-15 14:55:41 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-09-21
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-09-21
    https://git.kernel.org/netdev/net/c/f0b88fade64c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


