Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C4130EF84
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 20:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774471819; cv=none; b=kGz+Oe+hR6OUBLSxbLz2wlwCLx2qnLatfAInuKtJ9kzzXShlOcX9yJEPiYnNdVaSjymTZDUsERwvwQGfRIOoElkUF3X/3kqviTg93AdWmp+D5FiqI8vP3Fp4LcscbBQry7P2fUXnRK84utzHzXSKGtMG4jE68uttTwGD2zwIRik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774471819; c=relaxed/simple;
	bh=6G2rf5Uswz5VhZcCco6+jYeox6OHZI16suf9q/ewZ6g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h3/2GsoUqfJ2ZpdmpYftY35V/8gM1wyMzEjfaBokg2rOeEtif4wwo5JCk4AV3KjUveQsPpI73u/XMeOxCt1yAeLqpheX62Pk0uJXVBzMhdCXt3BlygFz5gpB12G0aSU9cuiIBT69EV/T8K8GnH2eeoaz5nTGW/jDXVn53RVt20I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3IGCasH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3IGCasH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C25C4CEF7;
	Wed, 25 Mar 2026 20:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774471819;
	bh=6G2rf5Uswz5VhZcCco6+jYeox6OHZI16suf9q/ewZ6g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R3IGCasHF6nTBequlVfIQGEAU5Y5Hb+gJ8jcbD83+ySZmwHjZWnxZyrxk4R/u6dHB
	 k+stdnI4QqvRbDSSKxCf680mRdrZDCzmZSDz9GgIZXsnmTd6+mMY5k4ki4+evN3WH0
	 ofoRyHFhHSnbFrMBM6kfqFt34xAKZotqYFKB0kIN4VSlcNwKNbQjPuyx10SN2mLeJc
	 UQOF8rilYAliU75ueue8LDcsPIaPtYTvUkDLB5IE5FBrSnycxYnOQ5lm9ERTjVALDh
	 nIo+sUYV0R0LXltZlYvuwBt2p/dFOlxhkQiYs2jG1TWBRQsmzyfqy+xLGwLLUIdS5G
	 +TeRg40Z4ucPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F2C3809A06;
	Wed, 25 Mar 2026 20:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/9] doc/btmon: Split Advertising and Scanning
 into
 btmon-advertising.rst
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177447180654.2200831.4372942658763587199.git-patchwork-notify@kernel.org>
Date: Wed, 25 Mar 2026 20:50:06 +0000
References: <20260325185406.568078-1-luiz.dentz@gmail.com>
In-Reply-To: <20260325185406.568078-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 25 Mar 2026 14:53:57 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Move the ADVERTISING AND SCANNING section into a standalone file and
> replace it with an RST include directive. This allows the
> btsnoop-analyzer to load only the relevant documentation for
> advertising/scanning focus-area analysis instead of the full btmon.rst.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/9] doc/btmon: Split Advertising and Scanning into btmon-advertising.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6ca24f69351e
  - [BlueZ,v3,2/9] doc/btmon: Split LE Audio Protocol Flow into btmon-le-audio.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d6e2bf9a3a2b
  - [BlueZ,v3,3/9] doc/btmon: Split L2CAP Channel Tracking into btmon-l2cap.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=042e211cd021
  - [BlueZ,v3,4/9] doc/btmon: Split SMP Pairing Flow into btmon-smp.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2bcd75cd75ea
  - [BlueZ,v3,5/9] doc/btmon: Split GATT Database Reconstruction into btmon-gatt.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d991284294f4
  - [BlueZ,v3,6/9] doc/btmon: Split Connection Tracking into btmon-connections.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=838c717f9dfb
  - [BlueZ,v3,7/9] doc/btmon: Add HCI initialization sequence documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=60a32f8c7517
  - [BlueZ,v3,8/9] doc/btmon: Add A2DP/AVDTP protocol flow documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=173fad8fbe9f
  - [BlueZ,v3,9/9] doc/btmon: Add HFP protocol flow documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=097196bf8a29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


