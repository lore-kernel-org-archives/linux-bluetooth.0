Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5542C79E3
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Dec 2023 03:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVgEMl1Y"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E615C433C7;
	Tue,  5 Dec 2023 03:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701747627;
	bh=xAS/58EJEW8cHAFOVzTyQqc9P1a9k7GX/pFWAMs5S1g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pVgEMl1Yo61X8qtjh7N8VQzJ9OvUMrlRFBOHJCz2aLvx5dpDzE2AlLC9IAYXsjsa5
	 0aAxQX8uZ9ooYusqkxkDNtMvrX8U7XLTlA+1VH6tNemaizQ/TYAozMI7fOkRheyzxX
	 l15+W5MA5/uVqG+QL2UN/rt+ivq2Uv/4p9xaUqJ7cEMgijSAR1OyG7s4p/xczpyeRB
	 j2sZx+Ie8NyB37K8SY3FgrAKGd8UUFbVmUzZao9RotSu/FOjpDHeqEVI5i/Cc/HIsg
	 AiQLQvoCCHYKNH4Vm8uWUb/ZNMkm/5O4fLrMSerHmmHm5G7hg1cvn//sCD/ukSSNU6
	 JSYv5+jaPl0dA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02C34C41671;
	Tue,  5 Dec 2023 03:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] shared/bass: Functions cleanup
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170174762700.12231.10264691599952163599.git-patchwork-notify@kernel.org>
Date: Tue, 05 Dec 2023 03:40:27 +0000
References: <20231204165934.2847-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20231204165934.2847-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  4 Dec 2023 18:59:33 +0200 you wrote:
> This adds some cleanup in shared/bass code: use util_iov
> APIs to extract/push bytes, use new0 to allocate structures,
> remove redundant functions.
> 
> Iulia Tanasescu (1):
>   shared/bass: Cleanup memory allocation/handling
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] shared/bass: Functions cleanup
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8980f4f1f730

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


