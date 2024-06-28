Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AF41C2314
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587430; cv=none; b=Ph+DBt95wPnUy5IT7gGm056GW7JGXLzkwfq71nE8zfBaV2N6AnEVkAztVFHWnpjn/f928FycpVEken8gimYJhSZO+ZY7QOEr0LkH+c06pytRdLxE+RS40lKzPW2+Vtm5cfJ+JaGH09ncD3Lkv8Jgc4hQWZ0TEIhhi+ERxWY3VwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587430; c=relaxed/simple;
	bh=VSxhhXepRGVlK8FuSrhpzC7IwstxeUwB2uZfK21/i3g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QDYLyizrZ5DGrNHW9NOVY1Eg1SjNJanvyGHJj2wOSuvfihApWmhUzoHVTBfAw7ktc3jphoFbOPvYAR8vJPz4rWrTOzBKfIHTMpR0mZ3hpH4uI5GgGugld4/OscYFDg9Wwd6z0SBhqvxGLFaLI8puPNoaRbrtL5bjnFPyXmQG6fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jE0z+5Bb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jE0z+5Bb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51356C4AF0A;
	Fri, 28 Jun 2024 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719587430;
	bh=VSxhhXepRGVlK8FuSrhpzC7IwstxeUwB2uZfK21/i3g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jE0z+5Bbte7Vp/FniMdxQ97IhwLDXUOxGpVpWm/LvlyR9Rot5go/pl/wKljMCaFan
	 1l0miva4QdlJ0AuAj6CMtBPPMmb18oSVJPxAWAUiM2WgjLxee/r4W20EcKuBgkDskR
	 nx+XWrsCH6eM0HZxWevL1jfcLc8cNUSbhqt9oa3qLNgOR+V0q5PszekTXbDg/REsr+
	 kUe95ovfj+UUJ+ePojvqj6GHuCxVJIJ3FvZ/rrFuNCGdGi+i/qeCAlq1HRRWa7Fo+B
	 fACcsr71+cQCXERjeIevqJVZR+RJflj9ViQ/fLb1J/k6OTM5mcjg0+vvE/0ps/B+YJ
	 A/pyawxpqeLLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C1A1C43335;
	Fri, 28 Jun 2024 15:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] core: add NULL check to adapter_service_remove()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171958743024.13318.9236630597581468943.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jun 2024 15:10:30 +0000
References: <20240628103050.535719-1-r.smirnov@omp.ru>
In-Reply-To: <20240628103050.535719-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 28 Jun 2024 13:30:49 +0300 you wrote:
> Make adapter_service_remove() safe for passing NULL pointers.
> ---
>  src/adapter.c | 4 ++++
>  1 file changed, 4 insertions(+)

Here is the summary with links:
  - [BlueZ,v1] core: add NULL check to adapter_service_remove()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ee12a631caef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


