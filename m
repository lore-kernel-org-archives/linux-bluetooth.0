Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60150380FCD
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 20:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553272; cv=none; b=ZtwJWU4Kx5aWiChz46auB0fWJ2MJlX8iC+CxNshQ97TfchQUJR3wXvgO07/+unTzPktA8sgvOErM+GPNT7W8kO9MMov7Q1wh0xYR7YZqQn+4RrDHDbqVJbaYwxzGPA1c24taJ5X8kFuznpczHNa54wiV02m2Y7rUJDQ435Gini4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553272; c=relaxed/simple;
	bh=KC2qNTnBjiTqZGXUIYogChIX4ZJhs+7w0DAsBRB7MNo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d0/1LbZO5ERpSNES98LrLzKyHfhXHiV0TbeB12/aLE/IeeGk7goSIJGGpt/ZngfixZZL9tYx323XYe2uxW5hB+P6qgUUjFYSAgxywbX/0Bf8QuGVOUcCfL9LvLLz6xmrVCFLiuAZZVrm6OSRFIZ5cczU7pA4VCqjGk71nMSaBPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F75RObdN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F75RObdN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CC91F00A3D;
	Fri,  4 Sep 2026 20:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553267;
	bh=TQ7nmCYsW7pqHxd/ppRrExNl/MQ4RtvuZ0NWoS7MXWQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=F75RObdNdO5kXcKfdLS6DRHQeAtEfkg0hzVq+9WHfZg8Z7IZgrwtSC9k0U2Jexsse
	 2HTTZiBGUkuhcrgdDUcrneQGSJfQe4NDY2ATDYAbMJ9iLPfdAYetqJ2GA3UkifZ+C0
	 w5UjROxXTUIfnmDUD7XtMhg1LWLLN47zuNPEqWT1DGgzFdYLPlxx5ShmU9sa7VmOAi
	 Sx8EEbnXC+P54vmlGLAPqNCODejp3Mr6e60KrcGP4w4kcHJqPn3FRKxbWArvCIZL1C
	 7EkW1imj9tBMZb0VdtisJtdREsuF8cKxr9V2MrRlumLqN+Ocz8R4F9oTRN3BuqsAhu
	 PaHGdopW4fJzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939703924A6E;
	Fri,  4 Sep 2026 20:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] Add MCS fast seek and track position write support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178855320839.954520.11171942781306472164.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 20:20:08 +0000
References: <20260904165332.42046-1-raghavendra.rao@collabora.com>
In-Reply-To: <20260904165332.42046-1-raghavendra.rao@collabora.com>
To: raghu447 <raghavendra.rao@collabora.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  4 Sep 2026 22:23:28 +0530 you wrote:
> These patches are needed to make MCS PTS tests pass.
> 
> raghavendra (4):
>   profiles/audio: Support MCS track position writes
>   profiles/audio: Support MCS fast seeking
>   shared/mcp: Notify unsupported RFU opcodes
>   unit/test-mcp: Test unsupported RFU opcode
> 
> [...]

Here is the summary with links:
  - [1/4] profiles/audio: Support MCS track position writes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d13f18c9a930
  - [2/4] profiles/audio: Support MCS fast seeking
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f801cd34402b
  - [3/4] shared/mcp: Notify unsupported RFU opcodes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4e237b304e5b
  - [4/4] unit/test-mcp: Test unsupported RFU opcode
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=36cc1305a827

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


