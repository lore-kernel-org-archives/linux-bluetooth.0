Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BCF747F
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jun 2024 01:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717551632; cv=none; b=T1bluNGUxeLCZgP81uHaHAuT4BD5lXmIbqzhdfqaK2iPXNPnfNXNCOnfsfMZuBJtmyPDUoIlRtv69ZbvNcU2elkI88BGr8m4yV550PV25Sl4BOB6yWaGbF2dCIfCw0g0rk+qA61NrwBiDuu/sG91veDeHmGQYyl/3To4GtCpyaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717551632; c=relaxed/simple;
	bh=rj0ogMl8Fd29mGvb5dkyO0hAG1Te5eQqoChNmG/FqFk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OHiVyy2pdwzqOVPBhcEsHHcgAdlFsOy5PA+TR7j8N3phY35fJeBFREkSvLRAuzX6Mj5dgNnSEzsoq7LglZf137M6dZAem+QZMqkbZQwTKvbm/iQ0+FKF04pcZKBJ+p+0+yr2xhQrbDun6Dw55lRf5U03Diky3nXjf0KF/f7lN68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZFeV7yZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZFeV7yZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A283C32786;
	Wed,  5 Jun 2024 01:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717551630;
	bh=rj0ogMl8Fd29mGvb5dkyO0hAG1Te5eQqoChNmG/FqFk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PZFeV7yZ0fhQfyrz0Vagi+NVJ8x3ocyT6s5Pmkc7Vn+IJOwcOzebJcZbRddUJtD/q
	 mv/nZh/6GpKtE3pClGUiVMkQJIkDf6+CzxTvqQMgLZnutSOj1sI6Yg5X8o7USKbH2w
	 7AH23JvGrI4M/Ajv0baIFS0PAdS09rmMw4MAE7fvNJIErR/IbUbTsW3HF5pNbKmyhW
	 uSyl9nWITSRFUir5NLHwIIuFZf4/TK2F5VpETUVMLvKKFRJt6RFaQajN+rc7FHf3lb
	 URz/239gvkL+8pfIN1QyTwmVubgWHvk/0RCbrqBp2JZo6Kn8dpjkt0qNkSIviHnbJv
	 hoQ350U5uG3lQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70853C43333;
	Wed,  5 Jun 2024 01:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ,v8 0/5] ASHA plugin
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171755163045.4125.8298101571522067583.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 01:40:30 +0000
References: <20240523155301.140522-1-arun@asymptotic.io>
In-Reply-To: <20240523155301.140522-1-arun@asymptotic.io>
To: Arun Raghavan <arun@asymptotic.io>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 23 May 2024 11:52:56 -0400 you wrote:
> Hello,
> This is v8 of the ASHA plugin patch set:
> 
>   * I've now refactored things so that fd management is all in the
>     profile code, rather than shared code
>   * In the process, there is bt_asha_device struct, so the transport
>     only interacts with that, and access to the shared bt_asha struct is
>     more cleanly mediated by shared code
>   * Absorbed the connection parameter update into the first two patches
>     for easier rebase
> 
> [...]

Here is the summary with links:
  - [BlueZ,v8,1/5] src/shared: Add initial implementation for an ASHA profile
    (no matching commit)
  - [BlueZ,v8,2/5] profiles/audio: Add an ASHA plugin
    (no matching commit)
  - [BlueZ,v8,3/5] test: Add a script to test ASHA
    (no matching commit)
  - [BlueZ,v8,4/5] gitignore: Add compile_commands.json
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5c793eb3c55e
  - [BlueZ,v8,5/5] gitignore: Add __pycache__
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=61776f0de7b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


