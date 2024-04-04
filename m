Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B43E82C63
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712257831; cv=none; b=poF+E4PIBPX0vAxtVMq3vRSFFHpZGQaLwn4YS3EUhjWFoSMCrvTl90N3hRRwVaZunyBi+zdtl8yvhE12PqT9273Jw/XsVPvSWVkChw+MQNCY8P8BcdXCGhiV8PrMLnMdRqV5kajHWfD10o5IO04an99Dnka/1fw7tUJknZwAEPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712257831; c=relaxed/simple;
	bh=wUwmY7Z+mAph4HS8NLPtJR56D8/m42PLHKU3Mmo4bgo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PZPRT8z+0Hfp/1shdtU9faLYOpuiWVkM6erpjxSFiMbl2p6fgr7pPjo3om63CP2cXST57KJIvARO10MHCgXbK7CuQ8shW4Xu/uUHtbcwziwpnpA0w2ne+gn1peeFwj5iAUTNrTbRDtEsJ9MZW9TeZb9AKXpT22wTCf8YujMplwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoVIgOZf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoVIgOZf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 827C6C433C7;
	Thu,  4 Apr 2024 19:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712257830;
	bh=wUwmY7Z+mAph4HS8NLPtJR56D8/m42PLHKU3Mmo4bgo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FoVIgOZfiigwMC5EzztbLcBIbgN58Nyv+rgPiE+t5ocmeR3a+4S8isI07Xht1T0a9
	 X5bqdDtD5XVzcormU4m3E7CMn/63XfxOPkVVVtWd6UUt3HDByefEJw6GhqwOIx8ZD5
	 GEt3P53c1pMgkNVw8AUDa5lsKUKnk47r+rdinlxdrY5n+yvkWg60Gch9d7PUOfIrwp
	 w1I9o0n0qTQ5S733oDmhjUQNKEtsUJPpxUiRM9vXY2AAYLSxNmAT4LTayvgkpBuf2A
	 oDoWpIewnr+yH/6b2KxKrZmqpaYc6mKdBpFyrEBEK8lJH4PkCZMuhNuBbRDr6UxYau
	 E+enLLZbjskBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73126D84BAD;
	Thu,  4 Apr 2024 19:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v7 0/7] tests: add TX timestamping tests
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171225783046.32408.15392696538219375629.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 19:10:30 +0000
References: <cover.1712243675.git.pav@iki.fi>
In-Reply-To: <cover.1712243675.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  4 Apr 2024 19:21:16 +0300 you wrote:
> Add tests for TX timestamping
> 
> v7:
> - Fix CI (false positive) compiler warning in sco-tester.c
> 
> v6:
> - Rebase.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v7,1/7] lib: add BT_SCM_ERROR
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b3bfe2110b7a
  - [BlueZ,v7,2/7] iso-tester: Add tests for TX timestamping
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5e85956e11e7
  - [BlueZ,v7,3/7] l2cap-tester: Add test for TX timestamping
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=349d7975e608
  - [BlueZ,v7,4/7] btdev: set nonzero SCO mtu & max pkt
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7158101e6c35
  - [BlueZ,v7,5/7] sco-tester: add TX timestamping test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9faf6f908fcc
  - [BlueZ,v7,6/7] bthost: handle client L2CAP conn in LE credit based mode
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9b21ce6f7956
  - [BlueZ,v7,7/7] l2cap-tester: add tests for LE Client read/write/tx-timestamping
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4fe4fda73be1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


