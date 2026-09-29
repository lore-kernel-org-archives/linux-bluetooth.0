Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CF853A3B9
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694651; cv=none; b=OJxsz1mOwjkKPacEnodEIufujDyEL4K6kmNrlR9uv16mEW+6DlSy625HnRHT8xF3XihfV28LFQSoR7vn43PSwhTYN6fe3k4EFEgX3CRS9s55J2wvOf+9aVkhz8RthlkgpRaJljuEv91s6cnLmaUqEJHM0eU7qESEKzQLPABk50M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694651; c=relaxed/simple;
	bh=gZneFaAGlPanCY7OIY7aFz4SLicKWco3Q/vskyTEFeY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ONwIZFFTXVrydc14JqJZMMeVOOqtU0aBQZmG/pX311gG8jN9qDurD8Eo1MDOCF2pHU27555VYfVCHdLx2P47sS5fFSrsYTSxb5NOKtS3ya2N2K9gwbpuDlVuPvqckmnPqIEXwPtzcJoXGryL5WOjIy9x/pBqYOfFQN9tUMXMG4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=homDRkLV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="homDRkLV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E280F1F0089C;
	Tue, 29 Sep 2026 15:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790694620;
	bh=kU4w2Tn+DznVOQhDp3KAxBcW4865Bb9yz+AqAmDAdYs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=homDRkLVsjpitlvt+zwz7TcwUnbCp7AYvq8d2xTaMhgvEa2pnEuBn/6JgVwqFZZro
	 +oOPZKkqI/JHCxTXTpSRpxMrrrcz+O6LTL9XGpF61AvR6rkR+EavRCtaP5Gvrd8Bza
	 A40AsgUYex+a8NF0Rf8EjP7xE1zslwAnrVajK32p+1hrJ9bw1uttu3SymseoRMjjHl
	 ky7ScvNFz+gK+fivfCb3HGMH2hubijCV1AA3F4tqvqlcqFD9XpeBGlzwFec4vjK6Lc
	 yK7wHQWImb9/fkRvU4l23KoLFanCHMmLblm4ft1fpg5dJhGFMBk3FliD+Pnz+iFvZY
	 ICUOsqP7PhYiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D7D7E3927049;
	Tue, 29 Sep 2026 15:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 4/4] Bluetooth: btintel_pcie: clear the GP0 cause with
 a
 W1C write
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179069461953.983246.6683069872210269524.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 15:10:19 +0000
References: <20260927152356.2886291-1-ravindra@intel.com>
In-Reply-To: <20260927152356.2886291-1-ravindra@intel.com>
To: Ravindra <ravindra@intel.com>
Cc: linux-bluetooth@vger.kernel.org, lsa.uz@pm.me,
 vladimirkondratyev2@gmail.com, chethan.tumkur.narayan@intel.com,
 kiran.k@intel.com, pmenzel@molgen.mpg.de

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 27 Sep 2026 20:53:56 +0530 you wrote:
> MSIX_HW_INT_CAUSES is a write-one-to-clear register. Using a
> read-modify-write helper writes zero to GP0, leaving the cause uncleared,
> and can acknowledge unrelated pending causes through the read value.
> 
> Write only the GP0 bit directly, matching the interrupt handler's W1C
> acknowledgment convention.
> 
> [...]

Here is the summary with links:
  - [v4,4/4] Bluetooth: btintel_pcie: clear the GP0 cause with a W1C write
    https://git.kernel.org/bluetooth/bluetooth-next/c/6091d2771395

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


