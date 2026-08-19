Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801643D566E
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787169059; cv=none; b=JPPdumD/zYIx8YUCNFPf17P6LLK4iaV1z1Ea0/NOC+CuPdkmYHUhL4Xku4LIQJTezL7d06HaJLuHBQ0pDbIRwJ4M3p9Ehrn/33ZgwlxpjhHyxuPpxWbK0HQn450TQ5aQTLhbYpwUI3tP8wlLBgDiQ+r2ID8xHLW1IpOb5zx9YCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787169059; c=relaxed/simple;
	bh=13c1yeF4fENyJp1ygjBqVhhL2lPWu6+TlRRwuyxU6nM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YseWp5Co1ixv5bdJnwhvpefE31mjk93Kx8WZZZvJ6N8OpHxFSr+rfRNH8M6vUvDgXzJ8NoQ9NbpCBnoAzPYx6rrw67fTyU90xIkj+WPLKlSlrI52tLeOrY9+nUStoXE8jLdib6gTVX69rE6l3kR6UdlQU4w6exD/aE0yqAAjZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ej4LVT3g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ej4LVT3g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E991F000E9;
	Wed, 19 Aug 2026 19:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787169058;
	bh=fG8eF4Jr03FTeMQS6DYunJ+/8wTIfJBQ6PhONE9r7ig=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ej4LVT3gEW+ciWPCbwd9eEy+mGWIEEP6xvkQQl7OFCKJXRkN5Qj4WMX86tGnAfOCz
	 iZIdG/mRrKkdjjGNg2G8bScseCLFEXyAXf+4wAFeta9Oi5aULZY7n76SxjhUBty8ej
	 Gh2XedeYwj2wYGf3kwIMe9jalaDjMmERF6b02WG10fnOXD53f1vI9r4ZO+J4fs00G/
	 FlwljC306Gs9cpCnO9D1CboxwMOrev/cgNovFoEOjmWwofRNok79IGCzl+rh9NYyDc
	 volxSn42g1F+Vh6sXwoKu8Di6kiJ8pdOkU8OyND4Q0c7zljx48AR5X3nANAmbZZwA7
	 Ndt1kA1uPvT5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3E84D3811A47;
	Wed, 19 Aug 2026 19:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ] test-runner: "-a" option also stands for "--all"
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178716900888.3669166.15973906945058696851.git-patchwork-notify@kernel.org>
Date: Wed, 19 Aug 2026 19:50:08 +0000
References: <20260819091347.1204005-1-hadess@hadess.net>
In-Reply-To: <20260819091347.1204005-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 19 Aug 2026 11:13:45 +0200 you wrote:
> In the options for most command-line tools, -a stands for --all, and so
> it does for test-runner. Add --all to the option description before
> --auto as it's a more common option.
> ---
>  tools/test-runner.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] test-runner: "-a" option also stands for "--all"
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c73fa2f9ae2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


