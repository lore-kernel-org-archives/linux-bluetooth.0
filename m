Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC723B52E2
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576437; cv=none; b=LxrPuvJzVKrW0peY4JbhhcouGpGd8sGjcZ/25vRBV+m1XI6fpqRfULAOMmP66jN0mx5ebRQUTwijAhj1DJAG6hyYDIcSV8nmXlBmsXhJdhpCrg7XGUImqL+x+YGITEN+1tezaFloULzUImSqRlu0NNpeGUTQMkct9mjuje1neQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576437; c=relaxed/simple;
	bh=VbIlYSbz0or3l2HRr3nyih/lq+3Fr1fZG5LUpaU/qJk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tnozuht1ZjY+3qJDtzeCpX8iuAhum/DJtp/g9qv9LId0mIIiKLZXf1zhbZGiI5Bsiywwch3O+giGj7hh7GDG9nY9b6Csp3GQ9Qz+V9M48cgSCMORuq9yFmyjadF9pUo7pFtpclAGS8Nmyo29UwvMZ9LR6zaTE0a8QB/oe/TKsgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRFvLLLP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRFvLLLP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93091F000E9;
	Mon, 20 Jul 2026 19:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784576435;
	bh=YiR00BPrWki7aRf1jWyJ4Ji/W3CxH3mEE58ELkhmcG4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KRFvLLLPA8DU/3p+GP0o9uYeu/K4an6R1BCVy7PiA0TZ3YTrIPsveKnmaBpeMq+w1
	 B3LZdfkZzjeJ10LowgHid2esDGEOUhx+O4f/MHUb6VZ47vfjJSPJ82ZO9CrfB5eb0+
	 jN+KBbkcugSJbLsyBHNlJBAkUTkKxL/sRRSXhrrYWYypIbaWApnZge5CpGLRrAbW3P
	 5woeXvRMjjhh+uWdx6DczJJLRH4JSDU3E3UntaFr4kdVXJ3twUpDqtbq+ToEwUfoBc
	 nYmv+H3spurfrVO6HhLn3SmjVIdECeg6n9a+DviokgpFXL+6uu47E8JdYt8HqNkfj1
	 D/xM/mCvfcdxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198DD39244CA;
	Mon, 20 Jul 2026 19:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] adapter: Infer BR/EDR only at public LE
 addresses
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178457640590.4136385.4018219369100632126.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jul 2026 19:40:05 +0000
References: <20260717082347.8429-1-pip@pipobscure.com>
In-Reply-To: <20260717082347.8429-1-pip@pipobscure.com>
To: Philipp Dunkel <pip@pipobscure.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 17 Jul 2026 10:23:47 +0200 you wrote:
> btd_adapter_device_found() records BR/EDR support for any LE device
> whose advertising Flags lack "BR/EDR Not Supported" (EIR_BREDR_UNSUP).
> The address type is not considered:
> 
>     if (bdaddr_type != BDADDR_BREDR && eir_data.flags &&
>                     !(eir_data.flags & EIR_BREDR_UNSUP)) {
>             device_set_bredr_support(dev);
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] adapter: Infer BR/EDR only at public LE addresses
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9965f36c6318

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


