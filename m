Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAEB1BDAA4;
	Thu, 31 Oct 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392230; cv=none; b=MILlp2pVfcjIIJP76zy3Q9p9RzgrdfLprm7YPQmQC/hhfv/gaE0Dv/EA4nXvxoA4u7sY371tH8SqaoEyya1WNlqxTlK8tQaNCpVvBPnFGPU47cEjJJDFCMCTl8AVBhRF8+us0+H74nuKA4V/qCjJZfLUsAnA/opCVtSbi4ztOcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392230; c=relaxed/simple;
	bh=gOMl+kSCc6fwm7A3rfT/74ZxcW+dJ5KGJC7N3Vaen+Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jat0q4lWYbwviAh11aP+MK+dAw1YjQcQ2sbWaR0dfbTMhzG0Xvc5t8NmTSZUcQSObjiMuUdaDJOA64UApCFUgDE3tPo046B+z23G4cSXX9UYJAYw0/0Eg4ClEG/S/RcmOhfXPmnUtNN/+ecd5zayJf5RK8XL+RuTXS/qAZf7vSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nf0onxaC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nf0onxaC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518D6C4FE89;
	Thu, 31 Oct 2024 16:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730392230;
	bh=gOMl+kSCc6fwm7A3rfT/74ZxcW+dJ5KGJC7N3Vaen+Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nf0onxaCXsOOJHKSw7LF1bV4YZ0xr4gsK5kpvD3IlefzqA4c1CmH3Mx+U9DoYQjPv
	 wY1DIO/I3OpdlaHNitIDwMYHUxSku9bNmuVniXx6YLnGOVtfqZlmlWamIuGbOEFsBs
	 Jy/IEBj/vYVm7Q//NOkBnO/WLD5o7fNOJNOLFIfcMip9AgzgYCZBwLueTH1cuHxeyk
	 SbEobUOf+0k/XZX33u5x8KcEMr0qI4h0hbd2lJrSyqZ5TeVc3aYrpBGBBV0Bn/qYqK
	 eGUg57eBadyn1PquDM3x/tI4B4ZzgxIUnk1uGFX2zQpBL18Mr5vMSsJkYrVdi3A9DH
	 vYf4dVHHAuqaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7107A380AC0A;
	Thu, 31 Oct 2024 16:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: btrtl: Decrease HCI_OP_RESET timeout from 10 s
 to 2 s
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173039223824.2016510.8618851893499822253.git-patchwork-notify@kernel.org>
Date: Thu, 31 Oct 2024 16:30:38 +0000
References: <20241030084334.2740513-1-hildawu@realtek.com>
In-Reply-To: <20241030084334.2740513-1-hildawu@realtek.com>
To: Hilda Wu <hildawu@realtek.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 max.chou@realtek.com, alex_lu@realsil.com.cn, kidman@realtek.com,
 howardchung@google.com, apusaka@chromium.org, yinghsu@chromium.org,
 johnlai@google.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 30 Oct 2024 16:43:34 +0800 you wrote:
> The original timeout setting for HCI Reset on shutdown is 10 seconds.
> HCI Reset shouldn't take 10 seconds to complete so instead use the
> default timeout for commands.
> 
> Signed-off-by: Hilda Wu <hildawu@realtek.com>
> ---
> V2 -> V3: Update commit message
> V1 -> V2: Modify commit message and summary
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: btrtl: Decrease HCI_OP_RESET timeout from 10 s to 2 s
    https://git.kernel.org/bluetooth/bluetooth-next/c/dff8a64238a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


