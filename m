Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DD136F908
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584864; cv=none; b=NLFbRbb7ezMXfWY7S8/BbQJWH/qm994fU+rcAqfMpXn76IXo13qN4ezs6bjKoSbOnsgxfQTBMdvMjkpOfjGddUSe1IzTymyirogICkabll4loAs94FuhgvXmY7zD/Ol8iFHeCBz0li4VnkqytaLhs9KjirdULeT5UoMwB/H/uAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584864; c=relaxed/simple;
	bh=H4hFTT8JdH7OUh93OvdmBKN7O5bAztAaJiu+1T9ejoc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=prW06gN233Ge3Dauov8g0+jHOIL6kJT4aeYTz5SnZd9JApaq0zOOlwX9urJYAqOVNAP3f0QNmK8MiPcEO7Qqqr8Nx4YNx+Se9HGvpRtaugUHOl4pEauYR3J1oNi0WAmAUlqf8FtT0Rr57Rr17Ll+3uwiMFbtxns54CRY2szbMYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcTOuVuB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcTOuVuB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2D41F00A3A;
	Mon, 24 Aug 2026 15:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787584862;
	bh=F7tKjMnVis8fK5g/VGsFWZZzZF2tmtDdKBXGyBI27yA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lcTOuVuBEkfH0GJVGi5eVpUaB+2XXcWsgNSMLv1uoTNMOXlD0r6A5lVXY6Hc79xh/
	 lHp9L2sT+AZe/2EREdRozCuz5M5ZIOGlSY9H9LQOOcRBqqNEYsnM3Kxqbkl3Jlw3P3
	 eGcCLJetZhlm0uO5GfT7K2UvCg1Frth+Vyw6xPelpQpk5XJr8Sg5QZpPGWDz8ZwVCU
	 znnc3OkL6wZhqQ9KhxUB4+/EHT6FXBu6Otv4shM9nMPUYbLdQcxfarUxWk1rXPeszp
	 Zmol6G4Bq4CTEISRymS42UyooK6LbA9xGt/17rWvIzxLsRHRwUwCvymlM2kbcJNDzy
	 qclAdmV5HqtvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0F7A1392445F;
	Mon, 24 Aug 2026 15:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] tools/iso-tester: fix GIOChannel refcounting
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178758480996.2968570.1115538871246541426.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 15:20:09 +0000
References: 
 <a95c6273788e688e4034705305ec0c960739a9c5.1787481678.git.pav@iki.fi>
In-Reply-To: 
 <a95c6273788e688e4034705305ec0c960739a9c5.1787481678.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 23 Aug 2026 13:41:30 +0300 you wrote:
> iso_defer_accept_* consume the reference passed in.  g_io_add_watch gets
> a reference.
> 
> Fix the refcounting accordingly. Also clear data->io_queue immediately
> after the test, so the sockets get closed.
> 
> Not leaking references makes "ISO Connect Close - Success" to work
> correctly again.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] tools/iso-tester: fix GIOChannel refcounting
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=df8f0873a16f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


