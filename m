Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF4E189536
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 09:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504038; cv=none; b=rVfUMzSycC2Q8H6YiGI8b5XRdPU6RnGENCpO5whAQgpCaAxwUlDIq97I61AULq79+3tgp8L4VXVbkoSgRW/+7/v8txeRyHtCi2cgFVGpgHkobI1x/TAKCfijk8qcYBgLDMmMxdq5nggjNZZrs66Go9SmHclw/PJ8sQ46bXk4bk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504038; c=relaxed/simple;
	bh=ozDPzhcpKfLeyKM6X75QqPco/i8VheiMKhA9zlkRTSQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FgKeFvUrHRGhVB/3i0fIBSbfXttotSrFcNT5tt33D+BSPkpnLzif9xTPuWYQz6XeHxQJPT+Kxh3tJIHzn7/y9Kfs5wVYz/FNocFjB+wUiSZNVBXZMsq7Kq35Ri2HQAEih2nMxlZcaboTNdgCtBSbJHSUix00hz7M91IDXPB0fiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcPCF/Je; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcPCF/Je"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46561C4AF0B;
	Thu,  1 Aug 2024 09:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722504038;
	bh=ozDPzhcpKfLeyKM6X75QqPco/i8VheiMKhA9zlkRTSQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OcPCF/JenL9AJZpyFwI4NAuc2B/FjL1PAI7I5lrT0Ajsn1+y0RFoDksNYK5n6tNzu
	 R+dmXQKe7s0A55QT/SVANGzkmK58Ix8kJ4pKD5xotLuDXH4S4b6FbgjChXas9QySXa
	 pmVOAe34NG0u+/avcaMq1bWVHre/U9kTEnR+jqXxp8P1RainrgLyFxt0PfHqEN/f/I
	 3+yL/AUKANdFEl0cxzQOAPnd8/L0dQUKCppNwF170y+VCy6i27Rr8ozM8n6710vxN/
	 VEzt4Jsu0kHV2ghWhIGrP3wZ0U8lFmtDIhZxam1zW/aXLtmnU0HQFhY7hMyC5N6Jo6
	 j8fgKm4Jpl6Dg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C134C43445;
	Thu,  1 Aug 2024 09:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v5 0/8] Add 'broadcasting' state
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172250403824.1152.13634174812370548618.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 09:20:38 +0000
References: <20240731061713.435586-1-vlad.pruteanu@nxp.com>
In-Reply-To: <20240731061713.435586-1-vlad.pruteanu@nxp.com>
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com,
 iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
 pav@iki.fi

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 31 Jul 2024 09:17:05 +0300 you wrote:
> This series adds a new 'broadcasting' state for transports created by
> the Broadcast Sink device as a result of scanning a Broadcast Source.
> Such transports will remain  in the 'idle' state until the user
> selects them, at which point they will be moved to 'broadcasting'.
> PipeWire detects these transports and automatically acquires them.
> 
> The transport selection is done using the 'transport.select' method,
> that this series implements. This allows the user to select the desired
> stream when running the setup with PipeWire since it acquires any
> transport that is broadcasting.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v5,1/8] doc/media: Add 'broadcasting' state and 'Select' method
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d7b7f3a39562
  - [BlueZ,v5,2/8] transport: Add 'broadcasting' state
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9357edb87bb9
  - [BlueZ,v5,3/8] transport: Add 'Select' method
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=083d1a7b66b5
  - [BlueZ,v5,4/8] client/player: Expose transport 'Select' method to the user
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=61e16e3b8317
  - [BlueZ,v5,5/8] transport: Broadcast sink: wait for user to select transport
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=53a4078cb350
  - [BlueZ,v5,6/8] doc/media: Add 'Unselect' method
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c7e79fa8bfff
  - [BlueZ,v5,7/8] transport: Add 'Unselect' method
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6ee75c3ec383
  - [BlueZ,v5,8/8] client/player: Expose transport 'Unselect' method to the user
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=827416638289

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


