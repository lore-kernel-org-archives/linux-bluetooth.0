Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D6B19F46D
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Oct 2024 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727975508; cv=none; b=REhyNIoN6cenGxBQvLZrJYa0HhwnRyKHWc0J9vkYXi5vlh1tnSi8fY2tkSuwfOvgYST6+OUgOHtMeTTwlyrbteZdCzf1RVJBz1RD+EQXCcRzXH1PejZvjMr9YIt4mgYWpMIKEtTpq8wXw5604PYiu0WaZTSiUQYx7h+VfcSlOhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727975508; c=relaxed/simple;
	bh=Etf0RC37HOxQ+SImE37X2Y6i/lTqEKmWgAs0WydsXHc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cp+VGU4gf280SNNnilTUxnOgTlH0JtzLdcvA/UUag52ZKoTjqnmtWCuCqCSBX8XtGtQ53uVo2/MyWCWXHJM26KrL7vj6EKzPhxWy77ML1cOJPJBAVTq2RTjbNXixadzDLzHtSlyDFZxOG0a8WbFTBeXVVzRUVHHr4qsRi242eAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KT50etRp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KT50etRp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A93C4CECC;
	Thu,  3 Oct 2024 17:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727975508;
	bh=Etf0RC37HOxQ+SImE37X2Y6i/lTqEKmWgAs0WydsXHc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KT50etRpdIjyQF/pwZgjixZINurCfXBPXMxuYEXcg+ZRmsQG/oIr6nCIAxbER51zI
	 wd3aEfyKeukPHyGIxY7iGRU6GWMygENF7MhM0cGk0kxxAHu6tLBmIYA7p3qyyt2CSM
	 GTW8FfTGmdxl9fBuxh8LNRdoKAH2AliEMeiXFqEPRDB8nDYa6FgV9fyMRB/gPZmB8a
	 h/L9g0+ygke5TNGIiVQdI7jlsHVrxxYp1NxdY4onDIErynNPYx8We9joshjDkhaJ3p
	 isFksayNQ0eUqmWc4qIKRdiZEJ4Z3b9zQZ3y0LEBjKEoiBfQfpTpaLTUG66fyCHvZq
	 DSDrmrPggePeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2FC3803263;
	Thu,  3 Oct 2024 17:11:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND v3] Bluetooth: btusb: Don't fail external suspend requests
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172797551124.1927250.1837436043810820999.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 17:11:51 +0000
References: <20241001152137.3071690-1-luiz.dentz@gmail.com>
In-Reply-To: <20241001152137.3071690-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  1 Oct 2024 11:21:37 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Commit 4e0a1d8b0675
> ("Bluetooth: btusb: Don't suspend when there are connections")
> introduces a check for connections to prevent auto-suspend but that
> actually ignored the fact the .suspend callback can be called for
> external suspend requests which
> Documentation/driver-api/usb/power-management.rst states the following:
> 
> [...]

Here is the summary with links:
  - [RESEND,v3] Bluetooth: btusb: Don't fail external suspend requests
    https://git.kernel.org/bluetooth/bluetooth-next/c/81b3e33bb054

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


