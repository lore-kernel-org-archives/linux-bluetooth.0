Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE0B24B24
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Dec 2023 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjFepkZL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98EC6C433C8;
	Fri,  1 Dec 2023 18:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701453626;
	bh=ryLJ45Q5HveYTXc9dEwCJh3D9NzLGZ3oTUwcCDqfxCY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GjFepkZLJchiUyUdMRUJlS+GzEHxmNJG7OhRLlr7WtXx9z9i/c6O3xUtzA67XYJty
	 z6ieutBiqKMPCiRoPrSfH1JuRWKr5kci1ALRyqrUM9qBaH5wfUIKDD9riE8Q1MtayE
	 yWONAQ6sh6nYIq5z0tVP+Y3PYIdqAWp9100h/CLd4//lF0Vt0MNxxMP9MxakYu159c
	 oxLCXFrqTBRS+DXn7ccbnqkRZrcexjGKvy5lJEjad57UFdZIOzHvUycUBJ7h7glvan
	 2udjOeZ3Pl2mvvwJEUpGsb3LckWeZSw+Xngr2h0oLp+R90uBadhGV9uPs8WCEZ8bTV
	 wLw4Al1w9Sw0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 865AADFAA94;
	Fri,  1 Dec 2023 18:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/vcp: Fix build error
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170145362654.10933.12458674054288282324.git-patchwork-notify@kernel.org>
Date: Fri, 01 Dec 2023 18:00:26 +0000
References: <20231130141040.2243867-1-luiz.dentz@gmail.com>
In-Reply-To: <20231130141040.2243867-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 30 Nov 2023 09:10:40 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following build error in some architectures:
> 
> src/shared/vcp.c:961:24: error: lvalue required as unary ‘&’ operand
>  961 |     iov.iov_base = &cpu_to_le32(vocs->vocs_audio_loc);
>    |            ^
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] shared/vcp: Fix build error
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cb1a3fd96c48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


