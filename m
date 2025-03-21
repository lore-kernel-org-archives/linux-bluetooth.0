Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFB922A4EA
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Mar 2025 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573398; cv=none; b=TV3gB4C0HoQixqHHo87wIivw3wCejfcDE816Sr/FN5zQhkcmgqgxHaHoeG9LpYlnae/zSagQThBDY4FaQNPPYjD7QTPob4/MUNc0Xr3An+JteQSpdn2RPTdrxvEyexu8HLW7xq6EbNLaeImNG7veK3zT4NB4lbl2nEEBRhsaoHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573398; c=relaxed/simple;
	bh=Hdz14+d62Kp63Odimn7LcWvJqmrjE9MgQErgo2jiguY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a2b3BaW1BmiASixnVymqoyChfgtWynTytHoCB4Y+v0RSd0VIsJqRhBtT8QQUkV+VE0qD8S/rDr7B/AzitNxDcV79Ji+7gLQ1B+wVwu2aOr884WA9QBFMX+VSghE68sBLOsiXRQW8DYOr6X5J3e7h4MHOn6gTfq08WwoHfiQMt08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=havSKwNl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="havSKwNl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C109C4CEE3;
	Fri, 21 Mar 2025 16:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742573397;
	bh=Hdz14+d62Kp63Odimn7LcWvJqmrjE9MgQErgo2jiguY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=havSKwNlS9one8vb4kBokr0BaG2/lvomO1ZyPfuM3sXeBdsmjlbN0Urki1frSSuzT
	 etGsRBPsvb5YchxCbPnGu63yeMNoZKttjFs+b3aG0iH+QV5kUredDYyrKS84CvD6u7
	 32wsxMo/THEgBUN1bpK5tgGcF29eLURI/E1N3iot2Rm9Efr1boJOgN7Prz5oCIyPgT
	 10ZgBISYbfi2DpBcVYLptsNvze2kW3XZQjcLVQEEh7A2V/e0QI/yL4K23CY553uGov
	 fsSYi6ny8Ytku8aTYGgMeX+8TsUSLLwRxCOZTKMegcvrODMkMhwEK8ChSDORk+pP4z
	 jZBDC1Xm8VeqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC6A3806659;
	Fri, 21 Mar 2025 16:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_event: Fix handling of
 HCI_EV_LE_DIRECT_ADV_REPORT
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174257343355.2533217.2479088988572782632.git-patchwork-notify@kernel.org>
Date: Fri, 21 Mar 2025 16:10:33 +0000
References: <20250320153415.1391223-1-luiz.dentz@gmail.com>
In-Reply-To: <20250320153415.1391223-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 20 Mar 2025 11:34:14 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Some controllers seems to generate HCI_EV_LE_DIRECT_ADV_REPORT even when
> scan_filter is not set to 0x02 or 0x03, which indicates that local
> privacy is enabled, causing them to be ignored thus breaking
> auto-connect logic:
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_event: Fix handling of HCI_EV_LE_DIRECT_ADV_REPORT
    https://git.kernel.org/bluetooth/bluetooth-next/c/a37df2815c1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


