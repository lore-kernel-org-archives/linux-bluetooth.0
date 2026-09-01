Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95576248880;
	Tue,  1 Sep 2026 00:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222068; cv=none; b=VI9jpOfXXQYIwmOMFzD432D9v18bv9tjMaJhu5WlPpudWUibMS4qwai30z7kpEmd2pknn+xI/wRyeKmUOeNu3uY7CbcbjQ5a83ZgoEuT03kgAXIE6nU4BQSrMMPGKk/WTAb9CI61urxKpCElQq+uElai7rwg9PZrDETP6FRJE7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222068; c=relaxed/simple;
	bh=VJP5RzviQC7lBjw9DX3Fypa9HnYHM+78XejOT5ej+bw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e5OGPDkaOSRmC0mUxR0x/AZBseggjoXsSsVs6M5hVzuwNZVUPDOndzMk/kfdB3oa5Sbmo50L+CICHxXgPGSv2/tMnKEly42vNp31eyUeyHvFVjUqpZbU8kqwva/RwqmtTKx1ZHBHOMfcv8K4xCyWGcY9K8mYjP9FQ55VAiWUDDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFudbUiW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFudbUiW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F691F00ACF;
	Tue,  1 Sep 2026 00:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788222067;
	bh=ZtzyGlMwIKu34s5jIQugApXgnrpWSxblayvs6hY+Keg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mFudbUiW5PB4uq/SKObSzjyDTowKVGR60OibfSbl+Qo8w7m8sxJ783KWbXDGUDTrD
	 tKzHQaWJ9kr5gMm6CEUgBJr52/iSKk2q/w2s6Yff3ZzJuFQ7E4cEFFMWtrggB0Bdw6
	 Yb/PzKoRJpW3MMMxYCFW89FJwFSMJiR9sOmy1eMnzGs4Om3c00K7Hkrwhj3h8OJWAF
	 8bQODsBFGdD3WBnnhDNJskaswIfto8Y2awTAxbzmGySf0jvxL8niMkak71tFz9fjOX
	 obIyaPecZxNtdfkWIMimHCHM2g7Qqs0WRgcqcgzSQ5rBq7VgxfCI+ERGtqoFqNaKrC
	 I2TXyiWRxKWFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AA2392447E;
	Tue,  1 Sep 2026 00:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-08-31
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178822201015.848040.2310165548994468237.git-patchwork-notify@kernel.org>
Date: Tue, 01 Sep 2026 00:20:10 +0000
References: <20260831181837.946230-1-luiz.dentz@gmail.com>
In-Reply-To: <20260831181837.946230-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Aug 2026 14:18:37 -0400 you wrote:
> The following changes since commit 1376afc7660bad2a1a5ee0876898312a486cf8bd:
> 
>   octeontx2-af: fix CN20K default MCAM rule removal on port cleanup (2026-08-31 10:04:32 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-08-31
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-08-31
    https://git.kernel.org/netdev/net/c/1ea9fff22bf6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


