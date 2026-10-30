Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368811;
	b=ho4o5PxsjTnmYT3wuK/hnQwS/3VqeOBufig/tw4M6AV5vIZPqhaZSN2IMiHmSlfbHTUB
	 iOSFDainCxHCfSyZd63lQ5LiuFr7lZHmfxmaCO+aSpk5xA8jGIjfM3Pjk/vpjVlzTVybK
	 fSznqOupCC4rP9O9bVxgrxg4FNIy+vHl04RRiAc1wlB+0BFFd981qGSVvtc4sTq6V+S7S
	 WFQ6wazjN8ZtnktxVPdQM+1FQT/gEvLaF4bH6fgsAQzgL3pDCl2PMxAVVWp2khsaS3gJP
	 bnGOmI0O/RVz8Q4Np7oUivQMBIU73LKDwytUIexT9T3w5iX7QZ1z+DufE0LFD5WVACg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368811;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=fgnn9x7chOJUelIQZiwQrFE4vEt8bWlZnxCPQ4pPBfU=;
	b=TxpxS+wClzciWjzWZS99P/AfZbiP6DJgsB7wtMqGTah4aGCg+CwC8XR4LEJdSjYmioku
	 5hi+nRrYmslsJGVBgkEmq+gqJoGTMzNX70z3Ey15uwo3xbihiev8k2XjcP8/0Qx+4fE6N
	 yqRunQd64Z67JaeG28d/RZD7YNpaO9E8Mc3u32pvnWfZ1TcDJ/uw5fgUBMzsvlXnkIlv2
	 0rKx0B5HSUb6YZm3zmpT5FBr1FDKAcg2LD5E0fOjRvL2xNzFMwHLYINBM0tyfJfIPnY7t
	 2rJirt8w/32uVbfwzG/H/aPe5oHqChIlW70xbX1r7Wl20OoAQxYV9vkk7K3gp8Kiqhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W77HDR/+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF111606A31E;
	Fri, 30 Oct 2026 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W77HDR/+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3E81F00A15;
	Fri, 30 Oct 2026 14:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793368810;
	bh=fgnn9x7chOJUelIQZiwQrFE4vEt8bWlZnxCPQ4pPBfU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W77HDR/+jK+b1UmS26QQ+85R3TBSc5dLNJQjEZEBHLqqFUED97OEVrKUnGjw6vtgN
	 CquGUFB/6JecuBDjteaFHcAQQ3BlsJiQrmwyBsJHWwVeVxKKW1V3fvFdWR9tEXdbVf
	 o0RNdChdRbKkaJNF5bMPkNDbeUzKgSIZA460IzobN/vV7bqrL8doVzeDIe6sku9gAM
	 wQ/Oa6n/kpBcb1ooBbBb4RCJkBEs9dIiGeExiF9FXASp+J2e9+U63MdQKYOvMGetXs
	 w3DpiIHO0BAKobI4zfxbzK2oc34Bj5yTekYJrMYtBm3fEjQn2/mOvqklOHaAi/SV6z
	 ZbFjjI7VckKSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 402013800465;
	Fri, 30 Oct 2026 14:00:10 +0000 (UTC)
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
Subject: Re: [PATCH v1] Bluetooth: L2CAP: Ignore connection responses with
 wrong
 ident
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179336880879.1091505.7130136240729052248.git-patchwork-notify@kernel.org>
Date: Fri, 30 Oct 2026 14:00:08 +0000
References: <20261029094104.2952304-1-jinwang.li@oss.qualcomm.com>
In-Reply-To: <20261029094104.2952304-1-jinwang.li@oss.qualcomm.com>
To: Jinwang Li <jinwang.li@oss.qualcomm.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
 quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
 shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
 xiuzhuo.shang@oss.qualcomm.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 29 Oct 2026 17:41:04 +0800 you wrote:
> L2CAP/COS/CED/BI-28-C requires the IUT to ignore a Connection Response
> that carries an invalid Identifier.
> 
> l2cap_connect_create_rsp() only checks that a connection request is
> outstanding, not that the response answers it. Add an ident check
> against the pending request so that a mismatched response is dropped.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: L2CAP: Ignore connection responses with wrong ident
    https://git.kernel.org/bluetooth/bluetooth-next/c/11701044c532

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


