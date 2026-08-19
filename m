Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D736436DA14
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787169056; cv=none; b=AJOzOV0/d4QQpWjellMJm7wTA1XL1uYbqY5U29gU51fGyCvv//+cRD2XNrLVLVnSu8MzfjX0BZKzyTs7aNF/t1S04rtdcMGDpi+y8J/15r6TuPgrA6BC+tOPbC/PdiaZhvAutkS59dLsbEE1MYQKkjqJC9h+HGBeXYjrrlcOTw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787169056; c=relaxed/simple;
	bh=TSFdKbhYT531HccjSRE1rrjgk7UMw37/pnt4QQTEYP4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AiQHeNSlcZogKXNF+7WgMexgYrI4zhHA683zk4JXCCooVM8yt0pfb1/rSFFWBxR0einy8hPFnAIrdQhRlQf9M1n68RWIRRl25punB/FpAPHRCIqoZR0lB57R4iQIGqd0v4jGTIpMt+CuuZPP1S88GVOho/dDzEEpuU6TxoolS6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xjnu+lAZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xjnu+lAZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680251F000E9;
	Wed, 19 Aug 2026 19:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787169055;
	bh=opXX7AUd874nqTTtTsGTJ3mQmrCYRn22kjUi6bE/rBM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Xjnu+lAZsY/IXos9tcjMbkmrJCmtL9TSgoiv4oSLIfgTEy27nhdpF+UWkJHqW6LzG
	 LgKWuxHpMJQtYvnNbItBxOPacCk/N58Y/7oCRuHiLZ8GaROtf3kbI2EBjP/aW0B+Y/
	 +9726mvYXP1cNaxE5y9U2XmD6g3QpB+CSZhpeB8epEJUv0rfLGoIkegWwcLNUPkUrt
	 Kv4+7S6goJK5KRhLOZ64+cVj2pJvNAd30Mflp4rwOtNwPYcVCGvJxbVutLYSEB6DsY
	 HarQFzMscdl1yU4MeqcXznjQVU/0oeDbLZtN262K9r6CAuIYqId1a/SdYJEeWS8Sc0
	 3kVgrSxmxWXpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 834263811A47;
	Wed, 19 Aug 2026 19:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ] avrcp: Fix media/folder name not being set
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178716900614.3669166.6100756359152972728.git-patchwork-notify@kernel.org>
Date: Wed, 19 Aug 2026 19:50:06 +0000
References: <20260817082315.4090729-1-hadess@hadess.net>
In-Reply-To: <20260817082315.4090729-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 17 Aug 2026 10:23:07 +0200 you wrote:
> *namelen was used before being set.
> 
> Fixes: bd8989620ed6 ("avrcp: Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing")
> ---
>  profiles/audio/avrcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] avrcp: Fix media/folder name not being set
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=58088149872d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


