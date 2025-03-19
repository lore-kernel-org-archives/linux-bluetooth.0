Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C9120B808
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411399; cv=none; b=TnMVwoTsBEulffUWeXzv6Xfw6k2tmjj+jNaPVTJhgusKT8yYQJeL3hYESqwc5tNqYQ6sWejTtAkybVcgybBeHIvUrZ2AeoHVtVLDEN2P9qLRM669nJ/2NacNu30rKfhRrGzULno/kyrFDUhEkCXHVHp1DSt+9gifReagLmtAnTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411399; c=relaxed/simple;
	bh=ELh1AqU3X9es8Nu1aZXzfXA12ZAkSA9yEdPZ+1sWJM4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sBq8HEP+bfBO+/pubUcOhel1MeylvMTUvsMLl9spZR6LnKioT9pn6UObbe7OiuPFRvrvpKc4b0molIyZQKjJbCCLQYVeVWCBIj2S4/YUBV3tYfIyQRV+7tqJaVh7P1mQSEJhbXWc9GNL4Svrq0WqOhzEmvt2Ss5bmune92xl2yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmIxKIkk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmIxKIkk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5306DC4CEE4;
	Wed, 19 Mar 2025 19:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742411399;
	bh=ELh1AqU3X9es8Nu1aZXzfXA12ZAkSA9yEdPZ+1sWJM4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tmIxKIkkHdXzasVq0bg5rPb87VbyU3z1vuQK9kSv7GfsUkpGPKBqyHc9Dv2cwdzMi
	 +E/U++6C3IvoySEsvXpWppEFplfXD4oysE6YiqyFV4pmPoMdUvzbZWQwWR31jHWeIs
	 1lkNMEUd6OBRdz0OJUPSc0Tt/IsSLAFozdXMAjoAgu09ILxRGbDQX+N/sbVDKTtOdu
	 cfRy4UsSSPQYoYanqUTT01tHUHquQHuQsBu5yot5vF1uRRP6UUyrC//lEJ4Rzu7mL6
	 /9pSGqCvJDvxGQAhBcfoczv1oso6xqybc9/kzqYceYpvsvQ/kaO7VxjNGVDMnYRmw5
	 35GKvoU4ci5Kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34758380CFFE;
	Wed, 19 Mar 2025 19:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/5] tools: iso-tester: add inclusion of time.h
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174241143502.1158753.5729727884437482019.git-patchwork-notify@kernel.org>
Date: Wed, 19 Mar 2025 19:10:35 +0000
References: <20250319103724.10433-1-ceggers@arri.de>
In-Reply-To: <20250319103724.10433-1-ceggers@arri.de>
To: Christian Eggers <ceggers@arri.de>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 19 Mar 2025 11:37:20 +0100 you wrote:
> Inclusion of <linux/errqueue.h> requires that 'struct timespec' has
> already been defined:
> 
> | In file included from ../bluez-5.79/tools/iso-tester.c:21:
> | /usr/include/linux/errqueue.h:57:25: error: array type has incomplete element type 'struct timespec'
> |    57 |         struct timespec ts[3];
> |       |                         ^~
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/5] tools: iso-tester: add inclusion of time.h
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d26a7f96cdd4
  - [BlueZ,2/5] mesh: include <time.h> before <ell/ell.h>
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6f26f2f8de7f
  - [BlueZ,3/5] tools/btpclient: include <time.h> before <ell/ell.h>
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ba9f9fbde34a
  - [BlueZ,4/5] client/player: fix printf format mismatch
    (no matching commit)
  - [BlueZ,5/5] shared/bap: fix printf format mismatch
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=50a01b0c17e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


