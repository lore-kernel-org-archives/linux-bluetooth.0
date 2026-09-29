Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7711541E4D
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695226; cv=none; b=ew6WVZY4hIZgn8Yn3V58K1AMQuQxDO1qEb610+U3hww/mPWqmS6P8bR7X2st4MUQfpVXtGMM7J8DkNn3u4r7mcH8OktfCR+puNitZe6oMtMWXWB+3ytBKWEg56gSkpalFiWpbl6GWrFWVjRCbEcszR2l0FViRc6PG+QkY0g5xFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695226; c=relaxed/simple;
	bh=iVFje0Al/DoXAc9zwy0Ofuv/vQ5mpfe9Lx419VU4Si8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oJGk9g1cQ9Vg8u1NTSpCvaDhouHLQV/DSIZhxVosuFutW71gI8CS1xOwpLT7Kp5ovmideF+nAdIVo43TEpzeUM93y3adnp/O0kngVGI9NyFwB/Ag06wXjBoci1/F5KuUN7kVUO9fZ/SSczW4YWmaxfOoUE5qPrqL6P9fcyb5Stw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MU819naW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MU819naW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B5E1F000FF;
	Tue, 29 Sep 2026 15:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790695214;
	bh=BJjdy8gtGF0/EGcoTRNmR3oTlx5PBXh6jK9Y4sG91rk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MU819naW+wbY3tF9BSfW5E2k7HpmirGTdBQCpUIKl4VPxv5B6F40di2JEN+iPhDnm
	 4sgUbIIAp7edgG9idAiDdh/c/zSMmn6/P3yBlHBaduSIgLNizYWakULc/ZsL+gwBAV
	 egUxAlaW0iSCmRm4tOzjxl1FdPrQqj/hLZzwabvduNnocJMuhsabMEgAfqIme98Z41
	 Vd8zi0SEiR3G33rkyyL/igTMqPHUOGM2DyIQqSBZewlrAE2q5LyA24CuniuSiKqKQG
	 Qa/o38fh6MlT6louXLkpNCgg5NYvvHPxjQRZ7mzmiI2OcyQLUGXQOd/UzNKSL4KMzW
	 9Qmy0QWSr9Lbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2BC392704A;
	Tue, 29 Sep 2026 15:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btusb: Preserve event and ACL packet
 ordering
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179069521277.987606.7177534620534882712.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 15:20:12 +0000
References: <20260929064556.1461915-1-kiran.k@intel.com>
In-Reply-To: <20260929064556.1461915-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com,
 chandrashekar.devegowda@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 29 Sep 2026 12:15:56 +0530 you wrote:
> When force_poll_sync is enabled, commit 800fe5ec302e ("Bluetooth:
> btusb: Add support for queuing during polling interval") defers ACL
> delivery to the RX worker. The event path currently wakes that worker
> before delivering the event, so queued ACL data can reach HCI first.
> 
> Deliver the event before waking the worker. This preserves the intended
> event-first ordering and the event callback's return value.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btusb: Preserve event and ACL packet ordering
    https://git.kernel.org/bluetooth/bluetooth-next/c/08c3c483047d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


