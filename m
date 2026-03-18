Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C092EA172;
	Wed, 18 Mar 2026 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852014; cv=none; b=reqQWzmXyNzyETErExXBrIvfoQCcso5YziB7GasT74WuvGSa6A8ysbZsTlEogfLZ4ZyRN0MZ3S8yy7BhYmVL5IPb+3QwCddFYpAp2NX315EwU7m0bU88HwZ3+iN07069rcrRAE7r2IrfxUJ1HLlsQ7ZMuoA2XihdyIR8TV+08uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852014; c=relaxed/simple;
	bh=XvqdGZRlZUEiDJj6bhpvQZSPDVF65ZGvUDvlEi3vTNw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=enS3UUl7QPH8c7Yv+jeZuf/abWmFDZHqWU6pncNTl9Jh6VgOpb1Xf8BBExmAR8LVdvriRB6MkAxE52B4upJUcBi5DBBZkKcGWSFVrDCDENUrCMsV9fO5BOSp5YhJG/xrLt9U4GIOiOEe4Sm3RZ6TEgColM08I7eq4XHkh9AFtX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUfZX1H+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUfZX1H+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC32C19421;
	Wed, 18 Mar 2026 16:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773852013;
	bh=XvqdGZRlZUEiDJj6bhpvQZSPDVF65ZGvUDvlEi3vTNw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IUfZX1H+GJunEMN9B7s1JVUwyds6q8oYGNRu3vHjs+GZhGYn92xquK6jngEHOKuux
	 sklkrJwvhxafui5bMcOwwTV+u5KJK+mK1D2+nM/U4iEbBKF1rWyahHo5Lu1LVk5vfV
	 8U/f6PWryrDBtDmQmVDEzsp1KPI/kdkH/lYF7k+jxYNxzl0+I4XMgWwxa6xR5iuilO
	 vTG45t/zAZhz9ruf/j1xP+5u64gFhml7OjND5BVh6rYbi5/pK5h2YsuYVP9klEZ0MZ
	 SnQiloL1aVG5VypCg3S+WkE3LD/edCwyxuVe/lvAs+W3gttPAVYVw+Sb3g5n+4Fdqx
	 /haWpYIGI9i3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF353808200;
	Wed, 18 Mar 2026 16:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_ll: Fix firmware leak on error path
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177385200529.385489.1830323325105295294.git-patchwork-notify@kernel.org>
Date: Wed, 18 Mar 2026 16:40:05 +0000
References: <20260315105138.1693-1-mohd.abd.6602@gmail.com>
In-Reply-To: <20260315105138.1693-1-mohd.abd.6602@gmail.com>
To: Anas Iqbal <mohd.abd.6602@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 luiz.dentz@gmail.com, marcel@holtmann.org, pmenzel@molgen.mpg.de

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 15 Mar 2026 10:51:37 +0000 you wrote:
> Smatch reports:
> 
> drivers/bluetooth/hci_ll.c:587 download_firmware() warn:
> 'fw' from request_firmware() not released on lines: 544.
> 
> In download_firmware(), if request_firmware() succeeds but the returned
> firmware content is invalid (no data or zero size), the function returns
> without releasing the firmware, resulting in a resource leak.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_ll: Fix firmware leak on error path
    https://git.kernel.org/bluetooth/bluetooth-next/c/0f1a322270bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


