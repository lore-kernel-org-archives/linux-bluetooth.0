Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8862156FB
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Nov 2023 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I25OlTiW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CCDEC433C9;
	Mon, 27 Nov 2023 15:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701098426;
	bh=jP2elUqNM4qOWS1XuZG195KC09RzbtEtU8woRlSrhnQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I25OlTiWJVwh2VNDSZQil7ufEObtk/+7PgILZt9TDNuobpzqGSHyY0Y8HBxzLq0Tr
	 J8Z6i+gPZWto9hbSD34NjvEOv7PlPrdNKRLI1SCb10el5YvtkUb0+d6ayXztMZU8vf
	 wmSQZHjB1o27txlk74iysht+GShH9sJ53XtHl9q8js9re6i+wvXcVvQHP4Vhcd7Foz
	 vtU+sF4Q47bmuZ8H7yTvGEPlvym0+YdVkwQ9OvPR4rVroURGKs1Xw2gQK+yaYRNjkh
	 hRZadgA+pMo5EW6NSSZ+ygl+Rc02jlmRaUtb1eEzQaFXvYoA5DRUCOdCWIUjbvg56k
	 4WBt27Be6RAmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 450B4E1F666;
	Mon, 27 Nov 2023 15:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btintel: Print firmware SHA1
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170109842627.13376.8961624115373099369.git-patchwork-notify@kernel.org>
Date: Mon, 27 Nov 2023 15:20:26 +0000
References: <20231127044202.2456465-1-kiran.k@intel.com>
In-Reply-To: <20231127044202.2456465-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 27 Nov 2023 10:12:02 +0530 you wrote:
> Intel Read Version event contains a TLV(0x32) having firmware sha1 in
> operational image.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 5 +++++
>  drivers/bluetooth/btintel.h | 4 +++-
>  2 files changed, 8 insertions(+), 1 deletion(-)

Here is the summary with links:
  - Bluetooth: btintel: Print firmware SHA1
    https://git.kernel.org/bluetooth/bluetooth-next/c/514525d3087c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


