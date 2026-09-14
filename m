Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F99B47FAF0;
	Mon, 14 Sep 2026 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396272; cv=none; b=KlRrhzzlyEa3SXmYwM5cFMgAKCFEkAbYv7exdBXFqIC09nDR35S5+R6d+NViX/wd5tzVyXPmV6ExNNFpuojTjr1n5cA+yPYS4hdBcePiiTcgxHuTJSot8O1hO5SllK5YqCKoq5QYlmQ/I3djcGQMKGSBYGu+LrLlowpNMFcGMmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396272; c=relaxed/simple;
	bh=kyxsl66AC8g55dW435CXg+SoZ9lLfWUu4cPAm63xPjQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hVQob6LegE7K3nqv6po/og3EOM1G3auWSt6o7i9xRu/4d3eIkrWN/azR1p1wBSBeUPw0JC1BDurOdwkQQfJtESyF0Ih4r8tYIts4LWcmnYbRXO/Ma6715zu0/YU3UQHuUyCsCz/qigJx05h009FsDQE8Y+4SAcsuqExjV+LNscs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnLeLUky; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnLeLUky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A804E1F000FF;
	Mon, 14 Sep 2026 14:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396270;
	bh=qP7p6Lw9XBuNpZD4yTpL5ZkISx0ECNRa0OCciHWyqMM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UnLeLUkyvfYtHAvBjvIbwR+jupgLARs6tT5nEzAbpyOWQ98xEpiD3ETaQ3iN37Rco
	 3QxFGGesbMhIRa09yJZ2WU5jB4ePnfEdnlnwOWnR0MCnMLcjpbrS3YDbP44E48jede
	 aw46t5yvJ43NSrhR6/ElGU8NVR1GQxlwsm6iqXN98aPNOf4ayezcN/2yICBx0s+GHk
	 0q25sRxFzkCdlHF9AOt2qFEIuQRgYjhmGuh6nPy2Waggonf4jUtDSUGmQ1sM8wV4xu
	 M+EKaB6s/JtoqUOq0POvZsfSrhA0soe5S4suz2elF3a5eyngdHV6cpIXOha2/eGqCK
	 wwU13wk06eTAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1996B3924A67;
	Mon, 14 Sep 2026 14:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] Bluetooth: btmtk: firmware debug event routing and
 WMT
 FUNC_CTRL status fixes
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178939620588.604238.15437504595416258002.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 14:30:05 +0000
References: <20260914065654.102916-1-chris.lu@mediatek.com>
In-Reply-To: <20260914065654.102916-1-chris.lu@mediatek.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, will-cy.Lee@mediatek.com, ss.wu@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 14 Sep 2026 14:56:51 +0800 you wrote:
> This series bundles three independent MediaTek Bluetooth driver fixes:
> 
> Patch 1 is a resend of a fix submitted on 25 Aug 2026
> ("Bluetooth: btmtk: Route firmware debug event to the diag channel")
> that received no review feedback at the time.
> 
> Patches 2-3 fix how btmtk_usb_hci_wmt_sync() (and its btmtksdio.c /
> btmtkuart.c counterparts) interpret a WMT FUNC_CTRL event that carries
> only the WMT header and no trailing 2-byte status word. Such an event
> is a normal firmware ack for a plain enable/disable request, with the
> result carried in the header's own flag byte, not a failure as the
> current code assumes:
> 
> [...]

Here is the summary with links:
  - [v2,1/3] Bluetooth: btmtk: Route firmware debug event to the diag channel
    (no matching commit)
  - [v2,2/3] Bluetooth: btmtk: fix wrong status for short WMT FUNC_CTRL events
    https://git.kernel.org/bluetooth/bluetooth-next/c/8fcc7afecb81
  - [v2,3/3] Bluetooth: btmtksdio, btmtkuart: validate WMT event length before struct access
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


