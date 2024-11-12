Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790BD206955
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429623; cv=none; b=kBItFrlQ9p6kv79NLqKJciRaraDpySVneJ+kUoljaiETMpYMt2cUeyQReKoUYX1I2CXgG4AdY6jSkVmHJC1NwXzWdQnWYjqhwcZjC9UoNv3E9BE8nbox3FGBnkMUGznm48MEX5uiiqba5swen06ntrhUNdIDqlvUtlcu7JtFTd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429623; c=relaxed/simple;
	bh=YKJ6fMPxupqmhXis8A16t101z3WR4uKU1CnZqinFlko=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UVwYA2G+TlD6rIGSPTJzjSaJqxkjSV3BTiORwi6+YFW1Az2SMsfdDtpNSelQBSxsS/lK3htjeDMrnAo1Y93m+5pKqJeww6uVastCKgTKnyWzeQO96VAKCEo7nYxnuuljWoOsQevqeVCrdvf8Sz5bba2QccD51c9IuCve1EN/6W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMopw2TS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMopw2TS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F790C4CECD;
	Tue, 12 Nov 2024 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731429623;
	bh=YKJ6fMPxupqmhXis8A16t101z3WR4uKU1CnZqinFlko=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sMopw2TStRvwK+ClrYrTV5kUtdr2V/LzU7+I+mQD7BhGnUcFNZukY1Yetxf4rzcI4
	 kDh/84MhegCXB46OSDJNx10gmhZBcDPgs5/bjelGbr2KOzBa6UCHjWS9VwsrpMx9uZ
	 nmQs1/Yt5+HaRPQYMsQWhTLpjuK7zR5R0osSJpaUzBg59EsVEq7hS5dGep9AyPsB6b
	 taTXoGV0LfDVl5aN+4KQRfpyaJ9MREa54fM/KRX6F86s4lN/RWtuZu4cC3H47FY+bc
	 PtaSBt9bfhNau7p/EzMizDyT4oeFtosN6oTaHLAOU3+Z4IP9QMoeAF0ddptGxjXwIy
	 WAGyWjJVezR/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE053809A80;
	Tue, 12 Nov 2024 16:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_core: Fix calling mgmt_device_connected
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173142963351.591115.167271593962139580.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 16:40:33 +0000
References: <20241111181428.726441-1-luiz.dentz@gmail.com>
In-Reply-To: <20241111181428.726441-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 11 Nov 2024 13:14:28 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Since 61a939c68ee0 ("Bluetooth: Queue incoming ACL data until
> BT_CONNECTED state is reached") there is no long the need to call
> mgmt_device_connected as ACL data will be queued until BT_CONNECTED
> state.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_core: Fix calling mgmt_device_connected
    https://git.kernel.org/bluetooth/bluetooth-next/c/48adce305dc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


