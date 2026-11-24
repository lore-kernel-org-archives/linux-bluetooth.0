Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552813;
	b=pdSq3kqziw2EMbnt4cn/6EI3VCMplE5bSJFCfrqaR5GDo8csAFzpThx5chMfu4jW6OPq
	 OGHWnfEI7V5U5FPK73TzgZgDITy9Ci2z5cro1cESYXdL7LxY6J6Ver8kBTXxnpW8558Yt
	 2GVddHC8wxlIMU91MokSr3z0N4Y5V3k2ym/zzilCv9ENwFtCa03a6MgmMk7CGnhSa+dV8
	 G5vpKRrD4zFVj9ZMcYzmP+XAI/0rZH/X6dOWi6yzBj4ufjw33N2XaaUtQHG5YQtaGMWMf
	 PbgitT8K1uPj49HQiOxNqrpNltPa8cCVKS+BcRh19zRLNtFOjoGohhWHtK1jt/zjZCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552813;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=86ozVZ+oUzs3w9kiQoUxHjeLxjCgJyHhgm/fy/qjftw=;
	b=veYAPt8/xoDci4Fpq1U8ioKPE4lHhWKfw79Tj+GkMP3BRQhN9usNSUSFieU+rQhfQMK6
	 COhYibBVznQu6kgev3oJGRhJfmRjNgH9iFb0mqPIy0z5oLCtlo5BpTeTG/78iC6Cwjwao
	 q49iSD18HnhhiRThcVVn03GYR9gr0Du6426f91qKZiLcq5i0gDSCAm1+aqLK/NDYR9yeo
	 4iRIU4jt5R4sbtoAKiZZneS2M7q3i1kqwXpyfEAO9Q+xFAin75rP58AozVnHEgZb2QIvI
	 ApkmfRONH7K7cNglxG1fUIEKlj0GNtVU1FuiqjOY/hyNbtQSd2nzP2S6AAmj+Seyelg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HeCX22nJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB5D606A688
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HeCX22nJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813E41F000F0;
	Tue, 24 Nov 2026 20:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795552813;
	bh=86ozVZ+oUzs3w9kiQoUxHjeLxjCgJyHhgm/fy/qjftw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HeCX22nJLhy108jV7yWzdeoh+PRgSOzAUZYg/Q/29+McOodLr8dgWhi3h8xRRqVL2
	 Rqt33qXjtOHGjcOEiWbXLqURbrRDoXLXFNxVhCwp4BPR1KG4LsYqk5j3oD6wuDCvYT
	 NaRwFWyevfWGaeGp6E4rGme0GRd+KEeq46Dmh4u4ChjvY1JxApBT/If1qWIZfDou/M
	 4HG0JFST472RBJVufBS/e3HgoXgDPtB+2+08/lYAVEzneKoQBOMeP+Gvu7PZcRxCyc
	 x7pNGDfkbmqQQMnCHDh8OdEubq/ubJhP88pFvX8Kkkzt9EyR3Z0kJK/Oh3sxlGOitd
	 dRLS+w90Pw+zQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7744C3808209;
	Tue, 24 Nov 2026 20:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: btintel: Add UEFI BPMO support for PeP
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179555281202.41195.14026446846487771844.git-patchwork-notify@kernel.org>
Date: Tue, 24 Nov 2026 20:40:12 +0000
References: <20261124055627.250718-1-catherine.l@intel.com>
In-Reply-To: <20261124055627.250718-1-catherine.l@intel.com>
To: Catherine L <catherine.l@intel.com>
Cc: linux-bluetooth@vger.kernel.org, kiran.k@intel.com,
 chethan.tumkur.narayan@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 24 Nov 2026 11:26:27 +0530 you wrote:
> PeP and later CNVr platforms allow the BIOS to supply a per-modulation
> SAR offset table (BPMO) through the UefiCnvBtBPMO UEFI variable. The
> firmware subtracts these per-chain, per-modulation offsets from the
> BRDS limit, giving finer SAR granularity than a single limit per band.
> 
> Read UefiCnvBtBPMO in the UEFI SAR path after the BRDS and BSSS
> handling. When the CNVr is PeP or later, UEFI BRDS revision 2 is
> enabled, the SAR tables are locked, and the BPMO revision 0 variable
> is enabled, write the BPMO enable flag (DDC 0x0359) followed by the
> chain A (DDC 0x035A) and chain B (DDC 0x035B) offset tables.
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: btintel: Add UEFI BPMO support for PeP
    https://git.kernel.org/bluetooth/bluetooth-next/c/68fc6046376d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


