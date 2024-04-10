Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBE7161B52
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758230; cv=none; b=aOkkQT0K3Vo5M4xorCOL4B7yfuODfQm66Eda+pWl31DbhnBJ6i5J2ny62bqJbHgNz2ipRKN33k2IXwEwtU2OZUItBLTpXbG+/oaydae9wD/O0i6h+NwjPBmorf7xUaVUcSSDR9+vwp4cAH4SZQlQa0C5DWpcpd6Ai1kRnuus2zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758230; c=relaxed/simple;
	bh=pq1alvM5e45wtsSHfRFLwnBCCD5hN9lVCSehPRr7xSo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fCayz5IaL6r4ERYWkOmKi0XWpy+tr7YqmGOWHJ3QpJ6bovHHvhIFLTPBDyczal/31PMAB9N/kfMURHQSTKlpt5Y+jN7OuVb/icx2Ci8c0xCmSCMzo9M7u/k2jfT5rOnk7kvI7v+3UgTncIbabn34dyGgDYqk0NpQgOL352yxge4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuI/BG9j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuI/BG9j"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29EADC43141;
	Wed, 10 Apr 2024 14:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712758230;
	bh=pq1alvM5e45wtsSHfRFLwnBCCD5hN9lVCSehPRr7xSo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JuI/BG9jpNRNr4igFpnMsa3Mn5wf1mJwhAndv2eRazSsvCVf/J6amZDRNI47FL5je
	 ClKuaL6gbmjKP4FNn68HNqwX3CdgmQCpE7D78ZuJUcL3nYF2DetmtpXHM1Cydase9m
	 S+S/lL7+vI7Gvw5nimYdyuQ0p3h+b3Zgq/4KpNrJgOqKT6cJNSvIfLW9tAdHkfnjNH
	 03mAXgcCQdoE6FzeYOC7mnHCDLyanCfwjbsHcn12Prhf4KM4mG+VCySmHpnvcr9VNM
	 B6Pr/JNxLgLW+cJwfKeeYFFD5+lzHlqBIMvxC0pJMJMZT0B+YDqsgnTbXcnVDyFKHm
	 Ogj+3BdSRpDCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F866D6030E;
	Wed, 10 Apr 2024 14:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Use advertised PHYs on
 hci_le_ext_create_conn_sync
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171275823012.12683.4651365373110520049.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 14:10:30 +0000
References: <20240405204037.3451091-1-luiz.dentz@gmail.com>
In-Reply-To: <20240405204037.3451091-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  5 Apr 2024 16:40:33 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The extended advertising reports do report the PHYs so this store then
> in hci_conn so it can be later used in hci_le_ext_create_conn_sync to
> narrow the PHYs to be scanned since the controller will also perform a
> scan having a smaller set of PHYs shall reduce the time it takes to
> find and connect peers.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_sync: Use advertised PHYs on hci_le_ext_create_conn_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/6093f28402aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


