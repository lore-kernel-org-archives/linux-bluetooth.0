Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348011;
	b=XhUGgPQVRZ1xrmgCeHEKdfx/YYzJSITWxItvwZ9KHR7a2uQcdjwDe6RcNIFWgDsIjYS9
	 Ul/LMxykCH7EIFgXMtOqd4rZIVFZ3xuDXnLMvb59rlN3AqXxJ54TuGYWbqF+GcwooygRf
	 HQpSfFpyc+A75fFkxyyuqVYSZmwM+Z3exxJftInHt1zJXY+CZ3X9dzNl/HIL2cp6TxwUY
	 tbcrTZUcPGZuT4tzl5JoYfW88bgRq1jvZEimD++YY0O94dA5HEwTb4sQuziCaGlFvDJA/
	 gKfKtUWyHs4I8/lhXxRCcbBATCr3jrxQId7NkyJFggBeFLOciRDvInqzOSuTGCVYzVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348011;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=PNnUNR9N1zVv1KtrXhue2SIR6yV1/m865iNT/0L6EIk=;
	b=pdtH7UBjZWsUwj24V3tNlFL3S68cczs7ge2+0ohnqzr2WifQ1MHi2WllHuLHUljy4NHR
	 EiTAkU+3MppYb49EDeUGNxrW7e0b5iW/zZgtNQ27TEOny4xdeS9cSVKIGYCH+h0oXYpF2
	 IfISC298KeKEIHRsucqqh6ZjXKzXEibdffcp+YeG1IwHQjuosG0OdvGAzmbBfFgCU40qJ
	 U6hmnKs5B/YX/7Q36OqGDVNB0kWVwv47wvGPLB3Z8YHH6GcVtl9lTXc9rGe32M7tMgUxe
	 CYnBxQ+cLEEbP1E95CwTLVsuDxCQh6PlgD8/5iivJv72totOtCc/SwlKGjKvO6RF/uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNmaBBZy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D046E606A32A
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNmaBBZy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98171F008A1;
	Tue, 10 Nov 2026 22:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348010;
	bh=PNnUNR9N1zVv1KtrXhue2SIR6yV1/m865iNT/0L6EIk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eNmaBBZyFRpndoKSj1ckVGd/WUyC/qSekv1iG4ckOy1vyL+06uQX7boysNkjwJxeU
	 ogAOmUtX319KgVlhnNJ8/hWUnnmOZAbPp03PuYMPe6MqbIqiKkq+Jxu1+Q5VcDI/hx
	 HbuGPwtNzyxvBuZn62h1ClVVf6hUoshy8faRZq64JONT/f2ObuaOAIoQqTySvrVBur
	 78rICcchlq3NeKjFYlOYHY4oAx9DR8XKkfxyDgc5NCr3+kCiq9tgrPhkplAPidqaax
	 tG+aDBKKkPm1UJy1RtBZ8e5DFQQqpalPfI/H9b5szAsqU3Ssf2sCmtBo4vbrMrt52a
	 bB5xoOmk5yVUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9AF9839E8A40;
	Tue, 10 Nov 2026 22:00:10 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v2] shared/asha: Send STOP without a response
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179434800919.80411.704170822998959847.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 22:00:09 +0000
References: <20261107012310.1224254-1-cochcoder@proton.me>
In-Reply-To: <20261107012310.1224254-1-cochcoder@proton.me>
To: Kyle Pepper <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 07 Nov 2026 01:24:00 +0000 you wrote:
> Avoid leaving a STOP Write Request pending after local state has been
> reset. Send a Write Command using the existing helper instead.
> 
> ASHA specifies Write with response for STOP; this changes that procedure
> and needs renderer STOP/restart validation.
> 
> Fixes: 9948168cca15 ("shared/asha: Don't wait for status notification on stop")
> Assisted-by: OpenCode:gpt-6.1-sol
> Assisted-by: Codex:gpt-6
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] shared/asha: Send STOP without a response
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d3e258ce4d0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


