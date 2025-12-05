Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618051C3BF7
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 20:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764965590; cv=none; b=d+KuTb642CHvtBQjOGMEYfVQCqAGwTL+zHFcU7iGFL2WEzcHkoRfZrudlS/M85tPVJC/oEaG8QVcXmP1r2hm9WGvtm3SXuxdrI43T9jqdi3vJD0w3hkxMOElhi1Tw2altlFup5nHJ5lHWawRI1oUdYqQQZTrUlGA+8APNJ0Yqi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764965590; c=relaxed/simple;
	bh=40Mb5mfPUF/h2wXgU3q6gr+ofz61LJ1p88uURwFGcno=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ncmast4Lmmkk+yZHonMTAFR/E3qnL+AFW7EQ2NAT/QHdL3nDkelHzsowrXGhekBxU3wvO5VgynrVDMMwy0NBrSAxQuvISg0agPUI04XJBJVap+btA0xGHmJ28Fa/6E4J4glcSSDXxIte8+KDgW2KMizr5/hbFBcb58H9aeAvy90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8cJ8ubF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8cJ8ubF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8CAC113D0;
	Fri,  5 Dec 2025 20:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764965590;
	bh=40Mb5mfPUF/h2wXgU3q6gr+ofz61LJ1p88uURwFGcno=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c8cJ8ubF5a2mcMpG2hVxg04PrJjCUIbv5vhJUiNW3Qo+LFGco9ZxCF/RG9EqaXyKB
	 /tTRoUhOvA7K4EPXjOmILOEt4NJrZEnUQym6uRNxKL4O942K3PEomkoXZhakZrBx7C
	 YSDtgVryYVAc6fLUvCnr57yoT/CIhqXN3wSQMIb82sbMvXbGuEzGtyFachvq29Z+nb
	 OOjxZ2EU75yqP7TJBKsWrRWV75c+sWKR4/86U7OqtNUTNY+P4V/A+yRj74pP8LpRsL
	 P1n7ZW1q5nlpi+gxIglJG6eHlguFgMoCzmZq5nZA7uVCaBxe+5vK4sbIzCjR/c0jt8
	 TSz/xVHyJ6Zow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B55E43AAA0D7;
	Fri,  5 Dec 2025 20:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] bass: Fix attempting to create multiple
 assistant
 for the same stream
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176496540727.1804616.18149146820752947845.git-patchwork-notify@kernel.org>
Date: Fri, 05 Dec 2025 20:10:07 +0000
References: <20251205144952.8373-1-luiz.dentz@gmail.com>
In-Reply-To: <20251205144952.8373-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  5 Dec 2025 09:49:52 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> bt_bap_stream may change from streaming -> streaming when updating its
> metadata in which case bis_src_handler would be called multiple times
> for the same stream causing it to fail at g_dbus_register_interface, to
> fix this adds a check if the state is already streaming then it must
> have been handle already so it safe to skip calling bt_bap_parse_base.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] bass: Fix attempting to create multiple assistant for the same stream
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d83198c78ee1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


