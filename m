Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439C9347FC8
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491671; cv=none; b=Ah/fj31rXGxEJffCPbnNqk6F3ZsSa+cltRj7BZjCM54LaW2RIc2FkaBzPCtO3vutNWA9JUFCtfTP22JS70rgMGYKYCuUPreCIdTeX/l6ec4CcFw3XMoXgQC71cGmiM7ZmplQvLZRiabQKY7xpeWpNQqlsOrgnGdG3wYjQJG5rss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491671; c=relaxed/simple;
	bh=LtwYddVTpbo9lbkISDy2hFtBWrdkYP92Fqwo4tkmoDY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mEi/Djxs/XMvCNc8Bhl09kGVLxBmoM1QGvAeLDBL8QGhMliCYmUgdK40qufEgycEggxmdZRo7RleyPGCbJpBnO7BrUATasrFh1LNtUK+5QQTnZ2wFHoRGmiBnl5yDBo3jAqMWN1du89c0545TPNjc1+nbk2sIDAy0vgaClnYpNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fs76bj7A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fs76bj7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55E81F000FF;
	Tue, 15 Sep 2026 17:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789491669;
	bh=68fNss7HJUVtax6zk5JmgRUr45b/pu67kyQOPeVhw3I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Fs76bj7AZrxXthaRKoWklrWXKJfmpr6oDuVmW6lpW9+IVc2RKjcYz+T3TKX4jqjNY
	 InbBRRDhxqpsPhltR7tC1fsRB0iS6iam1HIrIy/qZmxP5azmwenBBhiFWhMFFqyZry
	 S6ap0DLOCjMCpPWtrFh1Y8FHl44oJcfyHfXXxpWp5NBs2DRGRmcwOOzmrUvrripNdr
	 JbY2t+GOxd2Ak8Uz71cgvRcKLpE6smLU6KKKmRh9Es9flNowCR9iLgrkgP33bmjnZe
	 2x44j/hGB62hQNGGo+XU5JQUbM54DXnDfZsIpbXp7GMEDWadLrJBWgEZH02Wozv2wV
	 p7NB/Vhbek9Rg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A1B392666E;
	Tue, 15 Sep 2026 17:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] doc: test-runner: document the virtual
 machine
 architecture
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178949160439.1731852.11211943029246633562.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 17:00:04 +0000
References: <20260914175136.613532-1-luiz.dentz@gmail.com>
In-Reply-To: <20260914175136.613532-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 14 Sep 2026 13:51:33 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Add an ARCHITECTURE section describing how the virtual machine instance
> is created and how it communicates with the launcher.
> 
> Document that the tool is both the launcher and the guest init, that
> there is no disk image and the launcher root filesystem is shared
> read-only over 9p, the TEST* variables passed on the kernel command
> line, the sandbox mounts and the writable overlays needed on top of the
> read-only root.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] doc: test-runner: document the virtual machine architecture
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b4176324909d
  - [BlueZ,v1,2/2] doc: test-functional: document the test environment architecture
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6dc064623c57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


