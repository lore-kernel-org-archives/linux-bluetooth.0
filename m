Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF651304AF;
	Mon,  3 Jun 2024 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419630; cv=none; b=D++2bkrDn+T6Ldr1wAOkm4+piay3157TAGgVPyAKPZQaNHuB4ldiyhIXxG6nDfLmESJz/0rYB0cH2saf/JM7DpNLvuyVhGkPzcAIXo+hZXC85ySzJsMfrmBhFSUZpEEYM+BdPaBjan7x7QnqIM2SoZmIs3x9PbfpZa3ZovKjek4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419630; c=relaxed/simple;
	bh=QarKeWy+1n5zhKRlCtLrlWCA8qPpgJq07EAJPx+3Uic=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GRjbDAylX48sf6Z2T7x9H16+Wd4YUsYr1i4sPa+W3gn3iZhiiX16SgOqCgJk9EY/CLcacfezBueNa+rrawyQDMf5sFWZSdUqeCyBHdkg5j1DmnWlKKP/1rrO4iylZfmipyybGEO+h1jLufXXtt80d89SM3xMXwXB8G2Ojkrof70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6kyn7Z7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6kyn7Z7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41D6EC4AF0E;
	Mon,  3 Jun 2024 13:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717419630;
	bh=QarKeWy+1n5zhKRlCtLrlWCA8qPpgJq07EAJPx+3Uic=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G6kyn7Z7ELgGMRIicHJSsKaRt+J8GNIoVJ8q4T6HQ7im2sttJ+VN61Sz17eFHYjee
	 o7jNpWvEB9Xe+wJYeli36tfOJfl0aDgd7kEwAN+R8z29iiWSBcIoqrlzD7rL0CevVD
	 uy2vITFttYRZfxzKr7GSTKsJf9f3IGOnj1MCRxpt9QX4agiXWo9EBSuo31LnkeG9gw
	 iqGm3JArkmnzewg8th3fVF14XiREfDAqBDWHvQH90OqNqIRQJZsEumjmWWQPnu8Ba5
	 2Mn2MNAb4+7YB9goXo9syVTH6gnrBtM0N4THYmK+Jbj8BrIvr+D6cPBsBlfvsVUye1
	 4LE+N0jtKQ/rA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36BD2CF21FD;
	Mon,  3 Jun 2024 13:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btintel_pcie: Remove unnecessary memset(0) calls
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171741963022.17349.8989919081821118644.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jun 2024 13:00:30 +0000
References: <20240531235132.664665-2-thorsten.blum@toblux.com>
In-Reply-To: <20240531235132.664665-2-thorsten.blum@toblux.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  1 Jun 2024 01:51:33 +0200 you wrote:
> Remove memset(0) after dma_alloc_coherent(), which already zeroes out
> the memory, and fix the following two Coccinelle/coccicheck warnings
> reported by zalloc-simple.cocci:
> 
> btintel_pcie.c:837:19-37: WARNING: dma_alloc_coherent used in
> 
> 	/* Allocate full chunk of data buffer for DMA first and do indexing and
> 	 * initialization next, so it can be freed easily
> 	 */
> 	rxq->buf_v_addr   already zeroes out memory, so memset is not needed
> 
> [...]

Here is the summary with links:
  - Bluetooth: btintel_pcie: Remove unnecessary memset(0) calls
    https://git.kernel.org/bluetooth/bluetooth-next/c/c137bc53035c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


