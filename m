Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194213;
	b=IjsmuLsRwBFa4F0Z4vCAAXyJHdIn0jYKEAUqi5F2aBDThc+S/p2MUcQrZpKlxqJ1jXDA
	 QZuA48nuRE3MLIRH5Xl1m7IhGfXcXkXx7t14pcEyplo1QAfBW8PA0PGOwfAAV58q10oab
	 mrO7rSsi3fvOllArSEFrXwnCH0vauCz5CPlCiSfjUFoup2wIDWLcFX3f7U9Zs+BSgp9FN
	 OF8PfoeZF0mdpQGvwpGgbu+jOhWR9kIHYhnnRnDUdkyLAw6c7tEIIBG6zwFyjzN3IVf7y
	 IweWciF61iwNNmoC5Gy2LKorLdOy2eC9awyaaw25R9AYtjY6ZBSblYIiFGT2g6ktrNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194213;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=DRWiL0IQvJCZrsmsquvFERBuR3hEea1zAwCIJch5KYw=;
	b=rynvtBJq7X9M3pmDw5rahEWIj4jMMMN1Gdc6FcCZ+fetWM5Mu9zlfbD+QMQ25Ghvdmk7
	 h983UwgrAX/n6DiIE4tpFyz/g+gDZRPxWToYtRnGp5w5Izb6o9mWNzCyHCfnFHCqIycMX
	 YQ+vAL+B354LdfxlQ8/56Itx5Y7wvrItrkQ4MI8J4zjlrzT/4RTCRtRYO9Rx/gDSssaRL
	 pCm0CZXv72d2JOAdTxYBfac9n91G5MRrbzvlETj/yMHEMFJn2iABCH0p0GBpAkZWu0lVA
	 e+JrN0H5sj8Jy/EPWYN+f6T0iY3wY1lGmqbO/UpoKtk5S24my/CJQ7qpPT7ZGcT6y4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JOprU8VX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C56606A32F
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JOprU8VX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108651F031E0;
	Wed, 28 Oct 2026 13:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793194213;
	bh=DRWiL0IQvJCZrsmsquvFERBuR3hEea1zAwCIJch5KYw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JOprU8VX2tQ7eLRorLCpExUcaRR+0wGcPD2q3PY5cvSA5K9eK3TpkF80GySKjzSkP
	 Ytk64ogBL47UMt2MqZy/6PgiH5czphgSZbJf+eHIINmDOScrKqqhcMJYVD31cUhwmp
	 716pZod9xxFmcUHWM4e61vh1WP1GdErh5LIU2mSNRGUGhLjZdLYqAaQDaX3Q8O1nuC
	 JRxNjO8Rf3OGmoEgRnaBB65pHDC2RxvF04BNk9Q3GAmn2KcA/ws6cMTtXiORc1glFa
	 b3F2thdL0ZyJymJwJip4Au+FIHB5eJRuzKRjN2GG6vOckwBR96BdHO/vG93qLOSg0c
	 d1GFW8rjvt8dg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 073B73AAA6E8;
	Wed, 28 Oct 2026 13:30:13 +0000 (UTC)
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
Subject: Re: [PATCH v2 0/2] obexd/pbap: Fix NewMissedCalls reporting
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179319421156.722681.17373470691534809442.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 13:30:11 +0000
References: <20261027071046.2272116-1-jinwang.li@oss.qualcomm.com>
In-Reply-To: <20261027071046.2272116-1-jinwang.li@oss.qualcomm.com>
To: Jinwang Li <jinwang.li@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
 quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
 shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
 xiuzhuo.shang@oss.qualcomm.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 Oct 2026 15:10:44 +0800 you wrote:
> This series fixes NewMissedCalls reporting in obexd PBAP.
> 
> The first patch fixes the apparam encoding: NewMissedCalls is a
> one-byte value but was encoded as uint16. The second patch makes the
> dummy backend report the actual missed-call count for the mch folder
> instead of always zero, which is required by PTS PBAP/PSE/PBD/BV-05-C.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] obexd/pbap: Fix NewMissedCalls parameter size
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f1af76b9868e
  - [v2,2/2] obexd/pbap: Report NewMissedCalls for mch
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d987dbc0f081

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


