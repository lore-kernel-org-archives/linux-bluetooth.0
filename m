Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5261DF78
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jun 2024 18:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717613432; cv=none; b=AX0TLW1zdulXhOvA6cyDkaKWRGn6XxLtHaIuWr/Wb+z3bI4x9yC0aLxWir8dJ3rp97VsDKFrXnp28z2aIiLsCXD9YXyQ6YcWdmCheoY7ECC/4Rxl+x4ul8jtb8GUh5QekEzciVyuFokSD8qVV5miBne4rh8Y0zx9702eYsEJ9zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717613432; c=relaxed/simple;
	bh=HiZEtax71waJ2pp4vuZDMxAzQHxJ9lShnKUkgj17vOs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bDbS2rjMui2P+2iT/6+6xd59JN9OEN42zNtBwEwBc61qYx+toV62q6NMrbkAZaVOCmOjNp3v6KSNzzjGz4lKE1FxdlpeLRpQPMJqrsRiRGMyl5RKeScUNCj1+SA1tKG0fOxc+N1Ijo9r7Vnm+AvlwzAQ5nfpMg7JMVm99qetErc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCQowC0Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCQowC0Z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94692C32782;
	Wed,  5 Jun 2024 18:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717613432;
	bh=HiZEtax71waJ2pp4vuZDMxAzQHxJ9lShnKUkgj17vOs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KCQowC0ZzvpdnN1yCS5IskW3tMbwJiHo2SPwPnF7gCHjQqB4AvOdS6J+KeOywtxBD
	 leBQ+a67yU87dDz81uHR8Jb1E/MGcDwgye8cjwfbpuz86PW+WUZlTrIqF0LOu6dJTZ
	 qtGvoRNz9Xlao+mC+suTHexNqqn2FMD7qdD4v1sx3dsqAz6zeAgEfkKn3Lo9sR8Q7U
	 r5knHOudK5w+emZ8phBqxurC81tmJmm78Fm9cW2HGV4wrbRidfA6j/Tz9sv+CxncST
	 j+EdgAC/2R1gNMOzsB5MMp2YAR8tUo7xK+N5lNFjDHDqUfikwQ8Uqh+nYePsXYM9Df
	 kFDn6iweuk4bw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F411D3E996;
	Wed,  5 Jun 2024 18:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] test-bap: Add Broadcast Source STR one BIS tests
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171761343250.31003.13756461300078740414.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 18:50:32 +0000
References: <20240604114708.33423-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240604114708.33423-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com,
 andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  4 Jun 2024 14:47:07 +0300 you wrote:
> This patch adds BAP unit tests for Broadcast Source streaming with one
> BIS (4.14.1 Broadcast Audio Stream with One BIS - Source - page 180).
> 
> Iulia Tanasescu (1):
>   test-bap: Add Broadcast Source STR one BIS tests
> 
>  unit/test-bap.c | 259 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 259 insertions(+)
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] test-bap: Add Broadcast Source STR one BIS tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7c619d864afd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


