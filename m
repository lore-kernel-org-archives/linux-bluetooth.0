Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9745B47D940;
	Fri, 31 Jul 2026 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523850; cv=none; b=sA4VLvjgZEkc0Zh1/zHQSVm7EWsoK3Gb/GiJS/DxeUoOsjXrmkAkEoqWLOQ0JUqjx+do+33uglfnl+HaYdBcIwWrm42Wr/Mf08AiqEhHAxRaNrmy2j6kxCW2wlLFahF7fj5937hACsOkypue47jisizTMgOw8HLH4bhGZLIaIF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523850; c=relaxed/simple;
	bh=aI1BUjEsEpq/s2aHE9+c1VHEq6sIxmtt2+vv1P5QUb8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U8fEN7KZ/nCVFvqYuPBwAebCDx7B5GW82n4HFdLjP/MDcuxybxFlFeFsBvebvX39adecXTLErJcxre9EviQSGA9o0szIBrZgsIei/b8M3y1VlxYajX7gqfjBn8tvO2p1OS9Jg+ZNG576SmqfRZqvTzU91gXKfIZS3uj1ymRqZCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edGGwqMO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edGGwqMO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1191F00AC4;
	Fri, 31 Jul 2026 18:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785523849;
	bh=TyqjiQxjQezQZc3RgmaeR8aKKOJXKPU7Dl9LO67gTyY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=edGGwqMOTz6oSzMANk+iDg+rYobyPA4iEqiUiSiC0bWrwzM/TWFmtvtBSLYOalGT6
	 3YG2oyxf9cRinH6gjvYSpD6BcXUn1AhCt/J08FtSEcqyPvF9M+idPfchjIho4cHDlH
	 SuTQtxq3yc4BHoClFrK7c0/DJ+MFMri1bLeQFi30sCc6JtT0JHQR2/QdXnefNi3FV+
	 XUU7Tctlsq2EBue+z/9F+E7rjdU+7lYwYg2pnrF+1WDurFxjQfo2g98VG1qq5gZHgi
	 slOeI5br8ELhJqEWpUvKEBzoWK901Y5IwkMmvgL0L+M7d0EKVyI7RSTDFniFZELi8K
	 lgqaD2nMMuxgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9389E39263BC;
	Fri, 31 Jul 2026 18:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hcli_ldisc: Remove reduntant braces
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178552381213.861446.17999935623882989992.git-patchwork-notify@kernel.org>
Date: Fri, 31 Jul 2026 18:50:12 +0000
References: <20260730112509.72623-1-developerimalka@gmail.com>
In-Reply-To: <20260730112509.72623-1-developerimalka@gmail.com>
To: oshada imalka <developerimalka@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 30 Jul 2026 16:55:09 +0530 you wrote:
> Removed a redundant braces for a single if statement
> 
> Signed-off-by: Oshada Imalka <developerimalka@gmail.com>
> ---
>  drivers/bluetooth/hci_ldisc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - Bluetooth: hcli_ldisc: Remove reduntant braces
    https://git.kernel.org/bluetooth/bluetooth-next/c/e4ab19c7b7c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


