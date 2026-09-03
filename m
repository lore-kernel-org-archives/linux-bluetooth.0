Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB0D383333
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 20:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788465683; cv=none; b=SR1wuywiDP2RT8RmLyI5s5SOjqBMdPBO1eVJp22hj7uw6NKyh8qNTuf/iPS721Xf8sJ4U2LZn7Z/76p8QQuxnRzAFLjh0kNa7IvvTx9O1bE5CSK0PqwSr+mffayYPw2pHjXP+RdC9gFr0Z9HgRslXDHcbzGXKizC682TwfarS/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788465683; c=relaxed/simple;
	bh=ZqKqY/5y+He9k0iH2Yzj5zc068mVVQkXsuQXrd5F2to=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=shPS3WgSzbIf6npEibEOksmb0c5fJ5uenVWV0tphAZYrf/Yw7w2ksKx4daWeYZgXIoFmyvt7aiKspoKYyoi9ub90v9VaySqjRM4ZFCCz/MANODoN0lGorpYSqyEXmXI6/0ro2brZMjrDgGnnxqsW+bVaElJCV802745pJVhxWsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaGNfQhA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaGNfQhA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8D31F00A3F;
	Thu,  3 Sep 2026 20:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788465671;
	bh=iYDJO0Q0bJCtWmv+KWim1Fi1K4n+VR1sXxoHqucxPDA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kaGNfQhA9gdc30XHZZGRWzNDHdrFuqOxuxDPSPGgBRRj9X0MX3f9gm8EkGwD/DTz7
	 gHF/+ZPc0BwPf+POKQX5mZtJATfcVRK4EjVmGL5+HdlTEmT+GAmKtDUs8ei9xD6Mtn
	 yJFhHk/s4aIagHFbtmMQ6T3uUdWb2bDF5Npua3MD6rXPnq0hknY9TrYXeCSp5AoPr9
	 iX3lOFBz1rUcbFQ39M05Ovo2tHP0sRrhP8Ks+lMOBcm9n2y2PXdN9UV6YqdBTSzy2I
	 4/Ea2a7b3Q+KLKXpsu+ZNw0pjY74SzYeqU+XzXvxL3pGe+Brx+sgMc5VN3ELrbS9xU
	 9DFUKcy8aROUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1969D38119DE;
	Thu,  3 Sep 2026 20:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_sync: Fix not setting CE length
 properly
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178846561263.3994681.709793121678223106.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 20:00:12 +0000
References: <20260902171626.1711932-1-luiz.dentz@gmail.com>
In-Reply-To: <20260902171626.1711932-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  2 Sep 2026 13:16:26 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Both hci_le_set_def_rate_sync() and hci_le_conn_rate_request_sync() were
> leaving Min_CE_Length and Max_CE_Length set to 0x0000, but the connection
> event length recommended in requests by a Peripheral has a valid range of
> 0x0001 to 0x7CFF (Time = N * 125 us, Time Range: 0.125 ms to 3.999875 s),
> so 0x0000 cannot be used.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_sync: Fix not setting CE length properly
    https://git.kernel.org/bluetooth/bluetooth-next/c/88a8184cb44c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


