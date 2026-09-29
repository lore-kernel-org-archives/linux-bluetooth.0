Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE2C3D88F2;
	Tue, 29 Sep 2026 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696411; cv=none; b=U/qCIOU4ZYx0uyugMikE7/jjFxiOOTN1vdfZFSEnQE3czW2nh/azDg+9LkmCg2AMvYOhMRoqgxhSUHnqxltSztUFhXZhGk2MlJwYlYhtpYHMWFcjBhUWDMAMOeMbcHnLx6YkVay1n4Lb0/tGgy5wtZjHnmLdCwyDFyBqzRyW22M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696411; c=relaxed/simple;
	bh=dksADsFEbTLF3EKReye9ZlfDT5pVRFCKmvhtNZlOH4A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q876xct+hXb8IUmVci0AQZzMowN1NxbUPabZRS3zYjmruaoQLUZyebUMVPUaTWd41j4rs546g+u8W5feI2Bi4LDM13+t4z1U9Ppjev5LVd2e/P1Y1QeGrF9TzPm2ww7mJnIepwkWhB1uca+SB4or/g7sma5x0iGqukj02SLS7wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=na6pclsh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="na6pclsh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED8F1F00898;
	Tue, 29 Sep 2026 15:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790696408;
	bh=vF5j6g9WG6e3eUnrBxsyO3KNBqQKDnjkpKAHzFlZuoM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=na6pclsh7D+grmDiIFBYkM0qmiRpYnAvHubLPxl2on/pLxthbGAPEwf3qrP3ao/D9
	 4FHTO9lqWZn/p3qq85Qn345YmpYoBmFGWadmY2VPo0cvUe5hlpUGEg3WFx3AzMc/7k
	 hM8f6+Ne9e3AroS+Xm/H2FtROWphXFeDeo3ZD1j4adrDmmeoafOX7MNaNWwcVFBeE6
	 EpfJTaXUlsdXUYfqaptDEFk3DXJtFxyt1J87CzdAtmfHlsUo4SHOJPfZwQieEV0GKR
	 PDOVSrlXITyiGWVOZwdmahXf+M4BrfuWrOJlXQyJ78DixENyOGKBvEW8HR/+Cm2BuH
	 DDO0Rrc+s8HoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43883927058;
	Tue, 29 Sep 2026 15:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: MGMT: Fix status of pending commands flushed
 on
 power off
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179069640730.997963.2754170739187086814.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 15:40:07 +0000
References: <20260924171158.804136-1-yaroslav.voytovych@gmail.com>
In-Reply-To: <20260924171158.804136-1-yaroslav.voytovych@gmail.com>
To: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 24 Sep 2026 19:11:58 +0200 you wrote:
> cmd_complete_rsp() receives a struct cmd_lookup and, for a pending
> command that has no cmd_complete callback, falls through to
> cmd_status_rsp(cmd, data). cmd_status_rsp() reads data as a u8 *, so
> the status sent comes from the first byte of match->sk's
> representation, not from match->mgmt_status.
> 
> commit f53e1c9c726d ("Bluetooth: MGMT: Fix possible crash on
> mgmt_index_removed") changed the callers' data from &status to &match
> and updated the cmd_complete branch to match->mgmt_status, but left
> the fall-through passing data unchanged.
> 
> [...]

Here is the summary with links:
  - Bluetooth: MGMT: Fix status of pending commands flushed on power off
    https://git.kernel.org/bluetooth/bluetooth-next/c/86ef0f58bdec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


