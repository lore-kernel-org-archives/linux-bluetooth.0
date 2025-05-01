Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3D2125DF
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746107389; cv=none; b=jqgvuqUUhrG81RSr10B3z9gMzw5hqH5PJSmUGiSwqQ/CmbxluensDnZYCPkDKRKYlEecZLqSsVB0DlQnVxZZ6pPT+rMOvzo4sjeZnP0x88TG62gOnu/Xmg2JI2Zzx8huP0zNX5GTBorSvBBs77+NU5MttL9GzC+A92iZ4NoAaaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746107389; c=relaxed/simple;
	bh=ZhTLO9BgFHc7vch2ZbeUKSSaUMm3g6SoIvcqzabYydo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MRtWZwaityXSprXodIxGWn/rTzswQPc+mDj2qsKSsQiUF0RiIi8B3uNhSZviNHQSTo+9s87KSUnLHFMRB+MOBJoPfBfrSiLAjujj3fy71VJ5Esdrw1wOlke9CRoZJsssVlimuXQkTrQKpER+ipj9QMeUXB2Pk3vZeCU5w5fTklI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBH8Lavz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBH8Lavz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E705BC4CEE3;
	Thu,  1 May 2025 13:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746107388;
	bh=ZhTLO9BgFHc7vch2ZbeUKSSaUMm3g6SoIvcqzabYydo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lBH8LavzfICuBFNo8qMnzBUY0oX4Deb/jkyMiX1AR0u6rP/cfyEDpdrTkHXFuCd0Z
	 EJk12IDXzGhwehRKIqwmW+oN7psua2lBRVXKXS7WCF1/RZA+XcFRBKsku08Ea7vcy5
	 VqVMeBopUXrf8N46gz66IfWt8JZAmNivrDICzQSD4RuO3s7esRyWAaXWzd6D4lzSGW
	 AXcca8tTRwGQprwK/kgdtzgJBpgBv7bPCpJvGN83wewRlJ1jb42a1Hv4Znv4lY8K8v
	 KbLESR7/F5MUHJYZFTAPor+nAxHiOih07MIMfqdkEz92muEGrsrrcxhC6yJIsVQBLa
	 SKxJrTOGCU3Wg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CEA3822D59;
	Thu,  1 May 2025 13:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: MGMT: Fix MGMT_OP_ADD_DEVICE invalid device
 flags
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174610742800.2986402.3752531720911579312.git-patchwork-notify@kernel.org>
Date: Thu, 01 May 2025 13:50:28 +0000
References: <20250429191319.2234877-1-luiz.dentz@gmail.com>
In-Reply-To: <20250429191319.2234877-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 29 Apr 2025 15:13:19 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Device flags could be updated in the meantime while MGMT_OP_ADD_DEVICE
> is pending on hci_update_passive_scan_sync so instead of setting the
> current_flags as cmd->user_data just do a lookup using
> hci_conn_params_lookup and use the latest stored flags.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: MGMT: Fix MGMT_OP_ADD_DEVICE invalid device flags
    https://git.kernel.org/bluetooth/bluetooth-next/c/a1afd438e713

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


