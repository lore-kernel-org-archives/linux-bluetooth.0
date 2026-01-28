Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2965A33A9F8
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769637012; cv=none; b=PSJrknsCX0eKoz9teSbI2wx/VydBREtnHoq8ZxXDpAzzlLoNcu8CA7+EGGHfUWQAMn8TRWhvdF4whRkXsAUXb5dn8GkT0zvYWANRQlHahEvGsIjNiFuzD50hjMOo5rxNbu544SEPwtm0QEX3L5nDTqqvvAVwD0VoZcJ80/YHt5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769637012; c=relaxed/simple;
	bh=ePLtc0vXj5ZLX/8O5tu90tYqf9PRY2R1g+FB/wKhgFQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cArGe8nXxaB3cUBEXdwlDU2+ZP3IBngUk4k0+Srhrz+3etfX7mQXbMrGgronbAE0ZTYbC6IByE4K7QZwHICrC7Sz5OA4sy8wSNevuakqQasmEnxSl3+1RNztuCwjkmUvzhd+ML6kAoAeG6dWArbLncZdkIXfu8zhU3W9X8U9pY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvCwCegG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvCwCegG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A91C4CEF1;
	Wed, 28 Jan 2026 21:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769637011;
	bh=ePLtc0vXj5ZLX/8O5tu90tYqf9PRY2R1g+FB/wKhgFQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PvCwCegGtXlO7DQmYdWX0R+i5ucEB/JXQOFEEyUFQh5CLM63NwSzGsiV/QnAC8CNs
	 bVRUfaPo5PCHXk9cc45r+ctihWNjADBijmLP/rlHbPlvSBzwTHPSqyjM7T8JJ75Gl+
	 f9eITuHrFty0pjfD3Eh5/QJkxoR+pr5t+1E7Eln8m3ha5VpZVhnsee7xMj8I9hTDf1
	 crMge8kaAym2adwFuKJ6ALGk2eTUqy4NdnFPBPn11owGoP3WDyWcT1CDg1ATGW+Vh+
	 aFQfabeePSUk33JpN2zIQE8hoCyMSgiU0mZRNYGaxkSljSi6Pq0QHpWOZhcjr8DsE8
	 azpNc00sDjbfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11B5A39EF953;
	Wed, 28 Jan 2026 21:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] build: Remove SAP support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176963700485.2244560.8654968252856548726.git-patchwork-notify@kernel.org>
Date: Wed, 28 Jan 2026 21:50:04 +0000
References: <20260128183454.545066-1-luiz.dentz@gmail.com>
In-Reply-To: <20260128183454.545066-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 28 Jan 2026 13:34:53 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> SAP plugin hasn't seen any updates in decades and the industry doesn't
> really use it anymore.
> ---
>  .gitignore               |    1 -
>  Makefile.am              |    3 +-
>  Makefile.plugins         |    8 -
>  Makefile.tools           |    4 +-
>  README                   |   10 -
>  bootstrap-configure      |    1 -
>  configure.ac             |    4 -
>  doc/sap-api.txt          |   20 -
>  profiles/sap/main.c      |   31 -
>  profiles/sap/manager.c   |   60 --
>  profiles/sap/manager.h   |   10 -
>  profiles/sap/sap-dummy.c |  364 ----------
>  profiles/sap/sap.h       |  168 -----
>  profiles/sap/server.c    | 1411 --------------------------------------
>  profiles/sap/server.h    |   10 -
>  test/sap_client.py       |  930 -------------------------
>  test/test-sap-server     |  152 ----
>  17 files changed, 3 insertions(+), 3184 deletions(-)
>  delete mode 100644 doc/sap-api.txt
>  delete mode 100644 profiles/sap/main.c
>  delete mode 100644 profiles/sap/manager.c
>  delete mode 100644 profiles/sap/manager.h
>  delete mode 100644 profiles/sap/sap-dummy.c
>  delete mode 100644 profiles/sap/sap.h
>  delete mode 100644 profiles/sap/server.c
>  delete mode 100644 profiles/sap/server.h
>  delete mode 100644 test/sap_client.py
>  delete mode 100755 test/test-sap-server

Here is the summary with links:
  - [BlueZ,v1,1/2] build: Remove SAP support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e328fde3e2e2
  - [BlueZ,v1,2/2] build: Remove health profiles support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e2551c5b9809

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


