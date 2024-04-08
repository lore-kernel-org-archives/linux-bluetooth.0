Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C79146D74
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712613028; cv=none; b=qO6Zm3xDg41Rpzgwxd2QFY9IZIDNVEKFXOzmo1jw/glmXFPQ5VL/3Wo52k62H/ubd48VBqBKb/BFyEVD+RjjtIpFJ+YIC8RoYrokPrjVkHaJxlAt/iTuzcJVnWg8GGxIFAYoAQL5l3lwAm9qab71BYmZJ4Tt4G/hf32UoTu5DEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712613028; c=relaxed/simple;
	bh=cTxFFEQxuuuh+MV3EAtQgTVtdNqYnh0Hbqx03IUk2vs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kkoXo2/8rbq3dhyfcrLeW6USUSKqrVT46j1Uju4tMReZnWXh8kMEJ4nZ4EWxGai7CvohDxZQHWJQZ1rqZc5L0hTe33MjtmDRtv9OseE+0buufnbCyc+U5HEuq6Tgo9myaVMfA9YGtRdofdnL50CKJjaZh+6SGV7IQCKlUuWhJqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHouSynV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHouSynV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C34F8C43390;
	Mon,  8 Apr 2024 21:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712613027;
	bh=cTxFFEQxuuuh+MV3EAtQgTVtdNqYnh0Hbqx03IUk2vs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MHouSynVAZjnYvKHCER3wL4mY4qnNwdR5IexJ83yC50drjVT07C5i4a2NcFxk2w87
	 kvp468KuEPLM+mPm+l+x3LTrB2LGbrCblyafQjrqs7VzjGmhB4Rauk+EsKs4zS5PNm
	 bS91rap+5eGx898ygZMZiBkT3T5o6BdTD4X1UvSRZwMVy9Li/wUpFqYwE6GczsSCgR
	 lJTOL11JS8uTyzR7pmLEDrvpOcnxv4noQ6HHN/o3xl6UQG+/rZl/RmS7oJ243OIkbo
	 lS3nyNcrMlhYoZyQTC0dnUt5Q1KL3i9DjUoM9jw9dTtJBIUPipNwckddP1IWccdCc2
	 ckgmi6mqmXS3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6897C54BD3;
	Mon,  8 Apr 2024 21:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/5] Bluetooth: SCO: Fix not validating setsockopt user
 input
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171261302774.18719.10072615300794191048.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 21:50:27 +0000
References: <20240405204827.3458726-1-luiz.dentz@gmail.com>
In-Reply-To: <20240405204827.3458726-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  5 Apr 2024 16:48:23 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> syzbot reported sco_sock_setsockopt() is copying data without
> checking user input length.
> 
> BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset
> include/linux/sockptr.h:49 [inline]
> BUG: KASAN: slab-out-of-bounds in copy_from_sockptr
> include/linux/sockptr.h:55 [inline]
> BUG: KASAN: slab-out-of-bounds in sco_sock_setsockopt+0xc0b/0xf90
> net/bluetooth/sco.c:893
> Read of size 4 at addr ffff88805f7b15a3 by task syz-executor.5/12578
> 
> [...]

Here is the summary with links:
  - [v2,1/5] Bluetooth: SCO: Fix not validating setsockopt user input
    https://git.kernel.org/bluetooth/bluetooth-next/c/82f018d9ae0e
  - [v2,2/5] Bluetooth: RFCOMM: Fix not validating setsockopt user input
    https://git.kernel.org/bluetooth/bluetooth-next/c/05dcb647b289
  - [v2,3/5] Bluetooth: L2CAP: Fix not validating setsockopt user input
    https://git.kernel.org/bluetooth/bluetooth-next/c/d10a75a2b47c
  - [v2,4/5] Bluetooth: ISO: Fix not validating setsockopt user input
    https://git.kernel.org/bluetooth/bluetooth-next/c/723cf24d84c1
  - [v2,5/5] Bluetooth: hci_sock: Fix not validating setsockopt user input
    https://git.kernel.org/bluetooth/bluetooth-next/c/f3ab06000608

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


