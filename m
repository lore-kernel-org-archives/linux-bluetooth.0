Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFFE231846
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 19:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748547596; cv=none; b=UcPAzdsWYj6IrQ2aTddBbMaXzpI/sJ+/frV6WRCy7RYCYH0mOOVGUZbPRZdkvIV4WnuUzbiXTvgcWdknehC+V5jMwyCXqT/DpGTpJ5qeaW1J56araNVo1ZoWpgAdDApiU6Em89JjH7+pnLTJ7VUxWCZvBVHCVx6c/HEn04GEruc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748547596; c=relaxed/simple;
	bh=R8nnRcKoRdp6vqHikJBPaNb22a2w6b6gahofuqmEetY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R7SKwlamS0A4KdDGuEhU6e0DvArcMZrtUORCsEzjPflzTdkeW9ebIbp3+yda8FXfuiGw75RqkFb/WN6DKa6G0du+Ziu4l4OP3YZ/1S4x/QuWxi5NIQ7kNPv6ProGVQoFNpljPG0An22EQYF+dpaF0rd8CPy92G9hobasa68zNzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWhJetYT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWhJetYT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46133C4CEE7;
	Thu, 29 May 2025 19:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748547595;
	bh=R8nnRcKoRdp6vqHikJBPaNb22a2w6b6gahofuqmEetY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AWhJetYTesW470tvXK9BXz2iUf6mMvhhBl/h01I7NiQ7sMvC0YmL5TVfEZFU7RNW5
	 t6qKxWyaFOelX0FuZgl4JMyKP+43vzitVCA3AGb/An8lU081sTmUFfDy43d8QhbFaH
	 x7FB+ZAfXluF0hPpUTBhDlJg6MdhvrK8QGqm/dhET2VzDhAMdEBXnKR1HQ5TMFKENu
	 UuMk4OJqHRGvpOxdhFwmiig/P0lS/9WohvSsI4Ry0SQrne920CZVvf22b9Ldu2lTCs
	 pkuVaCmmVCufxm6eyPrDtCFZ5bzLEOImBdQCOD+PXNLSCmoF1pQaX3MG7GK1IVpq7z
	 k5emPHhwRStLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AE6380664F;
	Thu, 29 May 2025 19:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] bass: Fix not setting SID for assistant objects
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174854762874.3369736.474330597989684058.git-patchwork-notify@kernel.org>
Date: Thu, 29 May 2025 19:40:28 +0000
References: <20250529174349.197433-1-luiz.dentz@gmail.com>
In-Reply-To: <20250529174349.197433-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 29 May 2025 13:43:49 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The assistant objects shall contain the SID so it can properly be sent
> with MediaAssistant.Push/BT_BASS_ADD_SRC.
> ---
>  profiles/audio/bass.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] bass: Fix not setting SID for assistant objects
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a805bae3dbc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


