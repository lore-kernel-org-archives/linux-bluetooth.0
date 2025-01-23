Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326C1165F13
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jan 2025 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737657613; cv=none; b=jn2HSZx3Zf/hUkVSgffD0XZY3R+M+34bmt7UJdAC326Y29amYDZCeQIK5sPLbS6PonNBWsZfUn63qMkWybmFFh12F1x6vGqDR1HDH8s7gTpitkM2zZNso7Jvi7d6N5IT++A+81BoEIuF8vA3RmWLm7bS5lPgTuOrff3RhvMLjPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737657613; c=relaxed/simple;
	bh=3SFlKhlzrdpPtdx1vSg4wXK2hbcW5c1PUVxX+XA/KtQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VM8sfx4/67db93mHZEeTfjXeRWle1abw58Bt6EP9r3hbcIAAk49l7CIeNv5KUbXt2QsZlMGQM+K+I3y6EVZ+fV0hLzdmNkbZmjrz1IaF7udYj39H/pvaAQQUQJX5yScj3Vi+BMumXQSFAcQUZXUvI5CYlFjOVUrgih0IVYipS5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8cvC1nS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8cvC1nS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8A0C4CEE1;
	Thu, 23 Jan 2025 18:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737657613;
	bh=3SFlKhlzrdpPtdx1vSg4wXK2hbcW5c1PUVxX+XA/KtQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W8cvC1nSP0TkDendSw5rhmvrHXeoc2BrtBLMwTg3rUarNNR6iQOREeSvoW02vID3S
	 imE79DIE0ZWAaPofVssgbox1EM6DSiT6Xxl1UdJH1l8+4s1BxImwMF8jd33nsaCREM
	 FDYkX6SteFRbR4vVo9MtxEy/2ukjWNYw8T0Zp2fyb6QcrRnSMjH6Eo8nWaVI0Lk7lJ
	 NuHg8HW0fZB9ZT+fLeWY6mqjfX/d25ziahL9rSOWsjbY54XEXIYX9IpxVCRcLdmEn4
	 ZHDJ2fBLWEtNwWVmA8rVCbgWd7lcO00Asr43VtNwZCWvY+pAGxcqUzb831LWtBtzl1
	 JlfR4azcJOKEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB684380AA79;
	Thu, 23 Jan 2025 18:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/shell: add proper line clean to bt_shell_printf
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173765763775.1461938.15914899422016036247.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jan 2025 18:40:37 +0000
References: <20250117180611.14869-1-hitechshell@mail.ru>
In-Reply-To: <20250117180611.14869-1-hitechshell@mail.ru>
To: Denis Burkov <hitechshell@mail.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 17 Jan 2025 23:06:11 +0500 you wrote:
> ---
>  src/shared/shell.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [BlueZ] shared/shell: add proper line clean to bt_shell_printf
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f2ed57ed555b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


