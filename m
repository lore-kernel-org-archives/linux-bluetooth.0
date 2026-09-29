Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBB053CA8F;
	Tue, 29 Sep 2026 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694626; cv=none; b=ORQU5kHS3e2Sq3oczX1VMhB+ZePPj2oK5rUKZDsLcv6Rur0cV9uXlP7kYcrMFIkbfuZjzioeLYBymM9hOHiqOSvuqsMWejwjQ9RfpdVFeu+j0NxJBypnyrZMqtCI+AEjR2KXZA7K3QwMNA3dsltu0INLrsewfgKKM1LGKY0+yBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694626; c=relaxed/simple;
	bh=Dm55oRNo/2ZcubdkT3ktxKTA7Ab2EfXTOBSaPIi3cfM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WW6DJaK5hRRtf6b6Cx9vytaLvbls1EOxaMrppxOcjdmhyil+xL3bZqupk+vwWwrnzi355V6/pLstgyjdD1WdAqKpYWeoj5bWEjQD7gVyLCH/vi/oA53JUsor/upKnkNsBf8//pbfInuk0Rpt/Dg4c9P1fbllJ4F3TJ2JUgWYcu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJPn0EL+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJPn0EL+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800F41F0089A;
	Tue, 29 Sep 2026 15:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790694616;
	bh=fDZKM69ADP//OxLvoi/1DqGw7bDmqyjFFtd/YUsa04Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NJPn0EL+gJnvno4abjdyrfkEHXz0fLcoZzOxEsTCG4iJu4RQcZcGplhMsifbK4sNh
	 d1RVqbTnNgHraODRu8Lz8Hu5sl06u9WgDLzRcKC5wDxaTChHZjhIPQkfOmaKmurVWD
	 lPUMi6SMfdfPfxFV7wuuyjYYvsngSkUSkQvf4/HG/jOlJdMH97m3Hajth285U2+s1C
	 qtYJQEUjFQwp8f5SnKnGHx+esQH+aNXDc10bow4RZOJaYIBHjdcnkELXXlE84hgpfG
	 V+qKQ+bfGf/YzvCniAAU+CM3707U32+BZZn7mrrefvwpXe1GCJYITWY9fN+ttQryvH
	 0PNAzMeIk7png==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 772F93927049;
	Tue, 29 Sep 2026 15:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Bluetooth: btintel_pcie: two PM fixes,
 assembled as one series
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179069461502.983246.6739474420030801580.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 15:10:15 +0000
References: <20260909123416.71919-1-lsa.uz@pm.me>
In-Reply-To: <20260909123416.71919-1-lsa.uz@pm.me>
To: Sergey Lebedev <lsa.uz@pm.me>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, vladimirkondratyev2@gmail.com,
 ravindra@intel.com, dev@lengyelf.eu, chethan.tumkur.narayan@intel.com,
 ravishankar.srivatsa@intel.com, pmenzel@molgen.mpg.de, kiran.k@intel.com,
 chandrashekar.devegowda@intel.com, mahalingeshwara.chambarakatta@intel.com,
 arnd@arndb.de, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 09 Sep 2026 12:34:25 +0000 you wrote:
> Two patches already on this list fix different halves of the same fault, and
> each leaves a real failure behind when applied alone. This assembles them into
> one series. I am the submitter only - authorship, Fixes: tags and existing
> trailers are unchanged.
> 
>   1/2  Vladimir V. Kondratyev  - re-read BOOT_STAGE_REG before the fallback
>                                  check, so a missed alive interrupt is
>                                  survivable
>   2/2  Ravindra (Intel)        - fix the PM flow for S0ix, S3 and S4, which
>                                  among other things stops .thaw running an FLR
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
    https://git.kernel.org/bluetooth/bluetooth-next/c/20dfccf8d854
  - [2/2] Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and S4
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


