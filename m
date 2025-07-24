Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C527C23B628
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753390792; cv=none; b=ljkuYWROsxR28FYB/9ck/5di45dOxslb+C92LZ59eRYjXpp6wQElALQOJUW3VojCKLyPAfyOy8K95LjoNWpJSEbkr+CCg6b5kk9+hJvzQVDTOCv9xtasfLS525ZYg1+jZBOzpqiDd/wxAhMG2a+nwwhITearNQzLjCC72yAXjvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753390792; c=relaxed/simple;
	bh=PJ95pMuPlFmJrijvlmHItFQ7iBDgTJY0CRPskeDeOX8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VF5cXV6+2HjJ0rOUTD18TNKxZ3VCscXV7e434EFbD7t7EfbOgpN+ivW6pYy95oXb32HiON3IezsOd+ak0XsCB5F3jD4t431dumVSurL1BBTLDjGwWObZcJB/DZzFypFHcQSrAGaCVY1COL3eMUCHcYMkfx1WueRYof4/9Aufi1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNl5Otie; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNl5Otie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627A6C4CEED;
	Thu, 24 Jul 2025 20:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753390792;
	bh=PJ95pMuPlFmJrijvlmHItFQ7iBDgTJY0CRPskeDeOX8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TNl5OtieQV+RNifmJXOuY6bdOPjGxVebWleX5NGrrf2LvQe1cPY9v+M2S+9FP803j
	 nwmmCMhLEV+6x3Af4VU6yDSA0wMSSoDEmPBRxAHyVFwXqT8K1cGwrL/RWArEItpZ/O
	 72dIbu6KcoRh+9tR3VlNlBabYQCeBzL+tUuaQvZK70pq85+JoFuonBp2UFpgpc4tgA
	 Rp0N449oDTFkS4vgJWzR3fs5Jtc62jfF35KIzwCwrzzh0HesCYYBcmA9ezZpX4GVwB
	 cPYB+qHj2vZH/MaNYWJcb2b9sD5SxClnBwBsbiTpM3+C3cCiDOTwy0SvFddthTfsS5
	 0QJfSoIFw0bew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D1E383BF4E;
	Thu, 24 Jul 2025 21:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: ISO: Fix getname not returning broadcast
 fields
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175339080999.2527392.10645228008182771222.git-patchwork-notify@kernel.org>
Date: Thu, 24 Jul 2025 21:00:09 +0000
References: <20250724205259.13273-2-luiz.dentz@gmail.com>
In-Reply-To: <20250724205259.13273-2-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 24 Jul 2025 16:52:59 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> getname shall return iso_bc fields for both BIS_LINK and PA_LINK since
> the likes of bluetoothd do use the getpeername to retrieve the SID both
> when enumerating the broadcasters and when synchronizing.
> 
> Fixes: a7bcffc673de ("Bluetooth: Add PA_LINK to distinguish BIG sync and PA sync connections")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: ISO: Fix getname not returning broadcast fields
    https://git.kernel.org/bluetooth/bluetooth-next/c/05f7f9433718

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


