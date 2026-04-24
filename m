Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07ED3E5EDC;
	Fri, 24 Apr 2026 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777056649; cv=none; b=TdU+hdv6fnHtMml5bZW6t80xTdgZVVP0QnlPnw1ldQaOJGBTaRBxxNGAN4E0wSw0OeGqMi1KNpbkkTNf/wNGOT37rw8klD1qVLmnYjdv4ERSfpDKmvN6siLyogp2sjAAcjrn/zIp8xl7Sl0ePpM/duW/ii56TYkBjqwOWun1dYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777056649; c=relaxed/simple;
	bh=/HmWbBRzv2bdxtNoRQsM/QXBmP5tXQFB8Lthz0780gw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c3m2NZiJSbrXfq4BSda94KUosS/ybeWGUAXOjtSeWTY2Bta2HPRVQkSK2sPRIywDo4Gi/PibVOafdUFtVEqMX0HTAA+VSfA77wRFzDLYG9Y8wfIxnDMWoOKQOUurYPl+gHfLpC/R/wlIsiO/j4ivdg0cStUU8UU1MseUsPNNT5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBqd7Bo3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBqd7Bo3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AF5C19425;
	Fri, 24 Apr 2026 18:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777056648;
	bh=/HmWbBRzv2bdxtNoRQsM/QXBmP5tXQFB8Lthz0780gw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BBqd7Bo3qIrTRr98/beIPG3OXkgCUBOikTCzcgF3chOaYa4keaqK8fKxvOMgE+0IU
	 sItF1mD/+0XtBUAmBvnpVpnQEPc/t4helXhMF2861WyI53f+g4mnTbW20EpabOjKTY
	 wi/qb2fQvMG5u4fifYhG7dcnpgCFGhDM2aytHXGHMt6Sj6K/XeJFci9EKVsHhPMJon
	 8yX8upu7ngV3ZqXyMTXbjOk+JEdvj3onp5io7OVuLNQMzKYSEQsc+rYP6bXh3IikZ3
	 KaCnUlVjSI2UBfmL6UhQcCZdqyyvH92/MOjJ8ekqpzKvf7Tng6D/MmnlvE101FpZHu
	 0ja8anuexX/jA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02B9B38119C3;
	Fri, 24 Apr 2026 18:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: RFCOMM: pull credit byte with
 skb_pull_data()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177705660854.1662901.6374144616828981672.git-patchwork-notify@kernel.org>
Date: Fri, 24 Apr 2026 18:50:08 +0000
References: <20260424070102.1-rfcomm-v2-pengpeng@iscas.ac.cn>
In-Reply-To: <20260424070102.1-rfcomm-v2-pengpeng@iscas.ac.cn>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, kees@kernel.org,
 kuba@kernel.org, mingo@kernel.org, hadess@hadess.net, tglx@linutronix.de,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 23 Apr 2026 23:31:00 +0800 you wrote:
> rfcomm_recv_data() treats the first payload byte as a credit field when
> the UIH frame carries PF and credit-based flow control is enabled.
> 
> After the header has been stripped, the PF/CFC path consumes that byte
> with a direct skb->data dereference followed by skb_pull(). A malformed
> short frame can reach this path without a byte available.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: RFCOMM: pull credit byte with skb_pull_data()
    https://git.kernel.org/bluetooth/bluetooth-next/c/2940edce391d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


