Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA66253B4F
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099200; cv=none; b=WGhHYKVqSyYmo2UzKR+5CG1puEkmWytdZxq6aWAmRkiQamh38FbHCQ2a+aICZELsvr7k4SBo2C88otMqcb/xR0UGeRQPVV+ds7qANvvGHwUK0EgZfn4se3ypueMRZO7rFRUmCzlsLMDfV7BAHn03f8Bw10IR2aNc8Llr/keD+1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099200; c=relaxed/simple;
	bh=++oAd0nZUkpNqgWNcdp0zCuo4r02kcYFIVpF5auwVh8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Irh7rN57kCtWwuiMZz7sqEDibJnmWrBWN7roqtPqR9+mYNgTlH0nLiCm8WeUf76AaHaTkHsfm6OXIdgaKi/q0Mvjg2QsoYusvxifXDWAredBOmlFaYZeaStM5cM8V7DX5oi7PQeZUrB1AT2xJeCzdSfl9GusCig0Snm5kFf7qSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhGHB8zk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhGHB8zk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95090C4CEE7;
	Tue,  4 Mar 2025 14:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741099199;
	bh=++oAd0nZUkpNqgWNcdp0zCuo4r02kcYFIVpF5auwVh8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rhGHB8zkfNVrR2Ru3OXT6HQabZcjTGWX8B1+8E60NWK2nQyEo7sMOaf80/n71lK1i
	 m5muDojJ7Kvl6Cp19VYIbQtsOq2qoKBhRjNhimW5FAO9iGyioTlaAmKV4vyjib+/64
	 k+JkReHra1kyEQx1eqPWZvtsN9mVPvY+OgeM8NGHrgNpK1+wMiPyiTMQIN0Xg7sJKy
	 aMCE6BMXDNAkoOJjqMSiDFDyvVsb+28+frSOnswWH04sLnfsJOP3fe3NCmssWY4wXm
	 mMcxyV5ddYqlOBauu3ardmhwqTeNn1rdx3vJoJx9h/X9KNGo05+zEgsSZLXdhX7uPN
	 +xhl2BL08A9kA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD52380AA7F;
	Tue,  4 Mar 2025 14:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/3] uuid-helper: Add A2DP to the list of known
 profiles
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174109923251.166789.5438104960360882019.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 14:40:32 +0000
References: <20250304061959.34839-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20250304061959.34839-1-arkadiusz.bokowy@gmail.com>
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  4 Mar 2025 07:19:57 +0100 you wrote:
> ---
>  src/uuid-helper.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)

Here is the summary with links:
  - [BlueZ,v3,1/3] uuid-helper: Add A2DP to the list of known profiles
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7a09d207fd9a
  - [BlueZ,v3,2/3] client: Support single profile connection/disconnection
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2f48028af3a8
  - [BlueZ,v3,3/3] client: Document connect/disconnect optional profile argument
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=524fa22ed19e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


