Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3626819C566
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764946989; cv=none; b=YOnqGLsNcDKqh3+5GiOVsLYmleyjjOVENQYEWU1WsGga2LugdRO3690c5f37u6BbX44IEAoiCgfMFlQyPaiq7Tbpi6OeXyRBqZm5wTP6XYAEYWOVbyj90wnjLqlEbt7+vf+hBAthSGrGQR85utbYju7nMZzHqncTHktUlsV47xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764946989; c=relaxed/simple;
	bh=8j0GxRtOlNsh+KMHU6/B3f634wlyM4KDYu+TNiBg+ys=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GAFm47z3Oc9Jp37WsEsj4bJJx9BAmfs0VR4lhuGT7MzBELHEX5zRfRkEMARkLh2Bei4uPaLYZa9ziNnxk55BkxAyQ3bIZU3iHTziF33M+ky+lRgZd5HWPqvNpmwXS4OSIktyXaqfSrwdU2qKblSWGGUUjuA1BSWbtNLBMMZY0uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIpjcr5X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIpjcr5X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9030DC4CEF1;
	Fri,  5 Dec 2025 15:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764946988;
	bh=8j0GxRtOlNsh+KMHU6/B3f634wlyM4KDYu+TNiBg+ys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fIpjcr5XcoQ3tkdlW9p9YdZWtOv5vMZeQbgetcgU29jjSPI8cNikVMJ3DxTJ0NwHZ
	 gB65wNkYSaP2qrPhF7GbYGuNVdqdy2PMlpaJmHzPh6658t7Rh2GN52ngxkInb3akxF
	 zXKWCd/J+vUCe3OOou1zdeelZtL4jec5lTqwAqYVwi9IEJPKdhWfycJoucEsNH0qKW
	 b7CT2Bp4/E8iBA2kFsRO5FMDMo00ukifYbuu8aKfPKz74emRm96WSt9fYXaj28o3de
	 48K3YSSSaasAPRNIm8sOO8j8kpofT8QsgAerMMaJ7CHKCkgc2IkJLgO2GHcQnN+MJ0
	 jsNtlhT0+S5DQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78A213AAA0C2;
	Fri,  5 Dec 2025 15:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] main: fix bool vs. gboolean type in
 g_option_context_parse()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176494680629.1671663.485819958976897672.git-patchwork-notify@kernel.org>
Date: Fri, 05 Dec 2025 15:00:06 +0000
References: 
 <36c55de961b5b5ceda83c019ec511f8fa7cd44b6.1764880521.git.pav@iki.fi>
In-Reply-To: 
 <36c55de961b5b5ceda83c019ec511f8fa7cd44b6.1764880521.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  4 Dec 2025 22:38:09 +0200 you wrote:
> btd_opts.experimental and testing are bool, not gboolean, which may
> cause memory to be clobbered and crash.
> 
> Fix with separate variable for cmdline option.
> 
> Log:
> ERROR: AddressSanitizer: BUS on unknown address
>     #0 0x0000005b9914 in queue_find ../src/shared/queue.c:230
>     #1 0x00000057c0ff in btd_kernel_experimental_enabled ../src/main.c:721
>     #2 0x0000004ff52f in read_exp_features_complete ../src/adapter.c:10230
>     #3 0x0000005be40b in request_complete ../src/shared/mgmt.c:306
> 
> [...]

Here is the summary with links:
  - [BlueZ] main: fix bool vs. gboolean type in g_option_context_parse()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c42a49a243e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


