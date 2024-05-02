Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CE12208E
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 May 2024 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714683632; cv=none; b=AAznnn33aYtWH/c+h7TyVr3PylMC9vgtiji3oNmS1exnFDQ0SCbiJf+NVzFKcPO4UrPP4GQRIbOiiYCLLJKk+Nu6uzr3pd0sPEtDf+kL/HvoILGTfokSPAsWOKLlO+0mZUaI1+DfNvSIqYWbN50Gcrp1qM9GkSJ8Za9l7fZ34kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714683632; c=relaxed/simple;
	bh=p/V6YMkSqOqRZ93kAyiQ03hJe4UteemAw2dnb1mmZt8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QgRDei96T964OZrSrGnuRbRgtW/bTmSx8S5u4rC10ywUe+uuRDkECF4C7A0tDlMGRwhcK48aHTIMEhF3a5iY7ARyCgaM3fAgittqEXIWLbC3ruFAGUeRjV5Rd9/tRnkq56LqwL7L2dlmQQe+PR/lkd9KDmmPaA194EhxyaKvNEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfVw4cCX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfVw4cCX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFBC0C4AF14;
	Thu,  2 May 2024 21:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714683631;
	bh=p/V6YMkSqOqRZ93kAyiQ03hJe4UteemAw2dnb1mmZt8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bfVw4cCXWWusUVwC9O7h3aE2W5Ztss1sXJYUHS7L/fCzCgYIGjvDibXP4OLx/ckAw
	 z4P5l6QTNdtz1WcCJrErUjBdPlu3oKQTRkbrvAQyQuadRDL1VSXQLmQOqq8R1t3qyU
	 nv//FDbnnYnc5CC0fU4fVtlS6DO1P1iGv27zZYteALs+A71yxJVt2cK6E/tu7+6zYV
	 nhPNFOit3AnDjtUGEOBbAtVwzZH56Ly6FdOxR662xolJ3r9swTVmMyQwhcESvGoZoT
	 AmgLcGgeeFbAWBVt/Mbmws8zLxfg4ojJfAxp5gPczUJx0lZF25OmJL6HSviE1B6O+/
	 jwCPqf/41ryxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97D22C43335;
	Thu,  2 May 2024 21:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/2] Bluetooth: btintel: Add support for BlazarI
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171468363160.27708.13435730772840687107.git-patchwork-notify@kernel.org>
Date: Thu, 02 May 2024 21:00:31 +0000
References: <20240502052356.2630798-1-kiran.k@intel.com>
In-Reply-To: <20240502052356.2630798-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  2 May 2024 10:53:55 +0530 you wrote:
> Add support for BlazarI (cnvi) bluetooth core.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [v1,1/2] Bluetooth: btintel: Add support for BlazarI
    https://git.kernel.org/bluetooth/bluetooth-next/c/d250f0cced62
  - [v1,2/2] Bluetooth: btintel: Add support for Filmore Peak2 (BE201)
    https://git.kernel.org/bluetooth/bluetooth-next/c/93ff8ae40fcc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


