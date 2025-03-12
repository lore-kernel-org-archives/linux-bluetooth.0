Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1B61BC09A
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741797005; cv=none; b=hXWpRJ9lpqrgpQzjfkU00RZk2xHLyeKEIDhgMRIrxnQbnLGIhI/3N2Q/uhEdTFnJirMvMj/KfktNXCNurUhTiT2l5zQFIF+il03CCAspXYh9Yd/bAq6/81ghacWTtFuLu5AyE+mzGsbrlDtEyEXC30sI94ZqKexTLZnVBrQ+dwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741797005; c=relaxed/simple;
	bh=dcunAp3EcN1VaezJNJhXpp9INGjPKN3r34C1Q+ZKNzI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cVyqjFfM102MZo+ol2CV5Q51fRN8+64JzRSprYEFKL6VAQT5aqyvRBG/s9dkoMvnTdGnADUoR0SaK7Nb+9XjiIuy4ddy/1QoEWDKgnhk+RA0LcpZT+YQJ4eUNb1T6n2GDgxkURpeg1/wkwTK4LVQh2CR2aHgBKqO88ccC6/E0mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzBQ8vme; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzBQ8vme"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647EFC4CEDD;
	Wed, 12 Mar 2025 16:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741797004;
	bh=dcunAp3EcN1VaezJNJhXpp9INGjPKN3r34C1Q+ZKNzI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UzBQ8vmehDi5JFcrlyi/pzOkInKB6LNE6mnKX6bFouMnTxh1lJDrGvtbL0wjx4vlt
	 hmgXRGrtDq+YXEBgSu2QU7ha0DN/YR1W3pWe3ASdGaCSFHHSk3uO6vtxKjHE7WP/xB
	 mCmZ7LXJtZLRXgHSFqKWp0sfG7+4IWxzMgJoQ7m4YOcbxoj7d5u5x06vvFLptH0MOz
	 4npTlMOMlhB3eKAUwhNQgy9FW42k/kPDlLWqutjH5JK6iX21CChg3Q7nwtcYVgJEFN
	 leLWCjOYutSLMMjsuWt8egiubaeiIdIXaKCyf8JZmyZOyuuHLmPQoqtsp1451GMQ2O
	 Nc2If4guPvprg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE8E380DBDF;
	Wed, 12 Mar 2025 16:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] Fix data type in bt_hci_send_data
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174179703848.858864.12655289043756395894.git-patchwork-notify@kernel.org>
Date: Wed, 12 Mar 2025 16:30:38 +0000
References: <7dcaf905169d4c399d89eefbbdf0d3c3@realsil.com.cn>
In-Reply-To: <7dcaf905169d4c399d89eefbbdf0d3c3@realsil.com.cn>
To: =?utf-8?b?TWljaGFlbCBLb25nKOWtlOmRqykgPG1pY2hhZWxfa29uZ0ByZWFsc2lsLmNvbS5j?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	=?utf-8?b?bj4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 11 Mar 2025 01:54:49 +0000 you wrote:
> The data type in bt_hci_send_data shall be ACL, SCO or ISO. This fix cannot send ISO data in client/hci menu.
> 
> ---
>  src/shared/hci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] Fix data type in bt_hci_send_data
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e3b2759634d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


