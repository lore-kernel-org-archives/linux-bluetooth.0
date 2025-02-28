Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425C823F36A
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 20:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740775205; cv=none; b=l81hHmDvhO4nRJk0TNi9CjofSRdsoezSZqUqIkV87AF4u6N4CElDN21wxqLfpcmQoZ0H9MivszAZa8MHzoVtR5Qh1sTQrZCmyzjkJZ+XEz4gwgxVYPih8gysy4cN+Be4UQYocgpGDNtdKao5Lyj+nt98/Ebhfp/Lc7wpTi3CsS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740775205; c=relaxed/simple;
	bh=Goz0n9q/43PX+jK82QouYHIjAZ7xOaCZt20LF0A1DHo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A2zJWvihPWAAu+4Q06WEBoMf98sM2Iwe+oj5xwACXtUfhI4khRR0Md39XsA68UMJAkMZ9WCspNx3xOwQ4yln9Zzg2sgPaVMUjeod4w/a1/YFmF3AMmoGtltbxEaBsGqsJzxZuseZ1pzKGe3CwbajxQBQ4qSHpA246LSnwiN7Qro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMaQrxjb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMaQrxjb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFF6C4CED6;
	Fri, 28 Feb 2025 20:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740775204;
	bh=Goz0n9q/43PX+jK82QouYHIjAZ7xOaCZt20LF0A1DHo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mMaQrxjb4Bdl1px0aPL1L4TRAefCbVLjFFIxM2ZJJ/ycOfUDT5JevT7c9SulOHTCi
	 76RBOa4/7WDOcwN6SoeYPUPBavvIWDk1FnK3S36IxUjM/SVAcOHFgFE//IYBQ1F8s8
	 gf02LtQ/2Ppdw/1YMOTdA2T9C9/2slT6HUaKaYWB2X2jrNHBUdupIAvMLWL5H48uAE
	 deQbO1iKN1vyqIhQqrHsunapKH6mj9OFfvFJ9WTEDpfZcobUfJJ4oUIJRS7dmgoMud
	 /DAA7B6ea2FF18vWMINVp8JXUuAVCKfMz3K/jOtk8NHfVATYeN02DD7XzbXisHo6od
	 11agnI97ObbKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B60380CFF1;
	Fri, 28 Feb 2025 20:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] sco-tester: add test for disconnecting SCO
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174077523698.2271257.7126713020529646195.git-patchwork-notify@kernel.org>
Date: Fri, 28 Feb 2025 20:40:36 +0000
References: <b3bf384b8e710156dd2a0f7ee2c21b98da9f4c79.1740684902.git.pav@iki.fi>
In-Reply-To: <b3bf384b8e710156dd2a0f7ee2c21b98da9f4c79.1740684902.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, eadavis@qq.com, luiz.von.dentz@intel.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 27 Feb 2025 21:36:42 +0200 you wrote:
> Add test that checks that shutdown(sk) results to
> HCI_Disconnection_Complete for the SCO handle:
> 
> SCO Disconnect - Success
> ---
> 
> Notes:
>     It seems after the following commit closing SCO connections no longer
>     works, as kernel does not seem to be sending HCI Disconnect after the
>     SCO socket is shutdown & closed:
> 
> [...]

Here is the summary with links:
  - [BlueZ] sco-tester: add test for disconnecting SCO
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=711424319562

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


