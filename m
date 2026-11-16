Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851430;
	b=jzf4/74PJbiqjdBdjRO1rRnLp7W0oaOo/+Q6ycMp6rReaH59SlKSBy+CFZHVaYbtCuVf
	 OmrXgfp8Izl5Kbk+KMvtCwreOMA4EQD29yQ8PidyFf8MbAFBGToZizoQ3S8Lv7IFDM7AJ
	 uy3Azf0TvRf5aQAhvnnp8Z6vtRgCeFMGJzdsicTf9HC9Lxb6IaLUt48zmMdqFIHc3aZ/c
	 /FeNCuRyGz0rVFAEc8/XE4z8UHRF/MZuxmny4r1u37z3HkqpV0g3hL8Zt2npC6UgKf306
	 qVhCK8ah0nN4stc/ws5ZNVr6QMGaE590QnhaaLH66cqzxsUqhs9Yxbzv7T5MKBlwKyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851430;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=JaXH5D239epVLxBPyGWho7jEmdZy4YUdRhpioBWTBkk=;
	b=LzWTEdUHTn2I0+eW3dQj6p7Itqi0fMv8HOFu/nDljyR79m0zH8FKtAHTvW8P4vs1DIgY
	 Fda2YDDeWQX337/zYkSZCM+Vq3eHpShvc5rLekGtJRmpUQHyFjbMqha/xCK/giA4Og38D
	 FktRwtJ6fBXm+T4YYvhAUv+4FBcbTWgutQtsKYFpuE4BfxXDlSPdy05pGfQSVUJ0II7IU
	 mdqaj7kquwYbvuZKIhiCqmGUifJltGj7WfEhTcymqM4GnWUui7KvfYTAKoYaCfrRXDD22
	 KrZGIYgJDiE2JQ0PWOOyeDlIzQTfDCjXeqbLjkbkBtB/pOGqA5QhTC5rcXoS/bMatxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WKinUAnO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27D8606A331
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WKinUAnO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810141F000C4;
	Mon, 16 Nov 2026 17:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851430;
	bh=JaXH5D239epVLxBPyGWho7jEmdZy4YUdRhpioBWTBkk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WKinUAnOLT9BwgvhJo1XKWXDJKN390xg7O++HSWFvIvRIpPMj/8BeJ723kSCXGACe
	 f9zhaU0qGh7o9+vrfRyahT9kuOoYKs6UgRA+4d1mvv9QTRDPrJIqq70+8N4EDmO0hw
	 Vz+RGCNr5hTyC+U3/yIQti2QSrntIgTHYr6LhpmfD0Y09OsvREaELs6s7s6cmRJQIl
	 bHco6ci5tDUvuu52JDvuWvqQ3eVw7OcGmMrAjFdRSmvUVs5gCoQOrD4E1JzMG9Lyi+
	 Xlx4gNFzecOmyqAOs0oXbs3hALF9X0KxUCEb5p/zyLEa9TaDXs49f3Sn7HIeTLXvCE
	 UuN1ZKiv9onrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7734C391AFAF;
	Mon, 16 Nov 2026 17:50:30 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v3 2/6] shared/bap: Update the remote PAC when
 reusing
 an ASE
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179485142902.3796096.12970907320325102505.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 17:50:29 +0000
References: 
 <1c41577456acc2457f3c5177d9380eda950649f0.1794428234.git.luiz.von.dentz@intel.com>
In-Reply-To: 
 <1c41577456acc2457f3c5177d9380eda950649f0.1794428234.git.luiz.von.dentz@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Nov 2026 15:37:29 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> An ASE kept by a stream, e.g. one the server cached after its release,
> may be reused for another remote PAC, which replaced the local PAC but
> left the stream pointing to the previous remote one. Update it as well,
> so that it matches the PAC the ASE is now configured for.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,2/6] shared/bap: Update the remote PAC when reusing an ASE
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=be6c46a679fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


