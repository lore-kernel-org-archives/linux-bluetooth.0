Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5575F27602C
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 21:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767820409; cv=none; b=djh1FT4LZ9jtWm6SdoIc36fHOfi5G1OU5pql7F4jeiC6cVqqsMlhZsXCB1owcsCj2nvcrqvDQ/6ULovYbnpaYrrESlYmjDm/NNxkrD0T7t1CecWWEQFDaZd+UQBH62MbzdyZQhWxIkubT4R5F41gk29VvBy8PcTdEHHCfU2lSxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767820409; c=relaxed/simple;
	bh=AOeUsMXLmsFRbDWapb+uuLhd8GzUH3Lc21sGx3/2/LA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=smzvXZlIDcykC1YDkTFpI8jyc82dXL0JCN3o8KM9bzI/EminP2sVt/tY4RvaTKceyb1sTHbueU4e81ulS1xUylh82ON7YHobWdZy824OLBEd6C6aHr4GwND1AfEyUnVoTSb3JSeAld61BT6Cy7HpslNHtazG3V8+GVKtqZ/vK90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKjCE7sR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKjCE7sR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4A2C4CEF1;
	Wed,  7 Jan 2026 21:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767820408;
	bh=AOeUsMXLmsFRbDWapb+uuLhd8GzUH3Lc21sGx3/2/LA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UKjCE7sRGoKFQKWAqAcoPuLtYgAdfXfE8d4b6bAufh5uzX8Y7DOpetFDjZ1Htn6m4
	 Pf7QMKGiH0/L7MPBSBXBxRT208/UFabQ4nFOCUqE3sYxDSSqkGs//wQjx3lWVH/iB3
	 IigRoG0DXpVhkRPnmrkjPhTl0gKhPs/Fh++k9nrzbQm/xa/6AaAOEYUw4W6OVRMha7
	 5EbH2quE13vhIL47OBvjSgUDAn3eCk9epjOBHtFtZ4QEniEviQUqdFkki2STD0Re2V
	 rt0D1i/TZWs/xMI5VAetHTByLaExcmGcpw0vu1wnV1cYHtXg9ORI/YhIFCuH/rTgnN
	 HzNtUQ2OKvjlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2BB93A40FDD;
	Wed,  7 Jan 2026 21:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] lib: Rename bt_iso_io_qos phy field to phys
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176782020579.2982139.5033707749337353004.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 21:10:05 +0000
References: <20260106200913.3419162-1-luiz.dentz@gmail.com>
In-Reply-To: <20260106200913.3419162-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  6 Jan 2026 15:09:12 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This renames the bt_iso_io_qos phy field to phys to emphasize it is
> actually a bitfield rather than a single value.
> ---
>  emulator/bthost.c         |  8 ++++----
>  lib/bluetooth/bluetooth.h |  2 +-
>  profiles/audio/bap.c      |  4 ++--
>  profiles/audio/media.c    |  8 ++++----
>  src/shared/bap.c          | 16 ++++++++--------
>  src/shared/bap.h          |  2 +-
>  tools/btiotest.c          |  2 +-
>  tools/iso-tester.c        |  8 ++++----
>  tools/isotest.c           | 24 ++++++++++++------------
>  unit/test-bap.c           |  2 +-
>  10 files changed, 38 insertions(+), 38 deletions(-)

Here is the summary with links:
  - [BlueZ,v1,1/2] lib: Rename bt_iso_io_qos phy field to phys
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9247623a8d14
  - [BlueZ,v1,2/2] shared/bap: Fix PHY fields being treated as single value
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=561d4e815f28

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


