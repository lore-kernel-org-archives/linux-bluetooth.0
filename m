Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8014B79FD
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454430; cv=none; b=JkldB/iOPntguQq+snSLylwWpDhk9eTH5R2sJaNKr6E5qRr67lyA37j8OpChrbC+oBUlgAolIQcCak0wiNIRdz77T3HlwhqXjwbS/075X2ZTW43PhpeBwNf3/4G4QZ4YVgIkQ7mg2aad/0LmGz7zyKT6qEz7PKIQYpank3ogIS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454430; c=relaxed/simple;
	bh=dWtJn1AgSvba3XfJK6EXSMMkfdz63aZZlK/ft5vzJ6A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JKt6tNcqgDzg2UI1vOkhXykzHk1YEIN/uY//HY5us7fZxVJOBg9ZoXVIPkTWMSMiVYGq6iuVkID31fzNQdPlkAe7hjQVsBrzqR88KHRFOYvybIfgzU9K1UlSXbKLJorzGCV+N6CCb1xmS1dbZjQTEjdW6UNpd7eIUGOAIZNQI3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzTg25PE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzTg25PE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31EE3C4AF0A;
	Mon,  8 Jul 2024 16:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720454430;
	bh=dWtJn1AgSvba3XfJK6EXSMMkfdz63aZZlK/ft5vzJ6A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kzTg25PESJPA4VAypP/quYI5gLv1ht8Zq0VvAcZwfnbyygxTetQxx6jl2fh04R2Hd
	 dBoIJ46f7V0PSQn2RKtsUaWl2lsfju7W16WlDmdY1Jh0JMgyvyk/cal6IfjyN6yYPk
	 obshmMHeIn54YwPInKgftqP0VGuRnJG58k7y0wvEPwc8ZOzVYuVzJRCdte2/YxO+kA
	 rkpCDmJvj4iRiaKSB64ZtmmtQ5E3npHLyxx2SyUpi8BCQyquCEPjbaT3LDR9VclRs9
	 PtDaCylIc4HYDd7/huyvw0WUJ/sq5SFzSojLCFmk0+UkFAL66cMvH6SpV0CuK4fAo2
	 1KqqmZSISHVlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E779C433E9;
	Mon,  8 Jul 2024 16:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] Fix discoverable property not emitted on updating value
 to false
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172045443012.21290.3090794568507484663.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jul 2024 16:00:30 +0000
References: <20240708074024.5300-1-quic_prathm@quicinc.com>
In-Reply-To: <20240708074024.5300-1-quic_prathm@quicinc.com>
To: Prathibha Madugonde <quic_prathm@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, pmenzel@molgen.mpg.de,
 luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
 quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 8 Jul 2024 13:10:24 +0530 you wrote:
> From: Prathibha Madugonde <quic_prathm@quicinc.com>
> 
> client/advertising.c:
> Allowing discoverable property to list in the parsing
> function when discoverable is off.
> 
> Test steps:
> From DUT, bluetoothctl go to menu advertise
> set discoverable to off and then advertise on.
> 
> [...]

Here is the summary with links:
  - [BlueZ] Fix discoverable property not emitted on updating value to false
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b2371f9f1134

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


