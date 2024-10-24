Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821881E2614
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 14:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780232; cv=none; b=MVSa8G1KjhABcBShmZj5va52Lxpe6j/eeZV0XaEL+9uwDxeZHKLQCz1WPkYdLpiuYLxjXRb5hQwKesSa9PstA9/GKjuB3traNKroI1sopDFMAT2Wwqdgadlv/tcE5Xv2xfKiPRw9MMz6dPZ+QcR5I/iQhigRnlIB4iccCwTwaSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780232; c=relaxed/simple;
	bh=tR0zoTa8dcM//y8W3sLXJ7xci4X22D2cl+vXHHO2Bk4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g7s8nFuFwHKskrJMHzldE+pJ7mgYUbhJeohe8O8NOv249SPhu0hzS11EuxGN9LFgcdGDJ89fNLXSwbv5gU7ad3CBN9+PxgiixsfYrVKltbSeHrAJv7KKvEVlqnIYAAt9NrgOkJHss6oHJ7JyYD59igPcpBEii1G+6gShqu/curM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJeRPhBg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJeRPhBg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4C1C4CEC7;
	Thu, 24 Oct 2024 14:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729780232;
	bh=tR0zoTa8dcM//y8W3sLXJ7xci4X22D2cl+vXHHO2Bk4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dJeRPhBgyp4hqlhrAH1n3/VVTl6R4Hi14LImzJK232PrepyTRqtKoXcCCP1Z5FMaE
	 gNjajv4CxSCrPtUbbkvW+eLMPz/l4a4YYW6aDqS9kn9ul9X09FuT7EUlpks/z9Pvll
	 aAIpKy7JotWj37WF7zmUJSAJRTu3BA3uC8+XPlIyCpfuoKEl6MsVIbuik/W4TXdCiC
	 fcdOoLoB8Wj9FoeTPgswTnkfvO37A5TYBoVZln2RHN6aU3PIv4xaRvsuHlA1DkhUf4
	 2K7JySBmb3eQ0ffgrcrq0+X433AlNxYDdnkEX/fcjjFXy5DlW10LFBzXRwuRoHEQ6n
	 cF4BhoNWiszBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F7A380DBDC;
	Thu, 24 Oct 2024 14:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] obex: Resolve SRM issue for PTS testcases
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172978023880.2259464.14247225569218477048.git-patchwork-notify@kernel.org>
Date: Thu, 24 Oct 2024 14:30:38 +0000
References: <20241023071448.1017724-1-quic_amisjain@quicinc.com>
In-Reply-To: <20241023071448.1017724-1-quic_amisjain@quicinc.com>
To: Amisha Jain <quic_amisjain@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com,
 quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 23 Oct 2024 12:44:48 +0530 you wrote:
> Add check for unknown/undefined srm value.
> 
> This fix is required to pass the below the PTS testcases :
> 1. OPP/SR/GOEP/SRM/BI-02-C
> 2. FTP/SR/GOEP/SRM/BI-02-C
> 3. PBAP/PSE/GOEP/SRM/BI-05-C
> 
> [...]

Here is the summary with links:
  - [v3] obex: Resolve SRM issue for PTS testcases
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d35bae15152b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


