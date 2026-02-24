Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581D133A038;
	Tue, 24 Feb 2026 20:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771965001; cv=none; b=UxDVUSrqwXUdVd8R2FQDeWk+tbtDvMZw5F3m2exb9zl+qzTdNH/GO7dsKF3EdStJnKHQJafyVDh6Th+G1kdA4oNpc0Un7W9VzTgF/3TVT4qT774UDJ11LXz5zUn3feGOnL/5nZDqhDgdpjpg6097z2ucfN436FtbBp73ri0+U5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771965001; c=relaxed/simple;
	bh=q9YaTTwnRO8MYIxOjfjmG01zxDty4QZ+sKHnApGNIGw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CNKeMR6tLsAZ4f3uZdqTIODQSAKfDxWMs9W38YE4/pSzSsfCUb3FiM/V/qVtxFLhyWLo+0LmFqobiH+V0OxuA7D0cZa4iPOP7q1Nkkzkp80bxbgE7Lc6wHBmQdQWZdmebClsLsQG828wEJPHCcpHg0CufO+5el1XkwVhWPBaWFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NczgGPrR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NczgGPrR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E67BC116D0;
	Tue, 24 Feb 2026 20:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771965001;
	bh=q9YaTTwnRO8MYIxOjfjmG01zxDty4QZ+sKHnApGNIGw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NczgGPrRRh3dLG8ZwJGrhSM6ff87DbRf/cBIfCFs8ENQh5tOdeqPozfWhwh6Mz1A1
	 OtJMy9XC1OXWTsUdX9M0LKLR2oyCuIcoVv84HfIRs9a3VW322zAptLMe4xytwiIltG
	 N05dtpk3CqIb+YluvHUH2XRZDzAICHAfhCTw5ET0W/vA9Qo+ib9ckHoZsTJwyVdG6B
	 Bd7ONPtCURcspIS2FccIgWWOfk029nWupyH3cMq9pP8pBgXtdTI1z+OnEK2mo/Hocd
	 N2MsfYVCabEUWz+ZXk+O3hQMoQmmMf7BX2Be75lxSz7qfunF//wYsB9Qw+gJrMfkTO
	 anqIXonwgCjrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F3C3808200;
	Tue, 24 Feb 2026 20:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btintel_pcie: Use struct_size to improve
 hci_drv_read_info
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177196500654.4139022.1295751765617966981.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 20:30:06 +0000
References: <20260223233341.426067-2-thorsten.blum@linux.dev>
In-Reply-To: <20260223233341.426067-2-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 24 Feb 2026 00:33:42 +0100 you wrote:
> Use struct_size(), which provides additional compile-time checks for
> structures with flexible array members (e.g., __must_be_array()), to
> determine the allocation size for a new 'struct hci_drv_rp_read_info'.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/bluetooth/btintel_pcie.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - Bluetooth: btintel_pcie: Use struct_size to improve hci_drv_read_info
    https://git.kernel.org/bluetooth/bluetooth-next/c/932fa6b5adb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


