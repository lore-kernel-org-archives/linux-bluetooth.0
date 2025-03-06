Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E5912F5A5
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Mar 2025 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276203; cv=none; b=YAYLiRo1MewDqf/PUZg161fPRfnb3Xq/qtbwaM58dBy7GM0O3GRYBehB/ffiQbyz/sQMsgyeEAFY0hQg1YJf/5fr8ePvzGuz2ZrpBAJ+iAMhnCIuG7/VSgNpjmYD1UE2FNHw5m4suJVvBAdyIxc8tp8nSB3rA0X2J2M+pft5fdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276203; c=relaxed/simple;
	bh=UKHKZkVv2AA7Sb4EpVpbNeNjOx+MemfXHbDuFIZEidM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CKL7phTsrBOZy0wPyu4XeGII5enLAytTAIB9JRMjJ1M3h+rLJMxzA/uJkifr8LKIrpxD2jvPONq6g/iWk9AXp2xNUFOZcBIzr6mQFNGfJArSup7cFvXGbrCPSrj8k3aKuXpWbi3BkMTe2BWbGWweQE5I+yfB4lThACB2Qf3AQ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hscxy3Eh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hscxy3Eh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CC5C4CEE4;
	Thu,  6 Mar 2025 15:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741276203;
	bh=UKHKZkVv2AA7Sb4EpVpbNeNjOx+MemfXHbDuFIZEidM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hscxy3EhOpbgTQu0Mq4hVlCGO9EOVA+5loANZD1gP9EG21RlYal531t2oB/3biEDg
	 E3CiiO4dja4cka+2/x/Z/pdCf2jyGRD69S+hILjCegtVqbmhLpHUYZ5AKlw+cLGhTl
	 YaiyZuL5wkqd3dxjbI73+2Tzn6gmq7cTkJGf3bRSS/DerVi9urxsPkRYkEHGbRuTpA
	 wsYQP35OxYRQnOE2MfEiYmX3SF67fLz5ClSp+/MKCmwxKNwoiFd7W6l3t2JLUr9Aul
	 oDd62KSC+qrefDW2541VAmsI/DXFbvQemppVcicVa8BmAm0QOKJLKhZfhfjjsRlq+L
	 NsbPJexLI93HQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF7F380CEE6;
	Thu,  6 Mar 2025 15:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/3] bass: Register broadcast code request callback
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174127623650.1641239.16878353690398849064.git-patchwork-notify@kernel.org>
Date: Thu, 06 Mar 2025 15:50:36 +0000
References: <20250228155634.57979-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20250228155634.57979-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com,
 luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 28 Feb 2025 17:56:31 +0200 you wrote:
> This adds support for BASS to register Broadcast Code request callback
> with shared/bap, to be notified by the transport plugin when the
> Broadcast Code is needed at transport select. This is done to avoid
> direct calls between plugins.
> 
> Iulia Tanasescu (3):
>   shared/bap: Add APIs to register broadcast code callback
>   bass: Register broadcast code request callback
>   bass: Remove interface
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] shared/bap: Add APIs to register broadcast code callback
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2ca6e5215830
  - [BlueZ,2/3] bass: Register broadcast code request callback
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=518d2a7aa566
  - [BlueZ,3/3] bass: Remove interface
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=26bc1c9cd9df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


