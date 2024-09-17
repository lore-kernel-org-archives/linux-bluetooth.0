Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81AC187FF5
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726582834; cv=none; b=pY58cBkg2x+1cs231+hhnE5sXJXIYq7NBUIFgcVkSvNo+ecc5O0eOZbeV7BbEQxYKwOy7LmZDFcvCMiwMwb+SV/Ob/NruUqrLaIC6Z7pUQriwC+qLhksY3FxJzLj1vBsRDfwYr6vAZy//TeuUYQk6lNleR5LqNONPr3aEmn10E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726582834; c=relaxed/simple;
	bh=Tf8oy/4iV4ZSMvCeAOC0tkJyOdrhD052G0vy/dr/2WI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dRrRDxyeQ+R3NMuve6yCGRNc06emrZ2Ka08mFSu3ZF4pSHM/MkYx4IQx8miItXB6E02Px6EIgLaLk+BJDRtAjVyIz8ao6s1/JDhXa+tlegCIh5xb/2G7NCTz8tUs2VFvAeDQPDqkGExB/W+Tq7/ekOOglzETYFIcgaj2q6Qru+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4fSEnLy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4fSEnLy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E71C4CEC5;
	Tue, 17 Sep 2024 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726582834;
	bh=Tf8oy/4iV4ZSMvCeAOC0tkJyOdrhD052G0vy/dr/2WI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R4fSEnLynu72993Zd791MfO97eV041cyYharqwN1OKnNRWiNUcM7+xIOLZdYT6OCZ
	 pMK4Sdt2BimSxEtnN7gxUUJSde0yRi9y4eVSQDXV9Cv/Q9ehbtvU3zM3xtS7eWU8EF
	 xmnLKn//aRgNyY/A/gGpMcxaXwpcBZJttMszUmdWt+RI5A7IH/ahHhQGI3t6AHDa2l
	 4mVPYlqy8NdPUgje2OSx9JWpHXk11rmtIkISHVwgweGKEfw0VDh4kgCAKIESV6CCiD
	 KFLHi7xZLfd+8D+frc9wOizzZsx4xuD7FRHBuaZcDGjGy+rzfkA3HGcMqlWeknQlOr
	 T06ctCKITB9Vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F563809A80;
	Tue, 17 Sep 2024 14:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] shared/uhid: Fix crash after
 bt_uhid_unregister_all
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172658283625.155805.6796687178662331438.git-patchwork-notify@kernel.org>
Date: Tue, 17 Sep 2024 14:20:36 +0000
References: <20240916202341.238735-1-luiz.dentz@gmail.com>
In-Reply-To: <20240916202341.238735-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 16 Sep 2024 16:23:40 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following crash which happens when
> bt_uhid_unregister_all is called from a notification callback:
> 
> Invalid read of size 8
>    at 0x1D9EFF: queue_foreach (queue.c:206)
>    by 0x1DEE58: uhid_read_handler (uhid.c:164)
>  Address 0x51286d8 is 8 bytes inside a block of size 16 free'd
>    at 0x48478EF: free (vg_replace_malloc.c:989)
>    by 0x1DA08D: queue_remove_if (queue.c:292)
>    by 0x1DA12F: queue_remove_all (queue.c:321)
>    by 0x1DE592: bt_uhid_unregister_all (uhid.c:300)
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] shared/uhid: Fix crash after bt_uhid_unregister_all
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9a6a84a8a2b9
  - [BlueZ,v2,2/2] test-uhid: Add call to bt_uhid_unregister_all
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f9f98c0b2aa4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


