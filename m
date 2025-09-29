Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3569E2C1594
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Sep 2025 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759153213; cv=none; b=BXAWMciTK2E97pk7m9wURHusHyn+eXrNRzmq8RM5BGVf2gV1s4mguoWsRh3uS99QLXWN2Z+YpOeU5QG2UZFhXMbdkiKvNn3JeKfeZ4Wt4krp0+TLkT69Kddjj4vblLNMxuL0QKYl3/nQMjlzA7pCiimfZ+0f7aqnPWybh1VJ850=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759153213; c=relaxed/simple;
	bh=TEm+ZbRLVA4bmK7EnXVskYMUP3QGJkevQ+WRrsnyjPA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HFhw8i3ngKWb/pBmS0AWLezYO0o1JssKOckNb3QbFVR0xkM1GZMzMmwRoA2QGwY7EovS4DoEf8TEEbGLEbVrihPJ200pqXARziMGdnezVsBVcHrFHKyb1bmVy6Ou7Rahd6cJy/zqYzu/uu/k1XE0EKbo57JvIu5Cs6rGx2YnF4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/6B+qfJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/6B+qfJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C856CC4CEF7;
	Mon, 29 Sep 2025 13:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759153212;
	bh=TEm+ZbRLVA4bmK7EnXVskYMUP3QGJkevQ+WRrsnyjPA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q/6B+qfJUxHxylJwHZz1dp7WBHN7cR8zaF0wwDj09V85ACDEF6brYkkYvEK5XZ9EB
	 xwTCZg2QqeQdiKkdQsHTsFTC6ZYMeydqf5uqkwykUSHZ8Oyh1sHO5NYDROdxHMUKRk
	 MDsGmno072fcuq9AVgBKBJiDAQS4UrILYYCI0n6PpUXYOBrVn5QRG9pt3efJu+9fAw
	 8frdCHYt4bOGnti3Xa3sOOksyM21ClFuXR1gIMRQS5MzBa3+YJMOH+DQtnaBVNe2x1
	 Sqb5B0AnzW2Bp7iRH83L0nsiJu7des1oocC48RVf10V1KCKZ1+akMpw4d8zBkl8GNV
	 g5UyWqZIzdr7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF4D39D0C1A;
	Mon, 29 Sep 2025 13:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] btdev: Fix handling of
 BT_HCI_CMD_LE_SET_RESOLV_ENABLE
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175915320651.1222763.3576652426320996587.git-patchwork-notify@kernel.org>
Date: Mon, 29 Sep 2025 13:40:06 +0000
References: <20250926162003.754423-1-luiz.dentz@gmail.com>
In-Reply-To: <20250926162003.754423-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 26 Sep 2025 12:20:01 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Checking for le_adv_enable alone is not valid considering the comments
> itself states that peridic advertising shall be allowed.
> ---
>  emulator/btdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v1,1/2] btdev: Fix handling of BT_HCI_CMD_LE_SET_RESOLV_ENABLE
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a6d35e91b80b
  - [BlueZ,v1,2/2] btdev: Fix advertisement state
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e7c77f80787d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


