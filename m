Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D171EE019
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2025 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738254604; cv=none; b=jXanznpFAxcFlkYhkUZYb7/xT9uxp6vJj3qEWym9Pc9loZEt3F34AMaiV+Fc52Vqaxb/w6JpMZdl/ofzGvp1FF2Qq1Ud+tofV07PvPhIC/O/dm09zYUNCg4yJ/nfHc2yzt42/hv/Uhr4okQWdxXYixL4avDPdZJo1QjUqqapGP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738254604; c=relaxed/simple;
	bh=/EihxNbBLojT+gGjShCsh+crXXAng2Kghy89ugQ8JR8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fJ3QWJ4V1Guf3DZj/VU95+3K1E6y2GZV0JWrIRkohG9f6hrpKp6Tx2Tn+PMa9OyjtBebh+08xm49VzGFzdTr9Dd1Yb4MkfGb8UOo8j+0E0LpF5J68bBcJ2BiE6LhM3BNVuWkvmaLM5YPXeW/kxP0wGmVq02HN1Nmet27DpZEG3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2QQHIgv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2QQHIgv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013D9C4CED2;
	Thu, 30 Jan 2025 16:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738254604;
	bh=/EihxNbBLojT+gGjShCsh+crXXAng2Kghy89ugQ8JR8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E2QQHIgvL9qJGELcyPq64aM67h/yWj6oBat2BtCCzQats6L6tm140i7jC3F5OuB5o
	 mxjxt7DnXplj2fpzPbM9QWy1KKqlpcN63/BtktNNf19bQBNUvXCXf7P34TxMsRU2GS
	 3DJi51eFFy1L7UQ+2QzfrMajPNJ4rmkyjpCLmlaMvE+tlP1qeASZFZJr+fQnIQdBUu
	 KC5MA9jWUKuWuZsS7g11UHMdZsUvvlLuMkbskovaNeXXI/aQv851/mQMswfI6gNMK7
	 hlA/vzRZjBI+dQm1y+mGgp+x9vsqCpsuUbny3snknzSGxIKWvs3cTC/7Z5+3o3RPPo
	 +ShIL4IiH7OoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711A9380AA66;
	Thu, 30 Jan 2025 16:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] org.bluez.GattCharacteristic: Add confirmation
 support to AcquireNotify
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173825463025.1008974.7147923235030185933.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jan 2025 16:30:30 +0000
References: <20250128165424.1044479-1-luiz.dentz@gmail.com>
In-Reply-To: <20250128165424.1044479-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 28 Jan 2025 11:54:22 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds confirmation support for AcquireNotify when indication
> procedure is used, also document the behavior of clients vs servers.
> ---
>  doc/org.bluez.GattCharacteristic.rst | 5 +++++
>  1 file changed, 5 insertions(+)

Here is the summary with links:
  - [BlueZ,v1,1/2] org.bluez.GattCharacteristic: Add confirmation support to AcquireNotify
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1f7a7c9dcadb
  - [BlueZ,v1,2/2] gatt: Implement confirmation support for AcquireNotify
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6b34b055117c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


