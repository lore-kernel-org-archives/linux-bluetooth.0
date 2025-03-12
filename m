Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9CB1D5CCC
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798201; cv=none; b=MWIR2dtrc7oaeyvFOjVX1VKy1QdppbUfOgI6ae3J9K3A9gjcNmh0K8ZXdQ4Yl17mPjVdFoTiBC0miN3sB6/2f/89z2fkT/hdLyxqyq7aYp1/rZgZs50kDs7al36LF36gKtCkNcMy3B91ZbS0oPaxl7ce8GcqrGp/4b85OS3mPKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798201; c=relaxed/simple;
	bh=IXmSNzcwjHHRWTSBQCnAs+iYPQ4IM59uY4Jp6vdJnxg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=St28gSGb73E5XEPWlnW7b8m+nhcDpJD8Qnx7mPg2LkaZOF4K9i+aCPdnVqtXdMh5E6ay9hhugafpq6tnuY+Ahm7ov7qBlJSbXegTTxQ2EmN++Mdci201NS+Ka2IiLyAlIA+BQ38s2X+HuRGpRf3o8iV0GC/hYoIV8NK+D7pQjUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5DEcPEm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5DEcPEm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04F9C4CEDD;
	Wed, 12 Mar 2025 16:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741798200;
	bh=IXmSNzcwjHHRWTSBQCnAs+iYPQ4IM59uY4Jp6vdJnxg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r5DEcPEm3wYLTK6QQLJF97xVyzgmaKWGEGY5gjtqN4WMVGtCqHR8xWdahzPPlsZxp
	 u0U3QrQrutBbZT6GJ1VnhiSQ+8FESYlxnSbJCsJ0Ioh7gTirxEbnGEME/Jr8whfAB/
	 49Zb899Z4JFkND5MLyMQYcdFbYSLQry9U0A9cyZ7xUPp3LbAEbjBxeOlWRVWnKxMCq
	 ZUhQxz7e6Ygtj7FEzaA30W8zUEsb/aPG90mTZZhpPeYbIYeyV+eEizIwNZ13gBJeur
	 5forjq6IUoOZ1OT3eEbNE2wE5S1ndKR2VaBYOBysrGbyxoy5XMoIM1WOPhL+zz9zis
	 ITnDy1irU7s8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70A32380DBDF;
	Wed, 12 Mar 2025 16:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] Fix URL for submitting patches
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174179823498.864475.4863833477388370586.git-patchwork-notify@kernel.org>
Date: Wed, 12 Mar 2025 16:50:34 +0000
References: <20250310104134.4124489-1-kernel.org@pileofstuff.org>
In-Reply-To: <20250310104134.4124489-1-kernel.org@pileofstuff.org>
To: Andrew Sayers <kernel.org@pileofstuff.org>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 10 Mar 2025 10:41:34 +0000 you wrote:
> The previous URL is out of date, and now just says
> "This file has moved to process/submitting-patches.rst"
> ---
>  HACKING | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] Fix URL for submitting patches
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d4749cfd7fba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


