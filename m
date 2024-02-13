Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D15612F4
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857429; cv=none; b=jbbQZLbwhzt9KI7spSFXGDOZtZ+oE6Gq941faoaZC2NEJolQb8tFcDymgxBO1GOtFoOQDvJY+2cGIn7gh1JH1ST1NdrewpluHX/3hghGIu5l6/xXk4PLR3kvCuKgKbVIcRVz7RqQtg4uMRvx24gLD8eaiZFhZ9Um8ME3cznZvgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857429; c=relaxed/simple;
	bh=6J9fQpWXB4d9nKa8n5Yv00yWrmQ2O9RrTXJj90bIGvk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=USq3lUPlHOS0Odn8bZORMPDN6zIG9+kzKMLfpRatsQr7/izJyMglYc15o4+/lXneqybsEEOJWLXuCFBEM8sgn2tyL8X9H18vRaQX+2qK1aLEae/0cCW62Ey4FX7e0RUCq+tD5OWlPkcbjfWr+FzuiI4jG9pf1kClSgCj6Ya4h5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYf+nNWB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYf+nNWB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AB70C43390;
	Tue, 13 Feb 2024 20:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707857429;
	bh=6J9fQpWXB4d9nKa8n5Yv00yWrmQ2O9RrTXJj90bIGvk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VYf+nNWByDi37CCkKiPYMW/YCql1cp8Tj/YOPbENkbQ+8KADM76dXWcglHOEsHHJ/
	 qVfVXubTDb/GtOuIylfBf6NJdmMtymSNfP1MiVoWCGFtGUKFnsazrQDneVF4ZeNUyf
	 oEPfN/8adl2b+PSB9ohNTfNspmSgehJa15if+QUnqFURpF37+OvAHn6lf+6OU+erwM
	 wJQCkxm/KmOXvb7A5Yqk6gEHguoe6m/g6zBsNhRQap1k7g2C0yt4202hxKcoBU1FoT
	 CB2rOCNhsKob1j3tR0UIMH63uMbIrwpNrXTxIq3ao+qYAN0ZBo3Kc1aSxzgvVpi4n8
	 vy2Apoc5J2aXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8A76DC99FD;
	Tue, 13 Feb 2024 20:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/3] lib/uuid: Add support to compare 16bit uuids
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170785742894.22526.11138711747518901620.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 20:50:28 +0000
References: <20240212161726.3097145-1-ajay.k.v@intel.com>
In-Reply-To: <20240212161726.3097145-1-ajay.k.v@intel.com>
To: Ajay KV <ajay.k.v@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.sriv@intel.com,
 kiran.k@intel.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 12 Feb 2024 18:17:24 +0200 you wrote:
> ---
>  lib/uuid.c | 9 +++++++++
>  lib/uuid.h | 1 +
>  2 files changed, 10 insertions(+)

Here is the summary with links:
  - [BlueZ,1/3] lib/uuid: Add support to compare 16bit uuids
    (no matching commit)
  - [BlueZ,2/3] lib/uuid: Add GTBS UUIDS for Call Control Profile.
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=24d97e35fcde
  - [BlueZ,3/3] shared/ccp: Add initial code for Call Control Profile for Client Role.
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


