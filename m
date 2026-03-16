Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09B23CE495
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691214; cv=none; b=L/3/Gig1k8WNaHUmpmy111Ievx/DR7prJ8l1LDW4sIjjhOnPwUyxTpKzet3aQGXzXpsfIDgNgeLygMWvfQUDeGCos0uV4nUAwQbaBYig2kvSI7/GkvLcE9Y0UuGX7G6XJTFB2UTzVkGdwZZyqjGSQRN065Y855QJsFFzGbCIuw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691214; c=relaxed/simple;
	bh=GuSVPYLdtxO/rQOOM03h+LaUO2Wy7EPo4pD9CmjtWEc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eZuvocFezu2bxmm28rH+68aA5F614qLcmtbkQ/kUtUQ7jvyQ6ViqXjRL9NmWyT3RFTAhEzJezWMqVdpAerfuvRx3uC1urdcfhHsVK1iAXQDMkmnK2GeszL5Nmycol8OJx7N53cv09M3QZg2N91+UaVXaEJa+QK1kCz4IErcayRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgjZDwGi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgjZDwGi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61ADAC19421;
	Mon, 16 Mar 2026 20:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773691214;
	bh=GuSVPYLdtxO/rQOOM03h+LaUO2Wy7EPo4pD9CmjtWEc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LgjZDwGiBrUOTImFOzOhSt9IF2if1Apg2fYgDSLY0Inn6fA9f0xZZhJF2b9o6J3l2
	 qAG4K9E0AHiWPdEVr1l4F6hj0qyOPKow77wJl8f3aN0lOlfKSZk8wqKQWrO/bQnIFw
	 tUimu6d0PLc1AhG6n5JzEf3/STB4K3n1H3KDAB9M5p8YQ4CBsuoKDAxVY4/0jO84T9
	 N5oKmajv0Ls3xsvFvlBJbE5WZYtlTzwLc/VFVU5H6DLmiOYsNZuM+V3AxeUpUo1Spq
	 XCiEVdaQbwZTyt4ZHuH5BUyvVyQCll11FZGqQM//OV1yWpK2Ns3VjHgyU6rqqfZbEW
	 CjRoJ0BDnIAEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D1393808200;
	Mon, 16 Mar 2026 20:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: Validate PDU length before reading SDU
 length in l2cap_ecred_data_rcv()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177369120703.3291233.5058198954118841523.git-patchwork-notify@kernel.org>
Date: Mon, 16 Mar 2026 20:00:07 +0000
References: <abMgjwF9IdkNhmpF@v4bel>
In-Reply-To: <abMgjwF9IdkNhmpF@v4bel>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@intel.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 13 Mar 2026 05:22:39 +0900 you wrote:
> l2cap_ecred_data_rcv() reads the SDU length field from skb->data using
> get_unaligned_le16() without first verifying that skb contains at least
> L2CAP_SDULEN_SIZE (2) bytes. When skb->len is less than 2, this reads
> past the valid data in the skb.
> 
> The ERTM reassembly path correctly calls pskb_may_pull() before reading
> the SDU length (l2cap_reassemble_sdu, L2CAP_SAR_START case). Apply the
> same validation to the Enhanced Credit Based Flow Control data path.
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: Validate PDU length before reading SDU length in l2cap_ecred_data_rcv()
    https://git.kernel.org/bluetooth/bluetooth-next/c/a480f2bbc7c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


