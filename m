Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDC942B72F
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560053; cv=none; b=JnkB3k1sItIf/DoIVTU4cu724Ea52N6iJDwygbCXmg5ih8Hpur4sF66MIgpeCgeu57j/wk7tKdua7b4ftGhfEq1eOSWb2is111DkIiJqeI1nKGSZxZbTiLbmsqfSddGx8XS04nWD3e2+Ez8mkDbfHzbubIF619DtHQDUNDWWThI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560053; c=relaxed/simple;
	bh=C1MJx7CqwFDhMKTThYcoqWco7BhsAnu0GZwEBc9xxJM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XtnkWmcrYIY0V2Os/vWAXvMFkvVubsyMroYlgJmqBcAcP6nSM0Lus8VqLJ+5E1v/IhpccqoM35dQQfsGQHIQ7lDHRccA+iredYaGlRWNBfcr0BVZ/04p8Z6OqFeyzboXnlJ7wdgC3KoKqZIGWBymrjoy8OMEU/FJwzqNHYD4FdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m635/ccA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m635/ccA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6C4C2BCB8;
	Thu, 30 Apr 2026 14:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777560053;
	bh=C1MJx7CqwFDhMKTThYcoqWco7BhsAnu0GZwEBc9xxJM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m635/ccAL+kMcldbfoGvbYg8fgrlPRX+7sbqxkBPKsAQK5ZniK9W6p2vk0aMKB9db
	 EEckktftM+xkC386Jqafualgy8Rl4C0mFbcVL08TROl9in5k8W9qr1d/FEewvERjKB
	 pwFCNkVw5mtUbJArS3y5rNHZZe2qZklLY74t0o+1vFI8BaOJcbtW9+29tcRqzVidqG
	 FZk/U6Lt1zHECC7aqfdrTRadht/cnHYcYfbvGRA2un5WwSvLyAonY3h0kFp1x2qk/8
	 pRjwcxkMpiFvnXyKLGmMr8f4GxL9KZdlg78znu4BHn2fQq7HCwUElS5uaUACXyrUvC
	 /TC2tAcE6HpRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD6A380AA5D;
	Thu, 30 Apr 2026 14:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 0/3] Add RAS Packet format and Notification
 support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177756000779.3037252.11624795719233750654.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 14:40:07 +0000
References: <20260427113544.1063560-1-prathm@qti.qualcomm.com>
In-Reply-To: <20260427113544.1063560-1-prathm@qti.qualcomm.com>
To: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 27 Apr 2026 17:05:41 +0530 you wrote:
> From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
> 
> Changes in v3:
>  Fix for cs_mode_one_data struct members rearrage as per spec
>  Reading of cs_mode_one_data in rap_hci.c
>  Address cs_mode data struct padding in src/shared/rap.c
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/3] Add RAS packet formatting and notification support for CS reflector
    (no matching commit)
  - [BlueZ,v3,3/3] profiles/ranging: Read cs_mode_one_data members as per spec
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5d4792dc2a20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


