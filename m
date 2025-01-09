Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C65E224B1B;
	Thu,  9 Jan 2025 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439404; cv=none; b=WT2cEIjVQTWK0D+csmxZDVMjc/Dojmj6X2PZvZWUflS9EIvC3IwVEXw1ck7FtXFzpQVonjiA4OIrnJLtD0aV6FaWxfWCRH3tMvxfIvRT/cyH9r8XYum+E3KcqMXpEkU7HpR1TLHY0dwDzzl+RjYerVDbFFjYvPHf4MedtGFwqDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439404; c=relaxed/simple;
	bh=4hc2K5oa767CzV0XtDnimnCvFSAM18t5dEIktugozqs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DdNxFwVspnoMx+OUaD9hc0kZaUTS5XCI8qkEx/YJlrxYNrMfqM5s0sX8IH+HquhCHXZYaq+GAXXtLGG6SVQ56967HbrXEGAW9eAvmkUfvNj1MFZOvKtqzK+HaIxOV+d3aRlr6nMWBepbDjs4jr6RaW1r4yEXewU/jY0mCPkBiBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGz4Do37; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGz4Do37"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D492C4CED6;
	Thu,  9 Jan 2025 16:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736439404;
	bh=4hc2K5oa767CzV0XtDnimnCvFSAM18t5dEIktugozqs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZGz4Do37L7YCYQjeK1kszKDs/uMMIzsxtaQqsrZDwKd2QXKFf5CbRfnQ9WrwzMY7e
	 joYfZrk3P9SiAoCKzjvLqhYbbpYxmxpzgOyGSe3wxJ/VbUaoqKQwY/iYQvmt3J4IUs
	 VXgYj3IljDhBOy9J4qhdkgS8z8KEZWoqD5otH56j7X7qH5WJND3mAvUyBC59/g2Ovg
	 lvvO9NCG6dTNmRxbb5B/xrGsjEN3gSgsTjPbbKp8jfgTObNdBTzNT+csaVI2vBfQmT
	 E7B4V1F1steXdJFeSgHekyTx8+kb3nH6Lu7y7IFFyNiVRpEpSIE2AOKkBH0InMZj1f
	 3qlT/lkoo4Npw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFBA380A97D;
	Thu,  9 Jan 2025 16:17:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btrtl: check for NULL in btrtl_setup_realtek()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173643942549.1375203.10645168595674308073.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 16:17:05 +0000
References: <20241231065719.4840-1-max.chou@realtek.com>
In-Reply-To: <20241231065719.4840-1-max.chou@realtek.com>
To: Max Chou <max.chou@realtek.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 hildawu@realtek.com, alex_lu@realsil.com.cn

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 31 Dec 2024 14:57:19 +0800 you wrote:
> From: Max Chou <max.chou@realtek.com>
> 
> If insert an USB dongle which chip is not maintained in ic_id_table, it
> will hit the NULL point accessed. Add a null point check to avoid the
> Kernel Oops.
> 
> Fixes: b39910bb54d9 ("Bluetooth: Populate hci_set_hw_info for Intel and Realtek")
> Reviewed-by: Alex Lu <alex_lu@realsil.com.cn>
> Signed-off-by: Max Chou <max.chou@realtek.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: btrtl: check for NULL in btrtl_setup_realtek()
    https://git.kernel.org/bluetooth/bluetooth-next/c/402e07c75d07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


