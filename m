Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1EB51EE04
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694636; cv=none; b=AUPNhyYPkClbOAZdwF7M/NU8r+IqjVb4/Moatwz19F6jYsBfvUU3kJiAPjHUq4uyu3fj4mcc9HetQJgWACdE/siy53eDYPUIh7GogR8lIkLKtCB0KbVg3TBriOj5CiGqLSRzsn48/NQ1KdR2ZLOMG9swAvFtHdHlsR94Cup03tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694636; c=relaxed/simple;
	bh=fA4DdDkUZlaczrM2ZJg2SOAvEZHrPwd8hh9xO1V2y5U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O0JnBTrpbWMqAOH5XdHIo6JV8XSHnF+N8Uc9wFSWus0y5caASnszac6YZgBC/ak5CAIOUvyuMICo3jdSSnG2CwriKTXEZLy/gF2s3aCRo9JRwuaQ44a6FExCNQ5Xb/WwY54v2D41FMPvPCTFGIW9jjvt4IAxKGzxblEBR07+Okg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/Jzt3wE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/Jzt3wE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058931F0089D;
	Tue, 29 Sep 2026 15:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790694618;
	bh=zKfOD3lrL+Ir5XSjFiDjFy3oM15WRC1qVkXK+0/vb3U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=A/Jzt3wEg9O273WQiIpgSSWOeFSF+ymRoVfQVlBa33+PQ/HhiCwf+vQs2GtO1P2A8
	 q7dXUKBBabpO3sjjsGPz4xpN/ONZBGdC8lpzHMD/Td3oHijafn88sl/wnm/noToMeM
	 sd8NplAoVE8RoQs+HPjjGfnHZyqY8bM5SkkeHhO1TFFf9dB+ci8xAMWSEkp59kIc0T
	 xV49PC+KMtYK67lnMFEH1xseDx/q7TtEGfaBS/weDFmEt0TvLMaas20CqiZPNQWpQk
	 GVyqyRcU5e/6OT0Dai66kE+/hcKYMMiGCiC97eHRLdO1Wp020mcHgng5IUjSErMRMe
	 EWkyP57ZHdDtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F14E93927049;
	Tue, 29 Sep 2026 15:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/4] Bluetooth: btintel_pcie: fix stale cache in
 set_dxstate fallback check
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179069461652.983246.11812370447115539033.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 15:10:16 +0000
References: <20260926085302.2879093-1-ravindra@intel.com>
In-Reply-To: <20260926085302.2879093-1-ravindra@intel.com>
To: Ravindra <ravindra@intel.com>
Cc: linux-bluetooth@vger.kernel.org, lsa.uz@pm.me,
 vladimirkondratyev2@gmail.com, chethan.tumkur.narayan@intel.com,
 kiran.k@intel.com, pmenzel@molgen.mpg.de

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 26 Sep 2026 14:22:59 +0530 you wrote:
> From: "Vladimir V. Kondratyev" <vladimirkondratyev2@gmail.com>
> 
> btintel_pcie returns -16 (EBUSY) during suspend, causing the entire
> suspend operation to abort on Intel Lunar Lake hardware. The system
> immediately resumes after every suspend attempt:
> 
>   Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 0
>   Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 1
>   Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 2
>   btintel_pcie 0000:00:14.7: PM: pci_pm_suspend(): btintel_pcie_suspend [btintel_pcie] returns -16
>   btintel_pcie 0000:00:14.7: PM: dpm_run_callback(): pci_pm_suspend returns -16
>   btintel_pcie 0000:00:14.7: PM: failed to suspend async: error -16
>   PM: Some devices failed to suspend, or early wake event detected
> 
> [...]

Here is the summary with links:
  - [v4,1/4] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
    https://git.kernel.org/bluetooth/bluetooth-next/c/20dfccf8d854
  - [v4,2/4] Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and S4
    https://git.kernel.org/bluetooth/bluetooth-next/c/79463c0de429
  - [v4,3/4] Bluetooth: btintel_pcie: verify state after alive interrupt
    (no matching commit)
  - [v4,4/4] Bluetooth: btintel_pcie: clear the GP0 cause with a W1C write
    https://git.kernel.org/bluetooth/bluetooth-next/c/6091d2771395

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


