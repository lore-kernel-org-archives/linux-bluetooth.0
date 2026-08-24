Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1762359A99;
	Mon, 24 Aug 2026 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590260; cv=none; b=hQc3y/wRvrUrjRJyOo/buvm9q0gTpekn6u5DJBSVwPJS8hWsaZL+k7aWoh13sKQH1DI1rhm29Fjg2XnTd9kKDNxlFUQYLjkDsHA/bgBVc8wqPBrF16xO7u4GlqgLjUXgdNCWaQEaL0It1I9EZB9O4CZNAsV5nQd8EsGz9EH3vNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590260; c=relaxed/simple;
	bh=gpIZilrHx1H9ijTftbG/fpRSsKXRHs0HON3DZS/eDZY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sP0yBDUQWACw6R2CRdULHdPNismP1U1Xfl0fHb1BxqEHC1U5aQeHqG8Gso9oZ2sBaU9Pn5nhNlYJzHHJDoD7Opbl+WrYGFr+j3J5l3Arl6yW2zPOr8HsXdXgjJMHfUDKgwdDgYsH+9My47vPyho2B/tbSQLXATc/33YcZibQ8IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpQhyeR8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpQhyeR8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1861F00A3A;
	Mon, 24 Aug 2026 16:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590258;
	bh=qNHr0SHGMeij844ayA049XMDlBp9W/XEy/ZWYtPMiGI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fpQhyeR8p81MOBw44wHePyaN8bPRzmZNwCmyynGvp2i6lFElrsW5snY2phUSNDlZX
	 fB0LwGgB58z/1k5OSzi7/6c04bVM0iV353UfFtOMoNmGfv9qBCJNfkTlSsMSTdLk/N
	 l1Cn8MoRK9WZA1I/xw+i3iLZDMci5tst0/TAynCnhBUIYXmq/dWfBgbQo2Jd3r/g9V
	 spHh2xUMt2LJutkHkG1fZY5gevWx7ArjLmEI0Q/KaQ2wmpFnoV0E9Ga3n1CgwgvnR+
	 cMuOD5csuFKEpbkUj8UbOg7gxFzbg4w9r9JNCGv8oEmroLt/DbrX4B8O6/Rb1rrI1J
	 klwnjCbi8mM0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197EB3924478;
	Mon, 24 Aug 2026 16:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: do not leak an hci_conn when a second LE
 connect is rejected
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178759020578.3014491.9097993364125827682.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 16:50:05 +0000
References: <20260824110020.5423-1-radek@podgorny.cz>
In-Reply-To: <20260824110020.5423-1-radek@podgorny.cz>
To: Radek Podgorny <radek@podgorny.cz>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 24 Aug 2026 13:00:20 +0200 you wrote:
> create_le_conn_complete() decides whether the failed connection is
> still pending by comparing it against hci_lookup_le_connect(), which
> returns the first LE connection in BT_CONNECT. That is the same
> connection only while at most one is pending.
> 
> Two can be pending. Connections created on the passive scan path sit
> in BT_CONNECT with HCI_CONN_SCANNING set and are invisible to
> hci_lookup_le_connect() until hci_le_create_conn_sync() clears the
> flag when their command is issued, so the -EBUSY guard in
> hci_connect_le() does not prevent a second connection from being
> queued while the first is still on the scan path. Whenever two
> connections are in BT_CONNECT at once, the lookup may return one
> connection while create_le_conn_complete() is reporting the failure
> of the other; the early exit then drops the error and hci_conn_failed()
> never runs on the connection that failed.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: do not leak an hci_conn when a second LE connect is rejected
    https://git.kernel.org/bluetooth/bluetooth-next/c/aadb3cd4bbb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


