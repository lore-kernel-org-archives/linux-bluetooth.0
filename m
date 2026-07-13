Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C5635B136
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 20:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783973436; cv=none; b=JYdoOyKmFEXeyYMZ5iE014EynWbAgbp6ZUXLw/uBZU9XfRzwmlpuWEzr1vfBvUF4r18lGbinTTFaDbVrUkndJbLaUSOK7vmspCZrLol4YQOGRiCmWRM85PeuEQNfeivrA1mXTmQf4gOcS2AX3sPo8bNtjKDjAYPvH+CRbIM9AYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783973436; c=relaxed/simple;
	bh=mOGic6DsbaSbFfvsBehMzAX6JphBm2+B8iG91xLHdNU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jXsUd60PK63xlykhTJFS8XidGh7ejPrTxHqUYatF57l8Avrdz6mqaBj211E1x2G3B1RxZmV4DJZ8CZPKwe5fvDqx7gjVnhgHccZdJzFf14Q1n5WoAzzM+uY4mBQ6L5d3f2pe1e/MX03ahjjR30EANKt/T7eRQBZ20Y4UtEpiEL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BE+EnCWc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BE+EnCWc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEBF1F000E9;
	Mon, 13 Jul 2026 20:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783973434;
	bh=MkCEnUlm17lrkCcS7IKv6DH2y7D0mgjLR20LjxGb7lY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BE+EnCWcI1hpOqSJLCjoy0lO4uStXNVklLwamLAKFEBF6ZOnRmTUxEBam2KZHDO26
	 AKCxXknMdY+CoYygloMJaOg0v0L3dWONFLpa7hIz7QeEEkw6LGTd8e4Bl7IdLwCJ5r
	 jjsldM0/kxgupmH9gfzigG4X3T5gbHUirOlLqC4ZWmh3yFin9jqdRy0Pz9uaLCnj7U
	 CmcKmv684qxACO45QokRb88fgFvcvVNaofwraKMJx6LSsgjtbeAFDGgV2cqmWQhw/p
	 TW5B8Y96YooMeT1k8Pu0pFxruO9j+yq9Ob+PdDTJHhKyc7UznxqfbqxAzj/1hynBRC
	 p3iATO/A1dQuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569043924F90;
	Mon, 13 Jul 2026 20:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] monitor: Fix printing subpages bits after all
 subpages
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178397340989.2830302.14843798508087503498.git-patchwork-notify@kernel.org>
Date: Mon, 13 Jul 2026 20:10:09 +0000
References: <20260710185012.699301-1-luiz.dentz@gmail.com>
In-Reply-To: <20260710185012.699301-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 10 Jul 2026 14:50:12 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes printing the decoded subpage bitfields after all subpages
> rather then after the subpage itself:
> 
> before:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] monitor: Fix printing subpages bits after all subpages
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2a3d3b0e6f83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


