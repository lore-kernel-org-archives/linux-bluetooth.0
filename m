Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6A427702D
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 18:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753727392; cv=none; b=gtBINzXaV7v1mp4uYCjN2PmHJeTTC+kxungoPN2U4UZrK0fF8c+qTOBzX8TuyDZUv42R2B41jep9g9uvdzz5/UrCzIpVilkDhH2HAFV2Ni9SwM72JY4//30l/+ptHzSxbYh3aQQQiMv/0DVI1RlxsoFu3glPAhNAvg44fqFW+ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753727392; c=relaxed/simple;
	bh=U6AnCZaDBd22Mry81OeBcSNvXKN4A3PMX8C2YqORMxg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YvJsuF+ODBAOFtioaDPRgYeS9komtxsvKALcWmZPBeCgdJozTpg05ZhrMaiReK1Newb0ksD3GrqR2GD1z4l9GeDxbE/s70SjsTcoohou7AKku6JA+1DobJaSGDiT2x2vHRCnMayw1fzsbhaHmTwsxTfRgaqkkKxxXEQm24PM2dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKPQPPxF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKPQPPxF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8728FC4CEF7;
	Mon, 28 Jul 2025 18:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753727391;
	bh=U6AnCZaDBd22Mry81OeBcSNvXKN4A3PMX8C2YqORMxg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mKPQPPxFfIgIEo6lkN59ScszswymEGyK1lPiiuRNk/aQGxMukO2R15fS6Nzmn2YPr
	 mhMDabXdeRbxbxh+9/ed50tneNdaNdQ3AualDBENYLYm9XPpidmP+OPE2xT/cKh5ko
	 r3aB68PajkhW8OU2i6ab4I0cXhGBbNE4oQHbdC6c6jJBurHr/9QAXqYSl21iBSVZCW
	 qzTpxznWAvooE7H8/hSro0aC3fStpePy5GkOdx3LqII+cvY33pordbGB3PeWYCHN4s
	 irvzeqK6MjX2B7OLb7usxRp5n//KI8c0b+Q8DajVnZhx3jgi5O5yXt8tamE9FIncIS
	 CcdlaNbkkEG1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5EAE0383BF5F;
	Mon, 28 Jul 2025 18:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] Bluetooth: btintel_pcie: Add Bluetooth
 core/platform
 as commnents
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175372740794.805186.395500413057948885.git-patchwork-notify@kernel.org>
Date: Mon, 28 Jul 2025 18:30:07 +0000
References: <20250728090554.1425120-1-kiran.k@intel.com>
In-Reply-To: <20250728090554.1425120-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chandrashekar.devegowda@intel.com, pmenzel@molgen.mpg.de

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 28 Jul 2025 14:35:53 +0530 you wrote:
> Add Bluetooth CNVi core and platform names to the PCI device table for
> each device ID as a comment.
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> changes in v2:
>     - Update commit message
>     - Include reviewer name in commit message
>     - Include the complete platform name in the comment
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: btintel_pcie: Add Bluetooth core/platform as commnents
    (no matching commit)
  - [v2,2/2] Bluetooth: btintel_pcie: Add support for device
    https://git.kernel.org/bluetooth/bluetooth-next/c/ce0fc419c2cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


