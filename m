Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792789236;
	b=cuqGKNSaCyV/CKyFVIJTYyHSdCF58KjMTNR90Pv3QONLTcZXr+yYwDY6kIl0xKql2bFu
	 quXkWlocZ8KTCu+bToBLthPbNcpYyquQgXK8Aj81viYr8ISZ89Q+8JRL+moUKHQX9aHqg
	 hnwbuPVdGgob4vAHqC3ZeqS4skOE3qBJuCdUxtf1K81TOCGQMMlnwjCwVtSY2vQfO4mAr
	 To63j3wQINR9cg6TrN3um8bUBFoavrK2+4t1uanbup58BhSov2kmY8v9Ydc1Dpmziq2O7
	 Zr1mzGR8ymnr2H8wqEQcTtofff0LUV1k2T+j2E7ysS/67DQHbm0klPnlYACi2SWP6qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792789236;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=M62e+97RNKSG25v+mEceWfKhLrVp3JP02XdOV3iR4cc=;
	b=w8fKnMcb5MfmfT3fo1TdyrWWrVfAbgzUl43Yfr2wHVZB/eCWApEtLQvvR6rLfU2dXpOn
	 bB8HZ/+zt1kl4H0AeLbg6eWT3whn3FcSv4zDHpCztfriZVwEc3Ngy/8a3NsK1HKR7euHX
	 2yKm+SNduLvunc0rt+psvmnPWvmi1Nmmgnd/S9QgbKc6JZ5VG+e3K8Ll44U5edl7/c4bv
	 ohImxGQBnC6zcDMkZnpU2qqs+t87DcxPV824M6e2KbVO3KcWdv6rYsL0VCc7YUvw4sgL1
	 mNpVDuoZT8N17NXiOOXIT6rAOKp/mF2gcYVP9KKgfP5XXycJJQ6osDUezqq2tgQzR9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NLOHuP6M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC6E606A322
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 21:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NLOHuP6M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B51C1F01825;
	Fri, 23 Oct 2026 21:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792789236;
	bh=M62e+97RNKSG25v+mEceWfKhLrVp3JP02XdOV3iR4cc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NLOHuP6MTggd4H2J1f05d3IPeit5Zv357JH6rMZ1FQn5moRBt9QvU4KIDYu1zD4bs
	 lcZf5LQBX9Ig82xIvF1w8k4wrLa7oRUjMV65e5hfrqEdvfXMim+wPArc7WouTjlmyu
	 cL+dx0axEnYdT+VkG/xPuC5zPCDuRA9f0v7fYSRMtEePStOIfcViFKDlg2IMVL81bw
	 QoSs1Yp70+USV9aHaoihzsVU01asaBV1vhjUB3n1g39A/gvritP5QmpDU9jUTUqKNC
	 b38PS2x3gzyh8wprCPavwCP9Uw1pRhQQXCQcpM/UjYX61XtSKxJ8U9VlzhEvdh8MNQ
	 C9DDbQu6j60+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 44326391B157;
	Fri, 23 Oct 2026 21:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: L2CAP: Hold incoming data until encryption
 key
 size is known
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179278923481.1268720.9107027824998220837.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 21:00:34 +0000
References: <20261022154621.3958803-2-luiz.dentz@gmail.com>
In-Reply-To: <20261022154621.3958803-2-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 22 Oct 2026 11:46:21 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Once encryption is enabled on an ACL link, the encryption key size is
> read from the controller, using hdev->min_enc_key_size in the meantime.
> Data received before the reply is processed with that key size, so a
> peer starting SMP over BR/EDR right after encryption, which it may do,
> gets its Pairing Request rejected with "Encryption Key Size" whenever
> the pending security level is FIPS, as that requires a 16 octet key:
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: L2CAP: Hold incoming data until encryption key size is known
    https://git.kernel.org/bluetooth/bluetooth-next/c/2aa8a39c5a81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


