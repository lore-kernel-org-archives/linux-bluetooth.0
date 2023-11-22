Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B0451028
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4X07oIt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DA12C433CA;
	Wed, 22 Nov 2023 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700674824;
	bh=QODoAUhmWLd9utamUei2lzR6ILk3TaYy63KIVA04ylY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b4X07oItfzMHlbPVQpE/1TKatxOlnlhsBZCfMmX3Vfi8ygG+O2rxboGKtiFEAOlnX
	 1c9jIvnoajuQFZJLzioAL85zsFEcNhXJm/V1Cry0ywi24J43O7iiLPDpFicXj6QMlb
	 6CoitoUuQQI6jbGRShMn+1TK8ZRgNDpTEi92sXnAkmMJid7MDxahcZ4YAshr9tenGv
	 zhA+05A2I9BJQg7BeNtLP8HaRVLzerqePatKh7hQ6USsDBMO3GFhczK5jW3PJ+8wUE
	 kyhHcm+zyMGv+K6n5zNWzZxnfohSArNiqqjAjOnXjM0Cp8m370rNN81aPHxUEY4PKt
	 8aFl5nIVWT4pg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46F9DEAA958;
	Wed, 22 Nov 2023 17:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND] Bluetooth: btusb: Don't suspend when there are connections
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170067482428.16276.2411054203681899242.git-patchwork-notify@kernel.org>
Date: Wed, 22 Nov 2023 17:40:24 +0000
References: <20231121213200.680095-1-luiz.dentz@gmail.com>
In-Reply-To: <20231121213200.680095-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 21 Nov 2023 16:31:59 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This checks if there are connections before suspending since that may
> disrupt the connections making it stop receiving any data if remote
> wakeup is not enabled.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [RESEND] Bluetooth: btusb: Don't suspend when there are connections
    https://git.kernel.org/bluetooth/bluetooth-next/c/d4a9d62c7f82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


