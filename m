Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869757EEF3
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Apr 2024 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402231; cv=none; b=cQywdEgWagrHnEgDIvH8baicsG1jHORA/bqvgKzixzVj3UIN7WI4hLnD/KrCDQ4gbcbcLZ13XtaSXuuOgmUxivFYhh9N1+yOXsZflOT8fSq6Ptn4KFjkj2yVL/UkSNnbseNSbMLVVRYS7LvQJi0FUIqH2iaLsADqZZrNdOKghLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402231; c=relaxed/simple;
	bh=tUaSwmcL8uXoHLRPxAr4iCEEj1FiRVSshFfuZMTDQGA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mjXHecUac1Aw5JmPBHnQotJi/Mj/yh2yi3s135UFajFvp87z22h4PMJ1PmarH+427XMVBm2AE/h1975UXCSHIcnAUcMZLO6uLRgS4j8k6MwYTcV+O1+khHaP5sEEa96NeWbaNHhCacgfVJ1NHNTDWcshI8KSgEtLO3vUlZwSI4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NigKeNkx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NigKeNkx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FF64C4AF14;
	Mon, 29 Apr 2024 14:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714402230;
	bh=tUaSwmcL8uXoHLRPxAr4iCEEj1FiRVSshFfuZMTDQGA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NigKeNkx/3iHIIh+2x/eLBebVHe8Ekizf2wdZSTLXps8//GErsKc74/8xPSV58ZLg
	 lS6+ph8GQsnB3NebMHYeNBh9+cJJBlyR6pPT5AQnlWDc67naXRXTpPPSBXrJl+ik2Q
	 WwT1xQ7xvAnFpD9UkGQGRRpmszqW3Cx1RRevMGO6fvxl1rH1rw9S681b690r9yUrDH
	 TKHCWWlOmPkhD7ymyAKKQKgi/JGd/RHYqKx7vVD1OWN/64dEoGI53QXeZ3brLe3Txf
	 U6XnwJM8Cmu9EU63FJt1HulYugrN4Ijkz5isqonYTMTarMDSxd82n8riCtwfZTA0bM
	 6lH/yRhquLPVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2CD9CC54BA9;
	Mon, 29 Apr 2024 14:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/1] Fix null pointer deference in bap_get_ascs()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171440223017.10266.5614590080499662181.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 14:50:30 +0000
References: <20240423074426.62480-1-sarveshwar.bajaj@nxp.com>
In-Reply-To: <20240423074426.62480-1-sarveshwar.bajaj@nxp.com>
To: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, vinit.mehta@nxp.com,
 devyani.godbole@nxp.com, mahesh.talewad@nxp.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 23 Apr 2024 13:14:25 +0530 you wrote:
> Ensure that bap and rdb pointers are valid before accessing or
> allocating memory for ascs. Added  null check to prevent potential
> crash
> ---
>  src/shared/bap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v1,1/1] Fix null pointer deference in bap_get_ascs()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d2a2aabee646

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


