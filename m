Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F8C3E7BBD
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901207; cv=none; b=eZ0Sho5jdljbz7S52uPypTweq2qoIdnzkj14O6vxpbkYV6KgQtTW5lrjOlLdTRXwdBn9m8sUJrOG1QBAZbUJHL1rQldGhzUO2lVlAgH4cuIwuTbMOo1djcQYAeWlfabKP1xZGoU6RdFhdoIh1vmNuAVHAKmV0XL/ArJ10M75DHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901207; c=relaxed/simple;
	bh=of7tIqRzLy+ysoEJVsmq5O26FNPWCSpNQUmhL7+RWzs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X0OHKEtyPEdxfgVDyzWMNKmkPYs8cf2RcpkYzG1Q44pU0DwMN5M0AgadtjAB1hTy1sdrD4PPC9uVxH5z6RExUQa+FHhTEd0eIhciaP5Z84Ot+F0O0BhorXLsYvJS4mqJ+dOGo/rAZ8uJfCpGiBUso/jjXe5KIQGXfbKdfk5KTbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzuPAmY+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzuPAmY+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803F51F00893;
	Tue, 13 Oct 2026 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791901206;
	bh=HsIl42Dlbz17Ws8ivUz8pUcdKrAUybAL7ijisZ/7u44=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KzuPAmY+a+r5Q1DYe48kyKw3yap6ipH4YsSvf7u2XJcI5U2/9ViUAJtK0Kg8CAMSg
	 v8Q57ozB6c3LJjQgxJq4ef4RL3LJoWLEmuu5h0OYD7RvU6jfxoj9+yppYOy1vw3N5l
	 mOkFTQ6NTZEa0t/2G/k0bCdJWQnpUzyrWhD1Vr9bfjFOfxKE26J8LQphtb8UMtwR9N
	 Ei4taNi6wkE4IXHscfvjp4njvKEebYuZtykaqoNolptln8k0yuXrmtowSQuJuO7eS/
	 myn5ZiYrfsn7C0P5fcssejxdb6LMX9rmWIo/Kt1QsHNQcInKMc8kj8FEU1pdYWvvKR
	 VUZA2r1J6W+ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7737B39D237D;
	Tue, 13 Oct 2026 14:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: MGMT: Allow connection rate request as
 peripheral
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179190120527.334087.1616532744657945133.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 14:20:05 +0000
References: <20261012152803.66542-1-luiz.dentz@gmail.com>
In-Reply-To: <20261012152803.66542-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 12 Oct 2026 11:28:03 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Load Connection Subrate only issues the LE Connection Rate Request when
> connected as central, but either role can initiate the Connection Rate
> Update procedure, e.g. a HID device, which is the peripheral, does it
> once the HID host requests a HID SCI mode with the HID Control Point.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: MGMT: Allow connection rate request as peripheral
    https://git.kernel.org/bluetooth/bluetooth-next/c/fe921b758083

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


