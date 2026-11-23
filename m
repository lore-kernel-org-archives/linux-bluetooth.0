Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456810;
	b=RnNOcfJINeusscCJwfRUOs76hUPxRgMqHXFw7WAqfOT74CgQVPuzquCLU6Sx6QWvOC08
	 eTHSVxDg3K8pMzSShXy9uAUqWVktg3X3vAGHkG5zeyrC4ixDBwx4TXadV0Hnt0SIN5Hnt
	 b7v0PoQiV3aPF4oM8Yvl7bmhYb/d3be+FF39G/onWotHCeSqW5Nqca/tLWErfSM/+Mwev
	 pDGERz0x48rx/wCZ01ybJfPRoS+wLyk0pHRZipe1YOgOtU5bY95lDepgPzbwUiN6jjTg6
	 SoU6XBWwxT0A8gaLQBvyEY2VFs2VH16zNgwU9A3gEuqnMJ8mVgcWxJzfJxwXNK3MRxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456810;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=sKJmqXChlGQb5Pr2rsS34PhBCKlS2ls4Yeey80T1wls=;
	b=l+ZRO+DaAiDr1twwKJ/fD9sFCRaoWdqftzNNuGNvNG2IbqcWddB/8DaCpmmKOV3gwInB
	 9BdOyLWedSND71EM8gLUl1zuVpHrK7tGoA4kGcQRqEKVrbEljGgIVPWIVQCMPltqHlTd/
	 6WCGpFmYbkGxwlxUHQIIdwzK7vm38qGrjXLNyhB2FdGkN9/ya8D4KP3LMQ4TcOn5yxOOG
	 +cNXdmE5P9VeNbZ2LkObwDO/O7Srk4cqJAz+hPxo21qmQ5bvT3A8CLS4B4+6fzDqwrHk7
	 4Ua3kpIJnUbicN7XJx6nPuficLyTaIZSJgXnobFh6AJw7Gii/FhpF82CJvv7JPXDKgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J21skyKs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412D9606A32C
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J21skyKs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8941F000D0;
	Mon, 23 Nov 2026 18:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795456809;
	bh=sKJmqXChlGQb5Pr2rsS34PhBCKlS2ls4Yeey80T1wls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=J21skyKsB20qB4tZxWEsbtquYeFg0O0LIZRvFxhLlQJagiEafm314Yhs0BFRLC50O
	 /aCQqEdx9jYgrI5hqtRBioqmP2+nzfSIoop1pRNn2+zjo1spgCebLdKBmCs2z6d389
	 8C4FsINUml3vIhGUij0lqGaCMtFac+ji9vaETSjeoDjLIlkU6EPVVkmCigFPBYAojI
	 41PQBIvSgRzWyiyIhuc+Ng7pRzA5uoXy9Qm8CQ1oLHgBfGwVEo1BATDENy1/IynKgX
	 d1wPp1BV+ZTGToQoI/+WhD1mBPosJBgGe0LSD8aMWauWfIKkZyi00fE3M1WGr+i0v+
	 UZJBA71MOGPeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B436B392EE1A;
	Mon, 23 Nov 2026 18:00:09 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ] bap: Sync to the BISes of a broadcast in ascending
 order
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179545680827.3023180.2228334174771061663.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 18:00:08 +0000
References: <20261122114918.1063391-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261122114918.1063391-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org, simon.mikuda@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 22 Nov 2026 12:49:18 +0100 you wrote:
> From: Simon Mikuda <simon.mikuda@gmail.com>
> 
> The BIS list of a BIG sync is built in the order the transports were
> acquired, so when BIS 2 is acquired before BIS 1, the kernel sends
> LE BIG Create Sync with BIS 2 listed first. Core Vol 4 Part E 7.8.106
> requires ascending order, so the controller can reject the command with
> Invalid HCI Command Parameters (0x12). Nothing reports that, so the
> transports stay broadcasting and the stream is silent.
> 
> [...]

Here is the summary with links:
  - [BlueZ] bap: Sync to the BISes of a broadcast in ascending order
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=532e05b1257b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


