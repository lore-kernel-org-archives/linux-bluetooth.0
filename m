Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBD026ACD
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Apr 2025 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745024416; cv=none; b=W8ph1cQMSGyZNB6S+gfhCY7CMnb2sGvC1THNev3e/XGfA6Qbi/eXfWhfQrenOlFKandnXCPkRmfakR1qO4QZrvfwvKtFE/72BnXe4KbeiNozw9c0YLyzBW+yuVBA1SOSt6fjlgv1HzTkp2/MgQH4qSxVZP5ai4uslsqHimFkYHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745024416; c=relaxed/simple;
	bh=3HEu9994bp79J4SQWsWvyBZ/ez9AgJNVZKWupo/yW+0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pacqs2NpEYzO9rj2KAv8GtLCHMDfHuenmebHe4/ZlRmWdIScu9GGtWywIFOSU/fdv6QITyJXSHHNwbL4394PjD18HRIpXLxLEiVXgCEgvDxFUM3e03UI3fnHZFxMS1aj5WW+k8tI0tpY2VwDJG7vLReeh6d3GQX0b0Kw+J+6c0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8DWu5+q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8DWu5+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DDEC4CEE2;
	Sat, 19 Apr 2025 01:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745024415;
	bh=3HEu9994bp79J4SQWsWvyBZ/ez9AgJNVZKWupo/yW+0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T8DWu5+qP1Hc0JKUXLx0ZdXbKgMswjAXFDTr3zEaGr5UOXpvtMnksqtcL2J1SpNh/
	 3fYF4+GOyWvPb4lHmsTlfSbh8ngmhJd1+dHPWvm4iyfqF5kr1co2XFcpDvKav1Y3Jm
	 NPoSDLshA7EQ4j+p5yVD/5/JUpPAUKTCsbyxFait6wxUBFx/WySiLBIUTJA18txvP0
	 Mt4pz32863GNtqKE40eNkkMuzLJerRttVGDz74uPuqcD/4tldrUyfc+Oeoeo6Nc5fB
	 5SZZh6vQybMkPlbuVA5nPOH1JeKVmrz2Tuq96uZSu9y7/1+Cw0/D1BSF6x5L5RzSUh
	 eCvA1+DQAIMtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340103822E09;
	Sat, 19 Apr 2025 01:00:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] workflows: Add stale action
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174502445399.359361.3475080413268048121.git-patchwork-notify@kernel.org>
Date: Sat, 19 Apr 2025 01:00:53 +0000
References: <20250418211013.304822-1-luiz.dentz@gmail.com>
In-Reply-To: <20250418211013.304822-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 18 Apr 2025 17:10:13 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds stale action to which marks github issues as stale after 30
> days of inactivity, after an issue is marked as stale if it remais
> stale for another 5 days then it is marked as closed.
> ---
>  .github/workflows/stale.yml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 .github/workflows/stale.yml

Here is the summary with links:
  - [BlueZ,v1] workflows: Add stale action
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e3c5f6050a8b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


