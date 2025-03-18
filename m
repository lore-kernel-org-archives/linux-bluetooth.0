Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24992135AD
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 20:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742330564; cv=none; b=IRydVB2M1kmbQ7j0yDjWYz5T2hW6OzryyoG7ro/I+t0cnpWkMrS1wYNihK1CSz6/ZYClnjHhgYk1ABbff9CAauN2BiJy70WQBcNABCTy6aY0SbU5xksnxv2Trml1Hq4eLAdXrLA2JxFxvgrCIcxw4016rIGCfzBZd9Ifj/lktaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742330564; c=relaxed/simple;
	bh=PCKt4tgTbBb62XjUJzfdW2WVTuxd9SvW0N8EMkAgKqQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oekcHROM77LgQ+te+OmP/IfpZ6XARDdnApZxeoICu66EkjypXiGS/XlznoTSst+UksLJiZ99tpSYjyY4eqsvRBHqbYlTGmAANssKnB7wp18VTXJI2zx96lWXOQP36or10oV0tGaUJnGhFG9I/iNO4GYj0/g6g8r98TR8bUEDeIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBN1JLa6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBN1JLa6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF1AC4CEEE;
	Tue, 18 Mar 2025 20:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742330564;
	bh=PCKt4tgTbBb62XjUJzfdW2WVTuxd9SvW0N8EMkAgKqQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lBN1JLa6yUkl0EcH75TFffBY8xXOD/LH+3h2Xld8tkvDUnTbVdLbkUa9dGv/giFJp
	 n4RjQLcZcnd3za9Jxwa4YVqYUA1iLKaUk5BpBCva3j82Azk1ACcOtzArO9Giqu4MMl
	 1UbF23tZk6M/577sSRcEPmNrFX8bteibuHHXAYMeGUDFbJz1pgaQWiiWTmM1t/51Zt
	 D5Gk8HuznX1RAnI1LIeUWja0Xth8UFKbQWAK8WdqVmgEJTfm3uMi5+KyH43Linr7Te
	 tGpYUlA+GCYQb2QhDHzP8mxYsySGql9aQrNTyXOMvxTm+cYnwtRmgjF9ktybUkwe1O
	 qQmbNXF6Lfglw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB02E380DBE8;
	Tue, 18 Mar 2025 20:43:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] HCI: coredump: Log devcd dumps into the monitor
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174233059949.450362.17968825480246594396.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 20:43:19 +0000
References: <20250318161414.780565-1-luiz.dentz@gmail.com>
In-Reply-To: <20250318161414.780565-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 18 Mar 2025 12:14:14 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This logs the devcd dumps with hci_recv_diag so they appear in the
> monitor traces with proper timestamps which can then be used to relate
> the HCI traffic that caused the dump:
> 
> = Vendor Diagnostic (len 174)
>         42 6c 75 65 74 6f 6f 74 68 20 64 65 76 63 6f 72  Bluetooth devcor
>         65 64 75 6d 70 0a 53 74 61 74 65 3a 20 32 0a 00  edump.State: 2..
>         43 6f 6e 74 72 6f 6c 6c 65 72 20 4e 61 6d 65 3a  Controller Name:
>         20 76 68 63 69 5f 63 74 72 6c 0a 46 69 72 6d 77   vhci_ctrl.Firmw
>         61 72 65 20 56 65 72 73 69 6f 6e 3a 20 76 68 63  are Version: vhc
>         69 5f 66 77 0a 44 72 69 76 65 72 3a 20 76 68 63  i_fw.Driver: vhc
>         69 5f 64 72 76 0a 56 65 6e 64 6f 72 3a 20 76 68  i_drv.Vendor: vh
>         63 69 0a 2d 2d 2d 20 53 74 61 72 74 20 64 75 6d  ci.--- Start dum
>         70 20 2d 2d 2d 0a 74 65 73 74 20 64 61 74 61 00  p ---.test data.
>         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>         00 00 00 00 00 00 00 00 00 00 00 00 00 00        ..............
> 
> [...]

Here is the summary with links:
  - [v2] HCI: coredump: Log devcd dumps into the monitor
    https://git.kernel.org/bluetooth/bluetooth-next/c/5fa10370a7c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


