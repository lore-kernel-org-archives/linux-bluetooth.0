Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AFF3A7D98
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498804; cv=none; b=ND1HKQcyHr+X+7lsuoD4/5JMqKIK/+wFkQjnhPLf88IE4z9vSrQbKjp3R1uRnukBIu48cY0go/3bePBh0T6vftAklgX1gqokqo5bOnItMNKKSs/OkRI5A58GL+UhHCn0oToYdZ0G/nfxpMEfWbeaiJuvKrIIhcJ8TTvDtgDdu+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498804; c=relaxed/simple;
	bh=HT5maEP4dd9lMzLtg3voASrtRGr8RQXlg6IKyMvNPe8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ieIRiw4mvAhSlZRC+BfiOcVPKOC6/T61/1zGeK2bmo3e8199wx5/ils4edl2Jm+IuF6UWWMQjIpfBDI4HfuSVAaZ+VHne/4OMC6rXGYV+EoHS0h+0ChadmKUWl9YoLKtbKMnRQZ5gTQrgZ9RySM+5NzgE0w9v1nDW3U5u3p2lE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Us4wyfjI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Us4wyfjI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FE51F00898;
	Wed,  3 Jun 2026 15:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780498803;
	bh=QkefkEhcB6Zz+4vL6aJJRz2iwg6axBwp8CngSWgEuWk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Us4wyfjIjcShpv+E1m5FtzYNQb+IVX1h4P1Il3J7vIA4jlsyb8JZGiKCMvyJ8B//6
	 XaVG/WIOBSdAqhxRgu72/7ckuQHbxhp/byJjBlH0gAHQsEWn7T3CDXX2llTFlkMeBQ
	 egyjOyFy+yMjPH39fXcwUqtwAGCGqP6UtNrufCvxPIDmQNf8Lm82oG1ZtAWAE007Ms
	 oQRPb+wnAMxHvsMKipehZlAZKVWhyOEFkqB9jo8Y+3tcJFAzOBBTpAJigF8iRHUsb9
	 lwSqytEcptGkWPJPFXaB/KJ4oLEtqNVWWEDXsk2TWdgwvk3dRWpgKiU2nPO3iR6rkn
	 OWkJ76rTH9wEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 143793930892;
	Wed,  3 Jun 2026 15:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] advertising: Fix sending extra bytes with
 MGMT_OP_ADD_EXT_ADV_DATA
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178049880497.1456323.1149937692689879413.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jun 2026 15:00:04 +0000
References: <20260602204749.210857-1-luiz.dentz@gmail.com>
In-Reply-To: <20260602204749.210857-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  2 Jun 2026 16:47:49 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> MGMT_OP_ADD_EXT_ADV_DATA expects the command to be of size of
> struct mgmt_cp_add_ext_adv_data not mgmt_cp_add_advertising.
> ---
>  src/advertising.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] advertising: Fix sending extra bytes with MGMT_OP_ADD_EXT_ADV_DATA
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2a6968b40378

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


