Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B421C2322
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587430; cv=none; b=ciQoFz+lLiuTD8vIn1KEr2miRYTh4g5lyfbHpSIruyeQL2zRaVsoHXUNn4zoGR0/oERZ2FGMv7/E2nCOSQhjQWo22rH2LkyxeVQwU0leoQK0RefYJ0nNeHzypVMinAQEdbtyYhxxVOzXeat3HutVQFd/r+4Ul9djDQmuTt3Tgq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587430; c=relaxed/simple;
	bh=Wju77Uer4GwMg/OsEcyGPzz9Qx310Hz/BVRT9lwD5Uo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qAAugwykdz5eZYx0NgRInECISjyBsHyeyUpts9CLQsyNbA08b4WB279knW8hwwhLrJpksHwUv5n2G+r+Hw48Qk13XMxTxpCjqeO7l2BgGre6whJ8Vq55za3qpuMceub+4ffvAudRid1bH2cgpXv9Xds63xuVXqHcS66QFWzFobQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuwzYZyE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuwzYZyE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49840C2BBFC;
	Fri, 28 Jun 2024 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719587430;
	bh=Wju77Uer4GwMg/OsEcyGPzz9Qx310Hz/BVRT9lwD5Uo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QuwzYZyEooqq/bD+nn5Smqx4+gR8pnbL+MY0GXq0ly3S88/mqQf/jVZ+fnZb8Xz5r
	 +y0ofJCL3JEMBTqn4pcFiTYnDFqpiT8bs1JR5kj5Ycu4TX2VtCoQbA9O0MciVZ3V8j
	 drq4w4FtmSfzSgIpSCtzB7gudSYep0ypFLpkRmdWG3NddnUadIX21afptCqnl2vbEH
	 jmLpaPRympOMlAJAoo3W9AfnjhZckfYcvNYoQs/DLNABjADdiX2HewQqksbgvHLshx
	 IzjTD5FK4GrX3Z4H+K68CI/mKlLZ7Pl7u7v8u/DG74M+K+Yc+kCQhVI4W344g2/ej6
	 HbFWh+mPXXUqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34DA3C43336;
	Fri, 28 Jun 2024 15:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] rctest: replace sprintf() with snprintf() in
 recv_mode()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171958743021.13318.15310214353005522666.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jun 2024 15:10:30 +0000
References: <20240628131531.551699-1-r.smirnov@omp.ru>
In-Reply-To: <20240628131531.551699-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 28 Jun 2024 16:15:30 +0300 you wrote:
> Use snprintf() instead of sprintf() to avoid buffer overflow.
> 
> Found with the SVACE static analysis tool.
> ---
>  tools/rctest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v1] rctest: replace sprintf() with snprintf() in recv_mode()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=559e40a8b9a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


