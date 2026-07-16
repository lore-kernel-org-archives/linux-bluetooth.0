Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861C03A7D82
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220047; cv=none; b=PKrAz3xKukwF9JMchDZBR319UdSJCKeXb1kfBLrTn5RFYWUEU4KIx//vxqUT4HtioHgzdvZrp+tgk/HkX7DhE67k2miqUuZkhEAvyUB3qQfyCMAxvv+DFrADlLk1/NSaaSHj4UCnxZotUI1srzfUubu+lTtMjQHHjaOUTyF7S8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220047; c=relaxed/simple;
	bh=vcwh0PAKWsLXB+Z6Cs4ZzBZFZMk/PetqQsq1UESf580=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pibz9lGFa4menyT5GIyid88XjRcRfKQtN2DeRg4WZL+JeENWBOC+rPdoEeQn/+wBzV0GQMF5NdonPuPdxPUyYsMQQDttoJZCqQuPZHQIUWUdKe9wBz6oZEZVWqnsjaz4zCVXm++CVvVq3UiQrjI2670M1QqEWpG6tP8Ui06gA+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8Eiw1kz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8Eiw1kz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839AD1F00A3A;
	Thu, 16 Jul 2026 16:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784220035;
	bh=O4V4efllmRac281HtJJoOR5WqLuAwA4y2XLtpn2flU8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=K8Eiw1kzv98EorgqKBv58zjfqYEsSyEvMzOpDVUgmk3NCr6hoK2XqpXuBiR5Infa4
	 mB6tJD1uvzYGzBDVQ0rDZvyZOQiIH9k7u940gI1pckgwMNV45owdfb0x/Fr5do7SyS
	 mW6dpJpV9Rxc9pvPWWFWnf58yi98MIZbBFCQoY5Y48uP+vNSfl4htQa2Dk+jm/Xofv
	 D1DpEJYYvqDrWPeek/l9QHogtIsBVbMSeyJ7v+Qiu7HDfvdpXNyAerNMXJYTN4XHhl
	 Zel4qajgSv7EPKjJA8j3otwr1MhTS19FxLzaRsj9LRlBb/NXwytOTTmrPy9TgDIafz
	 3yEfD28unnTYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09613809A29;
	Thu, 16 Jul 2026 16:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] client: Add scripts to start cs
 Initiator/reflector
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178422000838.1338131.17986872695919805999.git-patchwork-notify@kernel.org>
Date: Thu, 16 Jul 2026 16:40:08 +0000
References: <20260716064842.4016066-1-naga.akella@oss.qualcomm.com>
In-Reply-To: <20260716064842.4016066-1-naga.akella@oss.qualcomm.com>
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 16 Jul 2026 12:18:42 +0530 you wrote:
> This adds sample bluetoothctl scripts for cs initiator/
> reflector.
> 
> cs-initiator.bt sets up and runs a CS measurement as an Initiator
> cs-reflector.bt sets up the device to respond as a Reflector
> ---
>  client/scripts/cs-initiator.bt | 23 +++++++++++++++++++++++
>  client/scripts/cs-reflector.bt | 22 ++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
>  create mode 100644 client/scripts/cs-initiator.bt
>  create mode 100644 client/scripts/cs-reflector.bt
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] client: Add scripts to start cs Initiator/reflector
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=efd216fe280b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


