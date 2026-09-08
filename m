Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0FA58124F;
	Tue,  8 Sep 2026 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885099; cv=none; b=tXIjkPnzqAxSadrxknDhGpbyAIWNiUs6mIXduYchPmfQSPmrrGwH0SOOtpFSJzPRPKDeOQPYxbNfSHI2Tfcul4tKD7OWcM26n8xJB51iyJGNUCfK8KSazR6rbtMNctB9KK5B2efwKfaI1tfwT3+4/qSqvFMSH4qmfhi+PgakgCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885099; c=relaxed/simple;
	bh=6Sr/O9W86zLY0EDzb07kgqNuG0nuRVClwT2jBQeEtSw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n1HSBmMEfkg++dhAus2FdorAkUpyYEpIOQscY1LeRvRW1p50X5wbq45rC4AaGQBz8E6pSMJE3bGRlFtfmScaJ69CtAFmmWmj9oyswyiV6TiFR290keUh1quCTb7yKmwBJDGuKGc6SXD33a6wrSAvJp/RPaLVSeA4ukq2FaSvOW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rb03MNUe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rb03MNUe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432CD1F00A3A;
	Tue,  8 Sep 2026 16:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788885097;
	bh=nE/0nzLAWFIZPt9SAm7O//ZtyTCW1Y37d7KimKTbkSI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Rb03MNUeEEYT7Uxcz/DMINHyTJ2VT3br/o4jm5QsvZRdUZm9oeirpONgeFgVoiXdv
	 Zwi9w/zXBz3ofrreIN/q+4P2Sub9+nDAxSa2CiM9a0RJ9CzpGX/28cP8jDW6aVLfKb
	 lFA5CmlUYz9eqOvVmEXcRTjyZ/oVsihcSbvn2bON/pNxw+14+CL0pMHWXOgADdQJCZ
	 iWjElMlFXULiD0V104EYpLi9ZwlffhDXNuAhD/hrZbwsWEA1KXTyRdJtefWA6un4N2
	 99gYdO10NhRUWrlM3flFs618mc7wW0SPo4SLhkMqx7S4ZkKBiwOu1uRi23A4+9Sjga
	 2WyRA3/tS9iag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1981339EAF6D;
	Tue,  8 Sep 2026 16:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_h5: Avoid clearing the escape bit for
 ordinary
 bytes
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178888503563.3627954.6813577109173768938.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 16:30:35 +0000
References: 
 <8B4A9BA701BE6DED+20260907150808.13442-1-zhangxuhua@kylinsec.com.cn>
In-Reply-To: 
 <8B4A9BA701BE6DED+20260907150808.13442-1-zhangxuhua@kylinsec.com.cn>
To: Xuhua Zhang <zhangxuhua@kylinsec.com.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  7 Sep 2026 23:08:08 +0800 you wrote:
> h5_unslip_one_byte() calls test_and_clear_bit() for every byte other than
> an initial SLIP escape byte, even when H5_RX_ESC is already clear. This
> performs an unnecessary atomic read-modify-write on the ordinary-byte
> receive path. On x86, it emits a locked btr instruction for each such
> byte.
> 
> Test H5_RX_ESC first and clear it only when consuming an escaped byte.
> Handle an initial SLIP escape byte in the alternative branch. The HCI
> UART receive callbacks are serialized by the TTY layer, and H5_RX_ESC
> is only changed by receive processing and initialization, so there is
> no need to atomically test and clear it in one operation.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_h5: Avoid clearing the escape bit for ordinary bytes
    https://git.kernel.org/bluetooth/bluetooth-next/c/676cc47454c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


