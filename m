Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B95A12BF18
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708032029; cv=none; b=sFMt9T4Fy9qVuvOIiXW25cBxtzVsWECTWCPOYpCxC5ViuCm3Hc4gev4qbD7umdTfe2wU/hKSDt0DWSr828p62TYkNgvlbl2y3i9ImOWg2JtEIXpFEJ0uNtm+al8niFpyvEp3ePAByaKuQ/oj8UPcTDnpc5B5h/c7gixl7cGdVnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708032029; c=relaxed/simple;
	bh=xUCx59ekUF6O1GUr6hPt6JjC5EPU8qWL5wGn4BbHbt8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CWIgVYxMyn7V12Guqb6FRWIqO+1EiMDH/yYqm26u4AsA0suhz1haaC7DEgIdelmc1p1Jqc2J1oSR6GOQ4xOKTI2EcgFIeWhK1AheKd1PGeleUC9pE05dajax1f9CuVYG2pgC2xveq97Wg0Oh2/qquXEGPJO0vT7s8yXRr21Xlxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCe8CCZA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCe8CCZA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71FC7C43390;
	Thu, 15 Feb 2024 21:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708032028;
	bh=xUCx59ekUF6O1GUr6hPt6JjC5EPU8qWL5wGn4BbHbt8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cCe8CCZAsWQKiN+FvLoBtxmaB84Tj52GdHPkvjZ+hBniz07Z4mD2Es6SiMiwqv5U1
	 vwx2jsPmXZoF95pvqNapaEqRL/gal5M3lzchoJJtMXlv31HmsQaGTqEBWiVuy2/vn1
	 Cmw+nMUR/m3P8slER7wlV20zQuzbJ+8pM+o0soThhA1gQSTn2aaR6z/yyM2hoUQa6A
	 iJXr5eEvUGWOydZbSqdlv9E+TrAFddbm/b2DB25jrKeA4X8vYbONwIeGhpAdLmsgl8
	 h6INVOtoDEGHWdX4nMnrORuqA1OHgcE/FRMjVxKUBpboOTGmPUmKDIdmwk7VUjTc5D
	 zFMBsRsjmcXnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54467D8C97D;
	Thu, 15 Feb 2024 21:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/3] Bluetooth: hci_conn: Fix UAF Write in
 __hci_acl_create_connection_sync
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170803202833.1943.9588547245890812286.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 21:20:28 +0000
References: <20240213213123.403654-1-luiz.dentz@gmail.com>
In-Reply-To: <20240213213123.403654-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 13 Feb 2024 16:31:21 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the UAF on __hci_acl_create_connection_sync caused by
> connection abortion, it uses the same logic as to LE_LINK which uses
> hci_cmd_sync_cancel to prevent the callback to run if the connection is
> abort prematurely.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] Bluetooth: hci_conn: Fix UAF Write in __hci_acl_create_connection_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/f36e87456bf6
  - [v2,2/3] Bluetooth: hci_sync: Add helper functions to manipulate cmd_sync queue
    https://git.kernel.org/bluetooth/bluetooth-next/c/4a8a8f446ef2
  - [v2,3/3] Bluetooth: hci_sync: Attempt to dequeue connection attempt
    https://git.kernel.org/bluetooth/bluetooth-next/c/96fb2aab16bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


