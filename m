Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6B84AB1DC;
	Mon, 21 Sep 2026 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999877; cv=none; b=JC0FP9F70r2okoCAFxMNHM6FIhrAHRutrWbr5ks2Di3uoDgwR0tz8ds9ht6+nPLKsy57OJHkeyJ1GjcCF/e/MCvYLlmsJaWBys2tnYBRcjtUtaiPpChFi2M507ZmY7MJKJuAUI0H1KoJVjdMedNTwcJxyV9luCrzhBJGrkiNPAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999877; c=relaxed/simple;
	bh=vz4FTYgtNHaHXhuOi1Jvhl+cWX0aFTf36PBkXtqOixI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sJhhd22f0p1LJvzNgkPVkpo6fhjni4nzLlIx6OYYqfTTPW8ej08auUTRuutsQqHTlIwO1v9awUzk2thABXH0Tjp2nxFg5nfzRQ4JL/CAyYQjKNE6RPura9UNPXaAYcn76GyFV5MuV7gwXPxN9YggehtfGk7mSOjyrXqwk32PD0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhLTtYkn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhLTtYkn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13161F00893;
	Mon, 21 Sep 2026 14:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789999875;
	bh=hng+xFMbMb1nZdiHSvG7kUa78GiD5OvvA8A5MGrqdbc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nhLTtYkn9CRxb7znW9OisguWRdluegXO4dNqxtW66uFC/B7jGSkgZiB5vn6fJhuho
	 92PBGAcaMDwVUW1wKHuxyxQm/R7onoVrqleIWSb79ZRAJjsTkGy7AiMu2YO0egSjt4
	 jvRMsyPO6n9ynMvF+AJVq8lqD7y3IPBySkUXQOkS/9Pdh39LASeJ8bHuLujEgWp7d9
	 N9//2lGzXN3kEBShzAk4/GBF9ELy5B4IXMAfqs0oqJfoHnxYaq4vPy1sKoIrGXk2sB
	 LsuxBgqYwtYAsYO9WRjNZ7ibfu3I2WgFR5t+ImEN6jafLso0anljIO+Wej7fNUdCHp
	 fxKtm3WoRXoaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939263926659;
	Mon, 21 Sep 2026 14:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: use assign_bit() where applicable
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178999980714.3047822.7600652499809584862.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 14:10:07 +0000
References: <20260920022610.3145618-1-peng.fan@oss.nxp.com>
In-Reply-To: <20260920022610.3145618-1-peng.fan@oss.nxp.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, kees@kernel.org,
 nicoyip.dev@gmail.com, aliamemis@disroot.org, kuba@kernel.org,
 imv4bel@gmail.com, pengpeng@iscas.ac.cn, suunj1331@gmail.com,
 tim.bird@sony.com, peng.fan@nxp.com, leitao@debian.org,
 jcperdomo100@gmail.com, safa.karakus@secunnix.com, rollkingzzc@gmail.com,
 linux-kernel@vger.kernel.org, luiz.von.dentz@intel.com, oss@fourdim.xyz,
 pav@iki.fi, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 20 Sep 2026 10:26:02 +0800 you wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert open-coded if/else with set_bit/clear_bit the assign_bit API.
> 
> Done with Coccinelle semantic patch:
>     // set_bit -> clear_bit => assign_bit
> 
> [...]

Here is the summary with links:
  - Bluetooth: use assign_bit() where applicable
    https://git.kernel.org/bluetooth/bluetooth-next/c/5f639837ba47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


