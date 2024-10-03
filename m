Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627F91A76D2
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Oct 2024 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974229; cv=none; b=RPY9iwTb6bd2Y0R6N5v+4eYW0V+r/KoIgxDlIUCu8XUUbt8McytlWJezx4iZu7DCCuOuPWypDsx/ue+55nQ2iqysXgg5T4LYgpnX8rfDuWi3Zd73jKLgyRAwHSe45kJdiaRF0OOmrNoPMfyBKK6AU409xSA2p0prh8ZYqqnkk7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974229; c=relaxed/simple;
	bh=ceXqN5VtXf7cIozpAR04jwbVCWXmXtAzouhs444mCcY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QAfmhJd2i+8QNvW1w9MG6HFDrsqwuoXApUzgU4KTDUiDQN+YH9tHzL5pvdQU9l0jM44wDx8zatJsNQwAP5JScnG6BJd0MSMIuBSapDS9exPL5iYLTc6J0nx1Rbgs7q4bLigvIbzXE3JRo1kFUY09flpLvJq5gpGzf6smGsig9M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXtKzsfy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXtKzsfy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7B8C4CEC5;
	Thu,  3 Oct 2024 16:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727974228;
	bh=ceXqN5VtXf7cIozpAR04jwbVCWXmXtAzouhs444mCcY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RXtKzsfy01VoEfNaDbftOjIGq2IQGGKbU1+8RY50o5IY9kxAyDcyo5aGyQQNW0GAx
	 iuSvaF6rS9JXKZih0SfedrKlFcs1GKETt96p4vWjHWrhCclWZDeYu+vqdiFVbeM8vd
	 /B9CF6wPYyuGIGIaDvxmX9142USYSLXCMgkdRsHrRDo0nCPZtIK1oovr4cQus82Q5J
	 TrqXowj/44VVOZ0RKICsIW3RTaqSCRuwMyZoTCachoQwkwVg9d2vwrHVpDnKEObE4G
	 EBMys2wHFItyVjdWMoyjlPTD6q9oFG+xllpHZdZcq+SrnX+rj5yTl+YCZp8w3vbFjY
	 qGH2Yz6hSrBpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 715CB3803263;
	Thu,  3 Oct 2024 16:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] client: Add Broadcast Assistant/Scan Delegator
 scripts
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172797423228.1920089.11952184176890128376.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 16:50:32 +0000
References: <20241002141345.27931-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20241002141345.27931-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com,
 andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  2 Oct 2024 17:13:44 +0300 you wrote:
> This adds sample bluetoothctl scripts for the Broadcast
> Assistant/Scan Delegator scenarios.
> 
> A test setup can be created using these 2 scripts and the
> broadcast-source.bt script: The Broadcast Assistant connects
> to the Scan Delegator and sends information about a broadcast
> stream.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] client: Add Broadcast Assistant/Scan Delegator scripts
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=43bd13f7c700

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


