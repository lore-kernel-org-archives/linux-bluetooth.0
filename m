Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6102E34EEE2
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735445; cv=none; b=sCM8qd59ZK/NdC8tmoKjG13NCyorBLKYA1qv0wEc8fkaEM6+6QqGqK8XjjCa4lJ+fEQSDdtSHj05oQr+4xaSQmWvm5vn1AnurJ3NeipM7rRiAPtbx0iPaEZPGHzIXejwgzNX/KfBTNo6JyZPZMbTQF25GEPSneAEJsHsDwxL4YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735445; c=relaxed/simple;
	bh=SdV+j3JiV/oNkmBrjgcunRXXcyMRM/t6OdLB6W1V2i4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WsgmmP06Ge014t1ciHzUeZydP0ee7Bnl/YnizED386TC1g8BxLTYd8OLKkEb0dV0dFxeq1/BxTeDDs2jTCcIu6MXsLAQd8LZH+YRhP8G1hpbwLpUA/7pVmSV7hA0Sc0nxBqi5DXX39idWPhoEHl7osL+T28ONfawkeKzfUV7fvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvOekOqz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvOekOqz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39F7C4CEF1;
	Fri, 21 Nov 2025 14:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763735445;
	bh=SdV+j3JiV/oNkmBrjgcunRXXcyMRM/t6OdLB6W1V2i4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VvOekOqzNYPuXhJ2IrLega7bDRNVbz1IGBpG82gss0+061oiC/74RexLD6kYE05uK
	 j71B7Sei5bPLYa9+CrCnIY7owoxVPlXP9/2ELBN0kiiqvLjwutfvnPVo5xOpw/jIyB
	 LTJx4+A5xpj+JVdUaLyCxSNejZIVvMnqhrhbNQMdQfm/lYNJH0pPvZJFpuzzcA0LtJ
	 lVQFWOS3ELn+rVMnU0kLPy75ReTyWhWFIcukP3mA0Djxgk/mIMkaaPOdU4wTn8hnML
	 V2miO+V7ymd8w8sWTn+LOmx1F6DaUG8BFACy5cTpsJXyHsjjkfPxhLrBkftiiHtV0+
	 N9+E40XzdhbuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFE43A55FBE;
	Fri, 21 Nov 2025 14:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bluez] client: Fix issue of bearer info not printing
 correctly
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176373540977.2451256.7122543895977949126.git-patchwork-notify@kernel.org>
Date: Fri, 21 Nov 2025 14:30:09 +0000
References: <20251121-bearer-info-v1-1-f38dc0cbbbd0@amlogic.com>
In-Reply-To: <20251121-bearer-info-v1-1-f38dc0cbbbd0@amlogic.com>
To: Ye He <ye.he@amlogic.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 21 Nov 2025 17:16:25 +0800 you wrote:
> From: Ye He <ye.he@amlogic.com>
> 
> The device proxy was incorrectly used when printing
> bearer properties.
> 
> Signed-off-by: Ye He <ye.he@amlogic.com>
> 
> [...]

Here is the summary with links:
  - [bluez] client: Fix issue of bearer info not printing correctly
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ae54731047cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


