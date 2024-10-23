Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7CC146018
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692623; cv=none; b=gSG1+ezCzIwwGvc1NVjC5gD+3oqMUHwIXKL78qRxTIVXoeW4kAf6hxXHMeTI6TaBmyhWyCeSmUV6rbHGgQrVU1IrOv65F4Zwt/BkQ5KLYelIfYUdXkeWsb+YK6pv0F3FPXIknzz3utBgqYedzAP7EKQbXXJ2I1pV1/Er8zY0ENQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692623; c=relaxed/simple;
	bh=KqgstPb+dPYnhLuOKCPaeJ6PinScXfLUBj08z2FvKGQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jxijWOaPW5IzTTI59+ixSbSCyXMhxhdfxN6Oje6Hm5tQ48fX7bQt+cNZT2VUNih1W+puh+389QVg4utJOxqXsmoG5+H29301IZNrXBBed7p7LIh7vTYXOXmbFs62nJp/NPTW9/LWjx8EI8RAzwtwxW03UspbxJDyHhVW3Qwckzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwKSN6/E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwKSN6/E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB0CC4CECD;
	Wed, 23 Oct 2024 14:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729692622;
	bh=KqgstPb+dPYnhLuOKCPaeJ6PinScXfLUBj08z2FvKGQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DwKSN6/EculWC0160J3A7xIgM2AKKgxhOR+Io4r8e0hKOcP7J7NH4NQ5mYwQM4OY5
	 LY9xP6/bhRdl1wjcYOXg7yBfhhy54gHNfdx4Afdmg3hO6Eo2sksYk4nylYPug3lyPS
	 n2gsyZk5x6jL+LP9VHMtBzr+MISVMRzLkY28v7MvmgWz0Eq0DbyYbWQRw2V+ApwhXh
	 jPsBG9GYMsojQGEntkfr8T/00kk9/yJELX1sVW7HLC3Ca88JscKK22K1DvCUa/b1l3
	 VsrjQewqpw6SKBWeSiLb7Hbesb9HvVfY1H0R7XOcCMnzgyRpJHiSkV8fvONZHRyYKK
	 FieDDVdz+TmIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C373809A8B;
	Wed, 23 Oct 2024 14:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] Bluetooth: SCO: Fix UAF on sco_sock_timeout
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172969262900.1607474.17842690282865996474.git-patchwork-notify@kernel.org>
Date: Wed, 23 Oct 2024 14:10:29 +0000
References: <20241022203421.2126673-1-luiz.dentz@gmail.com>
In-Reply-To: <20241022203421.2126673-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 22 Oct 2024 16:34:20 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> conn->sk maybe have been unlinked/freed while waiting for sco_conn_lock
> so this checks if the conn->sk is still valid by checking if it part of
> sco_sk_list.
> 
> Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
> Tested-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
> Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with delayed_work")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: SCO: Fix UAF on sco_sock_timeout
    https://git.kernel.org/bluetooth/bluetooth-next/c/300b75192c4d
  - [v2,2/2] Bluetooth: ISO: Fix UAF on iso_sock_timeout
    https://git.kernel.org/bluetooth/bluetooth-next/c/fb4560832d4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


