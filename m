Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E83B3FB06E
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 May 2026 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778268056; cv=none; b=N3chK9wTN/pEdbTcamixQ4aDKpJiALyIT4nyBqYXnFs35Tyq2j1J1TbPJlC/1vTAvdEUPLJuDYDNoszUGZvMDQiXJXKIfOl7cUF5p3IJopP+wOtLQ/5Tsz1jz5sWa/wQI9PLcCwLkd/b13HQBSvm2EGvFkK46eYhmy9JbQ4Ya+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778268056; c=relaxed/simple;
	bh=OeIHhU6o1l2/Aul9jS56txC82GtnMsi6OGf8KTaaz3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K1NSM+d5ypL0D3MeIuFoPPwh+xkmbug8wiHlFQk9cFpuFGiE6C0+CbPtRh0n8soWK5D51aThR3HVzqWzVUdoFN/CFahIip3/c6NZEFoC/mtzNsTMQnyOUZI2HCGQ4SMP0hTHqT27ehpLXgt9xbIp9wnTgWFNa9eZ6ifeODJl2BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VK1ZIvuE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VK1ZIvuE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41406C2BCB0;
	Fri,  8 May 2026 19:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778268056;
	bh=OeIHhU6o1l2/Aul9jS56txC82GtnMsi6OGf8KTaaz3c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VK1ZIvuEfG5nHzV5U3unoMqKA5Y3n/lfKxZ1BDU7fFJX/OZZiBBjEu9v9ksGrgZqt
	 j+G1tH1Ewh5mqQYQl7vYmMVUie7Cxw3XeAGmJvFgV1Q1p4MxOVFnXuTwlHSbSbOW/D
	 JEt92OnESpC2lFCm1EhtK+dGUrHmNInFOf9j956VoH1voziOb2ZistxGvDRgNb1SXr
	 SnkuGoK43m/dB528/MCIwYiHe5jS4ldVkrDo9uByb72PCH3wchRlL3lTp62LKUWNGr
	 NbiL2jAKE3VHe0JrbzSZHvOqAoPWvHUVf0lVeW5cmC3WNfNPiLB53lSQI1ZARbq+we
	 UeqDUFiX1tC8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DDA38119C3;
	Fri,  8 May 2026 19:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3] monitor: Parsing of cs step mode data in RAS
 Notifications
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177826800480.815206.7081384699011433194.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 19:20:04 +0000
References: <20260508053819.3424918-1-prathm@qti.qualcomm.com>
In-Reply-To: <20260508053819.3424918-1-prathm@qti.qualcomm.com>
To: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  8 May 2026 11:08:19 +0530 you wrote:
> From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
> 
> Sample Decoding Example:
>             Subevent #0:
>               Start ACL Connection Event: 406
>               Frequency Compensation: -16384 (0.01 ppm)
>               Ranging Done Status: Partial results, more to follow (0x1)
>               Subevent Done Status: All results complete (0x0)
>               Ranging Abort Reason: No abort (0x0)
>               Subevent Abort Reason: No abort (0x0)
>               Reference Power Level: -14 dBm
>               Number of Steps Reported: 58
>                 Step 0
>                   Mode Type: 0
>                   Aborted: No
>                   Packet Quality: 0x00
>                     CS Access Address check is successful
>                     Bit errors: 0
>                   Packet RSSI: -52
>                   Packet Antenna: 1
>                 Step 1
>                   Mode Type: 0
>                   Aborted: No
>                   Packet Quality: 0x00
>                     CS Access Address check is successful
>                     Bit errors: 0
>                   Packet RSSI: -48
>                   Packet Antenna: 1
>                 Step 2
>                   Mode Type: 1
>                   Aborted: No
>                   Packet Quality: 0x00
>                     CS Access Address check is successful
>                     Bit errors: 0
>                   Packet NADM: Unknown NADM (0xff)
>                   Packet RSSI: -60
>                   ToA_ToD: 0xffffff45
>                   Packet Antenna: 1
>                 Step 3
>                   Mode Type: 1
>                   Aborted: No
>                   Packet Quality: 0x00
>                     CS Access Address check is successful
>                     Bit errors: 0
>                   Packet NADM: Unknown NADM (0xff)
>                   Packet RSSI: -54
>                   ToA_ToD: 0xffffff53
>                   Packet Antenna: 1
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3] monitor: Parsing of cs step mode data in RAS Notifications
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7cd27f4f66aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


