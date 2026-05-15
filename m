Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F933FF1A0;
	Fri, 15 May 2026 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860194; cv=none; b=R6LVdq1BhvXX2xeDGpFPznf12AXSbU67czZrhiTpx4nrl3Uh/RQPduhYUJr2W921nr2cv9wmiP5LMT22SKTK2W88yjuKtlf0Wi0mffmPBsFfRNscFUF8w0VnCB/4LQAxUeFpsPPU/S975L27eTsOji+pFuXV+kS8t88kv+scORk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860194; c=relaxed/simple;
	bh=lKOcLB9ZiUoihEdR0AeOWAwJvGkZtG6pKxi+SpQ2e/A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p9R409y3oZrMbw9CFNRu0wfhDY5RpxiQhyhIUiOXNRHVfyMEgY0bw9v+kIbxnj+M5dKxp7XtjSWnLHHHs5cqeeKfdYjMSPja6VWUZ/S/D5F6b1NX5T+ExVy0UETsUvZkhO74+VnNXMufOJ6qJkLP6fj2LrS3ygkMclm6nkyi0rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1EaKUCl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1EaKUCl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8704C2BCB0;
	Fri, 15 May 2026 15:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778860193;
	bh=lKOcLB9ZiUoihEdR0AeOWAwJvGkZtG6pKxi+SpQ2e/A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C1EaKUCl7B1ezVP2OF/UYSjBqgsTC5V9QrpiC10/tcU6YF4sPZZulNtaMzpAWCO1w
	 P+IPYJfljSELPuJQJ/vPHYymbXDljJjTgr9Wq+iEl5MlNfq2dICxS3CIwxbyZMuRrd
	 jEacUT5EGa28BDVwyGJLjEst77Smx/UO1DO66nVD+9UobNKsB51p2mq/qP0eF0x8MF
	 1rrC+dsD3YpmdC3reRObbJpdsCNh7JTJDxcpV3aNXBA+eDbuOIvtupVJ++ODX7iaWY
	 XivJPTaQVCSkRCG3yXVxCYR3W8JIAfXUru1DawiVIdu1vpOM5WFeQpcxk9Dz1SSFzL
	 QBSnTWd/IpdVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938EB3930998;
	Fri, 15 May 2026 15:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: bnep: Fix UAF read of dev->name
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177886020713.52984.6738499435725891558.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 15:50:07 +0000
References: <20260512-bnep-add-uaf-v1-1-f62ff8f61d50@google.com>
In-Reply-To: <20260512-bnep-add-uaf-v1-1-f62ff8f61d50@google.com>
To: Jann Horn <jannh@google.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 12 May 2026 22:15:39 +0200 you wrote:
> bnep_add_connection() needs to keep holding the bnep_session_sem while
> reading dev->name (just like bnep_get_connlist() does); otherwise the
> bnep_session() thread can concurrently free the net_device, which can for
> example be triggered by a concurrent bnep_del_connection().
> 
> (This UAF is fairly uninteresting from a security perspective;
> calling bnep_add_connection() requires passing a capable(CAP_NET_ADMIN)
> check. It also requires completely tearing down a netdev during a fairly
> tight race window.)
> 
> [...]

Here is the summary with links:
  - Bluetooth: bnep: Fix UAF read of dev->name
    https://git.kernel.org/bluetooth/bluetooth-next/c/ffeee619a13b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


