Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91894DDB31
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791398412; cv=none; b=jvdWlGgAO0wMlJHT6YbW+a6pl1EDIkxfuyzJnt/4e4krhEpmu08hTdLECMkGmH3vZMNpqe5WvIj6ApRjZLeMlldoiRZJ7TSJ77IUGSEK+UIyjct9+yX3k3wNHLzeynh7qjZXlQqpsYeAzz1CswEmeuZaH9D2QO4NylCY5aWjJC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791398412; c=relaxed/simple;
	bh=H1Wqvj88ahR8u5OT8KnI6RhCFjlHuV7mKU1zfcZjGx0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n/rhlYsGuONe/DSI7kPHYv38PcZw1kxaVQo0ymh7x+qgCsF2QnzxPrvfTQupsnOQInL/r5DWBr5/Zzsadsi+pPCgUJ5XycWcyHZyfwhkYevmNkT9a5KTc8TSCOHoI6IOSaIQ0ymbWzTlbO0LgcLbQ7mGyfyJAqAdOWn/NYUotxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFbLX5q7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFbLX5q7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4321F000FF;
	Wed,  7 Oct 2026 18:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791398410;
	bh=SHiOXUYEJ79Sm1L1Gv5g5dh8CnvErvtl7SRK2++s2RI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cFbLX5q7puadSDkjK1venOohFnOAIk1fiCqlh+XwjlIreXDtW7+0WajxtVcyg/7Qa
	 RseA6loxD0j4nQABzYTtZMk97KdtFrO/E4XG8NXk0YpJzuC24JxGSxoBU8ZrVunpNH
	 eyqj6vMbVx3a64wN+Akvg6d0yUmj4L8c4iqpNWZX6XS3VzWxjHnsSs/DehwssoQiPv
	 /J4f0EmnXaKlcV96DrMlVXcy1GXlH1wK3VN5/svmCU+mzHJQdYShWLyU4RqMgi7uTZ
	 uHdabgyG9sdeCsLe2McRZ3PDSYRTRBqm+FrYGwzb+GEl4qdoJh/2MgeWz8UKHBizyL
	 JYdPLKJ8gXNiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43143808209;
	Wed,  7 Oct 2026 18:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/3] BAP transport Release and reacquire fixes
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179139840927.3650240.11495171159381518976.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 18:40:09 +0000
References: 
 <1u4ljEAFqePjPZEbN-y_9BTWLNsqBnUqRAbQRokpIgWxUtdGlZtDC3gN8xIf4ovMpyIQ_UKBvvo2U1qgLrd7AHY8a2x1weRU9PUXtwSzUbc=@proton.me>
In-Reply-To: 
 <1u4ljEAFqePjPZEbN-y_9BTWLNsqBnUqRAbQRokpIgWxUtdGlZtDC3gN8xIf4ovMpyIQ_UKBvvo2U1qgLrd7AHY8a2x1weRU9PUXtwSzUbc=@proton.me>
To: dt <derektern@proton.me>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 06 Oct 2026 10:59:41 +0000 you wrote:
> Hi Luiz,
> 
> This v2 rebases the BAP Release/reacquire fixes onto master
> 7edaa61403390fe1cf2f1fb6d45fdd90fe6e93b3 after the v1 CI PR expired:
> https://github.com/bluez/bluez/pull/2550
> 
> The first fix prevents a late ready event from replying to Release with
> an Acquire payload and losing the pending Disable request. The second
> allows deferred IO recreation when a new Enable arrives before the old
> CIS has finished disconnecting.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/3] transport: Preserve Release on late BAP ready
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d852faf0b1d1
  - [BlueZ,v2,2/3] bap: Recreate stream IO after an early Enable
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=47f783ff5ba4
  - [BlueZ,v2,3/3] test: Cover BAP transport release and reacquire
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4b44e0726c6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


