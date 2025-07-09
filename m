Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2723E2BE048;
	Wed,  9 Jul 2025 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069585; cv=none; b=D0njWjNrjguCoFwoRy7yC6pP7A2q1KrwILQSQKrK/SEMaDUo93frENbRSpui86y5ODJQmqxRZt/kvAqf+YllfsG2Vu/iXU+ZAWmj1zQH3U5DPrnEj9ZCF30F3zvhHXGuIi/WE2hpLTyho5x7dDQHjotf7vKUMbQV+z7T7PGZu3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069585; c=relaxed/simple;
	bh=LujFGrErI6GlajZ+viWMdU/NY2oKOIVDY4g7JqmRKCM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tVP/wGT5VCAI1+AZrt3zb71H+oJDqf3P5lKc77pFLGLtUoKgvleMyOFmOx8/muo5PHG8R5dtJde2y+/QELVh3Ho3DCs01ADnaLJZdmzXEnoCE/iJkNqyIRveQK9FBE78eIV7ML0LfdEqZAMMbJzlpbdCRmHKEA2PZgVxxkGkzkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gvm8U0Yg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gvm8U0Yg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43E0C4CEEF;
	Wed,  9 Jul 2025 13:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069584;
	bh=LujFGrErI6GlajZ+viWMdU/NY2oKOIVDY4g7JqmRKCM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gvm8U0Yg4BUrqrn6pIR/Yx1ecUaYgdxYx/soN5sWg7qpJMDgUYYAM2hmOutbczAT5
	 3aKEHu6SOvPG+hEXni3nuiBarFHXwF10wvTEFeRei/+S1ea5MACkqmFQGCfDZiwa1I
	 7t019RwNbif0FOYX5q3hw9b0sxu7PlvYpNXZ5apJqoeChqokKjfUjApWHafARL3g0Q
	 mOAsF9X51njtNweTkYgr2C0Ixhw90UhjysgqIWMbotjPOHMJ3kvEbkTmRY22bgXvmd
	 DwGMqdMoHPDDjpUk43W08VzGauyxd1MYDcEDd/smXIU5zFwrSdpymPP/enwzt/PJdG
	 zv3AikNlKnxcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7EE7A380DBEE;
	Wed,  9 Jul 2025 14:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_sync: fix connectable extended
 advertising
 when using static random address
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175206960720.733062.17727343684373335640.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 14:00:07 +0000
References: <20250709080213.6097-1-alex.gasbarroni@gmail.com>
In-Reply-To: <20250709080213.6097-1-alex.gasbarroni@gmail.com>
To: Alessandro Gasbarroni <alex.gasbarroni@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  9 Jul 2025 09:53:11 +0200 you wrote:
> Currently, the connectable flag used by the setup of an extended
> advertising instance drives whether we require privacy when trying to pass
> a random address to the advertising parameters (Own Address).
> If privacy is not required, then it automatically falls back to using the
> controller's public address. This can cause problems when using controllers
> that do not have a public address set, but instead use a static random
> address.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_sync: fix connectable extended advertising when using static random address
    https://git.kernel.org/bluetooth/bluetooth-next/c/98b3f8ecdd57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


