Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C607D279907
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769538629; cv=none; b=dVvS+Nwwn9eDomC0Qvx8Aac+sUlkoQoM9uYCEEBUsyCAbbDmJubxNt4KCWrblGUxflzJq/q0MI0RU5Y0gGrzf/IlI/0HdpyXn5Gb7r4qSCCIQPU0J2i3OQkdRftdUytfoQtPl59BLOTYtldjkLe+wtqqm6u3lSdXK6z81ojJhnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769538629; c=relaxed/simple;
	bh=wcRslWjA5ng9xnzPQbMUJWlm6ABhdCDozY+tP1Jh11E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=alb0te5LvaA/e33cNfUGNfiUb0blTOPbqMNr6UUbFHqTkrSS2bCl9VirAISlKhZvh0cnGCBBFy36RrUKa4tYDEVyKp6tB9mo6daxbCJCLqQRfuqRh9MyqmQgFv+E/NeRZfT5VuK1XoNOLUbuYTsO0/Wrdhx3z/YZvk1+c37ccik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVoQiPoM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVoQiPoM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1569C116C6;
	Tue, 27 Jan 2026 18:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769538629;
	bh=wcRslWjA5ng9xnzPQbMUJWlm6ABhdCDozY+tP1Jh11E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LVoQiPoM4PZnsTaicU/CrfAlOP2i/SF0uu+A/col6JIgPl+9KfN7GCoa2HVmUzhZd
	 vTnyjyxMDPZV63Z/NkKVZLoKY0fTng1OosS8vhB4MGWCCbKxKN84z21ga0K1k2YT9M
	 uGzbNLCulTlbq3jPKxZfPYP25K193zXDBaGfJUNq3nxIeVQNsQ5g2YIfnz3saO1hT3
	 cvFnOdh849zksbkQaBxlsSwCE/iF8ZSHQMSoKiOh0G6QXGdAYAATQwIuTTpODM/kIG
	 wUQpsbdKlrvIqq4r1w0s1pMowpJc0/AhcEfNCFehiyp/xR0+2FvbrgAlFPQ2Dk0Nkx
	 +st2zQuGOYTnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8BEB380AA58;
	Tue, 27 Jan 2026 18:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] doc/qualification: Add PICS and howto for the AVRCP
 qualification
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176953862335.1352702.1811129694014184778.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 18:30:23 +0000
References: <20260127171054.151065-1-frederic.danis@collabora.com>
In-Reply-To: <20260127171054.151065-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 Jan 2026 18:10:53 +0100 you wrote:
> ---
>  doc/qualification/avrcp-pics.rst | 1153 ++++++++++++++++++++++++++++++
>  doc/qualification/avrcp-pts.rst  |  223 ++++++
>  2 files changed, 1376 insertions(+)
>  create mode 100644 doc/qualification/avrcp-pics.rst
>  create mode 100644 doc/qualification/avrcp-pts.rst

Here is the summary with links:
  - [BlueZ] doc/qualification: Add PICS and howto for the AVRCP qualification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3a6a1cc0c898

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


