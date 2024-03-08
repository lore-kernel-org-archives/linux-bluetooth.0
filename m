Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406822576D
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2024 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709913030; cv=none; b=e5R5QH/VK0AlSQeqrWmcrU1J4aDp5Vqnychck5YxzCzZWV1U5o5prVNIub9jeU+Rzxd5dBWl98QSTg2DbsyRRBDB1MMFc/L7Se9KuTayjKaUVytJhJgT5qWzqFI4qKSGyiwwALFHcXnI5JxeMxG5eda37Lzy7T88uyE4WzJ56h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709913030; c=relaxed/simple;
	bh=b0jL9z69hOhvLfcJc+7XOVdojzFqe29qXLyfDI7PbjU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aUBzxBtBeC16QRPWWv9yHme/Epx9oyG6Hjp+GAGicmt9MtrFzl2NEqlKIuPK7oPEGQta3FEZE6HxJ/3IRKuRSUVQ+bLkaM3e52VJGPJ2Vg8Red2qp5VZSLO+wumOIgH/YmejXIbX9z9mHhTPqo0yrGgvcPjenKKNPJjFtTLdEVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Na69t/kE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Na69t/kE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC6FCC43399;
	Fri,  8 Mar 2024 15:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709913029;
	bh=b0jL9z69hOhvLfcJc+7XOVdojzFqe29qXLyfDI7PbjU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Na69t/kEhwt5/MTmoCUrpb91xcLYD11YPK2q7hdJyaWnEiwz+bePHUVel6DwPlQO7
	 xwcs5QGaccAyJByQfsuirO6ynqrSPUPdyElanvCQHgAPxPEzozIuxbY1YrgxAW//3K
	 PvgWrcReynHZFrWhOJBL9lJ4p8M8xRg4diKP40fi/p9kKZUxOWNsRo8ceLoFDCPU02
	 Si6gTVrr0XdaY8tgovHBLhhbtgPI0MBsVhh+FKa8FBbLLp6FFAM/Kdbq1MZ+MEk5L9
	 +z5gbb/cVLckKTgoYU589BhNl29n3N5/HupCvDbRl0Tnm/ZQmXHdgRHa9hxmm7a9Qw
	 WWy5EQv22ZVww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C72DED84BDA;
	Fri,  8 Mar 2024 15:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] Bluetooth: Fix eir name length
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170991302981.6021.1858385197039417729.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 15:50:29 +0000
References: <20240307164205.1011133-1-frederic.danis@collabora.com>
In-Reply-To: <20240307164205.1011133-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@ci.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  7 Mar 2024 17:42:05 +0100 you wrote:
> According to Section 1.2 of Core Specification Supplement Part A the
> complete or short name strings are defined as utf8s, which should not
> include the trailing NULL for variable length array as defined in Core
> Specification Vol1 Part E Section 2.9.3.
> 
> The trailing NULL was introduce by commit f61851f64b17
> ("Bluetooth: Fix append max 11 bytes of name to scan rsp data")
> 
> [...]

Here is the summary with links:
  - [BlueZ] Bluetooth: Fix eir name length
    https://git.kernel.org/bluetooth/bluetooth-next/c/2ab3e8d67fc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


