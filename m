Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7031D25A2C9
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Sep 2025 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903614; cv=none; b=HaZJ7AGsuZSGEe+7wIFX45tAFBPnhvbjEBCs7Hpl1ZLgTPsuJWodX1fs7AfoXHQdFNGwm46kEC/YAiXRJIB1nw8UdeUC80pQzKHlYtpDw526OFy2+FWqpzkupkYaSEd3T4WDvBGxQ+RP2sb0YSewOpia6/VDcZ18tDOTOXdMadc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903614; c=relaxed/simple;
	bh=TVNGNGrZbFBuUulfkTjoZDdfvMx3iiI6blUWHWQgxlQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MRFxZ9zeH9FwUV44SG6qa0sf38C5HcNvgKqHnQeUrRMmIhWqMR+8Drmtm25JLKFtAA1pgXFKD8nfafhO6abON1biyFlYQ3KsNtyQ+OUKL6QljfWT1898C0o0MBNsgrK60NKssaWkyBATXWw71cpwWLNXGXXOf6WCmjhKXtb9mvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjTCxWts; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjTCxWts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED710C4CEF4;
	Fri, 26 Sep 2025 16:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758903614;
	bh=TVNGNGrZbFBuUulfkTjoZDdfvMx3iiI6blUWHWQgxlQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SjTCxWts2cUMJ6DVTKm+qgJdfe48IGLnYN5wBMaIZUEn4Tv9EBzkxhF9I4IcUoJKy
	 iiv1GQ9/iAYgO1OUAIaZHSnk8Hfp7u8zBMfJrNdxPVi/fY3YGPJpX3XFORwbZYHqTi
	 9xnnSKg+YzWtJG18KQMMYWUhUd/8QP+UuiTWmSsJh/RGuFR7kTmcYpLBBNkJJPykID
	 P6gm8T5HiWg8t3RiAW1J/bIdUv7WGezNZoUdMbBwaX020DFh4VSL3KAmvUTZGmivs6
	 b/GrWIeGSfeFh4Htw3Mg6NFQ0ZGRKYFMoy4yEkX2+bJKGOBky9MY2YfBVseHNZ6roS
	 D7Cu/3Oo/WOLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C2539D0C3F;
	Fri, 26 Sep 2025 16:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] doc: iso: add BT_PKT_SEQNUM documentation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175890360925.4178284.6745075723287505386.git-patchwork-notify@kernel.org>
Date: Fri, 26 Sep 2025 16:20:09 +0000
References: 
 <5ad48176668987b22fb71be24cf4e478d0869dc2.1758360020.git.pav@iki.fi>
In-Reply-To: 
 <5ad48176668987b22fb71be24cf4e478d0869dc2.1758360020.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 20 Sep 2025 12:20:36 +0300 you wrote:
> ---
>  doc/iso.rst | 76 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 70 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [BlueZ] doc: iso: add BT_PKT_SEQNUM documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=04a8966972d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


