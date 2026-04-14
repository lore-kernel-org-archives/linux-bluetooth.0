Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCD731ED93
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776184320; cv=none; b=diQx1fusN7JrPcak7YuwJ8TVdOCBkXD2pi+Pr0BXnAuQjSTallpCqWb6QlCcBmm+SeIRN8ceKWUgfWHr37AiajryCXO8INyXcQHGSexy57AhjxU9xJm1YadtXsvxexiTalPO/ayT6kBMCWXNv4jSU0DduxrR9i4vh0+6T7WIPbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776184320; c=relaxed/simple;
	bh=NYEQKYKEO94+ppJ5k4D+CDFj6m63xnfDdZC4sM5EDx4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Er9qd/WWnD/yD7lEy3uyFn8QkQgU14SV59hdkwPase3mON5wtVOuxWGhw9r9H0eXZgYGezU857phrNOKZeLtnMf75aLYlLXVBpFyUEOCGtM9bPoTO6pCiAeVSPtRNjtDSgJxwDeQU7d877bFzgdki3ziQ7tJN9JuiRMVZJ3ZgJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQ1LOSmz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQ1LOSmz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58610C19425;
	Tue, 14 Apr 2026 16:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776184320;
	bh=NYEQKYKEO94+ppJ5k4D+CDFj6m63xnfDdZC4sM5EDx4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kQ1LOSmzDVetCMjTOl7mymwkF2JLHTrwYy3M82CtS3FTtS2J/L4EQCgBNtAa563a5
	 gNn3xQ6MijprGj11JgAdrdmFNpzwOq6w/9Tmrik0z8e92kwgJkolY+v8wLGj0fW39R
	 hWnuCUSVP9nFY5WDdHzaVLn1FVGQLkL1rHYSSufbV1hh829gXGo859AcwOYhi0jbDo
	 ntQzKkAPjl19uoBPbLTKTLq2K1+qlnZqURdEI8sWyuIx2LT9iUy7MqvGVeG7pbux1V
	 h0T5UTr7ObiQMEIqfNHNl1jjhqLPxv1xMcpq8vSi0W9qX7Ga462pw7gZtIDDnd85+n
	 Pg765nuqQJRDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F4D3809A07;
	Tue, 14 Apr 2026 16:31:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] Bluetooth: hci_event: Fix OOB read and infinite loop
 in
 hci_le_create_big_complete_evt
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177618429045.1367635.11222923610101186397.git-patchwork-notify@kernel.org>
Date: Tue, 14 Apr 2026 16:31:30 +0000
References: <20260414144641.1168084-1-luiz.dentz@gmail.com>
In-Reply-To: <20260414144641.1168084-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 14 Apr 2026 10:46:41 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> hci_le_create_big_complete_evt() iterates over BT_BOUND connections for
> a BIG handle using a while loop, accessing ev->bis_handle[i++] on each
> iteration.  However, there is no check that i stays within ev->num_bis
> before the array access.
> 
> [...]

Here is the summary with links:
  - [v5] Bluetooth: hci_event: Fix OOB read and infinite loop in hci_le_create_big_complete_evt
    https://git.kernel.org/bluetooth/bluetooth-next/c/862fd776a9f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


