Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A5C1E7C1B
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590989; cv=none; b=lIKHEOOtiEAPwqKBYJBiOqRKdVYc3v2krQEUIv9N4l2NWRM0pWTa8RUkZAnREaRomZ44xqchPL7UpQuHVNp2filxHzjJVZTQguhZAxVhUxeY8uQRfp2DtTKzlnFW7kqzRYjjEPCKZBwTT0R3NYKPZDV7ui6GYMBsbVeIL/ALcu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590989; c=relaxed/simple;
	bh=UmVOPoeCiGSQF8cZrXMY55y3ZbhUq+fSh6Ca3P65g24=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r27LEDbOjKpTWU4rQN5CNIR2CQ2h2q1VXgbyK6t90kpuLdIMRKK8we90pjdc0VXdE1Em+TFFMYRPk3YZcOFQofj7zo1QlDImzfks3Oea8pPgyVpJcNdoAtAvqeLAWlZDZ5XLrWGqYRSX89J7kxFEr32GJELNrH6vQ4ZVF76G+5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1tKiQNV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1tKiQNV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B190C4CEF7;
	Tue, 15 Jul 2025 14:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752590988;
	bh=UmVOPoeCiGSQF8cZrXMY55y3ZbhUq+fSh6Ca3P65g24=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T1tKiQNVEmzXBtiwFGggTBaxmlzsU8PBGaHOTeAJHIsUOANf/WkkhP8wjpLRrX05k
	 RZgbr9J/d8ulz9p5JG43OOx3G1u1KK6M5aHJeyHq+FxET5yoV3GH12f1VyhucmKKfs
	 T8tLs6SIZIOHGmfK6x1jh+S+xc+zotAFIAUljLyTeykppZc3euSF6bEBZYuDEuDKCh
	 yUzEyKHjRjBjKpyEvSdEG11XJEK7Xr+xSEFcy+5tzVhdUCEFgxOyCg+PDX9k6VBQ4O
	 QRML5U5qpNBTrtrbMc3KMSaYpQkkr1S0hzLqJGjOy4u9iSqpyEJoRapnNVYdWmdpuc
	 /tuP6QAapBf7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A14383BA03;
	Tue, 15 Jul 2025 14:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] doc: explain SCO BT_SK_PKT_STATUS socket option
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175259100915.468243.16870047813833062758.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 14:50:09 +0000
References: 
 <bcaacbd8544b62688da6e401c354e1bb41e62e3e.1752575647.git.pav@iki.fi>
In-Reply-To: 
 <bcaacbd8544b62688da6e401c354e1bb41e62e3e.1752575647.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Jul 2025 13:35:29 +0300 you wrote:
> ---
>  doc/sco.rst | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

Here is the summary with links:
  - [BlueZ] doc: explain SCO BT_SK_PKT_STATUS socket option
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6c3cc38da9dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


