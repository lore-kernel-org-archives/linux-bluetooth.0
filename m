Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851413;
	b=oCIQuCFFsnR179APVhEJ4T2FST7EtIayQZ21ZrEhLckIB6janWf4DVZzmze5c7vOJtNn
	 Ylp8VJ6S1DxqAFXUEUtPDH+OrdF/6m4ibYhp1pI+uCyT6SI0I+q+8naCghWKLmr/cenlr
	 7aZ8gmhT1cNMICrv0aMxCaCgJd1yi/Gq9PJRxSSjhsKP4T8+hw7IANIDp3ZIhE2hqIEbS
	 3dGMld7dYDl/oofvClfbgBakNzYT4U2GX7+9kwxrhSp73PA8re3hy0TtaVQ7pqSH1jSDE
	 cfbMih66ET63M6XXZXz97i70Z/cU0GIEyk4U8/z/3o5JStzV5MiC5hZwBfk4WOLB96Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851413;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=WtzAc+dtKWxAtGE1a/+cV/bVy7/9LggSFvNzlZhw79s=;
	b=ode0Om17ur0GBijRLmdAXFlO+sdJ6T6lKFappCXnNEIssNthHiYO6sdIb55EVrzPYSGu
	 5OWf4JQaUJ8xpRtOQJGKB2j88Dih14juxPotIHrPsA22xy8aGvsLfl8byZjR884GIKt3f
	 mF2pqwWuTT4cClwYugcLQcFnamg3y/GNZmNNNO+rNyyXa/WCNctqJm5SwXb//U1zIWQQH
	 niQGwj2V+ZcvIPkvtR/T2iZHeVS1Wzfwizpae+hbTm38JpPzdE/oF1aQpwFSWOqxzRK9a
	 dYYNDkgTJMEQ/NIDRA4qnyOGjsjRu3DDTR5rD+2IlLx1leHsZ8ZUxCBCKI7FySVRZAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iebkFu/E";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435CB606A322
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iebkFu/E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEADC1F000C4;
	Mon, 16 Nov 2026 17:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851412;
	bh=WtzAc+dtKWxAtGE1a/+cV/bVy7/9LggSFvNzlZhw79s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iebkFu/EO1Sqt9JD2dSmO1DnagFJERPyxH0XIQrcBbpCJpA7B9Eakq8gIpnDtke9f
	 9IrGWgHbkEr/hbbm8umx7sj24QpppHS1SWmIAx55nsWCoHv6kZ8aXMtre5fUg0NTRO
	 aU9HGBPx9L5VWiW7BFeuJTxrg8zr5GhE3A5bSxV67DWCRK8J3MbzNaMky1iaxykJ0A
	 GUwBiYHlOBKYnjG4iD37GHJ0iRuFdX6c3hk4bcoLVzIhkgWF4ccUSbPL4RLQtyh4io
	 0qGBqFYh3dKxRUyJMs40pncvm8h8E+FqTQz7n3IJSV+DUAQeg9Lu9E08OduAnsXdEj
	 kirf7hb3kmOvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B46F3391AFAF;
	Mon, 16 Nov 2026 17:50:12 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v3 0/5] shared/bap: Don't disconnect a CIS still
 used by
 another ASE
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179485141128.3796096.738685084116950835.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 17:50:11 +0000
References: <cover.1794428234.git.luiz.von.dentz@intel.com>
In-Reply-To: <cover.1794428234.git.luiz.von.dentz@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Nov 2026 15:37:21 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> A remote initiator, e.g. a phone in a voice call, may enable the Source
> ASE of a CIS shared with a Sink ASE and then switch to the Sink ASE
> alone. The acceptor disconnected the CIS when the Source ASE detached
> from it, although the linked Sink ASE was still configured for it, and
> as the initiator does not request the CIS again, the Sink ASE was left
> enabled without a CIS and the voice stayed silent.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/5] shared/bap: Don't disconnect a CIS still configured for a link
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=466e60e8787f
  - [BlueZ,v3,2/5] shared/bap: Hold the IO of a link when using it
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=69f515f236c6
  - [BlueZ,v3,3/5] unit/test-bap: Add tests for a CIS shared by two ASEs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1f6e11d50a80
  - [BlueZ,v3,4/5] doc/functional-bap: Document switching the direction of a CIS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ca5cb9d85a88
  - [BlueZ,v3,5/5] test: functional: Cover switching the direction of a CIS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=901a4cfd0767
  - [BlueZ,v3,6/6] test: functional: Cover clearing a cached configuration
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=549ae613d637
  - [BlueZ,v3,7/8] doc/functional-bap: Document releasing a shared owner
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ff3760408ba9
  - [BlueZ,v3,8/8] test: functional: Cover releasing a shared owner
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ff78a09eb4d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


