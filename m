Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECEC2DF12F;
	Tue, 28 Oct 2025 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687033; cv=none; b=r+BdGpoYbT+bDdzpHDS879snL2DskNm92nfYAn5vqoxealAcuRc9SJbxi1ErYEqG1pyqCIU6IMKMAKq7ylTST7cPJZw8Y8VFAsIK3qzHxM5dMMr7GPA4BwtVBEGWsScT4CzAVlwgpv3OFoOdzgX8oRjI3npgdgdVUIkOkjupD/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687033; c=relaxed/simple;
	bh=wDTYHSfoAu4DI/RwDD/DRAaTjxLv+e4NQ7bgXB+ZnRc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gYHw0xTb8F/0Ifuyr4aY7HiRStsFqyCRHFYaD9ZHac49hmr33zLWoxxMo6jm8zXoqpfZw9tkCslcE/W5WhNbEDpIzM3iMc2HayorUmlSeCehoig9PNcqPcY8LCGXOn76K0Np7nGIwkgyGA5NcVdmkNrtcEEOLvjaqa0bOr9E3pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bl3YBjoi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bl3YBjoi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93ABCC4CEE7;
	Tue, 28 Oct 2025 21:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761687032;
	bh=wDTYHSfoAu4DI/RwDD/DRAaTjxLv+e4NQ7bgXB+ZnRc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bl3YBjoi4AoSsWDKXWKJDeGNyJgbO93oS74OvF1ok6TOi5Q55ibvtgGwpJllED/2+
	 Gi46wYbEZmphxesppDx8cD0eJvvkMkA2A9C2VSU8nZylRZkMFKqYLV8WeBJ/uxfHzi
	 fDmAdJeZkjGMpVFPRdSQxowDDnPZRsp9J2DQedAEbD5AOcCp7DChhPP2yY5V0Rbqts
	 /ZdU5uUa19LKWjfK7DqWyhcgAT9fORkSePkwFmJ5cFB/DKin6eCmkpUW3yIU6g9QiW
	 DbGV8vKSybAi4+JpGTc3uXSA35XJA9tU1xRGiu2WivWEjZp+oPc+U6dn/nUym06DCW
	 4e7BOjFYYtRWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D0039EFBBB;
	Tue, 28 Oct 2025 21:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: iso: fix socket matching ambiguity between
 BIS and CIS
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176168701024.2391991.6393088743773614505.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 21:30:10 +0000
References: <20251027-bis_cis_coexist-v4-1-81c4e890fa6d@amlogic.com>
In-Reply-To: <20251027-bis_cis_coexist-v4-1-81c4e890fa6d@amlogic.com>
To: Yang Li <yang.li@amlogic.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 27 Oct 2025 14:10:02 +0800 you wrote:
> From: Yang Li <yang.li@amlogic.com>
> 
> When both BIS and CIS links exist, their sockets are in
> the BT_LISTEN state.
> dump sock:
>   sk 000000001977ef51 state 6
>   src 10:a5:62:31:05:cf dst 00:00:00:00:00:00
>   sk 0000000031d28700 state 7
>   src 10:a5:62:31:05:cf dst00:00:00:00:00:00
>   sk 00000000613af00e state 4   # listen sock of bis
>   src 10:a5:62:31:05:cf dst 54:00:00:d4:99:30
>   sk 000000001710468c state 9
>   src 10:a5:62:31:05:cf dst 54:00:00:d4:99:30
>   sk 000000005d97dfde state 4   #listen sock of cis
>   src 10:a5:62:31:05:cf dst 00:00:00:00:00:00
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: iso: fix socket matching ambiguity between BIS and CIS
    https://git.kernel.org/bluetooth/bluetooth-next/c/7361123a3362

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


