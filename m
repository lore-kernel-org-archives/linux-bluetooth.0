Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809810;
	b=MeDFPhy9FrYIYU1KmOXWqqbypauzSNikEtNxPfNdx22g11SQimJ2UfVTKd2SWKl3Ds8o
	 8Od9qZBY5ZOAju8qTHCKcWdWQ+4vznAlo3115i2ls+JCJ1cqqepCgjO/6cTzvl1MFZV2h
	 JCavW7f3HQ/NEAO2kGJHtTyW+vChZfzzNjPLZsQAk38a99Pz7dttPCUnqmzj3NpcgMmIT
	 FIEqRLQVOpPim09eCJcUH/wN9Eht/QZtChqjzY3+c+sIl5/TsPqjEvVYcEPCSaTooPDyW
	 Cr/LwUjRkg3U2fHrHIKhsD/200hXURJCfzbx8MfEucUqt2jJR9BlxtYastkHdaVHgnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809810;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=CP8UtQLKgN2GLt/dy7xmelGDUBTcwLDEyKCJ2FBKJBc=;
	b=iRVbgvJPVl880C8+4HRN3tvV2+rNUZqHw3NnXOochIE7GLFrPj2pusAY78+z8Z5J31lD
	 qfDCDQjDG+mQMqxSPrdJc0/C/c8I3gwPPve2JHhkQD/8Bu6lb6wzRk/alU8oql4CJzWST
	 a7AKPLmS7OPP9c2yfffsOIXY+RDOGM81acI53Rly3Ha26qQYrTffih7Gl90V8YYg58F28
	 sDMCHaG7c42Tw56mne2g6fiVizSWd6l7SoeID4BfZzxocy/eMEBZ95bcis4xax6gvRZg4
	 ssPR54aj2SY9c0smcqVLGZlO3mBvahoz+8dOXgrhWNbg4OWm9isWZpHcYyWiCp/LCpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A1EoMpmQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E31C606A33B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A1EoMpmQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA2E1F000C1;
	Wed,  4 Nov 2026 16:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809810;
	bh=CP8UtQLKgN2GLt/dy7xmelGDUBTcwLDEyKCJ2FBKJBc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=A1EoMpmQWAWUq23mP5253NuX+k1/UB5qsMXwBheyXR2JQ3Wk0xX6/+IMPR1yDeffG
	 C/6AHaOdLHS2qZ2VwTfRIROk6Ij+ruGBXhAvUJIco914IF/vlNJ1wCO0nOSGnZMwP/
	 /Y+MBQ49ahbMK90ogmtpawGEyLHAHJeL/h4oPOn+2yGdpnOJA7DiVoguOBgtPoZ9AE
	 Mnn0Y4iL4FgHD0uDDQotd9NuJr2MDQKrsUmccDEmrVbDDz9vGmpUDCg9Tfu3Xmw6Ff
	 qGXh+nosIZR1f857ucdzUfRKBfB5rdXoABjeHm8Gs/mu0PmtOuBJvkFvxg4EO5f1er
	 6LyZKcZ7O5LnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0316F39E8A58;
	Wed,  4 Nov 2026 16:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: btintel_pcie: DBGC flush doorbell and dump
 rate-limit
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179380980870.2929236.9750765977869830675.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 16:30:08 +0000
References: <20261104064610.4109582-1-aluvala.sai.teja@intel.com>
In-Reply-To: <20261104064610.4109582-1-aluvala.sai.teja@intel.com>
To: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Cc: linux-bluetooth@vger.kernel.org, kiran.k@intel.com,
 chethan.tumkur.narayan@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  4 Nov 2026 12:16:10 +0530 you wrote:
> DBGC data in SMEM may not be up to date when a dump is collected. Make
> btintel_pcie_coredump() arm USER_TRIGGERED_DUMP and ring the
> IPC_CONTROL.COLLECT_DUMP_REQ doorbell first, so the firmware flushes
> the SMEM contents to DRAM and the dump holds valid data. The resulting
> fwTriggerDump interrupt queues the coredump with
> TRIGGER_REASON_USER_TRIGGER and skips the firmware trigger event, as
> there is none for a host-initiated flush. Firmware-initiated triggers
> emit the diagnostic frame with TRIGGER_REASON_FW_ASSERT, except while a
> doorbell reply is pending, as both raise the same interrupt.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: btintel_pcie: DBGC flush doorbell and dump rate-limit
    https://git.kernel.org/bluetooth/bluetooth-next/c/ed960ec020a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


