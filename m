Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAC3228CA9;
	Thu,  2 Oct 2025 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759439415; cv=none; b=H/ijcoZhVe+i2l31RSyfFhoHbHoD0JqbcMuMJY05zvfDVNE+GRjKvIm1ch9rGvr8DptHuk+wOL7+jp0okk65nAQhGdeDOTFf6CsUaPD8zmn30vUUUhh+axjdjdZlBU1rJaKJJ/D5DBpGcxFy1rAxq+FFM8WBM+ocQop2r8zyLDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759439415; c=relaxed/simple;
	bh=SFJ5JE3lO4uvmXe7zRylg/FoAIqAMCEXwbDs3g5uRTo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UpClmvjJGpAMDMjPxRrHHWRuaDiQ/6xVMLXhCi8POY0Z454vn2lVzIrmFkQun1ehSsQCUcjDcwD2S8ebWk1LmEqdz4qVxjf13O3LfEfBuQhBWrexO2GmfEYG0I93/CT0BssKNG692k64oGdhLdqyhebeXVZdtdOufRew4xo7fWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTXDuZnk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTXDuZnk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B15C4CEF4;
	Thu,  2 Oct 2025 21:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759439415;
	bh=SFJ5JE3lO4uvmXe7zRylg/FoAIqAMCEXwbDs3g5uRTo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YTXDuZnkPm5yo0PYBkxDIc5DQoHWkuOpUbblC+SS/OI73DJ67D/C5EYdzd6xoQada
	 SPxm2X7Glt++47XVTo5c5/8IZK41cCWCjqHAm2ssIRR5hdutljuwKobmhNM01nskst
	 GgajbGv/CbbECJTncY3n7xEWAcOYAUpYFWjArkIBPKaZQnfT9PCUJvXNpxpcCACfEo
	 68jkPnge5xfxfdW1BJ9krvGqj1NzbreZb3oVWQIpNkgA9YsO+jxW3wz3J9/NnVsW3F
	 z9Z4LlTkt7q0X373GfFy4x0Yo9BBuR2EcKp3TAcNtgNZOkw1rEAHWSWdWFg1yYJhMF
	 HWtZxA/7ARVBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DCB39D0C1A;
	Thu,  2 Oct 2025 21:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_h5: implement CRC data integrity
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175943940695.3462061.2489021874310090657.git-patchwork-notify@kernel.org>
Date: Thu, 02 Oct 2025 21:10:06 +0000
References: <20250929230051.87055-1-jgnieto@cs.stanford.edu>
In-Reply-To: <20250929230051.87055-1-jgnieto@cs.stanford.edu>
To: Javier Nieto <jgnieto@cs.stanford.edu>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 29 Sep 2025 15:59:21 -0700 you wrote:
> The UART-based H5 protocol supports CRC data integrity checks for
> reliable packets. The host sets bit 5 in the configuration field of the
> CONFIG link control message to indicate that CRC is supported. The
> controller sets the same bit in the CONFIG RESPONSE message to indicate
> that CRC may be used from then on.
> 
> Tested on a MangoPi MQ-Pro with a Realtek RTL8723DS Bluetooth controller
> using the tip of the bluetooth-next tree.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_h5: implement CRC data integrity
    https://git.kernel.org/bluetooth/bluetooth-next/c/2f7934c7c537

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


