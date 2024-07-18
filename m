Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4529A4D8C3
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 18:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327436; cv=none; b=uomozzgT7IisqKcxDfAhIA9Fcs3k4M6FiiVjgHub+iuO13vATaa55jg6T2VAJT2fWxpyUkLRd2Y9QZ+W3R+8rrlgvPInfL7JYOqoXqQaeRQ95zAvmygqXYStu549sTdATWCQtOG7b7SFxgtPTQOvqvSWxidP7JF1Vn9rSka8otI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327436; c=relaxed/simple;
	bh=JzauxjfQsFGqBeeZ1NXssMac6r8Lmj3J7HLvy29VLVU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jRbNBENHvPdk7Qd78OOP9zJ/9gcUq5uYL2qe72VnXGyE6BOODgHzadKyVjzhXLx/lY6rXA11ZuVdCVWcZyF2G36WSqDyY+UrynC23K+ZWliGnfsyK4ucuV/VaLbTcteKqzQflzn4aduPQrwF9ko+Xj780sT1vp4FXO0zDZEVZig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8dzl/+V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8dzl/+V"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFD34C4AF09;
	Thu, 18 Jul 2024 18:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721327435;
	bh=JzauxjfQsFGqBeeZ1NXssMac6r8Lmj3J7HLvy29VLVU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F8dzl/+VBWMXqbDo+eFTS4mMnPK4u/0dQTsg1I4qr7p1RviF9q7GMl8xS4E6Kg39Z
	 W137jmzVu4nCedsmKS6LaMokP4bNkvvP7dn6vDQ53HUtnBL9tsIiUTSBnBPCk8FkLN
	 JlHdejrSmhdQe7IxjGjL3soZX/3h7kXDAMwcI1JbGR6FU2+Eqw6QSSi1xAjz1/cE8o
	 ALACrOgyE0UinRXn7RsS94vwpcveZsjGiLFMFyDwDDrRB9g7U4MyXS1giqAc6DxYt0
	 3rNpEoqWXFx5npvvzdN8RtjzBggmi+iUD5mdXKuYoM8lH4V5N2Zw4U3btUv61mmeg3
	 NHefrUWLy8UZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3EE2C43445;
	Thu, 18 Jul 2024 18:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] bap: Fix crash in bap_bcast_remove
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172132743572.20188.9216759837554485881.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jul 2024 18:30:35 +0000
References: <20240716081131.14893-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240716081131.14893-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com,
 andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 16 Jul 2024 11:11:30 +0300 you wrote:
> This adds a check for the PA request dequeued in bap_bcast_remove,
> to avoid accessing a member within a NULL pointer.
> 
> Iulia Tanasescu (1):
>   bap: Fix crash in bap_bcast_remove
> 
>  profiles/audio/bap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] bap: Fix crash in bap_bcast_remove
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0bad3d5cbea8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


