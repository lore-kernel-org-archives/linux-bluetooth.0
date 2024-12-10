Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7C2205513
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Dec 2024 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733845404; cv=none; b=PxC/F72+Pq6rEnTgDixGLnB0J3djvm+b/YchMR0AfRam2TsP2wdwuelLZBu/ju2U0rk4c0F7NwuA1o41D8n63pt/tnB7L+GV/bZci9HydDKo5Fm0oPvrr9fRmc/MGTktzYWrclJrVXrkdVQonEnEXqatLvcI+bJivPhewW/1eP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733845404; c=relaxed/simple;
	bh=DzdyBvM3z4oM7zyegJHNAkqLrfN+piwex3GsfVmRi8E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eTifTUC0OLfiPwBsPoS9cK6MMwSWZPyJ66VNm9+E+8Vstmt6IjqOx2L1jB+urtPuFH18RLyWqxJh6TZ8R3D4HmH/V9Irl+hxhoyxDvlvoX9yAhJNUwGQxVMYPz7jEe52FS7hT2qGJ1zCOmshNp4X8t1O82s5TUWDeUJ21Nu0k7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDU0vj6I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDU0vj6I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B2BC4CED6;
	Tue, 10 Dec 2024 15:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733845404;
	bh=DzdyBvM3z4oM7zyegJHNAkqLrfN+piwex3GsfVmRi8E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uDU0vj6IEFOHBUX+mhdA9shHTM4w2nrNhm2CFtIHy3WWestKnUIGVmoJkF9CcrAyn
	 N9BpS56+vhpcuLK50oJ9hPamXVvqL3/1eqYqe7GIKLff28THholZuAUKjJJCXJPFKF
	 EC5eMVsIm53xnAKUI/ru4Z77gCikInEvXodOPCUAkwMuTmrnmahTu1eMxgJkBzzKJ2
	 V+VQ8OrAuA9qZUJ4PJr0xqDoJ7VMmrN2fFdc0imiv1vxEtM8mFNA8lIpJMdHLcHE20
	 4aJnDATgwHkNNiNA/+2CK9tzS2hmKn4ZnEKX7NbuVbWm39/iPPYtoa4gQK1kv9CjCC
	 dw3V5MkJE0jBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CD9380A954;
	Tue, 10 Dec 2024 15:43:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] Leave config files writable for owner
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173384542026.849431.12616062586965413185.git-patchwork-notify@kernel.org>
Date: Tue, 10 Dec 2024 15:43:40 +0000
References: <20241209154043.105358-1-fiona.klute@gmx.de>
In-Reply-To: <20241209154043.105358-1-fiona.klute@gmx.de>
To: Fiona Klute <fiona.klute@gmx.de>
Cc: linux-bluetooth@vger.kernel.org, hadess@hadess.net, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  9 Dec 2024 16:40:43 +0100 you wrote:
> This is needed for builds running as non-root users, so the build
> process and any distribution tools can create/move/delete files in the
> config directory without adjusting permissions separately. Limiting
> writes from the running service needs to be done in the systemd unit
> (already the case) or init script.
> 
> See also: https://lore.kernel.org/linux-bluetooth/4d1206df-598b-4a68-8655-74981b62ecca@gmx.de/T/
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] Leave config files writable for owner
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b1fd40996000

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


