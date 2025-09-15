Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DC03191D0
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943605; cv=none; b=T4qp6U07/C9Fc9FnxgZ0gQEQouljgsOOqWFk6hOmYHp8O2HBYGaUIOgspItvXZDutsHea+gDJALotPy9CmrdDsnKVB+4T3geI3/vc7wKMLVoIzen0a+Fq8vB5T3l+9qC33OL0wN9OftI4Ku1JJsxL2FXgKpqSYsoqS61keE6/44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943605; c=relaxed/simple;
	bh=1kpwBk52kCOute9KPEmTSkzD7BN2NPglW9G8/eCgXpo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G22R1D43iMtzayaRVlL3UyxD7z4pzist9EqPw6sEUOrTLXRjuLy4FbPswdVxmFxBDiPUAht0POn6c/n3zB3Gy/jK4HbFfWkPxvnusuetOsp0fGDGHgyqpilfG1adCZsCiMCVNqqnZ2A8/tkAKpuRzbAEgXdRdGLZBa5cGdCdprQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSl0+dgp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSl0+dgp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B8EC4CEF1;
	Mon, 15 Sep 2025 13:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757943604;
	bh=1kpwBk52kCOute9KPEmTSkzD7BN2NPglW9G8/eCgXpo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DSl0+dgpxHBjbLFIDQCILbmuSEFyEisL9/tLnD4djZmqi1GUJQd06lJQT5JSBHmQM
	 gr5ZIxB1YTPBHzsoMuH+gy7UllZjC7tAZytsPUm/b+H0XpQtSsP1R8hjnFrPiixZgp
	 UXHnvRoGduXRgGjRRMjr48Va7rIyk4NgMXt/n+5yZfvsrZqzKoyXCm7wOMNdSLx4f1
	 UaHNOou3RF4G0Q3Q9Tq5EqO3VyTynowlDADLi0zbm708gt6qPvGFgTGPOzHmrdUES5
	 T/y3Ial/L3SCUzRuCoGOvy93NaoLYGLNynqMlt5lXe/+6S2Q+OM4A3sfCIGbxFbVay
	 IPRENLYxdOAzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD9139D0C19;
	Mon, 15 Sep 2025 13:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] audio: Fix typos in A2DP error messages
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175794360651.4175453.11557983851824601343.git-patchwork-notify@kernel.org>
Date: Mon, 15 Sep 2025 13:40:06 +0000
References: <20250915075553.1636970-1-pwaago@cisco.com>
In-Reply-To: <20250915075553.1636970-1-pwaago@cisco.com>
To: =?utf-8?b?UGVyIFdhYWfDuCA8cHdhYWdvQGNpc2NvLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 15 Sep 2025 09:55:53 +0200 you wrote:
> ---
>  doc/org.bluez.MediaEndpoint.rst | 8 ++++----
>  profiles/audio/a2dp.c           | 8 ++++----
>  profiles/audio/a2dp.h           | 8 ++++----
>  3 files changed, 12 insertions(+), 12 deletions(-)

Here is the summary with links:
  - [BlueZ] audio: Fix typos in A2DP error messages
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9c9d6ca27bcb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


