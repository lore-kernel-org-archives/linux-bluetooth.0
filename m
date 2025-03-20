Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5321022A80A;
	Thu, 20 Mar 2025 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497212; cv=none; b=Tp/+OKF7v0X510HS0Njf9LRbNj1mKuS2McE+qq3snOaIhmuCOHuhdy9rmbd4ez8PpyDhoOlfBBFimKSCBPOUBaPdigqwawVSTEx5Qw6pQYbXgs4nMZMR4IzPFidyJbeNYWfuaj15tDoQCvhRB1asLWEeUzInPfKqmigZ7AAGjr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497212; c=relaxed/simple;
	bh=IOFWTt7KD5YrfSJLem5hkPUigKb81yX6foO7A5oQ3V0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QR05ESrAcyfBg6U0YYXabdyntlbO7hSEXZ9A0RLLZt1VtGn/hiYGT9R8l0GDhO+ktAMwK4YDHbPpGwrKCaI/wVlPDXoJ5z/E1tubYam8bWvLvjRAjtHcMuW1Q4EeKt3/MaLcOM+XHu+aDlPKatOZvLgm0yefQFFx0FM+8alxaok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOIgd2Sy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOIgd2Sy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7B9C4CEDD;
	Thu, 20 Mar 2025 19:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742497211;
	bh=IOFWTt7KD5YrfSJLem5hkPUigKb81yX6foO7A5oQ3V0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kOIgd2Syye02MnVtENbMEBtYYRlT3x0AbAQp4NRkTmrElGwWHv6LUxSu1LD+OF5Rr
	 qk9dBQXZGahNv8vnasvj+hzC+79DklLV/kc5EATVdXLtGkr0ahI/jCMLB6YwZciMC1
	 Dazd6yJPcIbQEkkSohSI4Mi2dgZ/ZrHKFqgCkvgSGuBLUMw2WG71HPHSZi2VPa1RGy
	 Xs2AoNG0Wk27yNxtIZEMs5vo/J9tx7arkox4jBa6xrPd0xZXl1r8x/RtjN40JhmwYc
	 D3l3gTfAXqkM1agaJjF0oQUHkwdx0j6OR69R+9QI62zwRWoEywx5jk5UstYaBAKK02
	 eE5ihftsKF/yA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD5D3806654;
	Thu, 20 Mar 2025 19:00:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/3] Bluetooth: btnxpuart: Add correct bootloader error
 codes
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174249724775.1878155.3820562093041068972.git-patchwork-notify@kernel.org>
Date: Thu, 20 Mar 2025 19:00:47 +0000
References: <20250310120231.263174-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20250310120231.263174-1-neeraj.sanjaykale@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 amitkumar.karwar@nxp.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 10 Mar 2025 17:32:29 +0530 you wrote:
> This corrects the bootloader error codes for NXP chipsets.
> Since we have a common handling for all error codes, there is no backward
> compatibility issue.
> Added error handling for CRC error code in V3 bootloader signature.
> 
> Fixes: 27489364299a ("Bluetooth: btnxpuart: Add handling for boot-signature timeout errors")
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> 
> [...]

Here is the summary with links:
  - [v3,1/3] Bluetooth: btnxpuart: Add correct bootloader error codes
    https://git.kernel.org/bluetooth/bluetooth-next/c/21860ba82ebb
  - [v3,2/3] Bluetooth: btnxpuart: Handle bootloader error during cmd5 and cmd7
    https://git.kernel.org/bluetooth/bluetooth-next/c/feef2b538224
  - [v3,3/3] Bluetooth: btnxpuart: Fix kernel panic during FW release
    https://git.kernel.org/bluetooth/bluetooth-next/c/ca127f8b9fce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


