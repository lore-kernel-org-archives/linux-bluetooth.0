Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3951947D927;
	Fri, 31 Jul 2026 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523848; cv=none; b=EC49uabvuQSdxhzr85dH5v4mYAhRdjOQOz5ASg0wEO7x9Ce0FuAJEdkXAGEBP/d0YnlNSAojp3D1JOUJcZUza5lxzdSC4P/QTu5WH2QpDJHmzDOijXFySd4qJzZTRHFYCsmU1mc6Toes7EdNgjlM3DPEsIr3wbD9G7/yrXeZHPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523848; c=relaxed/simple;
	bh=DreMTcjKLrZz9u0+U6+2k7qSwAYWKCaQ85dvvgd+498=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qsQKjRnFPsNgkgIanDIbZqhKPCsUQsz+aE/aWvRIJqqSCWVKNX3rVF/HCKWsOebEM+anrMGvz0lQY9/hhtz/jVM6Fg90iqMKlrEzT439x8EFvtL2K33ElLXx7kD3v7MdQpUBdemMw1N+gO3GDX8cXAv7kkTKZwLDRHk6N3kzSWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYORJfnX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYORJfnX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7091F01558;
	Fri, 31 Jul 2026 18:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785523846;
	bh=MtqYP5+3frRiRyBw+RTmMLcocns2BKBz8XEOzB7Rmxc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YYORJfnXV6MF3qASab0YmLWAVH1WTHTjKmoyVy725K3xHIl9EofHaxxNv8TNnpmyC
	 sga6BFhnMIcyFNqOnDtfSNAJhIT8Txi3+yl2ISLqa+PQlso4iJXKkqxls895qo89hk
	 9SCMOOfEbz9wDXzkVmtY+Mjfejnlh93O6YQ31y6jMNtqPAz5pY5oNW3ITTKiT6H2Yg
	 Ut4qZjz4zV+rdYHtTYFUUsxcYHwiuIFUbHQPC77aUnsghcnFfjHgwi7VCFwTWsKlOy
	 MYg3ED82CCxSt6GT8dJ9QALA0e8ZcL5gW5EdibyGhskWVPs6yLYZLyUBCVgYuF7h6z
	 XWOkpnr+ngLlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9393139263BC;
	Fri, 31 Jul 2026 18:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: virtio_bt: avoid OOB read of build info
 string
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178552380913.861446.3061212012664784295.git-patchwork-notify@kernel.org>
Date: Fri, 31 Jul 2026 18:50:09 +0000
References: <20260730015728.2798952-1-sammiee5311@gmail.com>
In-Reply-To: <20260730015728.2798952-1-sammiee5311@gmail.com>
To: HyeongJun An <sammiee5311@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 30 Jul 2026 10:57:28 +0900 you wrote:
> The virtbt_setup_zephyr() sends the Zephyr vendor command 0xfc08 (Read
> Build Information) and hands the response to bt_dev_info() and
> hci_set_fw_info() as a "%s" string starting at skb->data + 1, without
> checking the length. A backend that answers with status only leaves that
> pointer past the end of the received data, so the walk reads adjacent
> slab memory until it meets a NUL. Those bytes reach the kernel log and
> the firmware-info debugfs file.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: virtio_bt: avoid OOB read of build info string
    https://git.kernel.org/bluetooth/bluetooth-next/c/d264c90ca22e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


