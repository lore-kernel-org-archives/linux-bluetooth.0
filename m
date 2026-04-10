Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF153D170C;
	Fri, 10 Apr 2026 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830832; cv=none; b=uvjfVISZVXACVceSGGqb4GZDxe7XASY+cPfU5OLPIQxjaBLrCs74rExpT5NYOw1B2BqJeSyOq5K8jcdg2Dxuyy56RTImtKJMawyqxcoqqkoaRbQNBvkyIqe05fbPkZz3cY4vfjS9bR1AwM/UqCgFxIsEH87mRO+heK9n6ODMQpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830832; c=relaxed/simple;
	bh=8St/8cS5M/ld08hL1G88Pie4ELV9kREQ2pr2AHnOV6s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GASfs/WDO5OGD5lxn+dOqSaQpIOd5JDUmEnkLB40OCPB3cTTBkWPQrxWqf9ZCbN5boNRCVbhnoGUw9YZpSW3wqiFb1wSFdjQnA8Cy0Vk+qzV08WW+ASpSbjVda4nqYjEU1qtS3boUO6u5j2lppbUXyin21oSK8/WblJMgFPMETo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNCqPfGn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNCqPfGn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1695EC19421;
	Fri, 10 Apr 2026 14:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775830832;
	bh=8St/8cS5M/ld08hL1G88Pie4ELV9kREQ2pr2AHnOV6s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dNCqPfGna3TObZINfmulmC8NkgfvPhwtKqN8WkPctBk5iYHQ+sFmMB4aSwyhhKCox
	 2A7W927Mg7H3XVGaQzJhTf9beSarESQRvzNZm6wZ3ipfjjKoG9yUXKFIx+g4G6oc1J
	 PmVIbVXpcggIDldFErXGsO3Ij0j9KCWj02h9wzgzWagnTkk3KAfQPIJ5UirdqbEfYG
	 GKJPpfA9Mw+iZxH7bDqqLrg7i93wq28QoS9nqcmA9e7LmdAtOx3D89YUuBEXP21ZkE
	 TquIixmcyvptMff6Tv7+kFy+rMZLU43aMZeoosjNiH54Zspx0mbu99FAOdVEhb4c9Z
	 BMpcvR4wXK3iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C0B3809A22;
	Fri, 10 Apr 2026 14:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7] Bluetooth: hci_qca: Fix missing wakeup during SSR
 memdump
 handling
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177583080679.2077665.8641347877052929776.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 14:20:06 +0000
References: <20260410095443.4167332-1-shuai.zhang@oss.qualcomm.com>
In-Reply-To: <20260410095443.4167332-1-shuai.zhang@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: brgl@kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
 quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
 jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
 bartosz.golaszewski@oss.qualcomm.com, pmenzel@molgen.mpg.de

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 10 Apr 2026 17:54:43 +0800 you wrote:
> When a Bluetooth controller encounters a coredump, it triggers the
> Subsystem Restart (SSR) mechanism. The controller first reports the
> coredump data and, once the upload is complete, sends a hw_error
> event. The host relies on this event to proceed with subsequent
> recovery actions.
> 
> If the host has not finished processing the coredump data when the
> hw_error event is received, it waits until either the processing is
> complete or the 8-second timeout expires before handling the event.
> 
> [...]

Here is the summary with links:
  - [v7] Bluetooth: hci_qca: Fix missing wakeup during SSR memdump handling
    https://git.kernel.org/bluetooth/bluetooth-next/c/9f07d5d04826

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


