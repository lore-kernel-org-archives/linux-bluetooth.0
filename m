Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0544908CC
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728058; cv=none; b=IE+Ex72eBFL7pOAmgF5svaWTlJWhu132xuOKIF6ib/I2RrQY/W8owheBgd3usUwdlYdr3uMKSQ1t1bPTsRjSR+gLWniCCyK3m09nSjJbQ/UurB9jbjW+Uag/VfsYXwkmvO/RdDnXTJgzNaeiHW+1nh0avacTcUDwpTKFuuTp8mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728058; c=relaxed/simple;
	bh=tq1ZoUEEGbOtIJ1mi83GwIzdaWIQjBK4y0Ablx4J6p0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=npR864EyaGhvc/Eqlu7o0IovKStkZTJc2ILSyYYVMhfy7Z5jD8f7fkLSy3qQLeh+coFas43OWypIJ2UJNZSTAWge/GRVLPM3QudbCwzlgJ5SKcjKt9Yc5JFbi1b/K/Q6j8PpkL6TthUjrT48fLbVafaPo7Xlo5EmQ191AQVSJjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VK78ZIuE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VK78ZIuE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8711F000E9;
	Fri, 14 Aug 2026 17:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786728057;
	bh=0VifOuggSjQRH0BrZk/ZBgTRMqmKt5IHUz/njxBwqT0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VK78ZIuETo+NfT1gATAoyog7qxOEW76xpc7gmfl2U/JyGFwdGRiqM+wrkH3o+UvDR
	 42kxLMN69iXeSMh/VIqZ/7IunPVQQcM0bNJTlWKuiUQJViAiip1ty0N2lNCDntOdUI
	 2Lv+aF+cLMh/kq/+96rmNsqZ/tLfroTSRXw6wyHcazHsE+mf5Svn6f+zlGhCpnwUx1
	 GbA7P6nq7QLPHuxNCEG7QZEUbxlKAtsTlgTbRszcwD5YVxUx0YYaINfS3ofBT64ASF
	 7dRVjGpHMJwTlEWmex+wrEbpoWhuNapFFWnBwjtZRs7EsQkCb4mytomncAGZuJjhpJ
	 pooadA0IQ0+kA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 937A63924457;
	Fri, 14 Aug 2026 17:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ] attrib: Fix smatch "non-ANSI function declaration"
 warning
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178672801113.3885098.13144459149018536960.git-patchwork-notify@kernel.org>
Date: Fri, 14 Aug 2026 17:20:11 +0000
References: <20260814092747.3064311-1-hadess@hadess.net>
In-Reply-To: <20260814092747.3064311-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 14 Aug 2026 11:27:41 +0200 you wrote:
> attrib/interactive.c:175:27: warning: non-ANSI function declaration of function 'disconnect_io'
> ---
>  attrib/interactive.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] attrib: Fix smatch "non-ANSI function declaration" warning
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a01be7144cd8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


