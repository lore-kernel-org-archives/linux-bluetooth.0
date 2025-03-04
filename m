Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB523280A3A
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100401; cv=none; b=t6+WaN53WN059rFwQjU0atr9KryNjQMYAEtGOW11kXBsBdlJlVn3iyiwlTo0z+UtVscXvVChfBMcEuvmqYRckuFGP/u3ILdepz41aLCR45zPLlMQVD3FUo85QXes+KpkeWE5DWWAM4ZYVUw9oykRkmCpElvhj9la72GTBJKChXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100401; c=relaxed/simple;
	bh=SorMa4U+AS/DYX6iwjrpVKlMR2JTB9HDhwVmMT1rMAc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LfWt2RTF0uWL96PynHpOPhypNnWmTe7p1zOBePswi+1+X7LNBxkwgduswvV661rDixpyrafeKMtyYB9eKxzHrPqXXNbV3w9AK1RsscXb8JUvlP2/S7+ahMcBvo3Fq0WOQfIzYJ+SSpU6qjVZo+b8c+jvKbgVzOeH231kQl6PMGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peI8n3Dn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peI8n3Dn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57346C4CEE7;
	Tue,  4 Mar 2025 15:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741100401;
	bh=SorMa4U+AS/DYX6iwjrpVKlMR2JTB9HDhwVmMT1rMAc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=peI8n3Dnp2OwhZFqGQeCUneSzXD7bWYZfg/3XoRtCkEAr8utUn5hgBw4BDkd2XAeQ
	 nMfz1cAua4RGuJ3U4JpasKcShEJsFSZcyqHRSX7R6rmHxt6KqvQASf0PcPvh1agu0j
	 c4WbfwBGEnPAKK9UJB3U230ruTAxFyKZN/sz0HaGcD18yhFwDel4NjN+R2iyncjaBq
	 0xnOf5L2JT9Pe3BssG6DcFiAkCJjERm8YWh0/7Bu4kmJK6uP94al2u4OhBNh/PogDn
	 4wkfjoZEjyAeE9hDUTXthK236dQlWJav3IkMDg04LgNzR8VFs1Yn9TZhZUgrnneoGD
	 QXjRP18q2Kctg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F1A380AA7F;
	Tue,  4 Mar 2025 15:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_event: Fix enabling passive scanning
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174110043423.174904.6432239706228191863.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 15:00:34 +0000
References: <20250228183651.3492826-1-luiz.dentz@gmail.com>
In-Reply-To: <20250228183651.3492826-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 28 Feb 2025 13:36:51 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Passive scanning shall only be enabled when disconnecting LE links,
> otherwise it may start result in triggering scanning when e.g. an ISO
> link disconnects:
> 
> > HCI Event: LE Meta Event (0x3e) plen 29
>       LE Connected Isochronous Stream Established (0x19)
>         Status: Success (0x00)
>         Connection Handle: 257
>         CIG Synchronization Delay: 0 us (0x000000)
>         CIS Synchronization Delay: 0 us (0x000000)
>         Central to Peripheral Latency: 10000 us (0x002710)
>         Peripheral to Central Latency: 10000 us (0x002710)
>         Central to Peripheral PHY: LE 2M (0x02)
>         Peripheral to Central PHY: LE 2M (0x02)
>         Number of Subevents: 1
>         Central to Peripheral Burst Number: 1
>         Peripheral to Central Burst Number: 1
>         Central to Peripheral Flush Timeout: 2
>         Peripheral to Central Flush Timeout: 2
>         Central to Peripheral MTU: 320
>         Peripheral to Central MTU: 160
>         ISO Interval: 10.00 msec (0x0008)
> ...
> > HCI Event: Disconnect Complete (0x05) plen 4
>         Status: Success (0x00)
>         Handle: 257
>         Reason: Remote User Terminated Connection (0x13)
> < HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6
>         Extended scan: Enabled (0x01)
>         Filter duplicates: Enabled (0x01)
>         Duration: 0 msec (0x0000)
>         Period: 0.00 sec (0x0000)
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_event: Fix enabling passive scanning
    https://git.kernel.org/bluetooth/bluetooth-next/c/c7c65369f5a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


