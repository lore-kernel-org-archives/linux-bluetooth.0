Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFDE3FF1D9
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860191; cv=none; b=uj+Hjzm7KpWdizPlwg98LIsrKVM8YtlxdKo5+T4nF6qGVuL2+3ceoZ4oKKvq82ZwPfmuNVYff3GV48lBBk2IoPeXqLSyKiX/CBnc2T/YrKYGDSfuiLZWK8bSzntj+yOiEbK28cCZYbImwBQZNHK9yw6VKmmSzPJBEkp1cSbkRp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860191; c=relaxed/simple;
	bh=sT1Hy9SRznfyYoTNlg4MTEq6M5ijjIDOp880TBh/Ge8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EbKI1fyQa8BHhip4qRYV0uknfCtF4qCUS0GUjsYwWw6PYgLS1u+U7FzF0moKO9GCd0ruNqWC3z33yEPSVZrJ7D+7sx3FWnyoaxOSJp+gpItxXiRR17ENZ7KNGsUm3x1W3uOyI20NeZaixHgUbvtw59UtnQ5rhc8LbO9jvTVdMNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vq43n+HE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vq43n+HE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA7FC2BCB0;
	Fri, 15 May 2026 15:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778860191;
	bh=sT1Hy9SRznfyYoTNlg4MTEq6M5ijjIDOp880TBh/Ge8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vq43n+HEExM66U8lnBE1UZMXXaE5ChyP2nXpJ+NkX6djeXlQEqZILC2DEIhXl4U9a
	 YRyro7CnvvDMKvO3dAKcjlJjEtjvBita9Tga/LLzju+ALNuYxblQ6whIMzYENHmePX
	 Sh7uKYq9MuzodX5WUqAoUwHcdXhOD/kTS8TOVySliEGOC3W0mqJj74TuHzHxzDvOYh
	 WCjrrvSMrTu54JCBsbph3iJULltunli/Rqrgme64+rnDmyCpuqrg5xN5GQYIoXVJDM
	 fBjQRldp1HadiRfCMyT5zbXjCg9rSIRvWXsveH9ndx2CPVi8lzlv4l+bhqIhoapAIN
	 yTNPpEQtBd6/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939C83930998;
	Fri, 15 May 2026 15:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix not setting mask for
 HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177886020439.52984.14952219293789232273.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 15:50:04 +0000
References: <20260514134224.1396820-1-luiz.dentz@gmail.com>
In-Reply-To: <20260514134224.1396820-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 14 May 2026 09:42:24 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes not setting the bit for HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE
> when extended features bit is set otherwise the controller may not
> generate HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE causing
> hci_le_read_all_remote_features_sync to timeout waiting for it.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_sync: Fix not setting mask for HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE
    https://git.kernel.org/bluetooth/bluetooth-next/c/085d13bf8612

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


