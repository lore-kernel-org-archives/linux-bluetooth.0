Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327014;
	b=iiwJ5G0YfeBLhL70fK1zpbsxWXeufH9aY+Jc2qMYKL6IR4aAXj2nvpNLmD4bUXpMutP4
	 5QKQ+T+O0zK6mRLbkQiFsJu1eEJBn1u8i+Or9XBIxg9pLa1HycwAVHh+Nu0Sh3Bm5OTa8
	 Rwt2Hs+Kq76Hg/rSaCWhYNwYK0B4R9EnbESFv7QyHqUwYm+GVUL1Lxm6syHAt9EJKFc/I
	 3R1Q+eA4YXpT6PXAeG78p+Lwn9JFIsMs8o8L63PUQMhrwmCasiHVMq7ChwXlfHmhpa0dT
	 b9ibPVRPhAx/qiuq1F66x7o0tTvwlSXWBTnDdXG1YYTmJ2kypok8oo3p7HWQIH082yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327014;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=sW/+AZKOnfFUykr1vqtqOVrmPX3C/zFqJBALS7Am6x0=;
	b=hxwlhMoxnaJrzBGuCRkO4A5jIqkPngfaVerpd6oFcNLcJyIOhOmWVE8mpKSqC0Knq+iW
	 YWVvn6tPJkX0dWzblubSB76ooRxg0lndDzszqzPqeRbWlLPsNeA3MTguWABaHl2GxsGPL
	 yYa2WuWM2y79U8rEa8mI/5q8BCPEv7/liZM60/woHjzFggXglNUKKD+tbSBdVjP7ARUcu
	 +g1hkpcz7JG8wMsH6nODuk84SXyRGbqMemEIA0aiy2LBmi6RL92FAS6h3pC3G7gRH5TUn
	 c3uut28puElDZPffqrHmkAyFuKIPg8ftDapKKqhG+uZUe4w20nnR1FuWEyAkjtk2Q6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NSd4SjEr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A0360A2617;
	Tue, 10 Nov 2026 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NSd4SjEr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4E51F008BC;
	Tue, 10 Nov 2026 16:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327014;
	bh=sW/+AZKOnfFUykr1vqtqOVrmPX3C/zFqJBALS7Am6x0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NSd4SjErwghoktD6+63RlnMQSLJzpRbb7QfF4iWGdNQCY67WmM4rELpejgjWwE8Dx
	 Kkied1JdmsTaHRf2797F6PoCw4E08eaNEvwkLcBL7+P+v9ueiaLWAHc1r3m2vunI3O
	 ytcd1ACdOYdHi21FZUsJTIXn12eK8zM4T8H1gxMe/S38bWTnmeLrYxWHAZS4ks7//d
	 /bUmhzx4nKrxcJf9f+rj7zZYEkU50BKUd9RH6ycRcu+Gdy8xlWr1IUruFWm1d6F3NS
	 k5YD0rJea9xysBkt6KgSjinZHIwb2ylMFybK7aSXm3+cdykcOkOeG38tUCJrAomspP
	 b5QfP9F2lZ1aQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 213B939D267B;
	Tue, 10 Nov 2026 16:10:14 +0000 (UTC)
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
Subject: Re: [PATCH bluetooth-next v2] Bluetooth: L2CAP: validate MPS and MTU
 in ECRED connection response
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179432701267.4062787.11305401861516612930.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 16:10:12 +0000
References: <20261110-bt-ecred-mps-fix-v2-1-48c5ee28fd8a@gmail.com>
In-Reply-To: <20261110-bt-ecred-mps-fix-v2-1-48c5ee28fd8a@gmail.com>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Nov 2026 03:26:03 +0000 you wrote:
> From: Joas Antonio dos Santos <joasantonio108@gmail.com>
> 
> l2cap_ecred_conn_rsp() stores the MTU and MPS from the peer without
> checking them against the minimums required for enhanced credit based
> channels.  The other LE and ECRED handlers (l2cap_le_connect_req(),
> l2cap_le_connect_rsp(), l2cap_ecred_conn_req(), l2cap_ecred_reconf_req())
> all reject values below the minimum.
> 
> [...]

Here is the summary with links:
  - [bluetooth-next,v2] Bluetooth: L2CAP: validate MPS and MTU in ECRED connection response
    https://git.kernel.org/bluetooth/bluetooth-next/c/1645edfa8c29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


