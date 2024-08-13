Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A851A071B
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Aug 2024 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564233; cv=none; b=Qe3PNBhLJdqiZOjkfaI8/DApOsxJcjeFseWtX7cTNc6DTgd3C5MnxQ6A8BDFszxR+DG1zZHP0va66A0pySKyrCKcKuhADyHXcwMZUGiY+Xw6HUfzcu8DfgrkhUjgZeS+aaLjiBOe4gHRlpr/U+ZciLu1i/hems7NaElrwzYZN2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564233; c=relaxed/simple;
	bh=GliPQRE/Y6Kxff7VuaIvEZ/0nlU9+Sm5231JssFps1I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k97otJNyw2CcU6CG07wcVpkicPnn7upJFOjcPr4Q6P1XDqngXj7wGefxGo5U0PsA0UodN1+l1efqisCT210t/kn/8syC70PELpKyPl1LBnucsL86HpxxRCA+jycJZsIqiqO7/6POJpXBmZRisU7d9RgF21hbZIN9b2eQ3HyLWfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWTdLQ4Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWTdLQ4Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9001C4AF09;
	Tue, 13 Aug 2024 15:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723564232;
	bh=GliPQRE/Y6Kxff7VuaIvEZ/0nlU9+Sm5231JssFps1I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qWTdLQ4Y61Va5SKNlzQviB5edTllMClxKaqDpQzigxaS0toyDB/dbT6iMezxFd9Qf
	 Kn0ur8oO+NR+qVhmAD2REukUuzeCmCx7kvOHOE9zmzPIhVgR6e/RcdwZTvBBvRzv88
	 Gjp+rDhoBAmmB2X/onvOWU/0Qa19Puy/cUgLZBX1PZ9pArbBXgLzOnrBcw055vhd1a
	 5PmxujA4gBR4e7Z56nbOqlqVYo6vsmeBTgKTcNiqh7E/KDLpIv1+ImZHS+KKBXw2fT
	 ef2wD8o4/Btp90XVJjvx+Mw/tJurJbc9MlPLCxJRy5g/4KlrM8bpZdIGxX5WisCm1b
	 xQtYxXGOM/IeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BFF3823327;
	Tue, 13 Aug 2024 15:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 0/3] fix errors found by SVACE static analyzer #4
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172356423173.1679641.571163532568832268.git-patchwork-notify@kernel.org>
Date: Tue, 13 Aug 2024 15:50:31 +0000
References: <20240809162252.50098-1-r.smirnov@omp.ru>
In-Reply-To: <20240809162252.50098-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 9 Aug 2024 19:22:26 +0300 you wrote:
> Several bug fixes.
> 
> Roman Smirnov (3):
>   tools/rctest: add NULL checks to main()
>   android/avctp: remove check in session_browsing_cb()
>   android/avdtp: fix leak in avdtp_new()
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,resend,1/3] tools/rctest: add NULL checks to main()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b752f760da47
  - [BlueZ,v1,2/3] android/avctp: remove check in session_browsing_cb()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=19ff9ab91512
  - [BlueZ,v1,3/3] android/avdtp: fix leak in avdtp_new()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=537e399aa096

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


