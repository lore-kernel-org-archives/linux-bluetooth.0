Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734164A3869
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788544266; cv=none; b=erPP/J8AjODiEKjfujll3yDqrm3QxE1GX+QzKhv0NeO4ijkE7uLfAmyQ77FSN5Wv+Pg3GZeD9IfkIBIENs+PwCKyFXmNlNVUHopBpJMVRny1dINTDMslkV6ndMHAfknKcY587F2IR/V0jLfjEV2DPJ3DFAZBffzepesALKHb7PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788544266; c=relaxed/simple;
	bh=6fwERCkywiDQIkxbnvy6wx/j+KeNADesmILPf3Z1CK0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=soxw/3t9j+EgmWipH64LdYUuVa/JTrkuvYZ+psoPb5EkG2/CR0S/8iAx9T5PMakXRBfKfPrkImn/2/XdJ/gNwLt4Ip63YkESivN+/wyTQ/pzuCd6tM9tIyPbmykSc17REjRzmfPmE/Sf8V63+NRq4SXdqZd1NYq04OkNd+BR/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kfopku/c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kfopku/c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217E61F00A3D;
	Fri,  4 Sep 2026 17:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788544265;
	bh=PfVFda8MjhLpWDdjcr29NF+5y9dONCF5meTvp0G+fh8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Kfopku/cokrNttNVWOB63W7SoAqtEbENCCuDoZ5TBoLcVNCZQedq1xDjsIKYQt7Y+
	 nWHVpoM80v+/ESyXl2TfardACq/LG2KRju52UK7onihbnT/rx/ue7dZNadn/UWGMQ0
	 CWOgnslC2/D8uZP4pHUmm1IEoz9Z+3k3vCH5saTtVVQE4R0t+wZcN7pTBsgX/pIfSY
	 A6PpvlWP/w+V+t7qldGPM2YlPyxlqm3BF9qFCj+VTUfEryd7/uTyl8I/Wyg2zBe15O
	 1c3R9iism+kSoORBL+fcv4ZNbwW6svoGeEdrJN4+yj4cNzS0yGClaD7jNu5K+OXC6A
	 s+KnrPIWkO+eQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198AA3924A5F;
	Fri,  4 Sep 2026 17:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 2/3] Bluetooth: btintel_pcie: add MDBGC multi-buffer
 DBGC
 allocation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178854420566.463198.14005383653530534379.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 17:50:05 +0000
References: <20260904002939.622659-2-chandrashekar.devegowda@intel.com>
In-Reply-To: <20260904002939.622659-2-chandrashekar.devegowda@intel.com>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, kiran.k@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  4 Sep 2026 05:59:37 +0530 you wrote:
> Newer Intel BT PCIe variants (Nova Lake SCP2 and PTL FMP2) require
> three independent DRAM debug (DBGC) buffer pools instead of the
> single pool used by existing controllers.
> 
> Factor the per-pool buffer allocation into a common helper and add
> a multi-DBGC (MDBGC) setup path that allocates three pools using
> the fragment context format. MDBGC is used when the device reports
> an MDBGC-capable variant; otherwise the existing single-pool DBGC
> path is retained.
> 
> [...]

Here is the summary with links:
  - [v2,2/3] Bluetooth: btintel_pcie: add MDBGC multi-buffer DBGC allocation
    https://git.kernel.org/bluetooth/bluetooth-next/c/61f725843b50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


