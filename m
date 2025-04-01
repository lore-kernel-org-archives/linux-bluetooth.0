Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38300F4ED
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 21:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743543598; cv=none; b=XUjVHqAuYIfXYY4DPShiWGow19iEbSWnMXBrL1RJrtFHw2VsmHv/XZe8dtD1fwCJDNxPIdgKnKj3yOtk1U9BCcBZyHyj7RI468jvpnLSLABrDwVuuOODUYGxIMY2xcrRA1nN1P3uMT+nw77lBOMwEp7TYnWm+ZwE8Un2ZRfXbIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743543598; c=relaxed/simple;
	bh=2gwaJAR7TeSDyKl6/H16Y1RebtGD1sw6qjnB7ZgRzEU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CED98OmV/30qItKQNkKswMEBzcxkviCJlraXkVE/SmRyBaErWYw+NJoEdy3Dacyi8kmjH6M2A2CMfuYG4YjxIG7q8QQeLkERmJP7A44p5+MA6kL63feDbuhgUDCwZf6HRtcAp2IPqAwzhTzTozSsst5bbgYnOMgEjN0FkySZw+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnRrPlfk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnRrPlfk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDADC4CEE4;
	Tue,  1 Apr 2025 21:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743543597;
	bh=2gwaJAR7TeSDyKl6/H16Y1RebtGD1sw6qjnB7ZgRzEU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CnRrPlfkjTKE6T8BM1cvxg1hP5/wqoEi5BAm5iLqlt7u1a7wkz89ZTJFoRBCVLJI9
	 oQ3lyomjyYgvCOzlqzqT3oSX7LF9oo/NIcaCDhLtUMan55nwa/5lAmLZwF0W4aODkC
	 dqhCcAspQCKjpV3O4ciiLl1LMoPy4LfbFXgdbyfadaYwas1FGWjFBXRIqQDPVFzIEE
	 7CrUz1SxcCE2tENndPk89+fKA7R1NRAp8QtDbqZYZx+LwyCGNw7BgVlzZDnL66Tnqr
	 OMRkMC3HL/STDLLTmkgFGfffb4QWtTyOxmnfq++r2TJvbpPqeN/myvjMuIP6mqedkj
	 9Jl17KRF/oo6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B0322380AA66;
	Tue,  1 Apr 2025 21:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] dbus: Fix condition for invalidating path
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174354363454.930303.7357854694910048647.git-patchwork-notify@kernel.org>
Date: Tue, 01 Apr 2025 21:40:34 +0000
References: <20250401134904.3721187-1-luiz.dentz@gmail.com>
In-Reply-To: <20250401134904.3721187-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  1 Apr 2025 09:49:04 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the condition introduced in cdd02afbb7ef
> ("dbus: Fix add invalid memory during interface removal") which was
> reversed while applying the original fix.
> 
> Fixes: https://github.com/bluez/bluez/issues/1155
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] dbus: Fix condition for invalidating path
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=da5846c096cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


