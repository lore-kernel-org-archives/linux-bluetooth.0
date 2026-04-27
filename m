Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D116D227BB5;
	Mon, 27 Apr 2026 00:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777250264; cv=none; b=ZMEn1I4Z5MLpox6BWaK5FEufFo40uoiLPY85nHQw7BO6moJa1naxvduyGRBXdTSCxB9pbR6qty/pErpMvfmUR/bzuTvbczWMLh0c0WYEvqSyevt6fbMa7ei5TewtE3SXa/VizAhdvbkAA2onNy0LHr/wTFDZoNnoDQs+Oj4MpAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777250264; c=relaxed/simple;
	bh=s1ow/FM7+M4xivPdf7bVIsujBp/RKYxrt1Zv0/p7uLE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YvNJCUiMgmHFmY+K4l8vFukl7jkqxe238Ja/MFh4O01Ck7c/J+HEtl8sTTZEJSeskHPwyyRpJtRKOyCS0dXilUUhwyrXV5GXxPU6HiRbTEXPehNk+aUrF2fNrAnLAZG6gXsqDstKGWTA+6tL5saCwgsXM/AZxeYZuE8mZpDkBHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZRn4t3b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZRn4t3b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69653C2BCB7;
	Mon, 27 Apr 2026 00:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777250264;
	bh=s1ow/FM7+M4xivPdf7bVIsujBp/RKYxrt1Zv0/p7uLE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MZRn4t3bvjBS6zrOFfl6jwKDPlMs/ElDyeiwoazomQu3f1M4DzumBjgUtydRWHrxF
	 LMtWq4tGG9mx8sP3lpgQr4QCcZ/75swokGP7w3E46gWUOlBHkrGJWgCotjdrtyKPo9
	 TN3yZE81/fbhu8a9NqdbTgSTUgcsZddhF3Hyo4CDhwEtyykfcNNAULWHC3LcWryIxj
	 h/FDnfzm19EmcbWYwHxK0ebdZvsWdtOWEAUGc6J3QLVO7NyjCtnA9ZNbRzdUw2e/wH
	 B70oQiE8flIj72SK76VhSBMkBrQPx2EE6qoKQZ7bFgKTi9dm4A7g03GqNwwoxlDQEC
	 ZvM6tCy/R80ng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA04E38119E5;
	Mon, 27 Apr 2026 00:37:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-deletions] net: remove ISDN subsystem and Bluetooth
 CMTP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177725022232.2839245.6339161614264440162.git-patchwork-notify@kernel.org>
Date: Mon, 27 Apr 2026 00:37:02 +0000
References: <20260421022108.1299678-1-kuba@kernel.org>
In-Reply-To: <20260421022108.1299678-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, marcel@holtmann.org, luiz.dentz@gmail.com,
 mchehab+huawei@kernel.org, jani.nikula@intel.com, gregkh@linuxfoundation.org,
 demarchi@kernel.org, rdunlap@infradead.org, justonli@chromium.org,
 ivecera@redhat.com, jonathan.cameron@huawei.com, kees@kernel.org,
 marco.crivellari@suse.com, ferr.lambarginio@gmail.com, nihaal@cse.iitm.ac.in,
 mingo@kernel.org, tglx@kernel.org, linmq006@gmail.com,
 linux-doc@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Apr 2026 19:21:07 -0700 you wrote:
> Remove the ISDN (mISDN, CAPI) subsystem and Bluetooth CMTP protocol
> from the kernel tree.
> 
> ISDN is a pretty old technology and it's unclear whether anyone still
> uses it. I went over the last few years of git history and all the
> commits are either tree-wide conversions or syzbot/static analyzer
> fixes.
> 
> [...]

Here is the summary with links:
  - [net-deletions] net: remove ISDN subsystem and Bluetooth CMTP
    https://git.kernel.org/netdev/net/c/4f10f1dfb235

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


